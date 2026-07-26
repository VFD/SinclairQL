1000 REMark QBITS_Maze_v4 [QBITS Maze Game v4 2021 QPCII]
1001 :
1002 OPEN_IN#9,'ram2_QBITSConfig':INPUT#9,gx\gy\dn$\dev$\dn%\dm%
1003 DIM drv$(15,5):FOR d=0 TO 15:INPUT#9,drv$(d):END FOR d:CLOSE#9
1004 :
1005 WHEN ERRor
1006  eck=1:CONTINUE
1007 END WHEN
1008 :
1009 REMark Arrays
1010 SD$='MazeData_':LLoad
1011 DIM dir$(4,5):RESTORE 1011:FOR c=1 TO 4:READ dir$(c)
1012 DATA 'West ','East ','North', 'South'
1013 DIM SKey(5,3):RESTORE 1013:FOR i=1 TO 5:READ SKey(i,1):READ SKey(i,2)
1014 DATA -34,32, -40,3, 40,3, 34,32, 0,50
1015 DIM grid(21,17),cell(20*16):w=20:h=16
1016 DIM Mkey(5),Tres(12,3),name$(3,10),Grad(3,3)
1017 :
1018 REMark Variables
1019 w=20:h=16:x=0:y=0:cx=0:cy=0:px=0:py=0  :REMark Various Coordinates
1020 lev=1:glev=2:gmax=16:gdel=120          :REMark Maze Level/Guardians
1021 Gclk=DATE:GTS=0:sm=0:snum=0:sl=1       :REMark Score/Time/Moves/Points
1022 bc=0:sc=0:tc=0:scol=0:col=0            :REMark Various Colours
1023 gst=0:fd=3                 :REMark Maze Moves/Direction
1024 eck=0:pck=0:mck=0:TM=0     :REMark Checks:ERR/FilePath/MazeGen/Test Mode
1025 :
1026 MODE 4:f=0:m=1:Init_Win:Init_Maze:LScore:Mes1:QBITS_Maze
1027 :
1028 DEFine PROCedure QBITS_Maze
1029 REPeat Maze_lp
1030  IF gst=1:Score:ELSE Gclk=DATE:Score
1031  IF gdel=0:MGuard
1032  k=CODE(INKEY$(20))
1033  SELect ON k
1034    = 61:IF TM=0:TM=1:ELSE TM=0        :REMark [=]  Test Mode
1035    =232:IF TM=1:km=1:kr=1:MGuard      :REMark [F1] Guardians
1036    =236:IF TM=1:PortChk:GView         :REMark [F2] Open Portal
1037    =240:IF TM=1:snum=snum+50:Score    :REMark [F3] Score +
1038    =244:IF TM=1:snum=snum-50:Score    :REMark [F4] Score -
1039    =248:IF TM=1:tc=0:GView:tc=3:GView :REMark [F5] Key Stone
1040    = 86,118:GView                     :REMark [V]iew ON/OFF
1041    = 80,112:GPause:Gclk=DATE          :REMark [P]ause
1042    = 78,110:GNew :mck=1:GPause        :REMark [N]ew (Maze Check)
1043    = 76,108:MLoad:mck=1:GPause        :REMark [L]oad (Maze check)
1044    = 83,115:IF mck=1:MSave            :REMark [S]ave
1045    = 69,101:GExit                     :REMark [E]xit
1046    =192:IF gst=1:fd=1:MazView         :REMark Left  West
1047    =200:IF gst=1:fd=2:MazView         :REMark Right East
1048    =208:IF gst=1:fd=3:MazView         :REMark Up    North
1049    =216:IF gst=1:fd=4:MazView         :REMark Down  South
1050    ON k=32                            :REMark SpaceBar Forward
1051       IF snum<5:Mes2:GO TO 1067
1052       IF snum< 50+ 50*lev:BLOCK#4,30,30,300,216,0:km=0
1053       IF snum<500+500*lev:BLOCK#4,50,30,332,216,0:kr=0
1054       IF fvn=1
1055          INK#2,5:CURSOR#2,236,190:PRINT#2,'Solid Wall!':CLS#2,4
1056          BEEP 1000,1,140,190,0,0,0:PAUSE 20
1057       ELSE
1058          IF fd=1 : px=px-1            :REMark One Cell West
1059          IF fd=2 : px=px+1            :REMark One Cell East
1060          IF fd=3 : py=py-1            :REMark One cell North
1061          IF fd=4 : py=py+1            :REMark One cell South
1062          BLOCK#3,4,3,2+cx*6,1+cy*5,0  :cx=px:cy=py
1063          BLOCK#3,4,3,2+cx*6,1+cy*5,bc :REMark 2D Maze cell position
1064          BEEP 2000,20,40,190,0,0,0:gst=1
1065          ofd=fd:gdel=gdel-1:snum=snum-sl:sm=sm+1:MazView
1066          Loot=grid(px,py):SELect ON Loot=1,2,4,8:TresChk
1067       END IF
1068  END SELect
1069  END REPeat Maze_lp
1070 END DEFine
1071 :
1072 DEFine PROCedure Score
1073 INK#4,6:clk$=DATE$(DATE-Gclk+GTS):CURSOR#4,6,212
1074 PRINT#4,'Time:';clk$(13 TO 20);'  Moves: ';FILL$(' ',4-LEN(sm))&sm
1075 PRINT#5,'SCORE  ';FILL$(' ',6-LEN(snum))&snum
1076 END DEFine
1077 :
1078 DEFine PROCedure MazView
1079 fvn=0:INK#2,6:CURSOR#2,178,190:PRINT#2,dir$(fd):CLS#2,4
1080 FOR n=1 TO 5
1081   fv(n)=0                                       :REMark fv forward view
1082   IF fd=1
1083      cw=grid(px-n+1,py):IF Walls(8,cw)=1:fv(n)=1
1084      IF Walls(4,cw)=1:fv(n)=fv(n)+2             :REMark cw cell walls
1085      IF Walls(1,cw)=0:fvn=n:EXIT n   :REMark fvn forward view num cell
1086   END IF
1087   IF fd=2
1088      cw=grid(px+n-1,py):IF Walls(8,cw)=1:fv(n)=2
1089      IF Walls(4,cw)=1:fv(n)=fv(n)+1
1090      IF Walls(2,cw)=0:fvn=n:EXIT n
1091   END IF
1092   IF fd=3
1093      cw=grid(px,py-n+1):IF Walls(1,cw)=1:fv(n)=1
1094      IF Walls(2,cw)=1:fv(n)=fv(n)+2
1095      IF Walls(4,cw)=0:fvn=n:EXIT n
1096   END IF
1097   IF fd=4
1098      cw=grid(px,py+n-1):IF Walls(1,cw)=1:fv(n)=2
1099      IF Walls(2,cw)=1:fv(n)=fv(n)+1
1100      IF Walls(8,cw)=0:fvn=n:EXIT n
1101   END IF
1102 END FOR n
1103 vn=fvn:IF fvn=0 :fvn=6:vn=5  :REMark fvn vn forward view num cells
1104 xw=58*(2/3)^((vn-1)*2):ytw=14*xw/15:ybw=-2*xw/5
1105 BLOCK 240,82,0,0,7,0,1:BLOCK 240,38,0,82,0,5,3  :REMark Roof & Floor
1106 IF fvn=6
1107    INK 0,2,1
1108    FILL 1:LINE -xw,ytw TO xw,ytw TO xw,ybw TO -xw,ybw TO -xw,ytw:FILL 0
1109    GO TO 1113
1110 END IF
1111 INK 0,2,3
1112 FILL 1:LINE -xw,ytw TO xw,ytw TO xw,ybw TO -xw,ybw TO -xw,ytw:FILL 0
1113 REPeat sidewalls
1114  Wallcalc:cdv=fv(vn):INK 0,2,3
1115  IF cdv=2 OR cdv=3
1116      FILL 1:LINE oxw,oyt TO oxw,oyb TO xw,oyb TO xw,oyt TO oxw,oyt:FILL 0
1117  END IF
1118  IF cdv=1 OR cdv=3
1119     FILL 1:LINE -oxw,oyt TO -oxw,oyb TO -xw,oyb TO -xw,oyt TO -oxw,oyt:FILL 0
1120  END IF
1121  INK 0,2,2
1122  IF cdv=0 OR cdv=1
1123     FILL 1:LINE oxw,oyt TO oxw,oyb TO xw,ybw TO xw,ytw TO oxw,oyt:FILL 0
1124  END IF
1125  IF cdv=0 OR cdv=2
1126     FILL 1:LINE -oxw,oyt TO -oxw,oyb TO -xw,ybw TO -xw,ytw TO -oxw,oyt:FILL 0
1127   END IF
1128   Wallcalc
1129   FILL 1:LINE oxw,oyt TO oxw,oyb TO xw,ybw TO xw,ytw TO oxw,oyt:FILL 0
1130   FILL 1:LINE -oxw,oyt TO -oxw,oyb TO -xw,ybw TO -xw,ytw TO -oxw,oyt:FILL 0
1131   vn=vn-1:IF vn=0 : EXIT sidewalls
1132 END REPeat sidewalls
1133 END DEFine
1134 :
1135 DEFine FuNction Walls(side,wall)
1136 ans=0
1137 IF side=1:SELect ON wall=1,3,5,7,9,11,13,15  :ans=1
1138 IF side=2:SELect ON wall=2,3,6,7,10,11,14,15 :ans=1
1139 IF side=4:SELect ON wall=4,5,6,7,12,13,14,15 :ans=1
1140 IF side=8 AND wall>7 :ans=1
1141 RETurn ans           :REMark identify fd (forward direction)
1142 END DEFine
1143 :
1144 DEFine PROCedure Wallcalc
1145 oxw=xw:xw=xw*1.5:oyt=ytw:oyb=ybw:ytw=14*xw/15:ybw=-2*xw/5
1146 END DEFine
1147 :
1148 DEFine PROCedure TresChk
1149 FOR i=1 TO 12
1150  IF Tres(i,1)=px AND Tres(i,2)=py
1151    tn=Tres(i,3):IF tn=0:EXIT i
1152    BLOCK 100,60,70,24,0,2,2:FOR j=1 TO 8:BLOCK j*10,60,120-j*5,24,0:PAUSE 5
1153    ch=1:INK 2:x=0:y=20:INK#2,6:CURSOR#2,236,190
1154    LINE x-24,y-10 TO x-20,y TO x+20,y TO x+24,y-10 TO x-24,y-10
1155    LINE x-24,y-10 TO x-24,y-12 TO x+24,y-12 TO x+24,y-10
1156    IF tn>1 AND tn<7
1157       Coin 1,-4,26:PRINT#2,'Coin of Karnak':snum=snum+50*tn
1158    END IF
1159    IF tn=7
1160       Mask 4,220,20:Mask 1,0,20:km=1
1161       PRINT#2,'Mask of Wisdom':snum=snum+50+50*lev
1162    END IF
1163    IF tn=8
1164       Ring 4,250,22:Ring 1,0,22:kr=1
1165       PRINT#2,'Ring of Power ':snum=snum+500+500*lev
1166    END IF
1167    IF tn=9:KStone 1,0,20:PortChk:EXIT i
1168    Tres(i,3)=0
1169  END IF
1170 END FOR i
1171 END DEFine
1172 :
1173 DEFine PROCedure PortChk
1174 CURSOR#2,236,190:PRINT#2,'Key Stone - Portal to Next Level (Y/N)'
1175 IF INKEY$(#2,-1)=='Y'
1176   IF lev=5
1177     IF gmax>0:CURSOR#2,236,190:PRINT#2,'Defeat All Guardians':CLS#2,4:RETurn
1178     CURSOR#2,236,190:CLS#2,4:CLS:KeyStone
1179   ELSE
1180     lev=lev+1:glev=lev+1:IF glev>gmax OR lev=5:glev=gmax
1181     CLS:MPort:PAUSE 20:col=5:MazLev:MazNew:MazHall:MazTres:MazView
1182     snum=snum+2000:tc=0:bc=0:km=0:kr=0:gdel=120/RND(2 TO 4)
1183     px=RND(2 TO 19):py=RND(2 TO 15):CURSOR#2,220,190:CLS#2,4
1184   END IF
1185 ELSE
1186   tc=1:BLOCK#2,240,10,230,190,0
1187 END IF
1188 END DEFine
1189 :
1190 DEFine PROCedure MGuard
1191 IF glev=0:RETurn :ELSE Guard 1:INK 7:MPort
1192 PAUSE 20:MazView:Guard 1:INK#2,6:gdel=120/RND(2 TO 4)
1193 REPeat G_lp
1194  IF snum<  50:EXIT G_lp
1195  CURSOR#2,236,190:PRINT#2,'Use [1]Shield [2]Sword':CLS#2,4
1196  IF km=1 AND snum>50+50*lev:CURSOR#2,374,190:PRINT#2,'[3]Mask'
1197  IF kr=1 AND snum>500+500*lev:CURSOR#2,422,190:PRINT#2,'[4]Ring'
1198  k=CODE(INKEY$(-1))
1199  IF k=49:snum=snum-50:px=RND(3 TO 17):py=RND(3 TO 14):CLS:EXIT G_lp
1200  IF k=50
1201     INK#4,5:FOR i=1 TO 6 :CURSOR#4,197,170:PRINT#4,i:PAUSE 20
1202     a=RND(1 TO 6):INK#4,7:CURSOR#4,197,170:PRINT#4,a:PAUSE 20
1203     IF a=6 :INK#2,4:gmax=gmax-1:glev=glev-1:EXIT G_lp
1204     IF a<>6:INK#2,2:snum=snum-50:Score
1205  INK#2,6:CURSOR#2,236,190:PRINT#2,'Try Again':CLS#2,4:PAUSE 30
1206  END IF
1207  IF k=51 AND snum>50+50*lev:snum=snum-50-50*lev:gdel=120:EXIT G_lp
1208  IF k=52 AND snum>500+500*lev
1209     snum=snum-500-500*lev:gmax=gmax-glev:glev=0:EXIT G_lp
1210  END IF
1211 END REPeat G_lp
1212 GView:Score:CURSOR#2,236,190:CLS#2,4:INK 7:MPort:PAUSE 20:MazView
1213 INK#2,5:CURSOR#2,148,30+10*lev:PRINT#2,glev;'  ';gmax;'  '
1214 END DEFine
1215 :
1216 REMark Vector Graphics
1217 :
1218 DEFine PROCedure Guard(ch)
1219 IF ch=1:x=0:y=- 4  :INK#ch,0:FILL#ch,1
1220 IF ch=4:x=140:y=104:INK#ch,7:FILL#ch,0
1221 LINE#ch,x-5,y+32 TO x-5,y+26 TO x-12,y+25 TO x-14,y+6 TO x-10,y+4
1222 LINE#ch TO x-8,y-16 TO x-12,y-17 TO x-12,y-20 TO x+12,y-20 TO x+12,y-17
1223 LINE#ch TO x+8,y-16 TO x+10,y+4 TO x+14,y+6 TO x+12,y+25 TO x+5,y+26
1224 LINE#ch TO x+5,y+32 TO x-5,y+32:FILL#ch,0
1225 INK#ch,7:LINE#ch,x-8,y+4 TO x-2,y+4 TO x-2,y+8 TO x-8,y+9
1226 IF ch=1:Shield 1, 10, 20:Sword 1, 0,-24:Mask 1,  0, 26
1227 IF ch=4:Shield 4,150,128:Sword 4,140,82:Mask 4,140,134
1228 END DEFine
1229 :
1230 DEFine PROCedure MPort
1231 BEEP 2000,20,40,190,0,0,0:ch=1:x=0:y=20:INK#ch,7
1232 FOR i=0 TO 16 STEP 4
1233   CIRCLE#ch,0,-20+i*2,25-i,.2,PI/2:CIRCLE#ch,0,50-i*2,25-i,.2,PI/2
1234   LINE#ch,-i,-22+i/8 TO -i,52-i/8:LINE#ch,+i,-22+i/8 TO i,52-i/8
1235 END FOR i
1236 END DEFine
1237 :
1238 DEFine PROCedure Coin(ch,x,y)
1239 INK#ch,6:FILL#ch,1:CIRCLE#ch,x,y,10,.6,PI:FILL#ch,0
1240 INK#ch,0:CIRCLE#ch,x+3,y-1,10,.7,PI
1241 INK#ch,6:FILL#ch,1:CIRCLE#ch,x+10,y-4,10,.6,PI/4:FILL#ch,0
1242 INK#ch,0:CIRCLE#ch,x+10,y-4,10,.6,PI/4
1243 INK#ch,0:CIRCLE#ch,x+12,y-4,9,.5,PI/4
1244 END DEFine
1245 :
1246 DEFine PROCedure Shield(ch,x,y)
1247 FILL#ch,1:INK#ch,5:ARC#ch,x,y TO x-9,y-4, -PI/4
1248 ARC#ch,x-9,y-4 TO x,y-22, PI/2:ARC#ch,x,y-22 TO x+9,y-4, PI/2
1249 ARC#ch,x+9,y-4 TO x,y, -PI/4:FILL#ch,0
1250 END DEFine
1251 :
1252 DEFine PROCedure Sword(ch,x,y)
1253 FILL#ch,1:INK#ch,7
1254 LINE#ch,x,y TO x-1,y+3 TO x-1,y+20 TO x+1,y+20 TO x+1,y+3 TO x,y
1255 FILL#ch,0:INK#ch,0:LINE#ch,x,y+2 TO x,y+18:INK#ch,3
1256 FILL#ch,1:CIRCLE#ch,x,y+22,5,.2,PI/2:FILL#ch,0
1257 FILL#ch,1:CIRCLE#ch,x,y+26,5,.2,PI:FILL#ch,0:CIRCLE#ch,x,y+28,1
1258 END DEFine
1259 :
1260 DEFine PROCedure Mask(ch,x,y)
1261 INK#ch,5:FILL#ch,1:ARC#ch,x+7,y+9 TO x-7,y+9,PI/2
1262 LINE#ch,x-7,y+9 TO x-7,y-2 TO x,y-4 TO x+7,y-2 TO x+7,y+9:FILL#ch,0
1263 INK#ch,0:FILL#ch,1:LINE#ch,x+6,y+7 TO x,y+6 TO x,y+3 TO x+6,y+7:FILL#ch,0
1264 FILL#ch,1:LINE#ch,x-6,y+7 TO x,y+6 TO x,y+3 TO x-6,y+7:FILL#ch,0
1265 LINE#ch,x,y+4 TO x,y-4
1266 END DEFine
1267 :
1268 DEFine PROCedure Ring(ch,x,y)
1269 INK#ch,6:FILL#ch,1:CIRCLE#ch,x,y,11,.6,PI/2 :FILL#ch,0
1270 INK#ch,0:FILL#ch,1:CIRCLE#ch,x,y-1,9,.5,PI/2:FILL#ch,0
1271 INK#ch,6:FILL#ch,1:CIRCLE#ch,x,y+6,5,.5,PI/2:FILL#ch,0
1272 INK#ch,0:LINE#ch,x-3,y+9 TO x+3,y+9 TO x+3,y+5 TO x-3,y+5 TO x-3,y+9
1273 END DEFine
1274 :
1275 DEFine PROCedure KStone(ch,x,y)
1276 BEEP 2000,20,40,190,0,0,0:INK#ch,6:FILL#ch,1
1277 LINE#ch,x,y+6 TO x-6,y TO x,y-6 TO x+6,y TO x,y+6:FILL#ch,0
1278 INK#ch,0:LINE#ch,x,y+8 TO x-6,y TO x,y-8 TO x+6,y TO x,y+8
1279 LINE#ch,x,y+8 TO x-2,y-2 TO x,y-8
1280 LINE#ch,x-6,y TO x-2,y-2 TO x+6,y
1281 END DEFine
1282 :
1283 REMark New Game / Level Change
1284 :
1285 DEFine PROCedure MazNew
1286 w=20:h=16:DIM grid(w+1,h+1),cell(w*h,2),pm(5),fv(5)
1287 CLS#3:INK 7:x=w/2:y=h:cell(0,1)=x:cell(0,2)=y:inc=40:cn=1
1288 INK#2,5:CURSOR#2,18,190:PRINT#2,'Direction      Move':INK#2,7
1289 CURSOR#2,76,190:PRINT#2,'¼¾¿½':BLOCK#2,18,3,136,194,7
1290 FOR n=1 TO w*h-1
1291    p=0:PAUSE mp             :REMark p - Pass / mp - 0.5
1292    IF x>1 AND grid(x-1,y)=0 : p=p+1:pm(p)=1   :REMark West wall
1293    IF x<w AND grid(x+1,y)=0 : p=p+1:pm(p)=2   :REMark East wall
1294    IF y>1 AND grid(x,y-1)=0 : p=p+1:pm(p)=3   :REMark North wall
1295    IF y<h AND grid(x,y+1)=0 : p=p+1:pm(p)=4   :REMark South wall
1296    IF p=0
1297      IF m=1:cn=cn-1:x=cell(cn,1):y=cell(cn,2)
1298      IF m=2:cn=0:x=RND(w):y=RND(h):cell(cn,1)=x:cell(cn,2)=y
1299      IF m=3:x=x+1:IF x>w : x=1 :y=y+1:IF y>h : y=1
1300      IF grid(x,y)=0 : GO TO 1297
1301      GO TO 1292
1302    END IF
1303    r=pm(RND(1 TO p)):cn=cn+1:cell(cn,1)=x:cell(cn,2)=y
1304    IF r=1 : grid(x,y)=grid(x,y)+1:x=x-1:grid(x,y)=2:bx=x*6:by=y*5
1305    IF r=2 : grid(x,y)=grid(x,y)+2:bx=x*6:x=x+1:grid(x,y)=1:by=y*5
1306    IF r=3 : grid(x,y)=grid(x,y)+4:y=y-1:grid(x,y)=8:bx=x*6:by=y*5
1307    IF r=4 : grid(x,y)=grid(x,y)+8:by=y*5:y=y+1:grid(x,y)=4:bx=x*6
1308    IF r=1 OR r=2 :BLOCK#3,8,3,2+bx,1+by,0
1309    IF r=3 OR r=4 :BLOCK#3,4,8,2+bx,1+by,0
1310  END FOR n
1311 END DEFine
1312 :
1313 DEFine PROCedure MazHall
1314 REMark grid r row/c col:hw hall width:cw cell wall:sf side facing
1315 FOR hall=1 TO 6
1316  tx=RND(4 TO 16):ty=RND(4 TO 12):RESTORE 1328
1317  FOR r=0 TO 1
1318    FOR c=0 TO 2
1319     BLOCK#3,16,8,2+tx*6,1+ty*5,0
1320     BLOCK#3,2,2,6+tx*6,4+ty*5,5 :BLOCK#3,2,2,12+tx*6,4+ty*5,5
1321     FOR hw=1 TO 3
1322        cw=grid(tx+c,ty+r):READ sf
1323        IF Walls(sf,cw)=0:grid(tx+c,ty+r)=grid(tx+c,ty+r)+sf
1324     END FOR hw
1325    END FOR c
1326 END FOR r
1327 END FOR hall
1328 DATA 2,8,8,1,2,8,1,8,8,2,4,4,1,2,4,1,4,4
1329 END DEFine
1330 :
1331 DEFine PROCedure MazLev
1332 BLOCK#2,50,58,132,40,0:BLOCK#4,200,40,300,212,0
1333 FOR i=1 TO 5
1334   IF i=lev:INK#2,5:ELSE INK#2,3
1335   CURSOR#2,16,30+i*11:PRINT#2,i
1336   LINE#2,26,84-i*5 TO 46,84-i*5 TO 36,80-i*5 TO 16,80-i*5 TO 26,84-i*5
1337   IF i<lev:KStone 4,280+i*12,20
1338 END FOR i
1339 IF lev=1:px=10:py=16:ELSE px=RND(3 TO 18):py=RND(2 TO 14)
1340 INK#2,col:CURSOR#2,148,30+10*lev:PRINT#2,glev;' ';gmax
1341 END DEFine
1342 :
1343 DEFine PROCedure MazTres
1344 DIM Tres(12,3):n=1
1345 REPeat t_lp
1346   IF n>12:n=1:EXIT t_lp
1347   tx=RND(1 TO w):ty=RND(1 TO h):tn=grid(tx,ty)
1348   FOR i=1 TO n:IF Tres(i,1)=tx AND Tres(i,2)=ty:NEXT t_lp
1349   SELect ON tn=1,2,4,8:Tres(n,1)=tx:Tres(n,2)=ty:n=n+1
1350 END REPeat t_lp
1351 FOR i=1 TO 12:Tres(i,3)=RND(2 TO 6)
1352 Tres(3,3)=7:km=0:Tres(11,3)=8:kr=0:Tres(7,3)=9
1353 END DEFine
1354 :
1355 DEFine PROCedure MazKey
1356 DIM Mkey(5):RESTORE 1360:ra=RND(24)
1357 FOR i=1 TO 24
1358   READ a,b,c,d:IF i=ra:SKey(1,3)=a:SKey(2,3)=b:SKey(3,3)=c:SKey(4,3)=d
1359 END FOR i
1360 DATA 1,2,3,4, 1,3,2,4, 2,3,1,4, 2,1,3,4, 3,1,2,4, 3,2,1,4
1361 DATA 2,3,4,1, 3,2,4,1, 3,1,4,2, 1,3,4,2, 1,2,4,3, 2,1,4,3
1362 DATA 3,4,1,2, 2,4,1,3, 1,4,2,3, 3,4,2,1, 2,4,3,1, 1,4,3,2
1363 DATA 4,1,2,3, 4,1,3,2, 4,2,3,1, 4,2,1,3, 4,3,1,2, 4,3,2,1
1364 END DEFine
1365 :
1366 REMark Menu Commands
1367 :
1368 DEFine PROCedure Mes1
1369 BLOCK#2,200,26,240,40,0
1370 INK#2,6:CURSOR#2,240,48:PRINT#2,'Select (N)ew or (L)oad':gck=0
1371 END DEFine
1372 :
1373 DEFine PROCedure MSel                        :REMark Maze Algorithm
1374 IF m=1:Maz$='Recursive Backtraking'
1375 IF m=2:Maz$='Prims Algorithm'
1376 IF m=3:Maz$='Hunt and Kill Method'
1377 INK#2,3:CURSOR#2,332,12:PRINT#2,FILL$(' ',25-LEN(Maz$))&Maz$
1378 END DEFine
1379 :
1380 DEFine PROCedure GView
1381 IF gck=0:RETurn
1382 IF tc=0:tc=3:bc=7:sl=lev*5:ELSE tc=0:bc=0:sl=lev
1383 IF TM=1:BLOCK#3,4,3,2+Tres(7,1)*6,1+Tres(7,2)*5,241:PAUSE 20
1384 BLOCK#3,4,3,2+cx*6,1+cy*5,0:cx=px:cy=py:BLOCK#3,4,3,2+cx*6,1+cy*5,bc
1385 FOR n=1 TO 12:IF Tres(n,3)>0:BLOCK#3,4,3,2+Tres(n,1)*6,1+Tres(n,2)*5,tc
1386 END DEFine
1387 :
1388 DEFine PROCedure GPause
1389 IF gck=0:RETurn
1390 INK#2,6:CURSOR#2,240,48:PRINT#2,'Press any key to continue...'
1391 GTS=(DATE-Gclk+GTS):PAUSE:BLOCK#2,250,10,240,48,0
1392 END DEFine
1393 :
1394 DEFine PROCedure GNew
1395 GTS=(DATE-Gclk+GTS):INK#2,6:CURSOR#2,240,48
1396 PRINT#2,'Select Maze Algorythm  [1][2][3]       ¼'
1397 BLOCK#2,12,3,460,52,6:BLOCK#2,2,4,480,50,6:INK#2,3:om=m
1398 REPeat New_lp
1399  MSel:k=CODE(INKEY$(-1))
1400  SELect ON k
1401    =49,50,51:m=k-48
1402    =32:BLOCK#2,250,10,240,48,0:m=om:MSel:RETurn
1403    =10:BLOCK#2,250,10,240,48,0:CLS:EXIT New_lp
1404  END SELect
1405 END REPeat New_lp
1406 gdel=120/RND(3 TO 4):gmax=16:glev=2:lev=1:col=5:MazLev:MazKey
1407 GTS=0:Gclk=DATE:sm=0:snum=2000:Score:gck=1:gst=1
1408 w=20:h=16:mp=.5:MazNew:MazHall:MazTres:MazView:mp=0
1409 END DEFine
1410 :
1411 DEFine PROCedure SelPath
1412 REMark TS=(DATE-Gclk+GTS):INK#2,6
1413 INK#2,6:CURSOR#2,240,48:PRINT#2,'Select:¾¿      ';SD$;'  ¼½   ¼'
1414 BLOCK#2,12,3,412,52,6:BLOCK#2,2,4,432,50,6
1415 REPeat Path_lp
1416  CURSOR#2,300,48:PRINT#2,drv$(dn%):CURSOR#2,384,48:PRINT#2,fnum
1417  k=CODE(INKEY$(-1))
1418  SELect ON k
1419   =192:fnum=fnum-1:IF fnum<0:fnum=9
1420   =200:fnum=fnum+1:IF fnum>9:fnum=0
1421   =208:dn%=dn%-1:IF dn%<0:dn%=dm%
1422   =216:dn%=dn%+1:IF dn%>dm%:dn%=0
1423   = 10:pck=1:EXIT Path_lp
1424   = 32:pck=0:EXIT Path_lp
1425  END SELect
1426 END REPeat Path_lp
1427 END DEFine
1428 :
1429 DEFine PROCedure FCheck
1430 CURSOR#2,240,48:PRINT#2,'Searching...':CLS#2,4
1431 PAUSE 20:DELETE drv$(dn%)&'FList'
1432 OPEN_NEW#99,drv$(dn%)&'FList':DIR#99,drv$(dn%):CLOSE#99
1433 OPEN_IN#99,drv$(dn%)&'FList'
1434 REPeat Dir_lp
1435   IF EOF(#99):CLOSE#99:BLOCK#2,250,10,240,48,0:pck=0:EXIT Dir_lp
1436   INPUT#99,Fchk$:IF Fchk$==SD$&fnum:CLOSE#99:pck=1:EXIT Dir_lp
1437 END REPeat Dir_lp
1438 END DEFine
1439 :
1440 DEFine PROCedure MLoad
1441 SelPath:IF pck=0:BLOCK#2,250,10,240,48,0:RETurn :ELSE FCheck
1442 IF pck=0 OR eck=1
1443    CURSOR#2,240,48:PRINT#2,'File Not Found...':CLS#2,4
1444    PAUSE 20:BLOCK#2,250,10,240,48,0:eck=0:RETurn
1445 END IF
1446 OPEN_IN#99,drv$(dn%)&SD$&fnum:CURSOR#2,240,48:PRINT#2,'Loading...';
1447 FOR n=1 TO 12:INPUT#99,Tres(n,3):PRINT#2,'.';:PAUSE 2
1448 INPUT#99,m\lev\gmax\glev\km\kr\GTS\sm\snum:CLOSE#99
1449 CLS:MazNew:MazHall:MazTres:MazKey
1450 MSel:col=5:MazLev:Score:MazView
1451 IF km=1:Mask 4,220,20
1452 IF kr=1:Ring 4,250,22
1453 BLOCK#2,250,10,240,48,0:gdel=120/RND(2 TO 4):gst=1:gck=1
1454 END DEFine
1455 :
1456 DEFine PROCedure MSave
1457 SelPath:IF pck=0 OR gck=0:BLOCK#2,250,10,240,48,0:RETurn :ELSE FCheck
1458 IF eck=1
1459    CURSOR#2,240,48:PRINT#2,'DEVICE ERROR...':CLS#2,4
1460    PAUSE 20:BLOCK#2,250,10,240,48,0:eck=0:RETurn
1461 END IF
1462 IF pck=1
1463    CURSOR#2,240,48:PRINT#2,'Overwrite y/n'
1464    IF KEYROW(5)<>64:BLOCK#2,250,10,240,48,0:RETurn
1465 END IF
1466 DELETE drv$(dn%)&SD$&fnum:OPEN_NEW#99,drv$(dn%)&SD$&fnum
1467 CURSOR#2,240,48:PRINT#2,'Saving...';
1468 FOR n=1 TO 12:PRINT#99,Tres(n,3):PRINT#2,'.';:PAUSE 2
1469 PRINT#99,m\lev\gmax\glev\km\kr\GTS\sm\snum:CLOSE#99
1470 BLOCK#2,250,10,240,48,0
1471 END DEFine
1472 :
1473 DEFine PROCedure GExit
1474 INK#2,6:CURSOR#2,240,48:PRINT#2,'Exit Game (Y/N)':CLS#2,4:PAUSE
1475 IF KEYROW(5)=64:LRUN dn$:ELSE CURSOR#2,200,48:CLS#2,4
1476 END DEFine
1477 :
1478 REMark Sphere of Destiny - Matching Keystones
1479 :
1480 DEFine PROCedure KeyStone
1481 KStone 4,340,20:scol=6:SDest:SRing
1482 CURSOR#2,258,44:PRINT#2,'Activate the Sphere of Destiny'
1483 CURSOR#2,240,54:PRINT#2,'by Matching the Sphere and Maze Keys'
1484 INK#2,5:CURSOR#2,250,190:PRINT#2,'Use        to Match and Test Keys'
1485 INK#2,7:CURSOR#2,274,190:PRINT#2,'¼¾¿½ ¼':BLOCK#2,2,4,310,192,7
1486 check=0:col=0:FOR kp=1 TO 4:ks=kp:GetKey
1487 REPeat key_lp
1488  IF snum<500:snum=0:Score:Mes2:EXIT key_lp
1489  GetKey:k=CODE(INKEY$(-1))
1490  SELect ON k
1491    =192:kp=kp-1:IF kp<1:kp=4
1492    =200:kp=kp+1:IF kp>4:kp=1
1493    =208:ks=ks+1:IF ks>4:ks=1
1494    =216:ks=ks-1:IF ks<1:ks=4
1495    = 10:MatchKey:IF schk<5:snum=snum-500:Score:ELSE Mes3:EXIT key_lp
1496    =248:IF col=0:col=5:ELSE col=0
1497  END SELect
1498 END REPeat key_lp
1499 gst=0:BLOCK#2,250,30,240,40,0:Mes1:QBITS_Maze
1500 END DEFine
1501 :
1502 DEFine PROCedure MatchKey
1503 schk=1:FOR i=1 TO 4:IF SKey(i,3)=Mkey(i):schk=schk+1
1504 END DEFine
1505 :
1506 DEFine PROCedure GetKey
1507 IF kp=1:Mkey(1)=ks:c=414
1508 IF kp=2:Mkey(2)=ks:c=430
1509 IF kp=3:Mkey(3)=ks:c=466
1510 IF kp=4:Mkey(4)=ks:c=484
1511 RESTORE 1514:INK#4,col:FOR i=1 TO 4:READ a:CURSOR#4,a,212:PRINT#4,SKey(i,3)
1512 RESTORE 1514:INK#4,5  :FOR i=1 TO 4:READ a:CURSOR#4,a,240:PRINT#4,Mkey(i)
1513 INK#4,6:CURSOR#4,c,240:PRINT#4,Mkey(kp)
1514 DATA 414,430,466,484
1515 END DEFine
1516 :
1517 DEFine PROCedure Mes2
1518 IF gst=0:RETurn
1519 INK#2,6:CURSOR#2,240,190:PRINT#2,'Hard Luck You FAILED - Try a New Game '
1520 CLS:CLS#3:lev=1:glev=2:MazLev:SEnd:col=0:fil=1:Guard(1):Mes1
1521 END DEFine
1522 :
1523 DEFine PROCedure Mes3
1524 INK#2,6:CURSOR#2,240,190:PRINT#2,'The Past has Changed - Humanity Saved '
1525 CLS:CLS#3:lev=1:glev=2:MazLev:SEnd:BLOCK#2,250,30,240,40,0:LName:Mes1
1526 END DEFine
1527 :
1528 DEFine PROCedure SDest
1529 col=5:ss=8:x=0:y=10:INK 7:FILL 0
1530 REPeat sphere_lp
1531  FOR i=0 TO 1.1  STEP .1
1532     ARC x,y+ss TO x,y-ss,PI*i:ARC x,y+ss TO x,y-ss,-PI*i
1533     INK col:IF col=5:col=0:ELSE col=5
1534  END FOR i
1535  BEEP 2000,8,20,-8,0,0,0:ss=ss+8:IF ss>56:EXIT sphere_lp
1536  PAUSE 5:INK 0:FILL 1:CIRCLE x,y,36+ss,ss*2/100,PI:FILL 0
1537 END REPeat sphere_lp
1538 INK 5:CIRCLE x,y,66,.3,PI/2:y=20:INK 6::FILL 0
1539 LINE x,y+9 TO x-16,y TO x-34,y+4 TO x-30,y-6 TO x-66,y-10
1540 LINE TO x-34,y-14 TO x-40,y-22 TO x-12,y-22 TO x,y-28 TO x+12,y-22
1541 LINE TO x+40,y-22 TO x+34,y-14 TO x+66,y-10 TO x+30,y-6 TO x+34,y+4
1542 LINE TO x+16,y TO x,y+9:FILL 0:INK 248
1543 FILL 1:LINE x-6,y-30 TO x-16,y-50 TO x+16,y-50 TO x+6,y-30
1544 LINE TO x-6,y-30:FILL 0
1545 FOR i=1 TO 6:CIRCLE x,y-10,i*5,.3,PI/2:PAUSE 2
1546 END DEFine
1547 :
1548 DEFine PROCedure SRing
1549 ch=1:scol=6:FOR i=1 TO 5:KStone 1,SKey(i,1),SKey(i,2):PAUSE 5
1550 END DEFine
1551 :
1552 DEFine PROCedure SEnd
1553 FOR i=1 TO 24 STEP 2
1554     INK 241:CIRCLE 0,14,i*3,.7,PI/2:BEEP 2000,40,120,90,0,0,0:PAUSE 2
1555 END FOR i
1556 INK 0:FILL 1:CIRCLE,0,14,60:FILL 0:BEEP 30000,1,250,90,-8,15,15:INK 7
1557 FOR i=50 TO 15 STEP -5
1558     ARC 0,i TO 0,-i/2,PI:ARC 0,-i/2 TO 0,i-5,PI:PAUSE i/5
1559 END FOR i
1560 BEEP 10000,4,200,190,0,0,0:PAUSE 20
1561 END DEFine
1562 :
1563 REMark QBITS Maze Screen Setup
1564 :
1565 DEFine PROCedure Init_Win
1566 OPEN#5,scr_:WINDOW#5,180,24,8+gx,226+gy :PAPER#5,0
1567 OPEN#4,scr_:WINDOW#4,512,256,gx,gy      :PAPER#4,0
1568 OPEN#3,scr_:WINDOW#3,136,90,28+gx,106+gy:PAPER#3,5
1569 CSIZE#5,2,1:INK#5,6:BORDER#4,1,3:CLS#4:SCALE#4,240,0,0
1570 WINDOW#2,496,204,8+gx,6+gy      :PAPER#2,0:BORDER#2,1,5
1571 WINDOW#1,240,120,240+gx,74+gy   :PAPER#1,0:SCALE#1,100,-74,-30
1572 WINDOW#0,496,32,gx+8,gy+220     :PAPER#0,0:CSIZE#0,0,0:INK#0,7
1573 END DEFine
1574 :
1575 DEFine PROCedure Init_Maze
1576 DIM S$(3,70),M$(7,40):CLS#2
1577 S$(1)='The Human Race is under Threat of Extinction from a Rogue DNA Gene'
1578 S$(2)='propagated by an Event in Prehistory.  Beneath the Tombs of Karnak'
1579 S$(3)='     lies the Sphere of Destiny and a Time Portal to the Past.'
1580 M$(1)='Your Mission to go back in Time and'
1581 M$(2)=' prevent the Event from happening.'
1582 M$(3)=' To Activate the Time Portal there'
1583 M$(4)=' are five  Key Stones  each hidden'
1584 M$(5)=' on a different Level of the Tombs'
1585 M$(6)='   however they are protected by'
1586 M$(7)='    Guardians (Phantom Knights)'
1587 CSIZE#2,2,1:OVER#2,1
1588 INK#2,2:FOR i=1 TO 2:CURSOR#2,7+i,3:PRINT#2,'QBITS Karnak Maze'
1589 INK#2,6:FOR i=1 TO 2:CURSOR#2,9+i,4:PRINT#2,'QBITS Karnak Maze'
1590 INK#2,6:FOR i=1 TO 2:CURSOR#2,8+i,70:PRINT#2,'Sphere of Destiny'
1591 CSIZE#2,0,0:OVER#2,0:INK#2,7
1592 INK#2,7:FOR i=1 TO 3:CURSOR#2,44,24+i*10:PRINT#2,S$(i)
1593 INK#2,5:FOR i=1 TO 7:CURSOR#2,12,86+i*10:PRINT#2,M$(i)
1594 Coin 4,140,22:Shield 4,180,32:Sword 4,200,6:Mask 4,220,22:Ring 4,250,22
1595 Score:FOR i=1 TO 4:KStone 4,280+i*12,20
1596 SDest:SRing:INK#2,3
1597 CURSOR#2,24,180:PRINT#2,'Press any key to continue...':PAUSE
1598 CLS:BLOCK#2,490,40,2,28,0:BLOCK#2,220,136,2,60,0
1599 OVER#2,1:col=0:lev=0:MazLev:INK#2,7:Guard(4)
1600 CURSOR#2,236,12:PRINT#2,'[=]'
1601 CURSOR#2,236,30:PRINT#2,'(V)iew (P)ause (N)ew (L)oad (S)ave (E)xit '
1602 CURSOR#2,237,30:PRINT#2,' V      P       N     L      S      E '
1603 INK#2,5:FOR i=0 TO 1:CURSOR#2,6+i,30:PRINT#2,'LEVEL'
1604 OVER#2,0:CURSOR#2,140,30:PRINT#2,'Guardians':gst=0:gck=0:gdel=120:pck=0
1605 INK#4,7:CIRCLE#4,140,74,9,.6,PI/2
1606 INK#2,3:FILL#2,1:LINE#2,65,8 TO 71,12 TO 76,8 TO 65,8:FILL#2,0
1607 END DEFine
1608 :
1609 REMark League Table
1610 :
1611 DEFine PROCedure LScore
1612 FOR i=1 TO 7
1613    PAUSE 5:BLOCK 200,12*i,20,66-i*6,0
1614    BLOCK 200,2,20,66-i*6,2:BLOCK 200,2,20,66+i*6,2
1615 END FOR i
1616 INK 6:OVER 1:CSIZE 2,1:FOR i=0 TO 1:CURSOR 44+i,28:PRINT 'League Table'
1617 INK 5:OVER 0:CSIZE 0,0:CURSOR 24,50:PRINT 'Points/Moves    Time      Gamer'
1618 FOR a=1 TO 3
1619  CURSOR  30,52+a*12:PRINT FILL$(' ',5-LEN(Grad(a,1)))&Grad(a,1)
1620  CURSOR  66,52+a*12:PRINT FILL$(' ',4-LEN(Grad(a,2)))&Grad(a,2)
1621  CURSOR 154,52+a*12:PRINT name$(a) :HST$=DATE$(Grad(a,3))
1622  CURSOR  98,52+a*12:PRINT HST$(13 TO 20)
1623 END FOR a
1624 END DEFine
1625 :
1626 DEFine PROCedure LName
1627 GTS=DATE-Gclk+GTS:Gclk$=DATE$(GTS)
1628 FOR i=1 TO 3: IF Grad(i,1)<snum:Gmr=i:EXIT i:ELSE Gmr=0
1629 IF Gmr=0:LScore:RETurn
1630 IF Gmr>0
1631    Grad(Gmr,1)=snum:Grad(Gmr,2)=sm:Grad(Gmr,3)=GTS:LScore
1632    ch=6:OPEN#ch,con_:WINDOW#ch,60,10,394+gx,126+gy+Gmr*12
1633    PAPER#ch,0:CLS#ch:INK#ch,6:INPUT#ch,name$(Gmr):CLOSE#ch:LSave
1634 END IF
1635 END DEFine
1636 :
1637 DEFine PROCedure LSave
1638 DELETE dev$&'QBMazeLT':OPEN_NEW#99,dev$&'QBMazeLT'
1639 FOR a=1 TO 3:PRINT#99,name$(a)\Grad(a,1)\Grad(a,2)\Grad(a,3)
1640 CLOSE#99
1641 END DEFine
1642 :
1643 DEFine PROCedure LLoad
1644 OPEN_IN#99,dev$&'QBMazeLT'
1645 FOR a=1 TO 3:INPUT#99,name$(a)\Grad(a,1)\Grad(a,2)\Grad(a,3)
1646 CLOSE#99
1647 END DEFine
1648 :
1649 DEFine PROCedure LTDefault
1650 REMark League Table Score
1651 name$(1)='QBITS    ':Grad(1,1)=1730:Grad(1,2)=756:Grad(1,3)=1072
1652 name$(2)='         ':Grad(2,1)=   0:Grad(2,2)=  0:Grad(2,3)=0
1653 name$(3)='         ':Grad(3,1)=   0:Grad(3,2)=  0:Grad(3,3)=0:LSave
1654 END DEFine
1655 :
1656 DEFine PROCedure LTReset
1657 REMark League Table Reset
1658 name$(1)='         ':Grad(1,1)=0:Grad(1,2)=0:Grad(1,3)=0
1659 name$(2)='         ':Grad(2,1)=0:Grad(2,2)=0:Grad(2,3)=0
1660 name$(3)='         ':Grad(3,1)=0:Grad(3,2)=0:Grad(3,3)=0:LSave
1661 END DEFine
