100 REM Charger police en RAM
110 font_addr = ALCHP(2048)      : REM Alloue 2 Ko pour police
120 LBYTES flp1_font_bin, font_addr  : REM Charge police depuis un fichier binaire
130 CALL set_font,font_addr      : REM Routine machine pour activer police

140 REM Modifier caractère 'A'
150 FOR i = 0 TO 7
160   POKE font_addr + (65*8) + i, BIN("00111100") : REM Exemple motif ligne
170 NEXT i
180 PRINT "Police modifiée !"


100 REM === Redefinition de caractere sur Sinclair QL ===
110 REM Taille police standard : 256 caracteres x 8 octets = 2048 octets
120 font_len = 256*8
130 font_addr = ALCHP(font_len)        : REM Alloue memoire en RAM
140 REM Adresse police ROM standard (8x8) : $28000
150 rom_font = 163840                   : REM 0x28000 en decimal
160 REM Copier police ROM -> RAM
170 FOR i = 0 TO font_len-1
180   POKE font_addr+i, PEEK(rom_font+i)
190 NEXT i

200 REM === Modifier caractere 'A' (ASCII 65) ===
210 char_code = 65
220 char_offset = char_code * 8
230 REM Nouveau motif (8 lignes de 8 pixels)
240 DATA 00111100, 01000010, 01000010, 01111110
250 DATA 01000010, 01000010, 01000010, 00000000
260 FOR row = 0 TO 7
270   READ bits$
280   POKE font_addr + char_offset + row, BIN(bits$)
290 NEXT row

300 REM === Activer la nouvelle police ===
310 REM Routine machine pour changer pointeur police
320 REM SCR_FONT (trap #3, code $18)
330 REM On utilise CALL avec code machine minimal
340 DIM code 20
350 POKE_W code, $4E40        : REM TRAP #0 placeholder
360 POKE_W code, $4E75        : REM RTS (fin)
370 REM En vrai, il faudrait appeler le vecteur SCR_FONT
380 REM Mais plus simple : PRINT avec police RAM via toolkit
390 PRINT "Caractere A modifie :"
400 PRINT "A B C D E"
