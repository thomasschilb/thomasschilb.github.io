DECLARE SUB PrintStats ()
DECLARE SUB GetInput ()
DECLARE SUB GameLoop ()
DECLARE SUB HandleStars ()
DECLARE SUB MakeExplosion (XPOS, YPOS)
DECLARE SUB AddEnemy ()
DECLARE SUB KillEnemy (NUM)
DECLARE SUB HandleHealthAmmo ()
DECLARE SUB HandleLasers ()
DECLARE SUB HandleExplosions ()
DECLARE SUB HandleShips ()

DECLARE SUB DrawShip (POSX, POSY, COL)
DECLARE SUB DrawEnemyShip (POSX, POSY, COL)
DECLARE SUB DrawHealthAmmo (POSX, POSY, COL)

CLS
PRINT "Setting initial Variables..."

RANDOMIZE TIMER

DIM SHARED MaxNumEnemyShips AS INTEGER
MaxNumEnemyShips = 500

'Ship Variables'
DIM SHARED shipVelX(MaxNumEnemyShips + 1) AS SINGLE
DIM SHARED shipVelY(MaxNumEnemyShips + 1) AS SINGLE
DIM SHARED shipPosX(MaxNumEnemyShips + 1) AS SINGLE
DIM SHARED shipPosY(MaxNumEnemyShips + 1) AS SINGLE

'Laser Variables'
DIM SHARED MaxNumberLasers
MaxNumberLasers = 10
DIM SHARED laserVelX(MaxNumberLasers) AS SINGLE
DIM SHARED laserVelY(MaxNumberLasers) AS SINGLE
DIM SHARED laserPosX(MaxNumberLasers) AS SINGLE
DIM SHARED laserPosY(MaxNumberLasers) AS SINGLE

'Star Variables'
DIM SHARED NumberOfStars AS INTEGER
NumberOfStars = 100
DIM SHARED starVel(NumberOfStars) AS SINGLE
DIM SHARED starPosX(NumberOfStars) AS SINGLE
DIM SHARED starPosY(NumberOfStars) AS SINGLE

'Explosion Variables'
DIM SHARED MaxNumExplosions AS INTEGER
MaxNumExplosions = 10
DIM SHARED explodePosX(MaxNumExplosions)
DIM SHARED explodePosY(MaxNumExplosions)
DIM SHARED explodeStep(MaxNumExplosions)
DIM SHARED ExplodeSize AS INTEGER

'Health and Ammo Variables
DIM SHARED MaxHealthAmmo AS INTEGER
MaxHealthAmmo = 5
DIM SHARED HealthAmmoPosX(MaxHealthAmmo)
DIM SHARED HealthAmmoPosY(MaxHealthAmmo)
DIM SHARED HealthAmmoVelY(MaxHealthAmmo)
DIM SHARED HealthAmmoVelX(MaxHealthAmmo)
DIM SHARED ChanceHealthAmmo AS INTEGER

DIM SHARED i AS INTEGER
DIM SHARED j AS INTEGER

DIM SHARED maxX AS INTEGER
DIM SHARED maxY AS INTEGER
DIM SHARED minX AS INTEGER
DIM SHARED minY AS INTEGER

DIM SHARED EnemyMaxVel AS SINGLE
DIM SHARED StarMaxVel AS SINGLE
DIM SHARED NumEnemyShips AS INTEGER
DIM SHARED velIncrement AS SINGLE
DIM SHARED velDecay AS SINGLE
DIM SHARED VelLimitX AS SINGLE
DIM SHARED ShipNudge AS SINGLE
DIM SHARED ShipRestY AS INTEGER


DIM SHARED Ammo AS INTEGER
DIM SHARED Health AS INTEGER
DIM SHARED EnemiesToAdd AS INTEGER
DIM SHARED Kills AS INTEGER
DIM SHARED HighKills AS INTEGER
DIM SHARED ExplodeRadius AS INTEGER

DIM SHARED StartTimer AS DOUBLE
DIM SHARED EndTimer AS DOUBLE
DIM SHARED Loops AS SINGLE
DIM SHARED GameOver AS INTEGER

'THROW AWAY ZONE'

DIM SHARED SENDHEALTH AS INTEGER
SENDHEALTH = 0

'***************************************************************************************'
'************************* I N I T I A L  V A R I A B L E S ****************************'
'***************************************************************************************'

