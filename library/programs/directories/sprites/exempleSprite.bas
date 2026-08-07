300 sprite=RESPR(1280)
310 LBYTES mdv1_ghostred_bin,sprite
350 displaysprite16x16=RESPR(512)
370 LBYTES win1_displaysprite16x16_bin,displaysprite16x16
380 CALL displaysprite16x16, 60, 64, sprite
381 CALL displaysprite16x16, 61, 64+161, sprite
382 CALL displaysprite16x16, 62, 64+162, sprite
383 CALL displaysprite16x16, 63, 64+16*3, sprite