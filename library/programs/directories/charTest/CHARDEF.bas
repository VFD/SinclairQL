100 REMark ============================================
110 REMark  CHARACTER REDEFINITION DEMO
120 REMark  Redefines chars 192-196 with custom shapes
130 REMark  For Sinclair QL with Minerva ROM
140 REMark ============================================
150 :
160 REMark MODE 4
170 REMark PAPER 0: INK 7: CLS
180 :
190 REMark --- Reserve memory for custom font ---
200 REMark Each character = 9 rows of 1 byte = 9 bytes
210 REMark 64 characters (192-255) = 64 * 9 = 576 bytes
220 :
230 font_size = 576
240 font_base = RESPR(font_size)
250 :
260 REMark --- Clear the font area ---
270 FOR i = 0 TO font_size - 1
280   POKE font_base + i, 0
290 END FOR i
300 :
310 REMark --- Define character shapes using DATA ---
320 REMark Each char = 9 bytes (rows top to bottom)
330 REMark Each byte = 8 pixels (MSB=left, LSB=right)
340 REMark Example: BIN('01111110') = 126
350 :
360 REMark --- CHR$(192) = Spaceship ---
370 RESTORE 2000
380 char_num = 192: GO SUB 1000
390 :
400 REMark --- CHR$(193) = Star ---
410 RESTORE 2100
420 char_num = 193: GO SUB 1000
430 :
440 REMark --- CHR$(194) = Heart ---
450 RESTORE 2200
460 char_num = 194: GO SUB 1000
470 :
480 REMark --- CHR$(195) = Arrow right ---
490 RESTORE 2300
500 char_num = 195: GO SUB 1000
510 :
520 REMark --- CHR$(196) = Skull ---
530 RESTORE 2400
540 char_num = 196: GO SUB 1000
550 :
560 REMark --- Set the font as second font (chars 128-255) ---
570 REMark On Minerva, use CHAR_USE to set user font
580 REMark CHAR_USE font_base, 0
590 :
600 REMark --- Display the redefined characters ---
610 PRINT "CUSTOM CHARACTERS DEMO"
620 PRINT "======================"
630 PRINT
640 CSIZE 3,1
650 FOR c = 192 TO 196
660   PRINT "CHR$("; c; ") = "; CHR$(c); "  ";
670 END FOR c
680 CSIZE 0,0
690 PRINT \\ "Spaceship  Star  Heart  Arrow  Skull"
700 PRINT \\ "Characters 192-255 are now redefinable."
710 PRINT "Modify the DATA lines to create your own!"
720 STOP
730 :
990 REMark ----------------------------------------
991 REMark SUB: Poke one character into font table
992 REMark Input: char_num, RESTORE DATA
993 REMark ----------------------------------------
1000 offset = (char_num - 192) * 9
1005 PRINT \\ "Offset" ! offset
1010 FOR row = 0 TO 8
1020   READ byte: PRINT byte
1030   POKE font_base + offset + row, byte
1040 END FOR row
1050 RETurn
1060 :
1990 REMark ========================================
1991 REMark  CHARACTER PIXEL DATA
1992 REMark  9 rows per char, 8 pixels per row
1993 REMark  Draw your shapes on 8x9 grid:
1994 REMark    1=pixel on, 0=pixel off
1995 REMark    Row value = binary to decimal
1996 REMark ========================================
1997 :
2000 REMark --- CHR$(192) Spaceship ---
2001 REMark  ..OO....  = 00110000 = 48
2002 REMark  ..OO....  = 00110000 = 48
2003 REMark  .OOOO...  = 01111000 = 120
2004 REMark  .OOOO...  = 01111000 = 120
2005 REMark  OOOOOO..  = 11111100 = 252
2006 REMark  OOOOOO..  = 11111100 = 252
2007 REMark  .O..O...  = 01001000 = 72
2008 REMark  .O..O...  = 01001000 = 72
2009 REMark  ........  = 00000000 = 0
2010 DATA 48, 48, 120, 120, 252, 252, 72, 72, 0
2020 :
2100 REMark --- CHR$(193) Star ---
2101 REMark  ...O....  = 00010000 = 16
2102 REMark  ..OOO...  = 00111000 = 56
2103 REMark  OOOOOOO.  = 11111110 = 254
2104 REMark  .OOOOO..  = 01111100 = 124
2105 REMark  ..OOO...  = 00111000 = 56
2106 REMark  .OO.OO..  = 01101100 = 108
2107 REMark  OO...OO.  = 11000110 = 198
2108 REMark  ........  = 00000000 = 0
2109 REMark  ........  = 00000000 = 0
2110 DATA 16, 56, 254, 124, 56, 108, 198, 0, 0
2120 :
2200 REMark --- CHR$(194) Heart ---
2201 REMark  ........  = 00000000 = 0
2202 REMark  .OO.OO..  = 01101100 = 108
2203 REMark  OOOOOOO.  = 11111110 = 254
2204 REMark  OOOOOOO.  = 11111110 = 254
2205 REMark  OOOOOOO.  = 11111110 = 254
2206 REMark  .OOOOO..  = 01111100 = 124
2207 REMark  ..OOO...  = 00111000 = 56
2208 REMark  ...O....  = 00010000 = 16
2209 REMark  ........  = 00000000 = 0
2210 DATA 0, 108, 254, 254, 254, 124, 56, 16, 0
2220 :
2300 REMark --- CHR$(195) Arrow right ---
2301 REMark  ...O....  = 00010000 = 16
2302 REMark  ....O...  = 00001000 = 8
2303 REMark  OOOOOOO.  = 11111110 = 254
2304 REMark  OOOOOOOO  = 11111111 = 255
2305 REMark  OOOOOOO.  = 11111110 = 254
2306 REMark  ....O...  = 00001000 = 8
2307 REMark  ...O....  = 00010000 = 16
2308 REMark  ........  = 00000000 = 0
2309 REMark  ........  = 00000000 = 0
2310 DATA 16, 8, 254, 255, 254, 8, 16, 0, 0
2320 :
2400 REMark --- CHR$(196) Skull ---
2401 REMark  .OOOOO..  = 01111100 = 124
2402 REMark  OOOOOOO.  = 11111110 = 254
2403 REMark  OO.O.OO.  = 11010110 = 214
2404 REMark  OOOOOOO.  = 11111110 = 254
2405 REMark  .OO.OO..  = 01101100 = 108
2406 REMark  .OOOOO..  = 01111100 = 124
2407 REMark  .O.O.O..  = 01010100 = 84
2408 REMark  ........  = 00000000 = 0
2409 REMark  ........  = 00000000 = 0
2410 DATA 124, 254, 214, 254, 108, 124, 84, 0, 0
2420 :