'Initial varibales'
velIncrement = 1.5
velDecay = .988
ExplodeSize = 15
VelLimitX = .75
ShipNudge = .75
ShipRestY = 280

'Playable area'
maxX = 640
maxY = 350
minX = 0
minY = 25

EnemyMaxVel = 3
StarMaxVel = 10

ChanceHealthAmmo = 3000
'ChanceHealthAmmo = 500

ExploseSize = 15
ExplodeRadius = 30

HighKills = 0

'***************************************************************************************'
'**************************** S P L A S H  S C R E E N *********************************'
'***************************************************************************************'

CLS
PRINT
PRINT " Aliens Attack!"
PRINT " By Alex Crane"
PRINT " V.2.0.7"
PRINT
PRINT MaxNumEnemyShips; "Ships Max"
PRINT
FOR i = 0 TO 16
    COLOR i, 0
    PRINT i
NEXT

COLOR 2
LOCATE 13, 30
PRINT "Press Any Key to Continue"

DO
LOOP WHILE INKEY$ = ""

MainMenu
END

'***************************************************************************************'
'****************************** M E N U   L O O P **************************************'
'***************************************************************************************'

SUB MainMenu

    SCREEN 9
    CLS

    InitStars

    DO

        _LIMIT 60
        LOCATE 10, 20
        COLOR 14
        PRINT "                ALIENS ATTACK!"
        LOCATE 12, 20
        COLOR 10
        PRINT "                 (N)EW GAME!"
        LOCATE 13, 20
        COLOR 12
        PRINT "                   E(X)IT!"
        IF HighKills > 0 THEN
            LOCATE 15, 20
            COLOR 9
            PRINT "               HIGH SCORE: "; HighKills
        END IF

        SELECT CASE INKEY$
            CASE "n":

                Ammo = 100
                Health = 100
                Kills = 0

                NumEnemyShips = 10
                EnemiesToAdd = 10
                GameOver = 0

                'Ship Starting POS'
                shipPosX(1) = 200
                shipPosY(1) = 200
                shipVelX(1) = 0
                shipVelY(1) = 0

                FOR i = 1 TO MaxNumberLasers
                    laserPosY(i) = -1
                NEXT

                FOR i = 1 TO MaxNumExplosions
                    explodeStep(i) = 0
                NEXT

                FOR i = 1 TO MaxHealthAmmo
                    HealthAmmoPosX(i) = -1
                NEXT

                InitEnemyShips
                GameLoop

            CASE "x":
                END
        END SELECT

        HandleStars

    LOOP

END SUB

'***************************************************************************************'
'****************************** G A M E   L O O P **************************************'
'***************************************************************************************'

SUB GameLoop

    CLS
    DrawShip shipPosX(1), shipPosY(1), 1
    StartTimer = TIMER

    DO
        _LIMIT 60
        Loops = Loops + 1

        'Add more ships if all gone'
        IF NumEnemyShips < 1 THEN
            FOR i = 1 TO EnemiesToAdd
                AddEnemy
            NEXT
            EnemiesToAdd = EnemiesToAdd + 10
        END IF
     
        'CLS

        GetInput
 
        HandleShips
        HandleLasers
        HandleHealthAmmo
        HandleExplosions
        HandleStars

        CheckGameOver
        PrintStats

    LOOP

END SUB

'***************************************************************************************'
'************************************ H A N D L I N G **********************************'
'***************************************************************************************'

SUB GetInput
    SELECT CASE INKEY$
        CASE CHR$(0) + CHR$(75):
            shipVelX(1) = shipVelX(1) - velIncrement
        CASE CHR$(0) + CHR$(77):
            shipVelX(1) = shipVelX(1) + velIncrement
        CASE CHR$(0) + CHR$(72):
            shipVelY(1) = shipVelY(1) - velIncrement
        CASE CHR$(0) + CHR$(80):
            shipVelY(1) = shipVelY(1) + velIncrement
        CASE "x":
            EndTimer = TIMER
            COLOR 6
            LOCATE 6, 1
            PRINT "Start Timer: "; StartTimer
            PRINT "End Timer: "; EndTimer
            PRINT "Total time: "; (EndTimer - StartTimer)
            PRINT "FPS: "; Loops / (EndTimer - StartTimer)
            END
        CASE "e":
            shipVelX(1) = 0
            shipVelY(1) = 0
        CASE "=":
            AddEnemy
        CASE "-":
            RemoveEnemy
        CASE "c":
            CLS
        CASE " ":
            'find first available laser'
            IF Ammo > 0 THEN
                FOR i = 1 TO MaxNumberLasers
                    IF laserPosY(i) <= minY THEN
                        laserPosY(i) = shipPosY(1)
                        laserPosX(i) = shipPosX(1)
                        laserVelX(i) = shipVelX(1)
                        laserVelY(i) = shipVelY(1) - 5
                        i = MaxNumberLasers
                        Ammo = Ammo - 1
                    END IF
                NEXT
            END IF
        CASE "0"
            Health = Health + 10
        CASE "9"
            Health = Health - 10
        CASE "h":
            SENDHEALTH = 1
    END SELECT
