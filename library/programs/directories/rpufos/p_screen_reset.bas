32000 REMark ------------------
32010 REMark Reset channels
32020 REMark Change as you wish
32030 REMark ------------------
32040 DEFine PROCedure p_screen_reset
32050   BORDER #0,0: PAPER #0,0 :INK #0,4: CLS #0
32060   BORDER #1,0: PAPER #1,0 :INK #1,4: CLS #1
32070   BORDER #2,0: PAPER #2,0 :INK #2,4: CLS #2
32080   WINDOW 512,200,0,0: CLS: REMark ch #1; ch #0 not impacted
32090   REMark WINDOW 512,256,0,0: CLS: REMark ch #1; ch #0 impacted
32100 END DEFine p_screen_reset
