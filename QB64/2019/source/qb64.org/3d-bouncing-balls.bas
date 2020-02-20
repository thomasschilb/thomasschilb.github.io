' 3D Bouncing Balls Using _MAPTRIANGLE by QWERKEY (Richard Notley) 21/04/18

' Cyperium method for sphere image

CONST True = -1`, False = 0`
_TITLE "3D Bouncing Balls"
RANDOMIZE (TIMER)

CONST NoBalls%% = 10, Uscreen% = 1000, Vscreen% = 800, NoPhis%% = 16, NoAlphas%% = 6, XBright! = 0.5
CONST Pi! = 4 * ATN(1), Rad1%% = 25, PerspDist% = 550, DeltaSepn! = 0.25 'small offset to stop balls sticking
CONST Alpha! = Pi! / (2 * NoAlphas%%), Phi! = 2 * Pi! / NoPhis%%
DIM BallStats!(NoBalls%% - 1, 9), ViewOrder%%(NoBalls%% - 1), Cyperium&(NoBalls%% - 1)
DIM MapConv%(NoPhis%%, NoAlphas%%, 1, 2)

'Conversion from 2D
FOR N%% = 0 TO NoPhis%%
    FOR M%% = 0 TO NoAlphas%%
        MapConv%(N%%, M%%, 0, 0) = 128 + CINT(127 * SIN((Pi! / 2) - M%% * Alpha!) * COS(N%% * Phi!))
        MapConv%(N%%, M%%, 0, 1) = 128 + CINT(127 * SIN((Pi! / 2) - M%% * Alpha!) * SIN(N%% * Phi!))
        MapConv%(N%%, M%%, 1, 0) = CINT(Rad1%% * SIN((Pi! / 2) - M%% * Alpha!) * COS(N%% * Phi!))
        MapConv%(N%%, M%%, 1, 1) = CINT(Rad1%% * SIN((Pi! / 2) - M%% * Alpha!) * SIN(N%% * Phi!))
        MapConv%(N%%, M%%, 1, 2) = CINT(Rad1%% * COS((Pi! / 2) - M%% * Alpha!))
    NEXT M%%
NEXT N%%

'Screen Background
TempImage& = _NEWIMAGE(Uscreen%, Vscreen%, 32)
_DEST TempImage&
COLOR _RGB(255, 255, 255), _RGB(10, 60, 60)
CLS
FOR UCol% = 0 TO Uscreen% - 1
    FOR VCol% = 0 TO Vscreen% - 1
        PSET (UCol%, VCol%), _RGB(100, INT(180 * UCol% / Uscreen%), INT(180 * VCol% / Vscreen%))
    NEXT VCol%
NEXT UCol%
Background& = MakeHardware&(TempImage&)

'Set array for depth order
JumpStart%% = 1
WHILE JumpStart%% <= NoBalls%%: JumpStart%% = JumpStart%% * 2: WEND
FOR N%% = 0 TO NoBalls%% - 1
    ViewOrder%%(N%%) = N%%
NEXT N%%

' Define characteristics of balls
DATA 255,0,0
DATA 219,80,0
DATA 150,100,0
DATA 138,117,0
DATA 80,155,20
DATA 0,255,0
DATA 20,135,100
DATA 0,105,150
DATA 0,60,150
DATA 0,0,255
FOR N%% = 0 TO NoBalls%% - 1
    'Ball mass
    BallStats!(N%%, 0) = 0.1 + (0.8 * N%% / (NoBalls%% - 1))
    IF BallStats!(N%%, 0) = 0 THEN BallStats!(N%%, 0) = 0.000001
    'Ball colours (temporarily use (N%%,1,2,3)
    FOR P%% = 1 TO 3
        READ BallStats!(N%%, P%%)
    NEXT P%%
    TempImage& = _NEWIMAGE(256, 256, 32)
    _DEST TempImage&
    COLOR _RGB(BallStats!(N%%, 1), BallStats!(N%%, 2), BallStats!(N%%, 3)), _RGBA(0, 0, 0, 0)
    'Image data goes from 1 to 255 (not 0 to 255)
    FOR Z% = 128 TO 255
        FOR X% = 1 TO 255
            FOR Y% = 1 TO 255
                DeltaX% = X% - 127
                DeltaY% = Y% - 127
                DeltaZ% = Z% - 127
                Dist! = SQR((DeltaX% * DeltaX%) + (DeltaY% * DeltaY%) + (DeltaZ% * DeltaZ%))
                IF Dist! > 125 AND Dist! < 127 THEN PSET (X%, Y%), _RGB(CINT(Z% * BallStats!(N%%, 1) * (1 - (XBright! * X% / 255)) / 255), CINT(Z% * BallStats!(N%%, 2) * (1 - (XBright! * X% / 255)) / 255), CINT(Z% * BallStats!(N%%, 3) * (1 - (XBright! * X% / 255)) / 255))
            NEXT
        NEXT
    NEXT
    Cyperium&(N%%) = MakeHardware&(TempImage&)
    'Ball positions/velocities
    FOR P%% = 4 TO 6
        BallStats!(N%%, P%%) = (0.5 - RND) * 1000
    NEXT P%%
    FOR P%% = 7 TO 9
        Velocity! = 0.5 - RND
        IF Velocity! < 0 THEN
            Velocity! = Velocity! - 0.5
        ELSE
            Velocity! = Velocity! + 0.5
        END IF
        BallStats!(N%%, P%%) = Velocity! * 3
    NEXT P%%