END SUB

SUB HandleShips

    'OBEY RULES FOR ENEMY SHIP POSITIONS'
    FOR i = 2 TO NumEnemyShips + 1

        'Erase Old Enemy Ship'
        DrawEnemyShip shipPosX(i), shipPosY(i), 0

        'Update Positions'
        shipPosX(i) = shipPosX(i) + shipVelX(i)
        shipPosY(i) = shipPosY(i) + shipVelY(i)

        'Move to other side if they veer off the edge'
        IF shipPosX(i) > maxX THEN shipPosX(i) = minX
        IF shipPosX(i) < minX THEN shipPosX(i) = maxX

        'Re-Cast if moved past play field'
        IF shipPosY(i) > maxY THEN
            shipPosX(i) = minX + (RND * (maxX - minX))
            shipPosY(i) = minY
            shipVelX(i) = ((RND * EnemyMaxVel) - (EnemyMaxVel / 2)) * VelLimitX
            shipVelY(i) = (RND * EnemyMaxVel)
        END IF
    
        DrawEnemyShip shipPosX(i), shipPosY(i), 6

    NEXT

    'Erase old'
    DrawShip shipPosX(1), shipPosY(1), 0

    'Update Player Ship Position'
    shipPosX(1) = shipPosX(1) + shipVelX(1)
    shipPosY(1) = shipPosY(1) + shipVelY(1)

    shipVelX(1) = shipVelX(1) * velDecay
    shipVelY(1) = shipVelY(1) * velDecay

    'Limit player position but leave vel alone'
    IF shipPosX(1) < minX + 10 THEN shipPosX(1) = minX + 10
    IF shipPosY(1) < minY - 10 THEN shipPosY(1) = minY - 10
    IF shipPosX(1) > maxX THEN shipPosX(1) = maxX
    IF shipPosY(1) > maxY - 10 THEN shipPosY(1) = maxY - 10

    'Nudge Player Ship towards Rest Point'
    IF shipPosY(1) > ShipRestY THEN shipPosY(1) = shipPosY(1) - ShipNudge
    IF shipPosY(1) < ShipRestY THEN shipPosY(1) = shipPosY(1) + ShipNudge

    DrawShip shipPosX(1), shipPosY(1), 1

    'DETECT PLAYER COLLISIONS W/ OTHER SHIPS'
    FOR i = 2 TO NumEnemyShips + 1
        IF ABS(shipPosX(i) - shipPosX(1)) < 10 AND ABS(shipPosY(i) - shipPosY(1)) < 10 THEN
            Health = Health - 5
            MakeExplosion shipPosX(i), shipPosY(i)
            KillEnemy i
        END IF
    NEXT

END SUB

SUB HandleLasers

    FOR i = 1 TO MaxNumberLasers

        'erase last position'
        LINE (laserPosX(i), laserPosY(i))-(laserPosX(i), laserPosY(i) + 5), 0

        laserPosY(i) = laserPosY(i) + laserVelY(i)
        laserPosX(i) = laserPosX(i) + laserVelX(i)
        
        'if out of bounds, make it so in Y direction as well'
        IF laserPosX(i) < minX OR laserPosX(i) > maxX THEN
            laserPosY(i) = -1
        END IF

        IF laserPosY(i) > minY THEN
            LINE (laserPosX(i), laserPosY(i))-(laserPosX(i), laserPosY(i) + 5), 10 'only draw if in correct region'
        END IF

    NEXT

    FOR i = 2 TO NumEnemyShips + 1
        'Look for laser collision'
        FOR j = 1 TO MaxNumberLasers
            IF laserPosY(j) > minY THEN
                IF ABS(shipPosX(i) - laserPosX(j)) < 10 AND ABS(shipPosY(i) - laserPosY(j)) < 10 THEN
                    Ammo = Ammo + 3
                    MakeExplosion shipPosX(i), shipPosY(i)
                    Kills = Kills + 1
                    KillEnemy i
                    j = j - 1 'why is this here?'
                END IF
            END IF
        NEXT
    NEXT

