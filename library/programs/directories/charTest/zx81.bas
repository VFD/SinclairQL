100 REM === Reserve memory for the font ===
110 base = ALCHP(587)
120 REM === Load the font file into memory ===
130 LBYTES "zx81.font", base
140 REM === Install the font as upper font for window #1 ===
150 CHAR_USE #1, 0, base
160 REM === Set character spacing for 8x8 fonts ===
170 REM CHAR_INC #1, 8, 8
210 CSIZE #1,1,0
220 REM === Display all characters from 32 to 255 ===
230 FOR c = 32 TO 255
240   PRINT #1, CHR$(c);
250 END FOR c
260 REM === End: remove the font if needed ===
270 REM CHAR_USE #1,0,0
280 REM RECHP base
