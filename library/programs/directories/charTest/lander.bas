100 REM --- LUNAR LANDER (LATERAL MOVEMENT) ---
110 REM Global variables
120 fuel = 1000
130 altitude = 1000
140 velocity_y = 0       REM Vertical velocity (m/s)
150 velocity_x = 0       REM Horizontal velocity (m/s)
160 landed = 0
170 thrust = 0
180 lateral_thrust = 0   REM Thrust for lateral movement

200 REM --- FUNCTIONS ---
210 DEFine FuNction calculate_gravity()
220   REM Returns lunar gravity (m/s²)
230   RETURN 1.6
240 END DEFine FuNction

250 DEFine FuNction check_landing(alt, vel_y, vel_x)
260   REM Checks if landing is successful or crash
270   IF alt <= 0 THEN
280     IF ABS(vel_y) < 2 AND ABS(vel_x) < 1 THEN
290       RETURN 1  REM Success
300     ELSE
310       RETURN -1 REM Crash
320   END IF
330   RETURN 0  REM Still flying
340 END DEFine FuNction

360 REM --- PROCEDURES ---
370 DEFine PROCedure display_status(alt, vel_y, vel_x, fuel)
380   REM Displays current game status
390   CLS
400   PRINT "ALTITUDE:"; alt
410   PRINT "VERTICAL VELOCITY:"; vel_y
420   PRINT "HORIZONTAL VELOCITY:"; vel_x
430   PRINT "FUEL:"; fuel
440 END DEFine PROCedure

450 DEFine PROCedure update_physics(vel_y, vel_x, fuel, thrust, lateral_thrust)
460   REM Updates physics: gravity, vertical thrust, and lateral movement
470   LOCAL gravity
480   gravity = calculate_gravity()

490   REM Apply gravity
500   vel_y = vel_y + gravity

510   REM Apply vertical thrust (if any)
520   IF thrust > 0 THEN
530     vel_y = vel_y - thrust
540     fuel = fuel - thrust
550     IF fuel < 0 THEN fuel = 0
560   END IF

570   REM Apply lateral thrust (left/right)
580   vel_x = vel_x + lateral_thrust
590   fuel = fuel - ABS(lateral_thrust) * 0.5  REM Lateral thrust consumes less fuel
600   IF fuel < 0 THEN fuel = 0

610   REM Apply friction to horizontal movement
620   vel_x = vel_x * 0.95  REM Reduce horizontal speed over time

625   REM Update altitude
630   altitude = altitude - vel_y
640 END DEFine PROCedure

700 REM --- MAIN GAME LOOP ---
710 REPeat game_loop
720   display_status(altitude, velocity_y, velocity_x, fuel)

730   REM Reset thrust and lateral thrust at the start of each frame
740   thrust = 0
750   lateral_thrust = 0

760   REM Check for keypresses
770   SELECT CASE INKEY$(0)
780   CASE CHR$(11)  REM Cursor Up (vertical boost)
790     thrust = 9
800   CASE CHR$(8)   REM Cursor Left (move left)
810     lateral_thrust = -1.5  REM Move left
820   CASE CHR$(9)   REM Cursor Right (move right)
830     lateral_thrust = 1.5   REM Move right
840   END SELECT

850   update_physics(velocity_y, velocity_x, fuel, thrust, lateral_thrust)

860   landed = check_landing(altitude, velocity_y, velocity_x)
870   IF landed <> 0 THEN
880     IF landed = 1 THEN
890       PRINT "SUCCESS! YOU LANDED SAFELY."
900     ELSE
910       PRINT "CRASH! TRY AGAIN."
920   END IF
930     EXIT game_loop
940   END IF

950   PAUSE 50  REM Small delay for real-time feel
960 END REPeat game_loop



3000 REMark ------------------------------
3010 REMark p_init
3020 REMark ------------------------------
3030 :

4000 REMark ------------------------------
4010 REMark p_draw_ship
4020 REMark ------------------------------
4030 :