END SUB

SUB HandleHealthAmmo

    'Spawn new randomly'
    IF INT(RND * ChanceHealthAmmo) = 100 OR SENDHEALTH = 1 THEN
        SENDHEALTH = 0
        'Find First Available'
        FOR i = 1 TO MaxHealthAmmo
            IF HealthAmmoPosX(i) < minX THEN
                HealthAmmoPosY(i) = INT(RND * (maxY - minY) + minY)
                HealthAmmoPosX(i) = 1
                HealthAmmoVelX(i) = RND * EnemyMaxVel
                HealthAmmoVelY(i) = RND * EnemyMaxVel * .25
                i = MaxHealthAmmo
            END IF
        NEXT

    END IF

    FOR i = 1 TO MaxHealthAmmo

        IF HealthAmmoPosX(i) > minX THEN

            'erase old'
            DrawHealthAmmo HealthAmmoPosX(i), HealthAmmoPosY(i), 0

            'Update Positions'
            HealthAmmoPosX(i) = HealthAmmoPosX(i) + HealthAmmoVelX(i)
            HealthAmmoPosY(i) = HealthAmmoPosY(i) + HealthAmmoVelY(i)

            'Check if out of bounds'
            IF HealthAmmoPosY(i) > maxY THEN HealthAmmoPosX(i) = -1
            IF HealthAmmoPosY(i) < minY THEN HealthAmmoPosX(i) = -1
            IF HealthAmmoPosX(i) > maxX THEN HealthAmmoPosX(i) = -1

            'draw new'
            IF HealthAmmoPosX(i) > minX THEN DrawHealthAmmo HealthAmmoPosX(i), HealthAmmoPosY(i), 1

        END IF

    NEXT


    FOR i = 1 TO MaxHealthAmmo

        'Detect Collisions with Player
        IF ABS(shipPosX(1) - HealthAmmoPosX(i)) < 15 AND ABS(shipPosY(1) - HealthAmmoPosY(i)) < 15 AND HealthAmmoPosX(i) > minX THEN
            Ammo = Ammo + 25
            IF Health < 100 THEN Health = Health + 5

            'Erase Old'
            DrawHealthAmmo HealthAmmoPosX(i), HealthAmmoPosY(i), 0

            HealthAmmoPosX(i) = -1

        END IF

        'Detect Collisions with Laser'
        FOR j = 1 TO MaxNumberLasers
            IF laserPosY(j) > minY THEN
                IF ABS(HealthAmmoPosX(i) - laserPosX(j)) < 14 AND ABS(HealthAmmoPosY(i) - laserPosY(j)) < 15 AND HealthAmmoPosX(i) > minX THEN
                    MakeExplosion HealthAmmoPosX(i), HealthAmmoPosY(i)

                    'Erase Old'
                    DrawHealthAmmo HealthAmmoPosX(i), HealthAmmoPosY(i), 0
                    HealthAmmoPosX(i) = -1

                END IF
            END IF
        NEXT

    NEXT

END SUB

SUB HandleExplosions

    FOR i = 1 TO MaxNumExplosions
        IF explodeStep(i) > 0 THEN
            COLOR 12
            CIRCLE (explodePosX(i), explodePosY(i)), explodeStep(i) * 2
            IF explodeStep(i) > 1 THEN
                COLOR 0
                CIRCLE (explodePosX(i), explodePosY(i)), ((explodeStep(i) - 1) * 2)
            END IF
            
            explodeStep(i) = explodeStep(i) + 1

            IF explodeStep(i) > ExplodeSize THEN
                COLOR 0
                CIRCLE (explodePosX(i), explodePosY(i)), ((explodeStep(i) - 1) * 2)
                explodeStep(i) = 0
            END IF
        END IF
    NEXT
    
END SUB

