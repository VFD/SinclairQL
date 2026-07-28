100 REMark -----------------
110 REMark QL screen value
120 REMark Test SCALE
130 REMark to obtain X right
140 REMark -----------------
150 MODE 8: CLS
160 ScreenX = 512: REMark fixe for purpose
170 ScreenY = 256: REMark 
180 INPUT #0,"Window Width  : ";wid
190 INPUT #0,"Window Height : ";hi
200 INPUT #0,"Scale         : ";size
210 WINDOW wid,hi,0,0
220 PAPER 0:INK 7:CLS
230 :
240 SCALE size,0,0
250 :
260 Xratio = ScreenX/512: Yratio = ScreenY/256
270 PRINT #0,"Xr:" ! Xratio ! " - Yr:" ! Yratio
280 :
290 REMark Need to understand this formula
300 XY_ratio= ( 101 * Yratio / hi ) * wid / ( '135.5041505'*Xratio )
310 PRINT #0,"XY_ratio: " ! XY_ratio
320 :
330 x_right = INT( size * XY_ratio ): y_up = size
340 PRINT #0,"X right "; x_right ! " - Y up: "; y_up
350 :
360 LINE 0,0 TO x_right,y_up
370 LINE 0,y_up TO x_right,0
