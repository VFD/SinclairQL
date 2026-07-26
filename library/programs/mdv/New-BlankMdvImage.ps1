<#
.SYNOPSIS
    Creates a blank Sinclair QL microdrive (.mdv) image file compatible with QemuLator.

.DESCRIPTION
    Generates a properly formatted empty MDV image based on the QLAY/QemuLator format.
    Structure derived from mdvtool.c by Till Harbaum / Jason Lucas.

    Each sector (mdv_entry_t) consists of:
      - Header block (hdr_t): 28 bytes
        [12 preamble + 1 ff + 1 snum + 10 name + 2 rnd + 2 csum]
      - Data block (sector_t): 658 bytes
        [12 bh_preamble + 1 file + 1 block + 2 bh_csum + 8 data_preamble + 512 data + 2 data_csum + 120 extra_byte]
      - Total per sector: 686 bytes
      - Total image: 255 sectors x 686 = 174,930 bytes

    Write order follows QLAY format: sector 0 first, then sectors 254 down to 1.

.PARAMETER OutputPath
    Path for the output .mdv file. Defaults to "blank.mdv" in the current directory.

.PARAMETER MediumName
    Volume name for the cartridge (max 10 characters, padded with spaces).
    Defaults to "blank".

.EXAMPLE
    .\New-BlankMdvImage.ps1
    Creates "blank.mdv" in the current directory.

.EXAMPLE
    .\New-BlankMdvImage.ps1 -OutputPath "D:\QL\rpufos.mdv" -MediumName "rpufos"
    Creates a named MDV image at the specified path.

.NOTES
    Author  : VincentD et IA
    Version : 2.0
    Requires: PowerShell 5.1+ minimum
#>




param(
    [string]$OutputPath = "blank.mdv",
    [string]$MediumName = "BLANK"
)

# --- Constants from mdv.h ---
[int]$MAX_SECTORS = 255
[int]$HDR_PREAMBLE_SIZE = 12     # 10x 0x00 + 2x 0xFF
[int]$HDR_FF = 1
[int]$HDR_SNUM = 1
[int]$HDR_NAME = 10
[int]$HDR_RND = 2
[int]$HDR_CSUM = 2
[int]$HDR_TOTAL = 28             # 12 + 1 + 1 + 10 + 2 + 2

[int]$SEC_BH_PREAMBLE_SIZE = 12  # 10x 0x00 + 2x 0xFF
[int]$SEC_FILE = 1
[int]$SEC_BLOCK = 1
[int]$SEC_BH_CSUM = 2
[int]$SEC_DATA_PREAMBLE_SIZE = 8 # 6x 0x00 + 2x 0xFF
[int]$SEC_DATA = 512
[int]$SEC_DATA_CSUM = 2
[int]$SEC_EXTRA = 120
[int]$SEC_TOTAL = 658            # 12 + 1 + 1 + 2 + 8 + 512 + 2 + 120

[int]$ENTRY_TOTAL = $HDR_TOTAL + $SEC_TOTAL  # 686 bytes

# --- Checksum function (matching mdvtool's sum() function) ---
# Calculates 16-bit sum over a byte range, big-endian style
function Get-MdvChecksum {
    param([byte[]]$Data)
    [uint32]$csum = 0x0F0F
    foreach ($b in $Data) {
        $csum += [uint32]$b
    }
    # Return as unsigned short (big-endian stored)
    return [uint16]($csum -band 0xFFFF)
}

# --- Prepare the medium name (padded to 10 chars with spaces) ---
$nameBytes = [System.Text.Encoding]::ASCII.GetBytes($MediumName)
$paddedName = New-Object byte[] 10
for ($i = 0; $i -lt 10; $i++) {
    if ($i -lt $nameBytes.Length) {
        $paddedName[$i] = $nameBytes[$i]
    } else {
        $paddedName[$i] = 0x20  # Space padding
    }
}

# --- Generate a random number for the medium (simulates rand in mdv_create) ---
$rng = New-Object System.Random
[uint16]$mediumRnd = [uint16]$rng.Next(0, 65536)

# --- Build all 255 sectors in memory ---
Write-Host ""
Write-Host "Creating MDV image: $OutputPath"
Write-Host "Medium name       : '$MediumName'"
Write-Host "Entry size        : $ENTRY_TOTAL bytes x $MAX_SECTORS sectors = $($ENTRY_TOTAL * $MAX_SECTORS) bytes"
Write-Host ""

# Allocate full buffer
[byte[]]$buffer = New-Object byte[] ($ENTRY_TOTAL * $MAX_SECTORS)