SUB HandleStars

    FOR i = 1 TO NumberOfStars

        'Erase Old Star'
        LINE (starPosX(i), starPosY(i))-(starPosX(i), starPosY(i)), 0

        'Update Star Pos'
        starPosY(i) = starPosY(i) + starVel(i)

        'Recast is out of boundry'
        IF starPosY(i) > maxY THEN
            starPosY(i) = minY
            starPosX(i) = INT(RND * maxX)
            starVel = RND * StarMaxVel
        END IF

        'Draw New Star'
        LINE (starPosX(i), starPosY(i))-(starPosX(i), starPosY(i)), 3

    NEXT

END SUB

SUB CheckGameOver
    'Start Gameover Sequence'
    IF GameOver = 0 THEN
        IF Health < 1 THEN GameOver = 1
    END IF

    IF GameOver > 0 THEN

        IF GameOver = ExplodeSize THEN
            FOR i = 1 TO MaxNumExplosions
                explodePosX(i) = shipPosX(1) + ((ExplodeRadius / 2) - INT(RND * ExplodeRadius))
                explodePosY(i) = shipPosY(1) + ((ExplodeRadius / 2) - INT(RND * ExplodeRadius))
                explodeStep(i) = 1
            NEXT
        END IF

        IF GameOver = ExplodeSize * 2 THEN
            FOR i = 1 TO MaxNumExplosions
                explodePosX(i) = shipPosX(1) + ((ExplodeRadius / 2) - INT(RND * ExplodeRadius))
                explodePosY(i) = shipPosY(1) + ((ExplodeRadius / 2) - INT(RND * ExplodeRadius))
                explodeStep(i) = 1
            NEXT
        END IF

        IF GameOver = ExplodeSize * 2 THEN
            FOR i = 1 TO MaxNumExplosions
                explodePosX(i) = shipPosX(1) + ((ExplodeRadius / 2) - INT(RND * ExplodeRadius))
                explodePosY(i) = shipPosY(1) + ((ExplodeRadius / 2) - INT(RND * ExplodeRadius))
                explodeStep(i) = 1
            NEXT
        END IF

        IF GameOver = ExplodeSize * 4 THEN
            IF HighKills < Kills THEN HighKills = Kills
            LOCATE 12, 36
            COLOR 12
            PRINT "GAME OVER!"
            LOCATE 13, 36
            PRINT "(c)ontinue"
            DO WHILE INKEY$ <> "c"
            LOOP
            MainMenu
        END IF
        GameOver = GameOver + 1
    END IF
END SUB

SUB PrintStats
    LOCATE 1, 1
    COLOR 12
    PRINT "Enemies:"; NumEnemyShips
    
    LOCATE 1, 15
    COLOR 4
    PRINT "Kills:"; Kills
    
    LOCATE 1, 28
    COLOR 10
    PRINT "Ammo:"; Ammo

    LOCATE 1, 40
    COLOR 13
    PRINT "Health:"; Health
    
    COLOR 14
    LOCATE 1, 66
    PRINT "Aliens Attack!"

END SUB

'***************************************************************************************'
'************************************ T O O L S ***************************************'
'***************************************************************************************'

SUB MakeExplosion (XPOS, YPOS)

    ' Find first available explosion'
    FOR k = 1 TO MaxNumExplosions

        IF explodeStep(k) = 0 THEN

            explodePosX(k) = XPOS
            explodePosY(k) = YPOS
            explodeStep(k) = 1

            k = MaxNumExplosions

        END IF
        
    NEXT
END SUB

SUB KillEnemy (NUM)

    'ship(1)
    'ship(2)
    'ship(3)
    'ship(4)
    'ship(5)
    'ship(6)

    'Erase the Killed Ship
    DrawEnemyShip shipPosX(NUM), shipPosY(NUM), 0

    'shift enemies down array'
    FOR k = NUM TO NumEnemyShips + 1

        shipPosX(k) = shipPosX(k + 1)
        shipPosY(k) = shipPosY(k + 1)
        shipVelX(k) = shipVelX(k + 1)
        shipVelY(k) = shipVelY(k + 1)

    NEXT

    NumEnemyShips = NumEnemyShips - 1

END SUB

