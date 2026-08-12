100 REMark ---------------------------------------------------------------------
110 REMark Repair the header of Qlib_obj
120 REMark https://theqlforum.com/viewtopic.php?t=5283&hilit=Qliberator&start=30
130 REMark 
140 REMark check with :
150 REMark PRINT FTYP(\mdv2_QLIB_obj)
160 REMark if 0 then patch
170 REMark 
180 REMark ---------------------------------------------------------------------
190  d$="mdv2_"  : REMark adapt this to your use
200 base=ALCHP(46158)
210 LBYTES d$ & "Qlib_obj", base             : REMark load the "lost header" version
220 SEXEC  d$ & "Qlib_obj", base,46158,20386 : REMark save a new version with restored header
230 RECHP : REMark error ?
240 PRINT"Program finished."