for ($s = 0; $s -lt $MAX_SECTORS; $s++) {
    $offset = $s * $ENTRY_TOTAL

    # === HEADER (hdr_t - 28 bytes) ===
    $hdrOffset = $offset

    # Header preamble: 10 bytes of 0x00, then 2 bytes of 0xFF
    for ($i = 0; $i -lt 10; $i++) {
        $buffer[$hdrOffset + $i] = 0x00
    }
    $buffer[$hdrOffset + 10] = 0xFF
    $buffer[$hdrOffset + 11] = 0xFF

    # ff byte (0xFF = valid sector)
    $buffer[$hdrOffset + 12] = 0xFF

    # Sector number
    $buffer[$hdrOffset + 13] = [byte]$s

    # Medium name (10 bytes)
    for ($i = 0; $i -lt 10; $i++) {
        $buffer[$hdrOffset + 14 + $i] = $paddedName[$i]
    }

    # Random number (2 bytes, big-endian)
    $buffer[$hdrOffset + 24] = [byte](($mediumRnd -shr 8) -band 0xFF)
    $buffer[$hdrOffset + 25] = [byte]($mediumRnd -band 0xFF)

    # Header checksum: sum of bytes from ff(1) + snum(1) + name(10) + rnd(2) = 14 bytes
    $csumData = New-Object byte[] 14
    [Array]::Copy($buffer, $hdrOffset + 12, $csumData, 0, 14)
    $hdrCsum = Get-MdvChecksum -Data $csumData
    $buffer[$hdrOffset + 26] = [byte](($hdrCsum -shr 8) -band 0xFF)
    $buffer[$hdrOffset + 27] = [byte]($hdrCsum -band 0xFF)

    # === SECTOR DATA (sector_t - 658 bytes) ===
    $secOffset = $offset + $HDR_TOTAL

    # Block header preamble: 10 bytes of 0x00, then 2 bytes of 0xFF
    for ($i = 0; $i -lt 10; $i++) {
        $buffer[$secOffset + $i] = 0x00
    }
    $buffer[$secOffset + 10] = 0xFF
    $buffer[$secOffset + 11] = 0xFF

    # File number: 0xFD = free sector (253 in decimal)
    $buffer[$secOffset + 12] = 0xFD

    # Block number: 0x00
    $buffer[$secOffset + 13] = 0x00

    # Block header checksum: sum of file(1) + block(1) = 2 bytes
    $bhCsumData = New-Object byte[] 2
    $bhCsumData[0] = 0xFD
    $bhCsumData[1] = 0x00
    $bhCsum = Get-MdvChecksum -Data $bhCsumData
    $buffer[$secOffset + 14] = [byte](($bhCsum -shr 8) -band 0xFF)
    $buffer[$secOffset + 15] = [byte]($bhCsum -band 0xFF)

    # Data preamble: 6 bytes of 0x00, then 2 bytes of 0xFF
    for ($i = 0; $i -lt 6; $i++) {
        $buffer[$secOffset + 16 + $i] = 0x00
    }
    $buffer[$secOffset + 22] = 0xFF
    $buffer[$secOffset + 23] = 0xFF

    # Data: 512 bytes of 0x00 (blank)
    # Already zero from allocation

    # Data checksum: sum of 512 data bytes (all zeros)
    $dataBytes = New-Object byte[] 512
    [Array]::Copy($buffer, $secOffset + 24, $dataBytes, 0, 512)
    $dataCsum = Get-MdvChecksum -Data $dataBytes
    $buffer[$secOffset + 536] = [byte](($dataCsum -shr 8) -band 0xFF)
    $buffer[$secOffset + 537] = [byte]($dataCsum -band 0xFF)

    # Extra bytes: 120 bytes of 0x00
    # Already zero from allocation
}

# --- Write to file in QLAY order ---
# mdv_write() writes sector 0 first, then 254 down to 1
Write-Host "Writing in QLAY sector order (0, 254, 253, ... 1)..."

$outputBuffer = New-Object byte[] ($ENTRY_TOTAL * $MAX_SECTORS)
$writePos = 0

# First: sector 0
[Array]::Copy($buffer, 0, $outputBuffer, $writePos, $ENTRY_TOTAL)
$writePos += $ENTRY_TOTAL

# Then: sectors 254 down to 1
for ($i = ($MAX_SECTORS - 1); $i -ge 1; $i--) {
    $srcOffset = $i * $ENTRY_TOTAL
    [Array]::Copy($buffer, $srcOffset, $outputBuffer, $writePos, $ENTRY_TOTAL)
    $writePos += $ENTRY_TOTAL
}

# --- Write the final file ---
[System.IO.File]::WriteAllBytes(
    [System.IO.Path]::GetFullPath($OutputPath),
    $outputBuffer
)

$fileInfo = Get-Item $OutputPath
Write-Host "Done! File size: $($fileInfo.Length) bytes"
Write-Host "Expected size: $($ENTRY_TOTAL * $MAX_SECTORS) bytes"

if ($fileInfo.Length -eq ($ENTRY_TOTAL * $MAX_SECTORS)) {
    Write-Host "Size matches expected MDV format. Ready to mount in QemuLator."
} else {
    Write-Host "WARNING: Size mismatch!"
}
