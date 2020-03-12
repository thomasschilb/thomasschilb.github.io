'Tetris 64 Ver 0.9 (start date 10/3/18-13.27)
'v0.9: (current build on 10/13/2018-13:25)
'add 'no sound' option
'add level selection to menu A to game value
'add B-Type menu
'small rocket ending done
'med rocket ending done
'Large rocket ending done
'Shuttle ending done
'High Score screen Atype done
'high score screen Btype done
'Fix rotational collisions
'divorced Narika from code
'B-Type game functional
' found new bug with rotational collisions

TYPE GameData
    Mode AS _BYTE 'game type A or B
    BGM AS _BYTE 'Back Gound music 1,2,3
    BGMVol AS _BYTE 'Back Gound Music Volume
    SFXVol AS _BYTE 'Sound effects Volume
    Level AS _BYTE 'game level
    Height AS _BYTE 'line height B-type game
    HScore1 AS LONG 'Highest Score
    HScore2 AS LONG 'Higher Score
    HScore3 AS LONG 'High Score
    HName1 AS STRING * 6 'High score name
    HName2 AS STRING * 6 ' "    "     "
    HName3 AS STRING * 6 ' "    "     "
    Hlevel1 AS _BYTE
    Hlevel2 AS _BYTE
    Hlevel3 AS _BYTE
    HScore1B AS LONG 'Highest Score B-type
    HScore2B AS LONG 'Higher Score B-type
    HScore3B AS LONG 'High Score B-type
    HName1B AS STRING * 6 'High score name B-Type
    HName2B AS STRING * 6 ' "    "     "
    HName3B AS STRING * 6 ' "    "     "
    Hlevel1B AS _BYTE
    Hlevel2B AS _BYTE
    Hlevel3B AS _BYTE
    GameOverFlag AS _BYTE 'game over
    Sound AS _BYTE 'sound on or off
    Loaded AS _BYTE
END TYPE

TYPE CurrentData
    Icount AS INTEGER ' Number of I blocks used in current game
    Ocount AS INTEGER ' Number of O blocks used in current game
    Zcount AS INTEGER ' number of Z blocks used in current game
    Scount AS INTEGER ' number of S blocks used in current game
    Jcount AS INTEGER ' number of J blocks used in current game
    Lcount AS INTEGER ' number of L blocks used in current game
    Tcount AS INTEGER ' number of T blocks used in current game
    Score AS LONG '     Current game score
    Piece AS _BYTE '    The currently dropping piece
    NextP AS _BYTE '    The next piece in the queue
    Lines AS INTEGER '  The lines complete in A-Type, Lines remaining in B-type
    Orent AS _BYTE '    rotational orentation of current piece
    PieceX AS _BYTE '   current Piece's X location on board 1-10
    PieceY AS _BYTE '   current Piece's Y location on board 1-20
    bonus AS _BYTE '    Quick drop bonus +1 for each line while down is pressed
END TYPE

DIM SHARED G AS GameData, P AS CurrentData, Board(11, 21) AS _BYTE
DIM SHARED BGM(3) AS LONG, SFX(64) AS LONG, FFX(1) AS LONG
DIM SHARED MenuA AS LONG, MenuB AS LONG, FieldA AS LONG, CharacterA AS LONG
DIM SHARED Nomes AS LONG, Bzone AS LONG, ButtonHeld%%, LandedNew%%
DIM SHARED TI(10) AS LONG, MenuC AS LONG, EndScrnA AS LONG, EndSprtA AS LONG
DIM SHARED HighS AS LONG, FieldB AS LONG, QuitGameFlag%%, MenuID%%
DIM SHARED Splash&

CONST TRUE = -1, FALSE = NOT TRUE
CONST TypeA = 1, TypeB = 2
CONST NoBGM = 0, Song1 = 1, Song2 = 2, Song3 = 3, LoadIt = -1, NoSound = -2
CONST T = 1, O = 2, Z = 3, S = 4, J = 5, L = 6, I = 7
CONST AdjX% = -8, BACK = -2, QUIT = -3

FOR w% = 0 TO 10
    TI(w%) = _FREETIMER
NEXT w%
ON TIMER(TI(0), .85) DropPiece
ON TIMER(TI(1), .72) DropPiece
ON TIMER(TI(2), .63) DropPiece
ON TIMER(TI(3), .55) DropPiece
ON TIMER(TI(4), .47) DropPiece
ON TIMER(TI(5), .38) DropPiece
ON TIMER(TI(6), .3) DropPiece
ON TIMER(TI(7), .22) DropPiece
ON TIMER(TI(8), .13) DropPiece
ON TIMER(TI(9), .1) DropPiece
ON TIMER(TI(10), .05) DropPiece
StartData

st! = TIMER

RANDOMIZE TIMER
PRINT "loading.";
LoadGameStuff NoSound ' LoadIt
_CLEARCOLOR _RGB32(0, 0, 0), MenuB
_CLEARCOLOR _RGB32(0, 0, 0), MenuC
_CLEARCOLOR _RGB32(0, 89, 251), EndSprtA
BoardSetup
MenuID%% = 0
DO
    StartData
    IF MenuID%% = -1 THEN TitleScreen
    IF NOT QuitGameFlag%% THEN
        IF MenuID%% = 0 THEN MenuOne
        IF NOT QuitGameFlag%% THEN
            IF MenuID%% = 1 AND G.Mode = TypeA THEN MenuTwoA
            IF MenuID%% = 1 AND G.Mode = TypeB THEN MenuTwoB
        END IF
        IF MenuID%% = 2 AND (NOT QuitGameFlag%%) AND G.Mode = TypeA THEN GameModeA
        IF MenuID%% = 2 AND (NOT QuitGameFlag%%) AND G.Mode = TypeB THEN GameModeB
    END IF
LOOP UNTIL QuitGameFlag%%

'dumpboard 'debuging line
'------------------------------------------------------------------
SUB TitleScreen
    _TITLE "Tetris64 V.9  2018\Cobalt"
    _PUTIMAGE (-10, 0), Splash&, _DISPLAY
    _PRINTSTRING (168, 395), "Remake By Cobalt 2018", _DISPLAY
    IF NOT G.Loaded THEN _PRINTSTRING (155, 290), "Please Wait", _DISPLAY
    IF G.Loaded THEN _PRINTSTRING (155, 290), "Ready to Play", _DISPLAY

    IF MenuID%% = -1 THEN
        DisplayClickOptions
        COLOR _RGB32(0, 0, 0)
        _PRINTSTRING (570, 200), "Click here"
        _PRINTSTRING (570, 220), "to go Back"
        COLOR _RGB32(255, 255, 255)
        DO
            nul%% = _MOUSEINPUT
            IF _MOUSEBUTTON(1) THEN
                x% = _MOUSEX: y% = _MOUSEY
                exitflag%% = ClickInteraction(x%, y%)
                DO: LOOP WHILE _MOUSEINPUT
            END IF
            IF exitflag%% = TRUE THEN MenuID%% = 0 'goto next menu
            IF exitflag%% = BACK THEN exitflag%% = FALSE 'no where to go backwards to
            IF exitflag%% = QUIT THEN QuitGameFlag%% = TRUE 'quit game
        LOOP UNTIL exitflag%%
        CLS
    END IF
END SUB

SUB LoadGameStuff (opt%%)
    DIM Size(64) AS LONG, FOffset&(64)

    SCREEN _NEWIMAGE(800, 480, 32)

    OPEN "Tetris.gFX" FOR BINARY AS #1
    FOR w% = 1 TO 15
        GET #1, , FOffset&(w%)
        GET #1, , Size(w%)
        FOffset&(w%) = FOffset&(w%) + 1
    NEXT
    IF INSTR(_OS$, "WIN") THEN f%% = 1 ELSE f%% = 2
    'function LoadGFX(Foff&,Size&,id%%)
    OPEN "temp.dat" FOR BINARY AS #3
    dat$ = SPACE$(Size(f%%))
    GET #1, FOffset&(f%%), dat$
    PUT #3, , dat$
    CLOSE #3
    FFX(1) = _LOADFONT("temp.dat", 20, "monospace")
    IF _FILEEXISTS("temp.dat") THEN KILL "temp.dat"
    IF FFX(1) THEN _FONT FFX(1)
    _DELAY .125

    Splash& = LoadGFX(FOffset&(3), Size(3))
    'Splash& = _LOADIMAGE("Tetris_Splash.bmp", 32)
    ' FFX(1) = _LOADFONT("NESFont.otf", 20, "monospace")
    ' IF FFX(1) THEN _FONT FFX(1)
    ' _DELAY .125
    TitleScreen
    MenuA = LoadGFX(FOffset&(4), Size(4))
    MenuB = LoadGFX(FOffset&(5), Size(5))
    MenuC = LoadGFX(FOffset&(6), Size(6))
    EndScrnA = LoadGFX(FOffset&(7), Size(7))
    EndSprtA = LoadGFX(FOffset&(8), Size(8))
    FieldA = LoadGFX(FOffset&(9), Size(9))
    FieldB = LoadGFX(FOffset&(10), Size(10))
    HighS = LoadGFX(FOffset&(11), Size(11))
    Nomes = LoadGFX(FOffset&(12), Size(12))
    Bzone = _NEWIMAGE(160, 320, 32)
    IF _FILEEXISTS("temp.dat") THEN KILL "temp.dat"

    IF opt%% = LoadIt THEN 'load sounds option
        OPEN "Tetris.SFX" FOR BINARY AS #1
        FOR w% = 1 TO 21
            GET #1, , foffset&
            GET #1, , Size(w%)
        NEXT

        FOR w% = 1 TO 3
            OPEN "temp.dat" FOR BINARY AS #3
            dat$ = SPACE$(Size(w%))
            GET #1, , dat$
            PUT #3, , dat$
            CLOSE #3
            BGM(w%) = _SNDOPEN("temp.dat")
            IF _FILEEXISTS("temp.dat") THEN KILL "temp.dat"
        NEXT w%
        FOR w% = 4 TO 21
            OPEN "temp.dat" FOR BINARY AS #3
            dat$ = SPACE$(Size(w%))
            GET #1, , dat$
            PUT #3, , dat$
            CLOSE #3
            SFX(w% - 4) = _SNDOPEN("temp.dat")
            IF _FILEEXISTS("temp.dat") THEN KILL "temp.dat"
        NEXT w%
        CLOSE
        G.Sound = TRUE
    END IF
    G.Loaded = TRUE
    _PRINTSTRING (155, 290), "Ready to Play", _DISPLAY

END SUB

