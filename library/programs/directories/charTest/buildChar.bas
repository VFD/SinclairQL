100 REMark === font generation parameters ===
110 fst = 192
120 lst = 208
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
300 RESTORE 1000
310 FOR ch = fst TO lst
320   FOR li = 0 TO 8
330     READ b$
340     POKE ptr, HEX(b$)
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
999 :
1000 :
1010 : REMARK CSIZE 1,0 ou CSIZE 1,1 : MODE 4 only
1020 :
1030 DATA "00", "10", "10", "7C", "10", "10", "38", "44", "FE"  : REMark Tombe
1040 DATA "00", "7C", "82", "FE", "82", "92", "82", "82", "FE"  : REMark Coffre 1
1050 DATA "FE", "44", "44", "28", "10", "28", "44", "7C", "FE"  : REMark sablier
1060 DATA "00", "02", "FF", "FF", "68", "78", "60", "60", "00"  : REMark gun to right
1070 DATA "ED", "ED", "00", "BB", "BB", "00", "D7", "D7", "00"  : REMark motif type brique
1080 DATA "3C", "42", "3C", "42", "91", "A1", "81", "7E", "00"  : REMark fiole 1
1090 DATA "7C", "28", "28", "6C", "C6", "82", "FE", "DE", "7C"  : REMark fiole 2
1110 DATA "04", "2E", "1D", "97", "9E", "8C", "5E", "5E", "3F"  : REMark chat
1120 DATA "00", "12", "33", "BF", "AD", "9E", "4C", "5E", "3F"  : REMark chat 2
1130 DATA "00", "88", "F8", "A8", "FA", "72", "71", "79", "7E"  : REMark chat 3
1140 DATA "FC", "8A", "8E", "82", "82", "82", "82", "82", "FE"  : REMark Paper
1150 DATA "FC", "8A", "AE", "82", "BA", "82", "BA", "82", "FE"  : REMark Paper Text
1160 DATA "C6", "C6", "BE", "F6", "6C", "60", "6C", "6C", "6C"  : REMark chaine, haut - A
1170 DATA "6C", "60", "6C", "B6", "F6", "C6", "C6", "C6", "C6"  : REMark chaine, bas - B
2000 :
2010 : REMark compatible tous CSIZE
2020 :
2030 DATA "00", "44", "44", "28", "10", "10", "38", "7C", "00"  : REMark coupe
2040 DATA "08", "10", "28", "38", "10", "38", "38", "38", "38"  : REMark bougie 1
2050 DATA "20", "10", "28", "38", "10", "38", "38", "38", "38"  : REMark bougie 2
3000 :
3010 : REMark
3020 :