SUB AddEnemy
    IF NumEnemyShips < MaxNumEnemyShips THEN
        NumEnemyShips = NumEnemyShips + 1

        shipPosX(NumEnemyShips + 1) = INT(RND * maxX)
        shipPosY(NumEnemyShips + 1) = minY 'INT(RND * maxY)

        shipVelX(NumEnemyShips + 1) = ((RND * EnemyMaxVel) - (EnemyMaxVel / 2)) * VelLimitX
        shipVelY(NumEnemyShips + 1) = RND * EnemyMaxVel
    END IF
END SUB

SUB RemoveEnemy
    'Only for using - command'
    IF NumEnemyShips > 0 THEN
        i = NumEnemyShips + 1
        NumEnemyShips = NumEnemyShips - 1
        DrawEnemyShip shipPosX(i), shipPosY(i), 0
    END IF
END SUB

SUB InitEnemyShips
    'Give Enemy Ships an Initial velocity and position'
    FOR i = 2 TO NumEnemyShips + 1

        shipPosX(i) = INT(RND * maxX)
        shipPosY(i) = minY 'INT(RND * maxY)

        shipVelX(i) = (EnemyMaxVel - (RND * EnemyMaxVel)) * VelLimitX
        shipVelY(i) = RND * EnemyMaxVel

    NEXT
END SUB

SUB InitStars

    FOR i = 1 TO NumberOfStars
        starPosX(i) = INT(RND * maxX)
        starPosY(i) = INT(RND * maxY)
        starVel(i) = RND * StarMaxVel
    NEXT

END SUB

'***************************************************************************************'
'*********************************** G R A P H I C S ***********************************'
'***************************************************************************************'

SUB DrawShip (POSX, POSY, COL)

    IF COL = 1 THEN
        Col1 = 9
        Col2 = 11
    END IF

    IF COL = 0 THEN
        Col1 = 0
        Col2 = 0
    END IF

    '(0,0)-(-6,13)'
    '(0,0)-(6,13)'
    '(-6,13)-(-1,11)'
    '(6,13)-(-1,11)'

    '(-1,4)-(-1,10)'
    '(1,4)-(1,10)'

    LINE (POSX, POSY)-(POSX - 6, POSY + 13), Col1
    LINE (POSX, POSY)-(POSX + 6, POSY + 13), Col1
    LINE (POSX - 6, POSY + 13)-(POSX - 1, POSY + 11), Col1
    LINE (POSX + 6, POSY + 13)-(POSX - 1, POSY + 11), Col1

    LINE (POSX - 1, POSY + 6)-(POSX - 1, POSY + 10), Col2
    LINE (POSX + 1, POSY + 6)-(POSX + 1, POSY + 10), Col2



    'old pattern'
    'LINE (POSX, POSY)-(POSX + 5, POSY + 5), COL
    'LINE (POSX, POSY)-(POSX - 5, POSY + 5), COL
    'LINE (POSX, POSY + 1)-(POSX + 5, POSY + 10), COL
    'LINE (POSX, POSY + 1)-(POSX - 5, POSY + 10), COL
END SUB

SUB DrawEnemyShip (POSX, POSY, COL)
    'enemy color is 6'
    LINE (POSX, POSY)-(POSX + 5, POSY - 5), COL
    LINE (POSX, POSY)-(POSX - 5, POSY - 5), COL
    LINE (POSX, POSY + 1)-(POSX + 5, POSY - 10), COL
    LINE (POSX, POSY + 1)-(POSX - 5, POSY - 10), COL
END SUB

SUB DrawHealthAmmo (POSX, POSY, COL)

    IF COL = 1 THEN
        Col1 = 12
        Col2 = 10
    END IF

    IF COL = 0 THEN
        Col1 = 0
        Col2 = 0
    END IF

    'Red'
    '(-7,0)-(-2,-5)
    '(-7,0)-(-2, 5)
    '(7,0)-(2,-5)
    '(7,0)-(2,5)'
    'Green'
    '(-2,0)-(2,0)
    '(0,-2)-(0,2)

    LINE (POSX - 7, POSY)-(POSX - 2, POSY - 5), Col1
    LINE (POSX - 7, POSY)-(POSX - 2, POSY + 5), Col1
    LINE (POSX + 7, POSY)-(POSX + 2, POSY - 5), Col1
    LINE (POSX + 7, POSY)-(POSX + 2, POSY + 5), Col1

    LINE (POSX - 2, POSY)-(POSX + 2, POSY), Col2
    LINE (POSX, POSY - 2)-(POSX, POSY + 2), Col2

END SUB


