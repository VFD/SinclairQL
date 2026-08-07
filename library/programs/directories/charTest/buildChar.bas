100 REMark === font generation parameters ===
110 fst = 192
120 lst = 255
130 cnt = lst - fst + 1
140 PRINT #0,"Count:";cnt;
150 :
160 REMark === compute total size: 2-byte header + 9 bytes per char ===
170 fsz = 2 + (cnt * 9)
180 PRINT #0," - File Size: ";fsz;
190 :
200 REMark === allocate memory ===
210 bas = ALCHP(fsz)
220 PRINT #0," - Allocated memory ";bas
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
330     READ b$: PRINT b$!;
340     POKE ptr, HEX(b$)
350     ptr = ptr + 1
360   END FOR li
370 END FOR ch
380 PRINT #0,"Memory ok, write file"
390 :
400 REMark === write raw binary file (no qdos header) ===
410 OPEN_NEW #3, "rpufos.fnt"
420 FOR i = 0 TO fsz+1
430   PRINT "_";i!;PEEK(bas+i);"_";
440   BPUT #3, PEEK(bas+i)
450 END FOR i
460 CLOSE #3
470 REMark === free memory ===
480 RECHP bas
490 :
500 STOP
999 :
1000 :
1010 : REMark CSIZE 1,0 ou CSIZE 1,1 : MODE 4 only - 15
1020 :
1030 DATA "FF", "FF", "FF", "FF", "FF", "FF", "FF", "FF", "FF"  : REMark Bloc 8x9 (192)
1040 DATA "00", "10", "10", "7C", "10", "10", "38", "44", "FE"  : REMark Tomb
1050 DATA "00", "7C", "82", "FE", "82", "92", "82", "82", "FE"  : REMark Chest
1060 DATA "FE", "44", "44", "28", "10", "28", "44", "7C", "FE"  : REMark sablier
1070 DATA "00", "02", "FF", "FF", "68", "78", "60", "60", "00"  : REMark gun to right
1080 DATA "ED", "ED", "00", "BB", "BB", "00", "D7", "D7", "00"  : REMark motif type brique
1090 DATA "00", "3C", "42", "3C", "42", "91", "A1", "81", "7E"  : REMark fiole 1
1100 DATA "7C", "28", "28", "6C", "C6", "82", "FE", "DE", "7C"  : REMark fiole 2
1110 DATA "04", "2E", "1D", "97", "9E", "8C", "5E", "5E", "3F"  : REMark cat
1120 DATA "00", "12", "33", "BF", "AD", "9E", "4C", "5E", "3F"  : REMark cat 2
1130 DATA "00", "88", "F8", "A8", "FA", "72", "71", "79", "7E"  : REMark cat 3
1140 DATA "FC", "8A", "8E", "82", "82", "82", "82", "82", "FE"  : REMark Paper
1150 DATA "FC", "8A", "AE", "82", "BA", "82", "BA", "82", "FE"  : REMark Paper Text
1160 DATA "C6", "C6", "BE", "F6", "6C", "60", "6C", "6C", "6C"  : REMark chain, up - A
1170 DATA "6C", "60", "6C", "B6", "F6", "C6", "C6", "C6", "C6"  : REMark chain, bottom - B
1180 :
1190 : REMark All CSIZE - 4
1200 :
1210 DATA "00", "44", "44", "28", "10", "10", "38", "7C", "00"  : REMark coupe
1220 DATA "08", "10", "28", "38", "10", "38", "38", "38", "38"  : REMark bougie 1
1230 DATA "20", "10", "28", "38", "10", "38", "38", "38", "38"  : REMark bougie 2
1240 DATA "7C", "7C", "7C", "7C", "7C", "7C", "7C", "7C", "7C"  : REMark Bloc 5x9
1250 :
1260 : REMark Single Border - 11
1270 :
1280 DATA "10", "10", "10", "10", "FF", "10", "10", "10", "10"  : REMark 1 line cross
1290 DATA "10", "10", "10", "10", "F0", "10", "10", "10", "10"  : REMark N S W
1300 DATA "10", "10", "10", "10", "FF", "00", "00", "00", "00"  : REMark N E W
1310 DATA "10", "10", "10", "10", "1F", "10", "10", "10", "10"  : REMark N E S
1320 DATA "00", "00", "00", "00", "FF", "10", "10", "10", "10"  : REMark E S W
1330 DATA "10", "10", "10", "10", "1F", "00", "00", "00", "00"  : REMark N E
1340 DATA "10", "10", "10", "10", "10", "10", "10", "10", "10"  : REMark N S
1350 DATA "10", "10", "10", "10", "F0", "00", "00", "00", "00"  : REMark N W
1360 DATA "00", "00", "00", "00", "1F", "10", "10", "10", "10"  : REMark E S
1370 DATA "00", "00", "00", "00", "FF", "00", "00", "00", "00"  : REMark E W
1380 DATA "00", "00", "00", "00", "F0", "10", "10", "10", "10"  : REMark S W
1390 :
1400 : REMark Design cross Arrow , draw AB then CD - 4
1410 :
1420 DATA "01", "03", "07", "0F", "01", "11", "31", "71", "FF"  : REMark A
1430 DATA "80", "C0", "E0", "F0", "80", "88", "8C", "8E", "FF"  : REMark B
1440 DATA "FF", "71", "31", "11", "01", "0F", "07", "03", "01"  : REMark C
1450 DATA "FF", "8E", "8C", "88", "80", "F0", "E0", "C0", "80"  : REMark D
1460 :
1470 : REMark 19
2000 DATA "00", "3E", "7F", "7F", "A7", "A7", "DF", "72", "00"  : REMark Skull
2010 DATA "00", "7F", "41", "5D", "55", "45", "7D", "01", "FF"  : Remark Greek 1
2020 DATA "FF", "80", "BE", "A2", "AA", "BA", "82", "FE", "00"  : Remark Greek 1 inverse
2030 DATA "CC", "CC", "00", "33", "33", "00", "CC", "CC", "00"  : REMark Pattern A
2040 DATA "33", "33", "FF", "CC", "CC", "FF", "33", "33", "FF"  : REMark Inverse Patern A
2050 DATA "24", "24", "42", "42", "42", "42", "24", "24", "18"  : REMark try vert and H
2060 DATA "A5", "BD", "BD", "A5", "BD", "BD", "A5", "BD", "BD"  : REMark Pattern
2070 DATA "FF", "FF", "C3", "DF", "DF", "DF", "FF", "FF", "00"  : Remark Pattern 8x8
2080 DATA "81", "43", "3F", "27", "27", "3F", "7F", "FF", "00"  : Remark 
2090 DATA "81", "7F", "41", "41", "41", "41", "41", "FF", "00"  : 
2100 DATA "FF", "FF", "FF", "FF", "FF", "FF", "FF", "FF", "00"  : REMark Bloc 8x8 ZX 81
2110 DATA "F0", "F0", "F0", "F0", "FF", "FF", "FF", "FF", "00"  : REMark Corner
2120 DATA "FF", "FF", "FF", "FF", "F0", "F0", "F0", "F0", "00"  : REMark 
2130 DATA "FF", "FF", "FF", "FF", "0F", "0F", "0F", "0F", "00"  : REMark 
2140 DATA "0F", "0F", "0F", "0F", "FF", "FF", "FF", "FF", "00"  : REMark 
2150 DATA "00", "00", "00", "00", "FF", "FF", "FF", "FF", "00"  : REMark Barre
2160 DATA "FF", "FF", "FF", "FF", "00", "00", "00", "00", "00"  : REMark 
2170 DATA "F0", "F0", "F0", "F0", "F0", "F0", "F0", "F0", "00"  : REMark 
2180 DATA "0F", "0F", "0F", "0F", "0F", "0F", "0F", "0F", "00"  : REMark 
2190 :
2200 DATA "1C", "7E", "FF", "FE", "7F", "17", "23", "45", "89"  : REMark Spider A
2210 DATA "00", "00", "00", "F0", "A0", "F0", "48", "24", "22"  : REMark Spider B = AB
2220 DATA "AA", "55", "A9", "59", "A8", "C8", "80", "80", "80"  : Remark web A
2230 DATA "AA", "54", "28", "10", "10", "10", "00", "00", "00"  : Remark web B = AB
2240 :
2250 DATA "00", "38", "7C", "FE", "A7", "A7", "DF", "FE", "A8"  : REMark Skeleton A
2260 DATA "00", "00", "00", "00", "0A", "45", "45", "45", "2A"  : REMark B
2270 DATA "00", "00", "00", "00", "80", "40", "60", "50", "BE"  : REMark C = ABC
2280 :
2290 DATA "00", "7F", "FF", "FF", "FF", "FF", "FF", "38", "07"  : REMark stone A
2300 DATA "00", "FC", "FE", "FA", "FA", "E2", "02", "04", "F8"  : REMark stone B = AB
2310 DATA "00", "3C", "3E", "7A", "FA", "F2", "C6", "7C", "00"  : REMark stone C
2320 DATA "00", "3C", "7E", "7A", "72", "64", "3C", "00", "00"  : REMark stone D



