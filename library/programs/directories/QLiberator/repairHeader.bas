10 REMark 
20 REMark Repair the header of Qlib_obj
30 REMark https://theqlforum.com/viewtopic.php?t=5283&hilit=Qliberator&start=30
40 REMark 
50 REMark 
60  d$="flp1_"                          : REMark adapt this
100 base=ALCHP(46158)
110 LBYTES d$&Qlib_obj,base             : REMark load the "lost header" version
120 SEXEC  d$&Qlib_obj,base,46158,20386 : REMark save a new version with restored header
130 RECHP
140 PRINT"Program finished."