SUB MenuOne
    STATIC FirstRun%%
    IF FirstRun%% = FALSE THEN
        _PRINTSTRING (570, 130), "Click here"
        _PRINTSTRING (570, 150), "to Continue"

        DO
            nul%% = _MOUSEINPUT
            IF _MOUSEBUTTON(1) THEN
                x% = _MOUSEX: y% = _MOUSEY
                exitflag%% = ClickInteraction(x%, y%)
                DO: LOOP WHILE _MOUSEINPUT
            END IF
        LOOP UNTIL exitflag%%
        CLS
        exitflag%% = FALSE
        DO: LOOP WHILE _MOUSEINPUT
        FirstRun%% = TRUE
    END IF

    _PUTIMAGE (5, 5), MenuA, _DISPLAY, (64, 16)-(574, 462)
    _PUTIMAGE (30 + G.BGMVol * 1.28, 374), MenuA, _DISPLAY, (32, 0)-(45, 13)
    _PUTIMAGE (30 + G.SFXVol * 1.28, 278), MenuA, _DISPLAY, (32, 0)-(45, 13)
    IF G.Mode = TypeA THEN
        _PUTIMAGE (130, 117), MenuA, _DISPLAY, (0, 0)-(13, 13)
        _PUTIMAGE (250, 117), MenuA, _DISPLAY, (16, 0)-(29, 13)
    END IF
    _PUTIMAGE (212, 277), MenuA, _DISPLAY, (0, 0)-(13, 13)
    _PUTIMAGE (360, 277), MenuA, _DISPLAY, (16, 0)-(29, 13)
    IF G.Mode = TypeB THEN
        _PUTIMAGE (322, 117), MenuA, _DISPLAY, (0, 0)-(13, 13)
        _PUTIMAGE (442, 117), MenuA, _DISPLAY, (16, 0)-(29, 13)
    END IF
    DisplayClickOptions

    IF G.Sound THEN _SNDLOOP BGM(G.BGM)
    old%% = G.BGM

    DO
        nul%% = _MOUSEINPUT
        IF nul%% THEN
            IF _MOUSEBUTTON(1) THEN
                x% = _MOUSEX: y% = _MOUSEY
                IF x% > 120 AND y% > 102 AND x% < 275 AND y% < 146 THEN 'game type A
                    G.Mode = TypeA
                    LINE (322, 117)-(338, 131), _RGB32(0, 0, 0), BF
                    LINE (442, 117)-(458, 131), _RGB32(0, 0, 0), BF
                    _PUTIMAGE (130, 117), MenuA, _DISPLAY, (0, 0)-(13, 13)
                    _PUTIMAGE (250, 117), MenuA, _DISPLAY, (16, 0)-(29, 13)
                END IF
                IF x% > 312 AND y% > 102 AND x% < 466 AND y% < 146 THEN 'game type B
                    G.Mode = TypeB
                    LINE (130, 117)-(146, 131), _RGB32(0, 0, 0), BF
                    LINE (250, 117)-(266, 131), _RGB32(0, 0, 0), BF
                    _PUTIMAGE (322, 117), MenuA, _DISPLAY, (0, 0)-(13, 13)
                    _PUTIMAGE (442, 117), MenuA, _DISPLAY, (16, 0)-(29, 13)
                END IF
                IF x% > 210 AND y% > 270 AND x% < 378 AND y% < 296 THEN 'BGM 1
                    G.BGM = Song1
                    LINE (210, 270)-(226, 400), _RGB32(0, 0, 0), BF
                    LINE (360, 270)-(376, 400), _RGB32(0, 0, 0), BF
                    _PUTIMAGE (212, 277), MenuA, _DISPLAY, (0, 0)-(13, 13)
                    _PUTIMAGE (360, 277), MenuA, _DISPLAY, (16, 0)-(29, 13)
                    songchange%% = TRUE
                END IF
                IF x% > 210 AND y% > 302 AND x% < 378 AND y% < 328 THEN 'BGM 2
                    G.BGM = Song2
                    LINE (210, 270)-(226, 400), _RGB32(0, 0, 0), BF
                    LINE (360, 270)-(376, 400), _RGB32(0, 0, 0), BF
                    _PUTIMAGE (212, 310), MenuA, _DISPLAY, (0, 0)-(13, 13)
                    _PUTIMAGE (360, 310), MenuA, _DISPLAY, (16, 0)-(29, 13)
                    songchange%% = TRUE
                END IF
                IF x% > 210 AND y% > 334 AND x% < 378 AND y% < 362 THEN 'BGM 3
                    G.BGM = Song3
                    LINE (210, 270)-(226, 400), _RGB32(0, 0, 0), BF
                    LINE (360, 270)-(376, 400), _RGB32(0, 0, 0), BF
                    _PUTIMAGE (212, 340), MenuA, _DISPLAY, (0, 0)-(13, 13)
                    _PUTIMAGE (360, 340), MenuA, _DISPLAY, (16, 0)-(29, 13)
                    songchange%% = TRUE
                END IF
                IF x% > 210 AND y% > 368 AND x% < 378 AND y% < 394 THEN 'BGM Off
                    G.BGM = NoBGM
                    LINE (210, 270)-(226, 400), _RGB32(0, 0, 0), BF
                    LINE (360, 270)-(376, 400), _RGB32(0, 0, 0), BF
                    _PUTIMAGE (212, 374), MenuA, _DISPLAY, (0, 0)-(13, 13)
                    _PUTIMAGE (360, 374), MenuA, _DISPLAY, (16, 0)-(29, 13)
                    songchange%% = TRUE
                END IF
                IF x% > 36 AND y% > 372 AND x% < 166 AND y% < 392 THEN 'BGM Volume
                    G.BGMVol = ((x% - 37) / 128) * 100
                    LINE (30, 372)-(172, 388), _RGB32(0, 0, 0), BF
                    _PUTIMAGE (30 + G.BGMVol * 1.28, 374), MenuA, _DISPLAY, (32, 0)-(45, 13)
                    volchange%% = TRUE
                END IF
                IF x% > 36 AND y% > 276 AND x% < 166 AND y% < 292 THEN 'SFX Volume
                    G.SFXVol = ((x% - 37) / 128) * 100
                    LINE (30, 276)-(172, 292), _RGB32(0, 0, 0), BF
                    _PUTIMAGE (30 + G.SFXVol * 1.28, 278), MenuA, _DISPLAY, (32, 0)-(45, 13)
                    FXvolchange%% = TRUE
                END IF

                exitflag%% = ClickInteraction(x%, y%)
            END IF
            DO: _DELAY .001: LOOP WHILE _MOUSEINPUT
        END IF

        IF G.Sound THEN
            IF songchange%% AND G.BGM <> old%% THEN
                _SNDSTOP BGM(old%%)
                _SNDLOOP BGM(G.BGM)
                old%% = G.BGM
                songchange%% = FALSE
                volchange%% = TRUE
            ELSE
                songchange%% = FALSE
            END IF

            IF volchange%% THEN
                _SNDVOL BGM(G.BGM), (G.BGMVol / 100)
                volchange%% = FALSE
            END IF

            IF FXvolchange%% AND (NOT _MOUSEBUTTON(1)) THEN
                _SNDVOL SFX(0), (G.SFXVol / 100)
                _SNDPLAY SFX(0) 'plays a test sound effect
                FXvolchange%% = FALSE
            END IF
        END IF
        _DELAY .01
    LOOP UNTIL exitflag%%

    IF exitflag%% <> BACK AND exitflag%% <> QUIT THEN
        IF G.Sound THEN
            FOR w% = 0 TO 17
                _SNDVOL SFX(w%), G.SFXVol / 100
            NEXT w%
            _SNDVOL BGM(G.BGM), G.BGMVol / 100
        END IF
        DO: LOOP WHILE _MOUSEINPUT
    END IF
    IF exitflag%% = TRUE THEN MenuID%% = 1 'go to next menu
    IF exitflag%% = BACK THEN MenuID%% = -1 'go back to title screen
    IF exitflag%% = QUIT THEN QuitGameFlag%% = TRUE 'quit game
END SUB

SUB MenuTwoA
    LINE (0, 0)-(512, 480), _RGB32(0, 0, 0), BF
    _PUTIMAGE (109, 157), MenuB, _DISPLAY, (0, 0)-(31, 31)
    _PUTIMAGE (5, 5), MenuB, _DISPLAY, (64, 16)-(574, 462)
    DisplayClickOptions
    ShowHighScoreA
    DO
        nul%% = _MOUSEINPUT
        IF nul%% THEN
            IF _MOUSEBUTTON(1) THEN
                x% = _MOUSEX: y% = _MOUSEY
                IF x% > 108 AND y% > 155 AND x% < 271 AND y% < 221 THEN 'Start Level
                    IF y% > 155 AND y% < 188 THEN ll% = 0: yy% = 155: lvl%% = 0
                    IF y% > 188 AND y% < 221 THEN ll% = 5: yy% = 189: lvl%% = 5
                    SELECT CASE x%
                        CASE 108 TO 139
                            ll% = ll% + 0: xx% = 109: lvl%% = lvl%% + 0
                        CASE 139 TO 172
                            ll% = ll% + 1: xx% = 141: lvl%% = lvl%% + 1
                        CASE 172 TO 204
                            ll% = ll% + 2: xx% = 173: lvl%% = lvl%% + 2
                        CASE 204 TO 236
                            ll% = ll% + 3: xx% = 204: lvl%% = lvl%% + 3
                        CASE 236 TO 271
                            ll% = ll% + 4: xx% = 237: lvl%% = lvl%% + 4
                    END SELECT
                    _PUTIMAGE (109, 153), MenuB, _DISPLAY, (0, 32)-(63, 101)
                    _PUTIMAGE (173, 153), MenuB, _DISPLAY, (0, 102)-(63, 171)
                    _PUTIMAGE (237, 153), MenuB, _DISPLAY, (0, 172)-(63, 241)
                    _PUTIMAGE (xx%, yy%), MenuB, _DISPLAY, (0, 0)-(31, 31)
                    _PUTIMAGE (107, 153), MenuB, _DISPLAY, (166, 164)-(331, 243)

                END IF
                exitflag%% = ClickInteraction(x%, y%)
            END IF
            DO: LOOP WHILE _MOUSEINPUT
        END IF
        _DELAY .01
    LOOP UNTIL exitflag%%
    G.Level = lvl%%
    DO: LOOP WHILE _MOUSEINPUT
    IF exitflag%% = TRUE THEN MenuID%% = 2 'start game
    IF exitflag%% = BACK THEN MenuID%% = 0 'go back to menu one
    IF exitflag%% = QUIT THEN QuitGameFlag%% = TRUE 'quit game
END SUB