NEXT N%%

'Create screen
SCREEN _NEWIMAGE(Uscreen%, Vscreen%, 32)
_SCREENMOVE 50, 13
_DEST 0
_DISPLAYORDER _HARDWARE 'do not even render the software layer, just the hardware one.

'Initialise axes and rotations
ZRot! = (RND - 0.5) * 0.0011: YRot! = (RND - 0.5) * 0.0011: XRot! = (RND - 0.5) * 0.0011
ZTime% = 15 + INT(47 * RND): YTime%% = 15 + INT(47 * RND): XTime% = 15 + INT(47 * RND)
ZStart! = TIMER: YStart! = TIMER: XStart! = TIMER
Zaxis! = 0: Yaxis! = 0: Xaxis! = 0
Stereo` = True

WHILE Stereo`
    _LIMIT 120 'Game Frames/Second Rate

    _PUTIMAGE (0, 0), Background&

    'Calculate moves
    FOR N%% = 0 TO NoBalls%% - 1
        FOR P%% = 1 TO 3
            BallStats!(N%%, 3 + P%%) = BallStats!(N%%, 3 + P%%) + BallStats!(N%%, 6 + P%%)
        NEXT P%%
    NEXT N%%

    'Check for collsions
    FOR N%% = 0 TO NoBalls%% - 2
        FOR M%% = N%% + 1 TO NoBalls%% - 1
            SepnSqd! = (BallStats!(N%%, 4) - BallStats!(M%%, 4)) * (BallStats!(N%%, 4) - BallStats!(M%%, 4)) + (BallStats!(N%%, 5) - BallStats!(M%%, 5)) * (BallStats!(N%%, 5) - BallStats!(M%%, 5)) + (BallStats!(N%%, 6) - BallStats!(M%%, 6)) * (BallStats!(N%%, 6) - BallStats!(M%%, 6))
            IF SepnSqd! <= 4 * Rad1%% * Rad1%% THEN
                ' Set new velocities
                Multiplier! = 0: NDist! = 0: MDist! = 0
                FOR P%% = 1 TO 3
                    Multiplier! = Multiplier! + (BallStats!(N%%, 6 + P%%) - BallStats!(M%%, 6 + P%%)) * (BallStats!(N%%, 3 + P%%) - BallStats!(M%%, 3 + P%%))
                    NDist! = NDist! + BallStats!(N%%, 3 + P%%) * BallStats!(N%%, 3 + P%%)
                    MDist! = MDist! + BallStats!(M%%, 3 + P%%) * BallStats!(M%%, 3 + P%%)
                NEXT P%%
                NDist! = SQR(NDist!)
                MDist! = SQR(MDist!)
                Multiplier! = 2 * Multiplier! / (SepnSqd! * (BallStats!(N%%, 0) + BallStats!(M%%, 0)))
                FOR P%% = 1 TO 3
                    SepnVect! = BallStats!(N%%, 3 + P%%) - BallStats!(M%%, 3 + P%%)
                    BallStats!(N%%, 6 + P%%) = BallStats!(N%%, 6 + P%%) - (Multiplier! * BallStats!(M%%, 0) * SepnVect!)
                    BallStats!(M%%, 6 + P%%) = BallStats!(M%%, 6 + P%%) + (Multiplier! * BallStats!(N%%, 0) * SepnVect!)
                    IF NDist! > MDist! THEN
                        BallStats!(M%%, 3 + P%%) = BallStats!(M%%, 3 + P%%) - (DeltaSepn! * (BallStats!(N%%, 3 + P%%) - BallStats!(M%%, 3 + P%%)) / SQR(SepnSqd!))
                    ELSE
                        BallStats!(N%%, 3 + P%%) = BallStats!(N%%, 3 + P%%) + (DeltaSepn! * (BallStats!(N%%, 3 + P%%) - BallStats!(M%%, 3 + P%%)) / SQR(SepnSqd!))
                    END IF
                NEXT P%%
            END IF
        NEXT M%%
    NEXT N%%

    'Look for reflection off sides
    FOR N%% = 0 TO NoBalls%% - 1
        FOR P%% = 1 TO 3
            IF BallStats!(N%%, 3 + P%%) > 500 - Rad1%% THEN
                BallStats!(N%%, 6 + P%%) = -BallStats!(N%%, 6 + P%%)
                IF BallStats!(N%%, 3 + P%%) + BallStats!(N%%, 6 + P%%) > 500 - Rad1%% THEN
                    BallStats!(N%%, 3 + P%%) = BallStats!(N%%, 3 + P%%) - DeltaSepn!
                END IF
            ELSEIF BallStats!(N%%, 3 + P%%) < -500 + Rad1%% THEN
                BallStats!(N%%, 6 + P%%) = -BallStats!(N%%, 6 + P%%)
                IF BallStats!(N%%, 3 + P%%) + BallStats!(N%%, 6 + P%%) < -500 + Rad1%% THEN
                    BallStats!(N%%, 3 + P%%) = BallStats!(N%%, 3 + P%%) + DeltaSepn!
                END IF
            END IF
        NEXT P%%
    NEXT N%%

    'Adjust for angle of rotation
    FOR N%% = 0 TO NoBalls%% - 1
        R2! = SQR(BallStats!(N%%, 4) * BallStats!(N%%, 4) + BallStats!(N%%, 5) * BallStats!(N%%, 5) + BallStats!(N%%, 6) * BallStats!(N%%, 6))
        Theta2! = _ACOS(BallStats!(N%%, 6) / R2!)
        Phi2! = _ATAN2(BallStats!(N%%, 5), BallStats!(N%%, 4)) + Zaxis!
        BallStats!(N%%, 1) = R2! * SIN(Theta2!) * COS(Phi2!)
        BallStats!(N%%, 2) = R2! * SIN(Theta2!) * SIN(Phi2!)
        BallStats!(N%%, 3) = R2! * COS(Theta2!)
        R2! = SQR(BallStats!(N%%, 1) * BallStats!(N%%, 1) + BallStats!(N%%, 2) * BallStats!(N%%, 2) + BallStats!(N%%, 3) * BallStats!(N%%, 3))
        Theta2! = _ACOS(BallStats!(N%%, 1) / R2!)
        Phi2! = _ATAN2(BallStats!(N%%, 3), BallStats!(N%%, 2)) + Xaxis!
        BallStats!(N%%, 2) = R2! * SIN(Theta2!) * COS(Phi2!)
        BallStats!(N%%, 3) = R2! * SIN(Theta2!) * SIN(Phi2!)
        BallStats!(N%%, 1) = R2! * COS(Theta2!)
        R2! = SQR(BallStats!(N%%, 1) * BallStats!(N%%, 1) + BallStats!(N%%, 2) * BallStats!(N%%, 2) + BallStats!(N%%, 3) * BallStats!(N%%, 3))
        Theta2! = _ACOS(BallStats!(N%%, 2) / R2!)
        Phi2! = _ATAN2(BallStats!(N%%, 1), BallStats!(N%%, 3)) + Yaxis!
        BallStats!(N%%, 3) = CINT(R2! * SIN(Theta2!) * COS(Phi2!))
        BallStats!(N%%, 1) = CINT(R2! * SIN(Theta2!) * SIN(Phi2!))
        BallStats!(N%%, 2) = CINT(R2! * COS(Theta2!))
    NEXT N%%

    'Change display order: furthest first
    Jump%% = JumpStart%%
    WHILE Jump%% > 1
        Jump%% = (Jump%% - 1) \ 2
        DoneHere` = False
        WHILE NOT DoneHere`
            DoneHere` = True
            FOR Upper%% = 1 TO NoBalls%% - Jump%%
                Lower%% = Upper%% + Jump%%
                'BallStats! z-dim
                IF BallStats!(ViewOrder%%(Upper%% - 1), 3) > BallStats!(ViewOrder%%(Lower%% - 1), 3) THEN
                    SWAP ViewOrder%%(Upper%% - 1), ViewOrder%%(Lower%% - 1)
                    DoneHere` = False
                END IF
            NEXT Upper%%
        WEND
    WEND

    'Display balls
    FOR N1%% = NoBalls%% - 1 TO 0 STEP -1
        P%% = ViewOrder%%(N1%%)
        '_PUTIMAGE (BallStats!(P%%, 1) + 500, BallStats!(P%%, 2) + 400), Cyperium&(P%%)
        'Ball views done with _MAPTRIANGLE 3D
        FOR N%% = 0 TO NoPhis%% - 1
            FOR M%% = 0 TO NoAlphas%% - 2
                Ax% = MapConv%(N%%, M%%, 1, 0) + BallStats!(P%%, 1)
                Ay% = MapConv%(N%%, M%%, 1, 1) + BallStats!(P%%, 2)
                Az% = MapConv%(N%%, M%%, 1, 2) + BallStats!(P%%, 3) - PerspDist%
                Bx% = MapConv%(N%%, M%% + 1, 1, 0) + BallStats!(P%%, 1)
                By% = MapConv%(N%%, M%% + 1, 1, 1) + BallStats!(P%%, 2)
                Bz% = MapConv%(N%%, M%% + 1, 1, 2) + BallStats!(P%%, 3) - PerspDist%
                Cx% = MapConv%(N%% + 1, M%% + 1, 1, 0) + BallStats!(P%%, 1)
                Cy% = MapConv%(N%% + 1, M%% + 1, 1, 1) + BallStats!(P%%, 2)
                Cz% = MapConv%(N%% + 1, M%% + 1, 1, 2) + BallStats!(P%%, 3) - PerspDist%
                _MAPTRIANGLE (MapConv%(N%%, M%%, 0, 0), MapConv%(N%%, M%%, 0, 1))-(MapConv%(N%%, M%% + 1, 0, 0), MapConv%(N%%, M%% + 1, 0, 1))-(MapConv%(N%% + 1, M%% + 1, 0, 0), MapConv%(N%% + 1, M%% + 1, 0, 1)), Cyperium&(P%%) TO(Ax%, Ay%, Az%)-(Bx%, By%, Bz%)-(Cx%, Cy%, Cz%)
                _MAPTRIANGLE (MapConv%(N%% + 1, M%% + 1, 0, 0), MapConv%(N%% + 1, M%% + 1, 0, 1))-(MapConv%(N%% + 1, M%%, 0, 0), MapConv%(N%% + 1, M%%, 0, 1))-(MapConv%(N%%, M%%, 0, 0), MapConv%(N%%, M%%, 0, 1)), Cyperium&(P%%) TO(Cx%, Cy%, Cz%)-(MapConv%(N%% + 1, M%%, 1, 0) + BallStats!(P%%, 1), MapConv%(N%% + 1, M%%, 1, 1) + BallStats!(P%%, 2), MapConv%(N%% + 1, M%%, 1, 2) + BallStats!(P%%, 3) - PerspDist%)-(Ax%, Ay%, Az%)
                '_MAPTRIANGLE (MapConv%(N%%, M%%, 0, 0), MapConv%(N%%, M%%, 0, 1))-(MapConv%(N%%, M%% + 1, 0, 0), MapConv%(N%%, M%% + 1, 0, 1))-(MapConv%(N%% + 1, M%% + 1, 0, 0), MapConv%(N%% + 1, M%% + 1, 0, 1)), Cyperium&(P%%) TO(MapConv%(N%%, M%%, 1, 0) + BallStats!(P%%, 1), MapConv%(N%%, M%%, 1, 1) + BallStats!(P%%, 2), MapConv%(N%%, M%%, 1, 2) + BallStats!(P%%, 3) - PerspDist%)-(MapConv%(N%%, M%% + 1, 1, 0) + BallStats!(P%%, 1), MapConv%(N%%, M%% + 1, 1, 1) + BallStats!(P%%, 2), MapConv%(N%%, M%% + 1, 1, 2) + BallStats!(P%%, 3) - PerspDist%)-(MapConv%(N%% + 1, M%% + 1, 1, 0) + BallStats!(P%%, 1), MapConv%(N%% + 1, M%% + 1, 1, 1) + BallStats!(P%%, 2), MapConv%(N%% + 1, M%% + 1, 1, 2) + BallStats!(P%%, 3) - PerspDist%)
                '_MAPTRIANGLE (MapConv%(N%% + 1, M%% + 1, 0, 0), MapConv%(N%% + 1, M%% + 1, 0, 1))-(MapConv%(N%% + 1, M%%, 0, 0), MapConv%(N%% + 1, M%%, 0, 1))-(MapConv%(N%%, M%%, 0, 0), MapConv%(N%%, M%%, 0, 1)), Cyperium&(P%%) TO(MapConv%(N%% + 1, M%% + 1, 1, 0) + BallStats!(P%%, 1), MapConv%(N%% + 1, M%% + 1, 1, 1) + BallStats!(P%%, 2), MapConv%(N%% + 1, M%% + 1, 1, 2) + BallStats!(P%%, 3) - PerspDist%)-(MapConv%(N%% + 1, M%%, 1, 0) + BallStats!(P%%, 1), MapConv%(N%% + 1, M%%, 1, 1) + BallStats!(P%%, 2), MapConv%(N%% + 1, M%%, 1, 2) + BallStats!(P%%, 3) - PerspDist%)-(MapConv%(N%%, M%%, 1, 0) + BallStats!(P%%, 1), MapConv%(N%%, M%%, 1, 1) + BallStats!(P%%, 2), MapConv%(N%%, M%%, 1, 2) + BallStats!(P%%, 3) - PerspDist%)
            NEXT M%%
            _MAPTRIANGLE (MapConv%(N%%, NoAlphas%% - 1, 0, 0), MapConv%(N%%, NoAlphas%% - 1, 0, 1))-(128, 128)-(MapConv%(N%% + 1, NoAlphas%% - 1, 0, 0), MapConv%(N%% + 1, NoAlphas%% - 1, 0, 1)), Cyperium&(P%%) TO(Bx%, By%, Bz%)-(BallStats!(P%%, 1), BallStats!(P%%, 2), BallStats!(P%%, 3) + Rad1%% - PerspDist%)-(Cx%, Cy%, Cz%)
            '_MAPTRIANGLE (MapConv%(N%%, NoAlphas%% - 1, 0, 0), MapConv%(N%%, NoAlphas%% - 1, 0, 1))-(128, 128)-(MapConv%(N%% + 1, NoAlphas%% - 1, 0, 0), MapConv%(N%% + 1, NoAlphas%% - 1, 0, 1)), Cyperium&(P%%) TO(MapConv%(N%%, NoAlphas%% - 1, 1, 0) + BallStats!(P%%, 1), MapConv%(N%%, NoAlphas%% - 1, 1, 1) + BallStats!(P%%, 2), MapConv%(N%%, NoAlphas%% - 1, 1, 2) + BallStats!(P%%, 3) - PerspDist%)-(BallStats!(P%%, 1), BallStats!(P%%, 2), BallStats!(P%%, 3) + Rad1%% - PerspDist%)-(MapConv%(N%% + 1, NoAlphas%% - 1, 1, 0) + BallStats!(P%%, 1), MapConv%(N%% + 1, NoAlphas%% - 1, 1, 1) + BallStats!(P%%, 2), MapConv%(N%% + 1, NoAlphas%% - 1, 1, 2) + BallStats!(P%%, 3) - PerspDist%)
        NEXT N%%
    NEXT N1%%

    'rotate around z- axis
    Zaxis! = Zaxis! + ZRot!
    IF Zaxis! > Pi! THEN
        Zaxis! = Zaxis! - 2 * Pi!
    ELSEIF Zaxis! < -Pi! THEN
        Zaxis! = Zaxis! + 2 * Pi!
    END IF

    'rotate around y- axis
    Yaxis! = Yaxis! + YRot!
    IF Yaxis! > Pi! THEN
        Yaxis! = Yaxis! - 2 * Pi!
    ELSEIF Yaxis! < -Pi! THEN
        Yaxis! = Yaxis! + 2 * Pi!
    END IF

    'rotate around x- axis
    Xaxis! = Xaxis! + XRot!
    IF Xaxis! > Pi! THEN
        Xaxis! = Xaxis! - 2 * Pi!
    ELSEIF Xaxis! < -Pi! THEN
        Xaxis! = Xaxis! + 2 * Pi!
    END IF

    IF TIMER > ZStart! + ZTime% THEN
        ZRot! = (RND - 0.5) * 0.0011
        ZTime% = 15 + INT(47 * RND)
        ZStart! = TIMER
        RANDOMIZE (ZStart!)
    END IF
    IF TIMER > YStart! + YTime%% THEN
        YRot! = (RND - 0.5) * 0.0011
        YTime%% = 15 + INT(47 * RND)
        YStart! = TIMER
    END IF
    IF TIMER > XStart! + XTime% THEN
        XRot! = (RND - 0.5) * 0.0011
        XTime% = 15 + INT(47 * RND)
        XStart! = TIMER
    END IF

    IF _KEYHIT = 27 THEN Stereo` = False 'Esc  to quit

    _DISPLAY

WEND

SYSTEM

FUNCTION MakeHardware& (Imagename&)
    MakeHardware& = _COPYIMAGE(Imagename&, 33)
    _FREEIMAGE Imagename&
END FUNCTION

