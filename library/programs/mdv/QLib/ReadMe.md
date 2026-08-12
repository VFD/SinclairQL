# Qliberator

This is a work in progress not finished.

___
## Introduction

This is a big DEAL.

Download from [sinclairQL](https://sinclairql.net/djw/qlib/index.html)

Understand Bug : [QLForum](https://theqlforum.com/viewtopic.php?t=5283&hilit=Qliberator&start=30)

I download the zip file v3.36.

The first problem is on my system (Win 11) I unzip the file to have a directory.\
Replace all "." by "_".\
When I mount the directory inside QemuLator, Qlib failed.

- may be a failure with the emulator
- problem with memory
- problem with the file  "Qlib_obj"

Read the forum thread above.

__
## Build a microdrive version

This is how I build it, you have not to do this.\
Description for posterity...

### Brut force building (in french: "à l'arrache")

I write a JS program to create empty microdrive.

- [RPUFOS Utils microdrive](https://vfd.github.io/RPUFOS-Tools/QLmdvCreator.html)

Create one then mount it in your emulator (NB : I use QemuLator), I use slot 2 (mdv2_)

Format the microdrive.

```basic
format mdv2_Qlib336
```

Mount the directorie on slot 1, it's now "flp1_".

I made a simple copy basic program.

```basic
100 REMark --------------------
110 REMark copy file DIR to mdv
120 REMark --------------------
130 :
140 COPY flp1_BOOT TO mdv2_BOOT
150 COPY flp1_BOOT_USE TO mdv2_BOOT_USE
160 COPY flp1_CLONE TO mdv2_CLONE
170 :
180 COPY flp1_demo_input   TO mdv2_demo_input
190 COPY flp1_demo_multi   TO mdv2_demo_multi
200 COPY flp1_demo_pager   TO mdv2_demo_pager
210 COPY flp1_demo_pipedir TO mdv2_demo_pipedir
220 COPY flp1_demo_qerr    TO mdv2_demo_qerr
230 COPY flp1_demo_sort    TO mdv2_demo_sort
240 :
250 COPY flp1_Qlib_bin  TO mdv2_Qlib_bin
260 COPY flp1_Qlib_boot TO mdv2_Qlib_boot
270 COPY flp1_Qlib_ext  TO mdv2_Qlib_ext
280 COPY flp1_Qlib_help TO mdv2_Qlib_help
290 COPY flp1_Qlib_obj  TO mdv2_Qlib_obj
300 COPY flp1_Qlib_ovl  TO mdv2_Qlib_ovl
310 COPY flp1_Qlib_rpm  TO mdv2_Qlib_rpm
320 COPY flp1_Qlib_run  TO mdv2_Qlib_run
330 COPY flp1_Qlib_sys  TO mdv2_Qlib_sys
340 COPY "flp1_Qlib_patch.obj" TO "mdv2_Qlib_patch.obj"
350 :
360 COPY flp1_readme TO mdv2_readme
```

Now we need to patch the header of "Qlib_obj".\
Remember QLForum, each time you copy this file there is a probability that the header goes away...


```basic
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
230 RECHP                                    : REMark error ?
240 PRINT"Program finished."
```

NB :
- Remember Qliberator is in slot 2 (mdv2_).
- Line 230 produce an error, don't know why (mais on s'en fou).

Down, the microdrive is ready.\
Stop the emulator.

___
## Compil superBASIC

### Running Qliberator

I've notice a memory problem if I run the emulator with 128K.\
So I use the option 384k.


- Put the microdrive in slot 1.
- Put your directory where you have your superBASIC program in slot 2.
- Start the emulator

Qliberator is loaded and ready.

If neede :

```basic
100 REMark --------------------------
110 REMark Mini boot Qliberator v3.36
120 REMark 
130 REMark QLIB_USE is mandatory
140 REMark 
150 REMark "mdv1_" : REMark adapt this /!\
160 REMark ---------------------------
170 LRESPR "mdv1_Qlib_run"
180 LRESPR "mdv1_Qlib_bin"
190 LRESPR "mdv1_Qlib_ext"
200 QLIB_USE mdv1_,mdv1_
210 :
```


### Compiling

Load your program:

```
new
load flp2_yourProgram_bas
```

Simple as:

```
liberate flp2_yourProgram_bas,
```

NB : "," to do all.

Don't mind graphics artifact.\
Now on flp2_ you have your program: "yourProgramm_bas_obj".


### Running

TO DO, 

Reset the emulator.\
Put your directory inside slot 1.

type :

```
EXEC_W yourProgramm_bas_obj
```

Runtimes missing ! WTF !!!

Oh! the runtime is not in memory (Qlib_run). It's mandatory.

In the root of Qliberator.

```
...
100 td$='flp1_'
...
370 REMark ** Load runtime system **
380 a=RESPR(10552)
390 LBYTES td$&'Qlib_run',a : CALL a
```

Built your ROOT.

```
100 REMark -------------
110 REMark Load Qlib_run
120 REMark -------------
130 td$='flp1_'
140 a=RESPR(10552)
150 LBYTES td$&'Qlib_run',a : CALL a
```

or :
```
130 LRESPR "mdv1_Qlib_run"
```

Don't know....

___

Other way, in documentation

```
liberate flp2_yourProgram_bas,"-RUN flp2_"
```

Runtime will be added, need more experiment.

___
