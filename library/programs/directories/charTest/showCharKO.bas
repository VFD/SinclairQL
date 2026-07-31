100 REMark ----------------------------------------
110 REMark Display all QL characters (32-255)
120 REMark Shows code number and character
130 REMark ----------------------------------------
140 MODE 4
150 WINDOW #1,512, 256, 0, 0
160 PAPER #0,0: INK #0,7: CLS #1
170 CSIZE #1,1,0
180 REMark --- Header ---
190 AT #1,0,0: PRINT "QL CHARACTER MAP (32-255)"
200 AT #1,1,0: PRINT "------------------------"
210 REMark --- Display characters in columns ---
220 row=3: col=0
230 FOR c=32 TO 255
240   AT #1,row,col
250   REMark Print code number (3 digits) + character
260   IF c<100 THEN PRINT #1," ";
270   PRINT #1,c;" ";CHR$(c);"  ";
280   REMark Move to next row
290   row=row+1
300   REMark Switch to next column when reaching bottom
310   IF row>24 THEN row=3: col=col+7
320 NEXT c
330 REMark --- Wait for keypress to exit ---
340 AT #1,0,45: PRINT #1,"PRESS A KEY"
350 PAUSE