SUB MenuTwoB
    LINE (0, 0)-(512, 480), _RGB32(0, 0, 0), BF
    _PUTIMAGE (109, 157), MenuC, _DISPLAY, (0, 0)-(31, 31)
    _PUTIMAGE (317, 157), MenuC, _DISPLAY, (0, 0)-(31, 31)
    _PUTIMAGE (5, 5), MenuC, _DISPLAY, (64, 16)-(574, 462)
    DisplayClickOptions
    ShowHighScoreB
    DO
        nul%% = _MOUSEINPUT
        IF nul%% THEN
            IF _MOUSEBUTTON(1) THEN
                x% = _MOUSEX: y% = _MOUSEY
                IF x% > 108 AND y% > 155 AND x% < 271 AND y% < 221 THEN 'Start Level
                    IF y% > 155 AND y% < 188 THEN yy% = 155: lvl%% = 0
                    IF y% > 188 AND y% < 221 THEN yy% = 189: lvl%% = 5
                    SELECT CASE x%
                        CASE 108 TO 139
                            xx% = 109: lvl%% = lvl%% + 0
                        CASE 139 TO 172
                            xx% = 141: lvl%% = lvl%% + 1
                        CASE 172 TO 204
                            xx% = 173: lvl%% = lvl%% + 2
                        CASE 204 TO 236
                            xx% = 204: lvl%% = lvl%% + 3
                        CASE 236 TO 271
                            xx% = 237: lvl%% = lvl%% + 4
                    END SELECT
                    LINE (107, 153)-(272, 243), _RGB32(0, 0, 0), BF
                    _PUTIMAGE (xx%, yy%), MenuC, _DISPLAY, (0, 0)-(31, 31)
                    _PUTIMAGE (107, 153), MenuC, _DISPLAY, (166, 164)-(331, 243)
                END IF
                IF x% > 317 AND y% > 155 AND x% < 413 AND y% < 221 THEN 'Start Level
                    IF y% > 155 AND y% < 188 THEN hyy% = 155: hlvl%% = 0
                    IF y% > 188 AND y% < 221 THEN hyy% = 189: hlvl%% = 3
                    SELECT CASE x%
                        CASE 318 TO 348
                            hxx% = 317: hlvl%% = hlvl%% + 0
                        CASE 349 TO 380
                            hxx% = 349: hlvl%% = hlvl%% + 1
                        CASE 381 TO 412
                            hxx% = 381: hlvl%% = hlvl%% + 2
                    END SELECT
                    LINE (315, 153)-(415, 243), _RGB32(0, 0, 0), BF
                    _PUTIMAGE (hxx%, hyy%), MenuC, _DISPLAY, (0, 0)-(31, 31)
                    _PUTIMAGE (315, 153), MenuC, _DISPLAY, (374, 164)-(474, 243)
                END IF
                exitflag%% = ClickInteraction(x%, y%)
            END IF
            DO: LOOP WHILE _MOUSEINPUT
        END IF
        _DELAY .01
    LOOP UNTIL exitflag%%
    G.Level = lvl%%
    G.Height = hlvl%%
    P.Lines = 25
    DO: LOOP WHILE _MOUSEINPUT
    IF exitflag%% = TRUE THEN MenuID%% = 2 'start game
    IF exitflag%% = BACK THEN MenuID%% = 0 ' go back to menu one
    IF exitflag%% = QUIT THEN QuitGameFlag%% = TRUE 'quit game
END SUB

SUB DisplayNextPiece
    'display the next peice in queue
    'display peice centered in NEXT window(420)
    'first clear next window
    LINE (388, 212)-(450, 275), _RGB32(0, 0, 0), BF
    IF G.Level < 10 THEN Yshift~%% = 16 * G.Level ELSE Yshift~%% = 16 * 9
    SELECT CASE P.NextP
        CASE T
            _PUTIMAGE (420 - 24, 212 + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
            _PUTIMAGE (420 - 8, 212 + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
            _PUTIMAGE (420 + 8, 212 + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
            _PUTIMAGE (420 - 8, 212 + 32), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
        CASE J
            _PUTIMAGE (420 - 24, 212 + 16), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
            _PUTIMAGE (420 - 8, 212 + 16), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
            _PUTIMAGE (420 + 8, 212 + 16), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
            _PUTIMAGE (420 + 8, 212 + 32), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
        CASE L
            _PUTIMAGE (420 - 24, 212 + 16), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
            _PUTIMAGE (420 - 8, 212 + 16), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
            _PUTIMAGE (420 + 8, 212 + 16), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
            _PUTIMAGE (420 - 24, 212 + 32), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
        CASE Z
            _PUTIMAGE (420 - 24, 212 + 16), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
            _PUTIMAGE (420 - 8, 212 + 16), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
            _PUTIMAGE (420 - 8, 212 + 32), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
            _PUTIMAGE (420 + 8, 212 + 32), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
        CASE O
            _PUTIMAGE (420 - 16, 212 + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
            _PUTIMAGE (420 + 0, 212 + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
            _PUTIMAGE (420 - 16, 212 + 32), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
            _PUTIMAGE (420 + 0, 212 + 32), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
        CASE S
            _PUTIMAGE (420 - 8, 212 + 16), Nomes, _DISPLAY, (31, Yshift~%%)-(45, Yshift~%% + 13)
            _PUTIMAGE (420 + 8, 212 + 16), Nomes, _DISPLAY, (31, Yshift~%%)-(45, Yshift~%% + 13)
            _PUTIMAGE (420 - 8, 212 + 32), Nomes, _DISPLAY, (31, Yshift~%%)-(45, Yshift~%% + 13)
            _PUTIMAGE (420 - 24, 212 + 32), Nomes, _DISPLAY, (31, Yshift~%%)-(45, Yshift~%% + 13)
        CASE I
            _PUTIMAGE (420 - 32, 212 + 24), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
            _PUTIMAGE (420 - 16, 212 + 24), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
            _PUTIMAGE (420 + 0, 212 + 24), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
            _PUTIMAGE (420 + 16, 212 + 24), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)

    END SELECT
END SUB

SUB PlaceTetraNome
    px% = P.PieceX * 16 + 197 + AdjX%
    py% = P.PieceY * 16 + 85 - 16
    IF G.Level < 10 THEN Yshift~%% = 16 * G.Level ELSE Yshift~%% = 16 * 9
    SELECT CASE P.Piece
        CASE T
            SELECT CASE P.Orent
                CASE 1 'normal
                    _PUTIMAGE (px% - 24, py% + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% + 8, py% + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 32), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                CASE 2 '90 rt
                    IF P.PieceY > 0 THEN _PUTIMAGE (px% - 8, py% + 0), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 32), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% - 24, py% + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                CASE 3 '180rt
                    _PUTIMAGE (px% - 24, py% + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% + 8, py% + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    IF P.PieceY > 0 THEN _PUTIMAGE (px% - 8, py% + 0), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                CASE 4 '270rt
                    IF P.PieceY > 0 THEN _PUTIMAGE (px% - 8, py% + 0), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 32), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% + 8, py% + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
            END SELECT
        CASE J
            SELECT CASE P.Orent
                CASE 1 'normal
                    _PUTIMAGE (px% - 24, py% + 16), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
                    _PUTIMAGE (px% + 8, py% + 16), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
                    _PUTIMAGE (px% + 8, py% + 32), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
                CASE 2 '90 rt
                    IF P.PieceY > 0 THEN _PUTIMAGE (px% - 8, py% + 0), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 32), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
                    _PUTIMAGE (px% - 24, py% + 32), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
                CASE 3 '180 rt
                    _PUTIMAGE (px% - 24, py% + 16), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
                    _PUTIMAGE (px% + 8, py% + 16), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
                    IF P.PieceY > 0 THEN _PUTIMAGE (px% - 24, py% + 0), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
                CASE 4 '270 rt
                    IF P.PieceY > 0 THEN _PUTIMAGE (px% - 8, py% + 0), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 32), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
                    IF P.PieceY > 0 THEN _PUTIMAGE (px% + 8, py% + 0), Nomes, _DISPLAY, (32, Yshift~%%)-(45, Yshift~%% + 13)
            END SELECT
        CASE L
            SELECT CASE P.Orent
                CASE 1 'normal
                    _PUTIMAGE (px% - 24, py% + 16), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                    _PUTIMAGE (px% + 8, py% + 16), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                    _PUTIMAGE (px% - 24, py% + 32), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                CASE 2 '90 rt
                    IF P.PieceY > 0 THEN _PUTIMAGE (px% - 8, py% + 0), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 32), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                    IF P.PieceY > 0 THEN _PUTIMAGE (px% - 24, py% + 0), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                CASE 3 '180 rt
                    _PUTIMAGE (px% - 24, py% + 16), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                    _PUTIMAGE (px% + 8, py% + 16), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                    IF P.PieceY > 0 THEN _PUTIMAGE (px% + 8, py% + 0), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                CASE 4 '270 rt
                    IF P.PieceY > 0 THEN _PUTIMAGE (px% - 8, py% + 0), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 32), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                    _PUTIMAGE (px% + 8, py% + 32), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
            END SELECT
        CASE Z
            SELECT CASE P.Orent
                CASE 1, 3 'normal+180
                    _PUTIMAGE (px% - 24, py% + 16), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 32), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                    _PUTIMAGE (px% + 8, py% + 32), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                CASE 2, 4 '90 rt+270rt
                    IF P.PieceY > 0 THEN _PUTIMAGE (px% - 8, py% + 0), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                    _PUTIMAGE (px% - 24, py% + 16), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
                    _PUTIMAGE (px% - 24, py% + 32), Nomes, _DISPLAY, (16, Yshift~%%)-(29, Yshift~%% + 13)
            END SELECT
        CASE O
            SELECT CASE P.Orent
                CASE 1 TO 4 'normal-no rotation change
                    _PUTIMAGE (px% - 24, py% + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% - 24, py% + 32), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 32), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
            END SELECT
        CASE S
            SELECT CASE P.Orent
                CASE 1, 3 'normal+180rt
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (31, Yshift~%%)-(45, Yshift~%% + 13)
                    _PUTIMAGE (px% + 8, py% + 16), Nomes, _DISPLAY, (31, Yshift~%%)-(45, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 32), Nomes, _DISPLAY, (31, Yshift~%%)-(45, Yshift~%% + 13)
                    _PUTIMAGE (px% - 24, py% + 32), Nomes, _DISPLAY, (31, Yshift~%%)-(45, Yshift~%% + 13)
                CASE 2, 4 '90rt+270rt
                    IF P.PieceY > 0 THEN _PUTIMAGE (px% - 8, py% + 0), Nomes, _DISPLAY, (31, Yshift~%%)-(45, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (31, Yshift~%%)-(45, Yshift~%% + 13)
                    _PUTIMAGE (px% + 8, py% + 16), Nomes, _DISPLAY, (31, Yshift~%%)-(45, Yshift~%% + 13)
                    _PUTIMAGE (px% + 8, py% + 32), Nomes, _DISPLAY, (31, Yshift~%%)-(45, Yshift~%% + 13)
            END SELECT
        CASE I
            SELECT CASE P.Orent
                CASE 1, 3 'normal+180
                    _PUTIMAGE (px% - 24, py% + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% + 8, py% + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% + 24, py% + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                CASE 2, 4 '90rt,270rt
                    IF P.PieceY > 0 THEN _PUTIMAGE (px% - 8, py% + 0), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 16), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 32), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
                    _PUTIMAGE (px% - 8, py% + 48), Nomes, _DISPLAY, (0, Yshift~%%)-(13, Yshift~%% + 13)
            END SELECT
    END SELECT
END SUB

SUB DropPiece
    P.PieceY = P.PieceY + 1 'move Tetranome down
    IF ButtonHeld%% THEN P.bonus = P.bonus + 1 'if player is pressing down button then add to bonus
    IF CollisionDown THEN LandPiece 'check to see if the peice is landed
END SUB

