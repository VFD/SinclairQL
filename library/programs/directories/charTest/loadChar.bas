100 REMark === Reserve memory for the font ===
110 REMark  values must match the build
120 fst = 192
130 lst = 194
140 num = ((lst-fst+1)*9)+2
150 base = ALCHP(num)
160 REMark === Load the font file into memory ===
170 LBYTES "myfont_raw", base
180 REMark === Install the font as upper font for window #1 ===
190 CHAR_USE #1, 0, base
200 REMark === Set character spacing for 8x8 fonts ===
210 REMark CHAR_INC #1, 8, 8
220 CSIZE #1,1,0
230 REMark === Display all characters from 32 to 255 ===
240 FOR c = 32 TO 255
250   PRINT #1, CHR$(c);
260 END FOR c
270 REMark === End: remove the font if needed ===
280 REMark CHAR_USE #1,0,0
290 REMark RECHP base
