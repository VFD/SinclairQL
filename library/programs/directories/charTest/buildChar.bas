100 REMark === font generation parameters ===
110 fst = 192
120 lst = 195
130 cnt = lst - fst + 1
140 PRINT #0,"Count:";cnt;
150 :
160 REMark === compute total size: 2-byte header + 9 bytes per char ===
170 fsz = 2 + (cnt * 9)
180 PRINT #0,"- File Size:";fsz;
190 :
200 REMark === allocate memory ===
210 bas = ALCHP(fsz)
220 PRINT #0,"- Allocated memory";bas
230 :
240 REMark === write header: first code + number of chars-1 ===
250 POKE bas, fst
260 POKE bas+1, cnt-1
270 :
280 REMark === store glyph data ===
290 ptr = bas + 2
300 RESTORE 530
310 FOR ch = fst TO lst
320   FOR li = 0 TO 8
330     READ b
340     POKE ptr, b
350     ptr = ptr + 1
360   END FOR li
370 END FOR ch
380 PRINT #0,"Memory ok, write file"
390 :
400 REMark === write raw binary file (no qdos header) ===
410 OPEN_NEW #3, myfont_raw
420 FOR i = 0 TO fsz+1
430   PRINT "_";i!;PEEK(bas+i);"_";
440   BPUT #3, PEEK(bas+i)
450 END FOR i
460 CLOSE #3
470 REMark === free memory ===
480 REMark RECHP bas
490 :
500 STOP
510 REMark === example data (only 4 characters here) ===
520 REMark chr$(192)
530 DATA 255,129,129,129,129,129,129,255,0
540 REMark chr$(193)
550 DATA 0,24,36,66,66,36,24,0,0
560 REMark chr$(194)
570 DATA 255,0,255,0,255,0,255,0,0
580 DATA 0,0,0,0,0,0,0,0,0
