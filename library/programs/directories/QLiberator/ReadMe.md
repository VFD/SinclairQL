# Try to solve problem with Qliberator


## Introduction

https://theqlforum.com/viewtopic.php?t=5283&hilit=Qliberator


May be a problem with the header of "Qlib_obj".

```basic
100 base=ALCHP(46158)
110 LBYTES win1_Qlib_obj,base             : REM load the "lost header" version
120 SEXEC  win1_Qlib_obj,base,46158,20386 : REM save a new version with restored header
130 RECHP
140 PRINT"Program finished."
```

May be a problem with BOOT

Solve with 

```basic
100 LRESPR "mdv1_QLIB_RUN"
110 LRESPR "mdv1_QLIB_BIN"
120 LRESPR "mdv1_QLIB_EXT"
130 QLIB_USE mdv1_,mdv1_
```

mdv1_ is where is QLiberator


## to do

LIBERATOR name


## Minimum to have is


to do



___