FUNCTION CollisionDown
    result%% = FALSE
    SELECT CASE P.Piece
        CASE T
            SELECT CASE P.Orent
                CASE 1
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX, P.PieceY + 2) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 2
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 3
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 4
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX, P.PieceY + 2) > TRUE THEN result%% = TRUE
            END SELECT
            IF P.PieceY + 1 = 21 THEN result%% = TRUE
        CASE J
            SELECT CASE P.Orent
                CASE 1
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 2
                    IF Board(P.PieceX - 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 3
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 4
                    IF Board(P.PieceX - 0, P.PieceY + 2) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 0) > TRUE THEN result%% = TRUE
            END SELECT
            IF P.PieceY + 1 = 21 THEN result%% = TRUE
        CASE L
            SELECT CASE P.Orent
                CASE 1
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 2
                    IF Board(P.PieceX - 0, P.PieceY + 2) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 0) > TRUE THEN result%% = TRUE
                CASE 3
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 4
                    IF Board(P.PieceX + 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX, P.PieceY + 2) > TRUE THEN result%% = TRUE
            END SELECT
            IF P.PieceY + 1 = 21 THEN result%% = TRUE
        CASE Z
            SELECT CASE P.Orent
                CASE 1, 3
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX, P.PieceY + 2) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 2, 4
                    IF Board(P.PieceX + 0, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
            END SELECT
            IF P.PieceY + 1 = 21 THEN result%% = TRUE
        CASE S
            SELECT CASE P.Orent
                CASE 1, 3
                    IF Board(P.PieceX - 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX, P.PieceY + 2) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 2, 4
                    IF Board(P.PieceX + 0, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
            END SELECT
            IF P.PieceY + 1 = 21 THEN result%% = TRUE
        CASE I
            SELECT CASE P.Orent
                CASE 1, 3
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 0, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF P.PieceY + 1 = 21 THEN result%% = TRUE
                CASE 2, 4
                    IF Board(P.PieceX + 0, P.PieceY + 3) > TRUE THEN result%% = TRUE
                    IF P.PieceY + 1 = 20 THEN result%% = TRUE
            END SELECT
        CASE O
            SELECT CASE P.Orent
                CASE 1 TO 4
                    IF Board(P.PieceX + 0, P.PieceY + 2) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                    IF P.PieceY + 1 = 21 THEN result%% = TRUE
            END SELECT
    END SELECT
    CollisionDown = result%%
END FUNCTION

SUB LandPiece
    SELECT CASE P.Piece
        CASE T
            Board(P.PieceX + 0, P.PieceY) = 0
            SELECT CASE P.Orent
                CASE 1
                    Board(P.PieceX - 1, P.PieceY) = 0
                    Board(P.PieceX + 1, P.PieceY) = 0
                    Board(P.PieceX + 0, P.PieceY + 1) = 0
                CASE 2
                    Board(P.PieceX + 0, P.PieceY - 1) = 0
                    Board(P.PieceX - 1, P.PieceY) = 0
                    Board(P.PieceX + 0, P.PieceY + 1) = 0
                CASE 3
                    Board(P.PieceX - 1, P.PieceY) = 0
                    Board(P.PieceX + 1, P.PieceY) = 0
                    Board(P.PieceX + 0, P.PieceY - 1) = 0
                CASE 4
                    Board(P.PieceX + 0, P.PieceY - 1) = 0
                    Board(P.PieceX + 1, P.PieceY) = 0
                    Board(P.PieceX + 0, P.PieceY + 1) = 0
            END SELECT
        CASE J
            Board(P.PieceX + 0, P.PieceY) = 2
            SELECT CASE P.Orent
                CASE 1
                    Board(P.PieceX - 1, P.PieceY) = 2
                    Board(P.PieceX + 1, P.PieceY) = 2
                    Board(P.PieceX + 1, P.PieceY + 1) = 2
                CASE 2
                    Board(P.PieceX - 0, P.PieceY - 1) = 2
                    Board(P.PieceX + 0, P.PieceY + 1) = 2
                    Board(P.PieceX - 1, P.PieceY + 1) = 2
                CASE 3
                    Board(P.PieceX - 1, P.PieceY) = 2
                    Board(P.PieceX + 1, P.PieceY) = 2
                    Board(P.PieceX - 1, P.PieceY - 1) = 2
                CASE 4
                    Board(P.PieceX - 0, P.PieceY - 1) = 2
                    Board(P.PieceX + 0, P.PieceY + 1) = 2
                    Board(P.PieceX + 1, P.PieceY - 1) = 2
            END SELECT
        CASE L
            Board(P.PieceX + 0, P.PieceY) = 1
            SELECT CASE P.Orent
                CASE 1
                    Board(P.PieceX - 1, P.PieceY) = 1
                    Board(P.PieceX + 1, P.PieceY) = 1
                    Board(P.PieceX - 1, P.PieceY + 1) = 1
                CASE 2
                    Board(P.PieceX - 0, P.PieceY - 1) = 1
                    Board(P.PieceX + 0, P.PieceY + 1) = 1
                    Board(P.PieceX - 1, P.PieceY - 1) = 1
                CASE 3
                    Board(P.PieceX - 1, P.PieceY) = 1
                    Board(P.PieceX + 1, P.PieceY) = 1
                    Board(P.PieceX + 1, P.PieceY - 1) = 1
                CASE 4
                    Board(P.PieceX - 0, P.PieceY - 1) = 1
                    Board(P.PieceX + 0, P.PieceY + 1) = 1
                    Board(P.PieceX + 1, P.PieceY + 1) = 1
            END SELECT
        CASE Z
            Board(P.PieceX + 0, P.PieceY) = 1
            SELECT CASE P.Orent
                CASE 1, 3
                    Board(P.PieceX - 1, P.PieceY) = 1
                    Board(P.PieceX + 0, P.PieceY + 1) = 1
                    Board(P.PieceX + 1, P.PieceY + 1) = 1
                CASE 2, 4
                    Board(P.PieceX - 0, P.PieceY - 1) = 1
                    Board(P.PieceX - 1, P.PieceY + 0) = 1
                    Board(P.PieceX - 1, P.PieceY + 1) = 1
            END SELECT
        CASE S
            Board(P.PieceX + 0, P.PieceY) = 2
            SELECT CASE P.Orent
                CASE 1, 3
                    Board(P.PieceX + 1, P.PieceY) = 2
                    Board(P.PieceX + 0, P.PieceY + 1) = 2
                    Board(P.PieceX - 1, P.PieceY + 1) = 2
                CASE 2, 4
                    Board(P.PieceX - 0, P.PieceY - 1) = 2
                    Board(P.PieceX + 1, P.PieceY + 0) = 2
                    Board(P.PieceX + 1, P.PieceY + 1) = 2
            END SELECT
        CASE I
            Board(P.PieceX + 0, P.PieceY) = 0
            SELECT CASE P.Orent
                CASE 1, 3
                    Board(P.PieceX - 1, P.PieceY) = 0
                    Board(P.PieceX + 1, P.PieceY + 0) = 0
                    Board(P.PieceX + 2, P.PieceY + 0) = 0
                CASE 2, 4
                    Board(P.PieceX - 0, P.PieceY - 1) = 0
                    Board(P.PieceX + 0, P.PieceY + 1) = 0
                    Board(P.PieceX + 0, P.PieceY + 2) = 0
            END SELECT
        CASE O
            Board(P.PieceX + 0, P.PieceY) = 0
            SELECT CASE P.Orent
                CASE 1 TO 4
                    Board(P.PieceX - 1, P.PieceY) = 0
                    Board(P.PieceX - 0, P.PieceY + 1) = 0
                    Board(P.PieceX - 1, P.PieceY + 1) = 0
            END SELECT
    END SELECT
    CheckLines
    IF ButtonHeld%% THEN P.Score = P.Score + (P.bonus * (G.Level + 1)): LandedNew%% = TRUE
    P.bonus = 0
    IF NOT G.GameOverFlag THEN NewPiece
END SUB

SUB DrawBoard
    IF G.Level < 10 THEN Yshift~%% = 16 * G.Level ELSE Yshift~%% = 16 * 9
    FOR y% = 0 TO 19
        FOR x% = 0 TO 9
            IF Board(x% + 1, y% + 1) <> -1 THEN
                _PUTIMAGE (197 + x% * 16, 85 + y% * 16), Nomes, _DISPLAY, (0 + 16 * Board(x% + 1, y% + 1), Yshift~%%)-(15 + 16 * Board(x% + 1, y% + 1), 15 + Yshift~%%)
            ELSE
                LINE (197 + x% * 16, 85 + y% * 16)-(197 + 15 + x% * 16, 85 + 15 + y% * 16), _RGB32(0, 0, 0), BF
            END IF
        NEXT x%
    NEXT y%
END SUB

SUB BoardSetup
    FOR y% = 0 TO 20
        FOR x% = 1 TO 10
            Board(x%, y%) = TRUE
        NEXT x%
    NEXT y%
END SUB

SUB dumpboard
    OPEN "debugboard.txt" FOR OUTPUT AS #2
    LandPiece
    FOR y% = 0 TO 21
        FOR x% = 0 TO 11
            PRINT #2, Board(x%, y%);
        NEXT x%
        PRINT #2,
    NEXT y%
END SUB

SUB CheckLines
    DIM Lines%(4) 'can fill up to 4 lines at once for a TETRIS
    ip%% = 1
    'find solid lines
    FOR y%% = 1 TO 20
        solid%% = TRUE 'assume line is solid at start
        FOR x%% = 1 TO 10
            IF Board(x%%, y%%) = TRUE THEN solid%% = FALSE 'change to false if hole found
        NEXT
        IF solid%% THEN Lines%(ip%%) = y%%: ip%% = ip%% + 1
    NEXT
    ip%% = ip%% - 1
    IF ip%% > 0 THEN
        IF G.Mode = TypeA THEN P.Lines = P.Lines + ip%%
        IF G.Mode = TypeB THEN P.Lines = P.Lines - ip%%
        IF P.Lines < 0 THEN P.Lines = 0
        'remove solid lines
        IF Lines%(1) <> 0 THEN
            FOR x% = 1 TO 5
                FOR y% = 1 TO ip%%
                    Board(6 - x%, Lines%(y%)) = -1
                    Board(5 + x%, Lines%(y%)) = -1
                NEXT y%
                DrawBoard
                _DELAY .075
            NEXT x%
        END IF
        'give player points for lines completed
        SELECT CASE ip%%
            CASE 1
                P.Score = P.Score + (40 * (G.Level + 1))
            CASE 2
                P.Score = P.Score + (100 * (G.Level + 1))
            CASE 3
                P.Score = P.Score + (300 * (G.Level + 1))
            CASE 4
                P.Score = P.Score + (1200 * (G.Level + 1))
        END SELECT
        'TETRIS bonus
        IF ip%% = 4 THEN P.Score = P.Score + (100 * (ip%% * (G.Level + 1)))
        'drop any lines down to fill in gaps
        FOR w%% = 1 TO ip%%
            FOR y%% = Lines%(w%%) TO 1 STEP -1
                FOR x%% = 1 TO 10
                    Board(x%%, y%%) = Board(x%%, y%% - 1)
                NEXT x%%
            NEXT y%%
            FOR x%% = 1 TO 10 'reset top line
                Board(x%%, y%% + 1) = TRUE
            NEXT x%%
        NEXT w%%
        DrawBoard

        IF (P.Lines > 0) AND ((P.Lines MOD 10) = 0) AND G.Mode = TypeA THEN
            TIMER(TI(G.Level)) OFF
            IF G.Level < 10 THEN G.Level = G.Level + 1
            TIMER(TI(G.Level)) ON
        END IF

    END IF
    IF G.Mode = TypeB AND P.Lines = 0 THEN GameOver
END SUB

FUNCTION CollisionLeft
    result%% = FALSE
    SELECT CASE P.Piece
        CASE T
            SELECT CASE P.Orent
                CASE 1
                    IF Board(P.PieceX - 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 2
                    IF Board(P.PieceX - 1, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 3
                    IF Board(P.PieceX - 1, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 4
                    IF Board(P.PieceX - 1, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
            END SELECT
        CASE J
            SELECT CASE P.Orent
                CASE 1
                    IF Board(P.PieceX - 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 2
                    IF Board(P.PieceX - 1, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 2, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 3
                    IF Board(P.PieceX - 2, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 4
                    IF Board(P.PieceX - 1, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
            END SELECT
        CASE L
            SELECT CASE P.Orent
                CASE 1
                    IF Board(P.PieceX - 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 2, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 2
                    IF Board(P.PieceX - 2, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 3
                    IF Board(P.PieceX - 1, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 4
                    IF Board(P.PieceX - 1, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
            END SELECT
        CASE Z
            SELECT CASE P.Orent
                CASE 1, 3
                    IF Board(P.PieceX - 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 2, 4
                    IF Board(P.PieceX - 1, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 2, P.PieceY + 2) > TRUE THEN result%% = TRUE
            END SELECT
        CASE S
            SELECT CASE P.Orent
                CASE 1, 3
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 2, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 2, 4
                    IF Board(P.PieceX - 1, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
            END SELECT
        CASE I
            SELECT CASE P.Orent
                CASE 1, 3
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 2, 4
                    IF Board(P.PieceX - 1, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 3) > TRUE THEN result%% = TRUE
            END SELECT
        CASE O
            SELECT CASE P.Orent
                CASE 1 TO 4
                    IF Board(P.PieceX - 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 2, P.PieceY + 2) > TRUE THEN result%% = TRUE
            END SELECT
    END SELECT
    CollisionLeft = result%%
END FUNCTION

FUNCTION CollisionRight
    result%% = FALSE
    SELECT CASE P.Piece
        CASE T
            SELECT CASE P.Orent
                CASE 1
                    IF Board(P.PieceX + 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 2
                    IF Board(P.PieceX + 1, P.PieceY + 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 3
                    IF Board(P.PieceX + 1, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 4
                    IF Board(P.PieceX + 1, P.PieceY + 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
            END SELECT
        CASE J
            SELECT CASE P.Orent
                CASE 1
                    IF Board(P.PieceX + 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 2, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 2
                    IF Board(P.PieceX + 1, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 3
                    IF Board(P.PieceX + 1, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 4
                    IF Board(P.PieceX + 2, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
            END SELECT
        CASE L
            SELECT CASE P.Orent
                CASE 1
                    IF Board(P.PieceX + 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 2
                    IF Board(P.PieceX + 1, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 3
                    IF Board(P.PieceX + 2, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 4
                    IF Board(P.PieceX + 1, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 2, P.PieceY + 2) > TRUE THEN result%% = TRUE
            END SELECT
        CASE Z
            SELECT CASE P.Orent
                CASE 1, 3
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 2, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 2, 4
                    IF Board(P.PieceX + 1, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
            END SELECT
        CASE S
            SELECT CASE P.Orent
                CASE 1, 3
                    IF Board(P.PieceX + 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 2, 4
                    IF Board(P.PieceX + 1, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 2, P.PieceY + 2) > TRUE THEN result%% = TRUE
            END SELECT
        CASE I
            SELECT CASE P.Orent
                CASE 1, 3
                    IF Board(P.PieceX + 3, P.PieceY) > TRUE THEN result%% = TRUE
                CASE 2, 4
                    IF Board(P.PieceX + 1, P.PieceY - 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 3) > TRUE THEN result%% = TRUE
            END SELECT
        CASE O
            SELECT CASE P.Orent
                CASE 1 TO 4
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
            END SELECT
    END SELECT
    CollisionRight = result%%
END FUNCTION

SUB StatusUpdate
    DIM v$(11) 'value strings
    v$(0) = LEFT$("000", 3 - LEN(LTRIM$(STR$(P.Lines)))) + LTRIM$(STR$(P.Lines))
    v$(1) = LEFT$("000000", 6 - LEN(LTRIM$(STR$(G.HScore1)))) + LTRIM$(STR$(G.HScore1))
    v$(2) = LEFT$("000000", 6 - LEN(LTRIM$(STR$(P.Score)))) + LTRIM$(STR$(P.Score))
    v$(3) = LEFT$("000", 3 - LEN(LTRIM$(STR$(P.Tcount)))) + LTRIM$(STR$(P.Tcount))
    v$(4) = LEFT$("000", 3 - LEN(LTRIM$(STR$(P.Jcount)))) + LTRIM$(STR$(P.Jcount))
    v$(5) = LEFT$("000", 3 - LEN(LTRIM$(STR$(P.Zcount)))) + LTRIM$(STR$(P.Zcount))
    v$(6) = LEFT$("000", 3 - LEN(LTRIM$(STR$(P.Ocount)))) + LTRIM$(STR$(P.Ocount))
    v$(7) = LEFT$("000", 3 - LEN(LTRIM$(STR$(P.Scount)))) + LTRIM$(STR$(P.Scount))
    v$(8) = LEFT$("000", 3 - LEN(LTRIM$(STR$(P.Lcount)))) + LTRIM$(STR$(P.Lcount))
    v$(9) = LEFT$("000", 3 - LEN(LTRIM$(STR$(P.Icount)))) + LTRIM$(STR$(P.Icount))
    v$(10) = LEFT$("00", 2 - LEN(LTRIM$(STR$(G.Level)))) + LTRIM$(STR$(G.Level))
    v$(11) = LEFT$("00", 2 - LEN(LTRIM$(STR$(G.Height)))) + LTRIM$(STR$(G.Height))
    FOR u% = 0 TO 6
        COLOR _RGB32(240, 58, 0)
        _PRINTSTRING (102, 175 + u% * 32), v$(3 + u%), _DISPLAY
        COLOR _RGB32(255, 255, 255)
    NEXT u%
    _PRINTSTRING (308, 34), v$(0), _DISPLAY
    _PRINTSTRING (388, 70), v$(1), _DISPLAY
    _PRINTSTRING (388, 120), v$(2), _DISPLAY
    _PRINTSTRING (428 - (LEN(v$(10)) * _FONTWIDTH(FFX(1))) / 2, 324), v$(10), _DISPLAY
    IF G.Mode = TypeB THEN _PRINTSTRING (440 - (LEN(v$(11)) * _FONTWIDTH(FFX(1))) / 2, 390), v$(11), _DISPLAY
END SUB

SUB NewPiece
    IF Board(5, 1) <> TRUE THEN GameOver
    IF NOT G.GameOverFlag THEN
        P.PieceY = 0
        P.PieceX = 5
        P.Orent = 1
        P.Piece = P.NextP
        P.NextP = INT(RND * 7) + 1
        SELECT CASE P.Piece
            CASE T
                P.Tcount = P.Tcount + 1
            CASE J
                P.Jcount = P.Jcount + 1
            CASE L
                P.Lcount = P.Lcount + 1
            CASE Z
                P.Zcount = P.Zcount + 1
            CASE S
                P.Scount = P.Scount + 1
            CASE O
                P.Ocount = P.Ocount + 1
            CASE I
                P.Icount = P.Icount + 1
        END SELECT
        StatusUpdate
        DisplayNextPiece
    END IF
END SUB

FUNCTION CollisionRotate
    result%% = FALSE
    SELECT CASE P.Piece
        CASE T
            SELECT CASE P.Orent
                CASE 1
                    IF Board(P.PieceX + 0, P.PieceY + 0) > TRUE THEN result%% = TRUE
                CASE 2
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 3
                    IF Board(P.PieceX + 0, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 4
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
            END SELECT
        CASE J
            SELECT CASE P.Orent
                CASE 1
                    IF Board(P.PieceX + 0, P.PieceY + 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 0, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 2
                    IF Board(P.PieceX - 1, P.PieceY + 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 3
                    IF Board(P.PieceX - 0, P.PieceY + 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 0, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 4
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
            END SELECT
        CASE L
            SELECT CASE P.Orent
                CASE 1
                    IF Board(P.PieceX + 0, P.PieceY + 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 0, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 2
                    IF Board(P.PieceX + 1, P.PieceY + 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 3
                    IF Board(P.PieceX - 0, P.PieceY + 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 0, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 4
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
            END SELECT
        CASE Z
            SELECT CASE P.Orent
                CASE 1, 3
                    IF Board(P.PieceX - 0, P.PieceY + 2) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                CASE 2, 4
                    IF Board(P.PieceX - 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 0) > TRUE THEN result%% = TRUE
            END SELECT
        CASE S
            SELECT CASE P.Orent
                CASE 1, 3
                    IF Board(P.PieceX - 1, P.PieceY + 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                CASE 2, 4
                    IF Board(P.PieceX + 1, P.PieceY + 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX - 1, P.PieceY + 2) > TRUE THEN result%% = TRUE
            END SELECT
        CASE O
        CASE I
            SELECT CASE P.Orent
                CASE 1, 3
                    IF Board(P.PieceX - 0, P.PieceY + 0) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 0, P.PieceY + 2) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 0, P.PieceY + 3) > TRUE THEN result%% = TRUE
                CASE 2, 4
                    IF Board(P.PieceX - 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF Board(P.PieceX + 1, P.PieceY + 1) > TRUE THEN result%% = TRUE
                    IF P.PieceX + 2 < 12 THEN IF Board(P.PieceX + 2, P.PieceY + 1) > TRUE THEN result%% = TRUE
            END SELECT

    END SELECT
    CollisionRotate = result%%
END FUNCTION

SUB GameOver
    MenuID%% = -1 'return to title screen
    G.GameOverFlag = TRUE
    IF ButtonHeld%% THEN TIMER(TI(10)) OFF ELSE TIMER(TI(G.Level)) OFF
    _SNDSTOP BGM(G.BGM)
    _SNDPLAY SFX(3)
    _DELAY .25
    FOR y% = 1 TO 20
        FOR x% = 1 TO 10
            Board(x%, y%) = 3
        NEXT x%
        DrawBoard
        _DELAY .2
    NEXT y%
    IF G.Mode = TypeA THEN
        IF P.Score > 30000 THEN EndScreen
        IF P.Score > G.HScore3 THEN HighScoreScreen
    END IF
    IF G.Mode = TypeB THEN
        IF P.Score > G.HScore3B THEN HighScoreScreen
    END IF
    _DELAY 2.5
END SUB

FUNCTION ClickInteraction (x%, y%)
    IF x% > 570 AND y% > 130 AND x% < 710 AND y% < 175 THEN 'next
        result%% = TRUE
    END IF
    IF x% > 570 AND y% > 200 AND x% < 710 AND y% < 245 THEN 'go back
        result%% = BACK
    END IF
    IF x% > 570 AND y% > 400 AND x% < 710 AND y% < 445 THEN 'quit
        result%% = QUIT
    END IF

    ClickInteraction = result%%
END FUNCTION

SUB EndScreen
    COLOR _RGB32(250, 250, 250), _RGB32(0, 89, 251)
    LINE (0, 0)-(512, 480), _RGB32(0, 0, 0), BF
    _PUTIMAGE (5, 5), EndScrnA, _DISPLAY, (64, 16)-(574, 462)
    v$ = LEFT$("000000", 6 - LEN(LTRIM$(STR$(P.Score)))) + LTRIM$(STR$(P.Score))
    _PRINTSTRING (225, 50), v$, _DISPLAY
    SELECT CASE P.Score
        CASE 30000 TO 49999
            _PUTIMAGE (168, 373), EndSprtA, _DISPLAY, (98, 0)-(113, 15)
            _DELAY 2.75
            FOR w% = 0 TO 72
                y% = y% + (16 * (w% / 100))
                _PUTIMAGE (168, 373 - y%), EndSprtA, _DISPLAY, (98, 0)-(113, 15)
                SELECT CASE INT(RND * 3) + 1
                    CASE 1
                        _PUTIMAGE (167, 389 - y%), EndSprtA, _DISPLAY, (98, 16)-(113, 31)
                    CASE 2
                        _PUTIMAGE (167, 389 - y%), EndSprtA, _DISPLAY, (98, 32)-(113, 47)
                    CASE 3
                        _PUTIMAGE (167, 389 - y%), EndSprtA, _DISPLAY, (98, 48)-(113, 63)
                END SELECT
                _DELAY .05
                _PUTIMAGE (168, 388 - y%), EndScrnA, _DISPLAY, (168 + 59, 373 + 10 - y%)-(184 + 59, 388 + 10 - y%)
                _PUTIMAGE (168, 388 - y%), EndScrnA, _DISPLAY, (168 + 59, 389 + 10 - y%)-(184 + 59, 405 + 10 - y%)
            NEXT w%
        CASE 50000 TO 74999
            _PUTIMAGE (168, 357), EndSprtA, _DISPLAY, (82, 0)-(97, 31)
            _DELAY 2.75
            FOR w% = 0 TO 72
                y% = y% + (16 * (w% / 100))
                _PUTIMAGE (168, 357 - y%), EndSprtA, _DISPLAY, (82, 0)-(97, 31)
                SELECT CASE INT(RND * 3) + 1
                    CASE 1
                        _PUTIMAGE (168, 389 - y%), EndSprtA, _DISPLAY, (98, 16)-(113, 31)
                    CASE 2
                        _PUTIMAGE (168, 389 - y%), EndSprtA, _DISPLAY, (98, 32)-(113, 47)
                    CASE 3
                        _PUTIMAGE (168, 389 - y%), EndSprtA, _DISPLAY, (98, 48)-(113, 63)
                END SELECT
                _DELAY .05
                _PUTIMAGE (168, 356 - y%), EndScrnA, _DISPLAY, (168 + 59, 357 + 10 - y%)-(184 + 59, 389 + 10 - y%)
                _PUTIMAGE (168, 388 - y%), EndScrnA, _DISPLAY, (168 + 59, 389 + 10 - y%)-(184 + 59, 405 + 10 - y%)
            NEXT w%
        CASE 75000 TO 99999
            _PUTIMAGE (160, 325), EndSprtA, _DISPLAY, (50, 0)-(79, 63)
            _DELAY 2.75
            FOR w% = 0 TO 72
                y% = y% + (16 * (w% / 100))
                _PUTIMAGE (160, 325 - y%), EndSprtA, _DISPLAY, (50, 0)-(79, 63)
                SELECT CASE INT(RND * 3) + 1
                    CASE 1
                        _PUTIMAGE (162, 389 - y%), EndSprtA, _DISPLAY, (98, 16)-(113, 31)
                        _PUTIMAGE (172, 389 - y%), EndSprtA, _DISPLAY, (98, 16)-(113, 31)
                    CASE 2
                        _PUTIMAGE (162, 389 - y%), EndSprtA, _DISPLAY, (98, 32)-(113, 47)
                        _PUTIMAGE (172, 389 - y%), EndSprtA, _DISPLAY, (98, 32)-(113, 47)
                    CASE 3
                        _PUTIMAGE (162, 389 - y%), EndSprtA, _DISPLAY, (98, 48)-(113, 63)
                        _PUTIMAGE (172, 389 - y%), EndSprtA, _DISPLAY, (98, 48)-(113, 63)
                END SELECT
                _DELAY .05
                _PUTIMAGE (160, 325 - y%), EndScrnA, _DISPLAY, (160 + 59, 325 + 10 - y%)-(192 + 59, 389 + 10 - y%)
                _PUTIMAGE (160, 388 - y%), EndScrnA, _DISPLAY, (160 + 59, 389 + 10 - y%)-(192 + 59, 405 + 10 - y%)
            NEXT w%
        CASE 100000 TO 149999
            _PUTIMAGE (160, 278), EndSprtA, _DISPLAY, (0, 0)-(49, 112)
            _DELAY 2.75
            FOR w% = 0 TO 72
                y% = y% + (16 * (w% / 100))
                _PUTIMAGE (160, 278 - y%), EndSprtA, _DISPLAY, (0, 0)-(49, 112)
                SELECT CASE INT(RND * 3) + 1
                    CASE 1
                        _PUTIMAGE (162, 389 - y%), EndSprtA, _DISPLAY, (98, 16)-(113, 31)
                        _PUTIMAGE (177, 389 - y%), EndSprtA, _DISPLAY, (0, 114)-(15, 129)
                        _PUTIMAGE (192, 389 - y%), EndSprtA, _DISPLAY, (98, 16)-(113, 31)
                    CASE 2
                        _PUTIMAGE (162, 389 - y%), EndSprtA, _DISPLAY, (98, 32)-(113, 47)
                        _PUTIMAGE (176, 389 - y%), EndSprtA, _DISPLAY, (16, 114)-(33, 129)
                        _PUTIMAGE (192, 389 - y%), EndSprtA, _DISPLAY, (98, 32)-(113, 47)
                    CASE 3
                        _PUTIMAGE (162, 389 - y%), EndSprtA, _DISPLAY, (98, 48)-(113, 63)
                        _PUTIMAGE (168, 389 - y%), EndSprtA, _DISPLAY, (0, 130)-(31, 161)
                        _PUTIMAGE (192, 389 - y%), EndSprtA, _DISPLAY, (98, 48)-(113, 63)
                END SELECT
                _DELAY .05
                _PUTIMAGE (160, 278 - y%), EndScrnA, _DISPLAY, (160 + 59, 279 + 10 - y%)-(212 + 59, 389 + 10 - y%)
                _PUTIMAGE (160, 388 - y%), EndScrnA, _DISPLAY, (160 + 59, 389 + 10 - y%)-(212 + 59, 421 + 10 - y%)
            NEXT w%
        CASE IS > 150000
    END SELECT
    COLOR _RGB(255, 255, 255), _RGB32(0, 0, 0)
    _DELAY 2.5
END SUB

SUB HighScoreScreen
    _KEYCLEAR
    DIM names(6) AS STRING * 1
    _PUTIMAGE (5, 5), HighS, _DISPLAY, (64, 16)-(574, 462)
    IF G.Mode = TypeA THEN
        ShowHighScoreA
        IF P.Score > G.HScore1 THEN
            G.HScore1 = P.Score: G.Hlevel1 = G.Level
            _PRINTSTRING (264, 306), LEFT$("000000", 6 - LEN(LTRIM$(STR$(G.HScore1)))) + LTRIM$(STR$(G.HScore1))
            _PRINTSTRING (376, 306), LEFT$("00", 2 - LEN(LTRIM$(STR$(G.Hlevel1)))) + LTRIM$(STR$(G.Hlevel1))
            lv%% = 1: ltr%% = 65: G.HName1 = "      "
            names(1) = "A"
            FOR w%% = 2 TO 6
                names(w%%) = " "
            NEXT w%%
            DO
                kbd& = _KEYHIT
                SELECT CASE kbd&
                    CASE 19200 'left
                        IF lv%% > 1 THEN lv%% = lv%% - 1
                        ltr%% = ASC(names(lv%%))
                    CASE 19712 'right
                        IF lv%% < 6 THEN lv%% = lv%% + 1
                        ltr%% = ASC(names(lv%%))
                    CASE 18432 'up
                        ltr%% = ltr%% + 1
                        IF ltr%% = 91 THEN ltr%% = 64
                    CASE 20480 'down
                        ltr%% = ltr%% - 1
                        IF ltr%% = 63 THEN ltr%% = 90
                    CASE 13, 27
                        exitflag%% = TRUE
                END SELECT
                IF ltr%% = 64 THEN ltr%% = 32
                names(lv%%) = CHR$(ltr%%)
                IF ltr%% = 32 THEN ltr%% = 64
                G.HName1 = names(1) + names(2) + names(3) + names(4) + names(5) + names(6)
                _PRINTSTRING (150, 306), G.HName1
                LINE (150 + ((lv%% - 1) * 16), 326)-(166 + ((lv%% - 1) * 16), 328), _RGB32(212, 64, 48), BF
                _DELAY .02
                LINE (150, 326)-(256, 328), _RGB32(0, 0, 0), BF
            LOOP UNTIL exitflag%%
        ELSEIF P.Score > G.HScore2 THEN
            G.HScore2 = P.Score: G.Hlevel2 = G.Level
            _PRINTSTRING (264, 338), LEFT$("000000", 6 - LEN(LTRIM$(STR$(G.HScore2)))) + LTRIM$(STR$(G.HScore2))
            _PRINTSTRING (376, 338), LEFT$("00", 2 - LEN(LTRIM$(STR$(G.Hlevel2)))) + LTRIM$(STR$(G.Hlevel2))
            lv%% = 1: ltr%% = 65: G.HName2 = "      "
            FOR w%% = 1 TO 6
                names(w%%) = " "
            NEXT w%%
            DO
                kbd& = _KEYHIT
                SELECT CASE kbd&
                    CASE 19200 'left
                        IF lv%% > 1 THEN lv%% = lv%% - 1
                        ltr%% = ASC(names(lv%%))
                    CASE 19712 'right
                        IF lv%% < 6 THEN lv%% = lv%% + 1
                        ltr%% = ASC(names(lv%%))
                    CASE 18432 'up
                        ltr%% = ltr%% + 1
                        IF ltr%% = 91 THEN ltr%% = 64
                    CASE 20480 'down
                        ltr%% = ltr%% - 1
                        IF ltr%% = 63 THEN ltr%% = 90
                    CASE 13, 27
                        exitflag%% = TRUE
                END SELECT
                IF ltr%% = 64 THEN ltr%% = 32
                names(lv%%) = CHR$(ltr%%)
                IF ltr%% = 32 THEN ltr%% = 64
                G.HName2 = names(1) + names(2) + names(3) + names(4) + names(5) + names(6)
                _PRINTSTRING (150, 338), G.HName2
                LINE (150 + ((lv%% - 1) * 16), 358)-(166 + ((lv%% - 1) * 16), 360), _RGB32(212, 64, 48), BF
                _DELAY .02
                LINE (150, 358)-(256, 360), _RGB32(0, 0, 0), BF
            LOOP UNTIL exitflag%%
        ELSEIF P.Score > G.HScore3 THEN
            G.HScore3 = P.Score: G.Hlevel3 = G.Level
            _PRINTSTRING (264, 370), LEFT$("000000", 6 - LEN(LTRIM$(STR$(G.HScore3)))) + LTRIM$(STR$(G.HScore3))
            _PRINTSTRING (376, 370), LEFT$("00", 2 - LEN(LTRIM$(STR$(G.Hlevel3)))) + LTRIM$(STR$(G.Hlevel3))
            lv%% = 1: ltr%% = 65: G.HName3 = "      "
            FOR w%% = 1 TO 6
                names(w%%) = " "
            NEXT w%%
            DO
                kbd& = _KEYHIT
                SELECT CASE kbd&
                    CASE 19200 'left
                        IF lv%% > 1 THEN lv%% = lv%% - 1
                        ltr%% = ASC(names(lv%%))
                    CASE 19712 'right
                        IF lv%% < 6 THEN lv%% = lv%% + 1
                        ltr%% = ASC(names(lv%%))
                    CASE 18432 'up
                        ltr%% = ltr%% + 1
                        IF ltr%% = 91 THEN ltr%% = 64
                    CASE 20480 'down
                        ltr%% = ltr%% - 1
                        IF ltr%% = 63 THEN ltr%% = 90
                    CASE 13, 27
                        exitflag%% = TRUE
                END SELECT
                IF ltr%% = 64 THEN ltr%% = 32
                names(lv%%) = CHR$(ltr%%)
                IF ltr%% = 32 THEN ltr%% = 64
                G.HName3 = names(1) + names(2) + names(3) + names(4) + names(5) + names(6)
                _PRINTSTRING (150, 370), G.HName3
                LINE (150 + ((lv%% - 1) * 16), 390)-(166 + ((lv%% - 1) * 16), 392), _RGB32(212, 64, 48), BF
                _DELAY .02
                LINE (150, 390)-(256, 392), _RGB32(0, 0, 0), BF
            LOOP UNTIL exitflag%%
        END IF
        _KEYCLEAR

    ELSE
        ShowHighScoreB
        IF P.Score > G.HScore1B THEN
            G.HScore1B = P.Score: G.Hlevel1B = G.Level
            _PRINTSTRING (264, 306), LEFT$("000000", 6 - LEN(LTRIM$(STR$(G.HScore1B)))) + LTRIM$(STR$(G.HScore1B))
            _PRINTSTRING (376, 306), LEFT$("00", 2 - LEN(LTRIM$(STR$(G.Hlevel1B)))) + LTRIM$(STR$(G.Hlevel1B))
            lv%% = 1: ltr%% = 65: G.HName1B = "      "
            FOR w%% = 1 TO 6
                names(w%%) = " "
            NEXT w%%
            DO
                kbd& = _KEYHIT
                SELECT CASE kbd&
                    CASE 19200 'left
                        IF lv%% > 1 THEN lv%% = lv%% - 1
                        ltr%% = ASC(names(lv%%))
                    CASE 19712 'right
                        IF lv%% < 6 THEN lv%% = lv%% + 1
                        ltr%% = ASC(names(lv%%))
                    CASE 18432 'up
                        ltr%% = ltr%% + 1
                        IF ltr%% = 91 THEN ltr%% = 64
                    CASE 20480 'down
                        ltr%% = ltr%% - 1
                        IF ltr%% = 63 THEN ltr%% = 90
                    CASE 13, 27
                        exitflag%% = TRUE
                END SELECT
                IF ltr%% = 64 THEN ltr%% = 32
                names(lv%%) = CHR$(ltr%%)
                IF ltr%% = 32 THEN ltr%% = 64
                G.HName1B = names(1) + names(2) + names(3) + names(4) + names(5) + names(6)
                _PRINTSTRING (150, 306), G.HName1B
                LINE (150 + ((lv%% - 1) * 16), 326)-(166 + ((lv%% - 1) * 16), 328), _RGB32(212, 64, 48), BF
                _DELAY .02
                LINE (150, 326)-(256, 328), _RGB32(0, 0, 0), BF
            LOOP UNTIL exitflag%%
        ELSEIF P.Score > G.HScore2B THEN
            G.HScore2B = P.Score: G.Hlevel2B = G.Level
            _PRINTSTRING (264, 338), LEFT$("000000", 6 - LEN(LTRIM$(STR$(G.HScore2B)))) + LTRIM$(STR$(G.HScore2B))
            _PRINTSTRING (376, 338), LEFT$("00", 2 - LEN(LTRIM$(STR$(G.Hlevel2B)))) + LTRIM$(STR$(G.Hlevel2B))
            lv%% = 1: ltr%% = 65: G.HName2B = "      "
            FOR w%% = 1 TO 6
                names(w%%) = " "
            NEXT w%%
            DO
                kbd& = _KEYHIT
                SELECT CASE kbd&
                    CASE 19200 'left
                        IF lv%% > 1 THEN lv%% = lv%% - 1
                        ltr%% = ASC(names(lv%%))
                    CASE 19712 'right
                        IF lv%% < 6 THEN lv%% = lv%% + 1
                        ltr%% = ASC(names(lv%%))
                    CASE 18432 'up
                        ltr%% = ltr%% + 1
                        IF ltr%% = 91 THEN ltr%% = 64
                    CASE 20480 'down
                        ltr%% = ltr%% - 1
                        IF ltr%% = 63 THEN ltr%% = 90
                    CASE 13, 27
                        exitflag%% = TRUE
                END SELECT
                IF ltr%% = 64 THEN ltr%% = 32
                names(lv%%) = CHR$(ltr%%)
                IF ltr%% = 32 THEN ltr%% = 64
                G.HName2B = names(1) + names(2) + names(3) + names(4) + names(5) + names(6)
                _PRINTSTRING (150, 338), G.HName2B
                LINE (150 + ((lv%% - 1) * 16), 358)-(166 + ((lv%% - 1) * 16), 360), _RGB32(212, 64, 48), BF
                _DELAY .02
                LINE (150, 358)-(256, 360), _RGB32(0, 0, 0), BF
            LOOP UNTIL exitflag%%
        ELSEIF P.Score > G.HScore3B THEN
            G.HScore3B = P.Score: G.Hlevel3B = G.Level
            _PRINTSTRING (264, 370), LEFT$("000000", 6 - LEN(LTRIM$(STR$(G.HScore3B)))) + LTRIM$(STR$(G.HScore3B))
            _PRINTSTRING (376, 370), LEFT$("00", 2 - LEN(LTRIM$(STR$(G.Hlevel3B)))) + LTRIM$(STR$(G.Hlevel3B))
            lv%% = 1: ltr%% = 65: G.HName3B = "      "
            FOR w%% = 1 TO 6
                names(w%%) = " "
            NEXT w%%
            DO
                kbd& = _KEYHIT
                SELECT CASE kbd&
                    CASE 19200 'left
                        IF lv%% > 1 THEN lv%% = lv%% - 1
                        ltr%% = ASC(names(lv%%))
                    CASE 19712 'right
                        IF lv%% < 6 THEN lv%% = lv%% + 1
                        ltr%% = ASC(names(lv%%))
                    CASE 18432 'up
                        ltr%% = ltr%% + 1
                        IF ltr%% = 91 THEN ltr%% = 64
                    CASE 20480 'down
                        ltr%% = ltr%% - 1
                        IF ltr%% = 63 THEN ltr%% = 90
                    CASE 13, 27
                        exitflag%% = TRUE
                END SELECT
                IF ltr%% = 64 THEN ltr%% = 32
                names(lv%%) = CHR$(ltr%%)
                IF ltr%% = 32 THEN ltr%% = 64
                G.HName3B = names(1) + names(2) + names(3) + names(4) + names(5) + names(6)
                _PRINTSTRING (150, 370), G.HName3B
                LINE (150 + ((lv%% - 1) * 16), 390)-(166 + ((lv%% - 1) * 16), 392), _RGB32(212, 64, 48), BF
                _DELAY .02
                LINE (150, 390)-(256, 392), _RGB32(0, 0, 0), BF
            LOOP UNTIL exitflag%%
        END IF
        _KEYCLEAR
    END IF
END SUB

SUB ShowHighScoreA
    _PRINTSTRING (150, 306), G.HName1
    _PRINTSTRING (264, 306), LEFT$("000000", 6 - LEN(LTRIM$(STR$(G.HScore1)))) + LTRIM$(STR$(G.HScore1))
    _PRINTSTRING (376, 306), LEFT$("00", 2 - LEN(LTRIM$(STR$(G.Hlevel1)))) + LTRIM$(STR$(G.Hlevel1))
    _PRINTSTRING (150, 338), G.HName2
    _PRINTSTRING (264, 338), LEFT$("000000", 6 - LEN(LTRIM$(STR$(G.HScore2)))) + LTRIM$(STR$(G.HScore2))
    _PRINTSTRING (376, 338), LEFT$("00", 2 - LEN(LTRIM$(STR$(G.Hlevel2)))) + LTRIM$(STR$(G.Hlevel2))
    _PRINTSTRING (150, 370), G.HName3
    _PRINTSTRING (264, 370), LEFT$("000000", 6 - LEN(LTRIM$(STR$(G.HScore3)))) + LTRIM$(STR$(G.HScore3))
    _PRINTSTRING (376, 370), LEFT$("00", 2 - LEN(LTRIM$(STR$(G.Hlevel3)))) + LTRIM$(STR$(G.Hlevel3))
END SUB

SUB ShowHighScoreB
    _PRINTSTRING (150, 306), G.HName1B
    _PRINTSTRING (264, 306), LEFT$("000000", 6 - LEN(LTRIM$(STR$(G.HScore1B)))) + LTRIM$(STR$(G.HScore1B))
    _PRINTSTRING (376, 306), LEFT$("00", 2 - LEN(LTRIM$(STR$(G.Hlevel1B)))) + LTRIM$(STR$(G.Hlevel1B))
    _PRINTSTRING (150, 338), G.HName2B
    _PRINTSTRING (264, 338), LEFT$("000000", 6 - LEN(LTRIM$(STR$(G.HScore2B)))) + LTRIM$(STR$(G.HScore2B))
    _PRINTSTRING (376, 338), LEFT$("00", 2 - LEN(LTRIM$(STR$(G.Hlevel2B)))) + LTRIM$(STR$(G.Hlevel2B))
    _PRINTSTRING (150, 370), G.HName3B
    _PRINTSTRING (264, 370), LEFT$("000000", 6 - LEN(LTRIM$(STR$(G.HScore3B)))) + LTRIM$(STR$(G.HScore3B))
    _PRINTSTRING (376, 370), LEFT$("00", 2 - LEN(LTRIM$(STR$(G.Hlevel3B)))) + LTRIM$(STR$(G.Hlevel3B))
END SUB

SUB MoveLeft
    SELECT CASE P.Piece
        CASE T, J, L
            SELECT CASE P.Orent
                CASE 1, 2, 3
                    IF P.PieceX = 1 THEN P.PieceX = 2
                CASE 4
                    IF P.PieceX = 0 THEN P.PieceX = 1
            END SELECT
        CASE Z
            SELECT CASE P.Orent
                CASE 1 TO 4
                    IF P.PieceX = 1 THEN P.PieceX = 2
            END SELECT
        CASE S
            SELECT CASE P.Orent
                CASE 1, 3
                    IF P.PieceX = 1 THEN P.PieceX = 2
                CASE 2, 4
                    IF P.PieceX = 0 THEN P.PieceX = 1
            END SELECT
        CASE O
            SELECT CASE P.Orent
                CASE 1 TO 4
                    IF P.PieceX = 1 THEN P.PieceX = 2
            END SELECT
        CASE I
            SELECT CASE P.Orent
                CASE 2, 4
                    IF P.PieceX = 0 THEN P.PieceX = 1
                CASE 1, 3
                    IF P.PieceX = 1 THEN P.PieceX = 2
            END SELECT
    END SELECT

END SUB
SUB MoveRight
    SELECT CASE P.Piece
        CASE T, J, L
            SELECT CASE P.Orent
                CASE 1, 3, 4
                    IF P.PieceX = 10 THEN P.PieceX = 9
                CASE 2
                    IF P.PieceX = 11 THEN P.PieceX = 10
            END SELECT
        CASE Z
            SELECT CASE P.Orent
                CASE 1, 3
                    IF P.PieceX = 10 THEN P.PieceX = 9
                CASE 2, 4
                    IF P.PieceX = 11 THEN P.PieceX = 10
            END SELECT
        CASE S
            SELECT CASE P.Orent
                CASE 1, 3
                    IF P.PieceX = 10 THEN P.PieceX = 9
                CASE 2, 4
                    IF P.PieceX = 10 THEN P.PieceX = 9
            END SELECT
        CASE O
            SELECT CASE P.Orent
                CASE 1 TO 4
                    IF P.PieceX = 11 THEN P.PieceX = 10
            END SELECT
        CASE I
            SELECT CASE P.Orent
                CASE 2, 4
                    IF P.PieceX = 11 THEN P.PieceX = 10
                CASE 1, 3
                    IF P.PieceX = 9 THEN P.PieceX = 8
            END SELECT
    END SELECT
END SUB

SUB StartData
    IF G.HScore1 = 0 THEN
        G.BGMVol = 100
        G.SFXVol = 100
        G.Mode = TypeA
        G.BGM = Song1
        G.HScore1 = 15000
        G.HScore2 = 10000
        G.HScore3 = 5000
        G.Hlevel1 = 10
        G.Hlevel2 = 5
        G.Hlevel3 = 1
        G.HName1 = "Narika"
        G.HName2 = "Cobalt"
        G.HName3 = "Ninten"
        G.HScore1B = 5000
        G.HScore2B = 3000
        G.HScore3B = 1000
        G.Hlevel1B = 10
        G.Hlevel2B = 5
        G.Hlevel3B = 1
        G.HName1B = "Nobody"
        G.HName2B = "anybdy"
        G.HName3B = "losers"

        G.Level = 0
        P.Score = 0
    ELSE
        G.GameOverFlag = FALSE
        G.Level = 0
        P.Score = 0
        P.Lines = 0
        BoardSetup
    END IF
END SUB

SUB BTypeHeight
    IF G.Height > 0 THEN
        FOR y%% = 20 TO (20 - (G.Height * 3)) + 1 STEP -1
            FOR x%% = 1 TO 10
                garbage%% = INT(RND * 100) + 1
                IF garbage%% > 45 THEN Board(x%%, y%%) = INT(RND * 3)
            NEXT x%%
        NEXT y%%
    END IF
END SUB

SUB GameModeA
    LINE (0, 0)-(799, 480), _RGB32(0, 0, 0), BF
    _PUTIMAGE (5, 5), FieldA, _DISPLAY, (64, 16)-(574, 462)
    P.NextP = INT(RND * 7) + 1
    NewPiece
    PlaceTetraNome
    '197,85
    'Btype height * 3 lines
    TIMER(TI(G.Level)) ON
    DO
        KBD& = _KEYHIT
        SELECT CASE KBD&
            CASE 19200 'left
                IF NOT CollisionLeft THEN
                    P.PieceX = P.PieceX - 1
                    MoveLeft
                END IF
            CASE 19712 'right
                IF NOT CollisionRight THEN
                    P.PieceX = P.PieceX + 1
                    MoveRight
                END IF
            CASE 20480 'Down
                IF ButtonHeld%% = FALSE THEN 'if player holds the down arrow switch to faster timer
                    TIMER(TI(G.Level)) OFF
                    TIMER(TI(10)) ON
                    ButtonHeld%% = TRUE
                END IF
            CASE 32 'space
                'rotational point is second block, top row if app.
                IF NOT CollisionRotate THEN
                    P.Orent = P.Orent + 1
                    IF P.Orent = 5 THEN P.Orent = 1
                    SELECT CASE P.Piece
                        CASE T, J, L
                            'if piece is to close to edge to rotate then bump it out 1
                            IF P.PieceX = 1 AND P.Orent <> 4 THEN P.PieceX = 2
                            IF P.PieceX = 10 AND P.Orent <> 2 THEN P.PieceX = 9
                        CASE Z
                            IF P.PieceX = 10 AND P.Orent <> 2 THEN P.PieceX = 9
                        CASE O
                        CASE S
                            IF P.PieceX = 10 AND P.Orent <> 2 THEN P.PieceX = 9
                        CASE I
                            IF P.PieceX = 1 AND (P.Orent <> 1 OR P.Orent <> 3) THEN P.PieceX = 2
                            IF P.PieceX = 10 AND (P.Orent <> 1 OR P.Orent <> 3) THEN P.PieceX = 8
                    END SELECT
                END IF
                _KEYCLEAR
            CASE 27 'Esc
                exitflag%% = TRUE
                QuitGameFlag%% = TRUE
        END SELECT

        IF NOT _KEYDOWN(20480) AND ButtonHeld%% THEN 'if player releases the down arrow restore timer
            ButtonHeld%% = FALSE
            TIMER(TI(10)) OFF
            TIMER(TI(G.Level)) ON
            P.bonus = 0
        END IF

        LINE (197, 85)-(197 + 159, 85 + 319), _RGB32(0, 0, 0), BF
        DrawBoard
        PlaceTetraNome
        _DELAY .01
        IF G.GameOverFlag THEN exitflag%% = TRUE
    LOOP UNTIL exitflag%%
    TIMER(TI(G.Level)) OFF
END SUB

SUB GameModeB
    LINE (0, 0)-(799, 480), _RGB32(0, 0, 0), BF
    _PUTIMAGE (5, 5), FieldB, _DISPLAY, (64, 16)-(574, 462)
    P.NextP = INT(RND * 7) + 1
    BTypeHeight
    NewPiece
    PlaceTetraNome
    'Btype height * 3 lines
    TIMER(TI(G.Level)) ON
    DO
        KBD& = _KEYHIT
        SELECT CASE KBD&
            CASE 19200 'left
                IF NOT CollisionLeft THEN
                    P.PieceX = P.PieceX - 1
                    MoveLeft
                END IF
            CASE 19712 'right
                IF NOT CollisionRight THEN
                    P.PieceX = P.PieceX + 1
                    MoveRight
                END IF
            CASE 20480 'Down
                IF ButtonHeld%% = FALSE THEN 'if player holds the down arrow switch to faster timer
                    TIMER(TI(G.Level)) OFF
                    TIMER(TI(10)) ON
                    ButtonHeld%% = TRUE
                END IF
            CASE 32 'space
                'rotational point is second block, top row if app.
                IF NOT CollisionRotate THEN
                    P.Orent = P.Orent + 1
                    IF P.Orent = 5 THEN P.Orent = 1
                    SELECT CASE P.Piece
                        CASE T, J, L
                            'if piece is to close to edge to rotate then bump it out 1
                            IF P.PieceX = 1 AND P.Orent <> 4 THEN P.PieceX = 2
                            IF P.PieceX = 10 AND P.Orent <> 2 THEN P.PieceX = 9
                        CASE Z
                            IF P.PieceX = 10 AND P.Orent <> 2 THEN P.PieceX = 9
                        CASE O
                        CASE S
                            IF P.PieceX = 10 AND P.Orent <> 2 THEN P.PieceX = 9
                        CASE I
                            IF P.PieceX = 1 AND (P.Orent <> 1 OR P.Orent <> 3) THEN P.PieceX = 2
                            IF P.PieceX = 10 AND (P.Orent <> 1 OR P.Orent <> 3) THEN P.PieceX = 8
                    END SELECT
                END IF
                _KEYCLEAR
            CASE 27 'Esc
                exitflag%% = TRUE
                QuitGameFlag%% = TRUE
        END SELECT

        IF NOT _KEYDOWN(20480) AND ButtonHeld%% THEN 'if player releases the down arrow restore timer
            ButtonHeld%% = FALSE
            TIMER(TI(10)) OFF
            TIMER(TI(G.Level)) ON
            P.bonus = 0
        END IF

        LINE (197, 85)-(197 + 159, 85 + 319), _RGB32(0, 0, 0), BF
        DrawBoard
        PlaceTetraNome
        _DELAY .01
        IF G.GameOverFlag THEN exitflag%% = TRUE
    LOOP UNTIL exitflag%%
    TIMER(TI(G.Level)) OFF
END SUB

SUB DisplayClickOptions
    _PRINTSTRING (570, 130), "Click here"
    _PRINTSTRING (570, 150), "to Continue"

    _PRINTSTRING (570, 200), "Click here"
    _PRINTSTRING (570, 220), "to go Back"

    _PRINTSTRING (570, 400), "Click here"
    _PRINTSTRING (570, 420), "Exit Game"
END SUB

FUNCTION LoadGFX& (Foff&, Size&)
    IF _FILEEXISTS("temp.dat") THEN KILL "temp.dat"
    OPEN "temp.dat" FOR BINARY AS #3
    dat$ = SPACE$(Size&)
    GET #1, Foff&, dat$
    PUT #3, , dat$
    CLOSE #3
    LoadGFX& = _LOADIMAGE("temp.dat", 32)
END FUNCTION

