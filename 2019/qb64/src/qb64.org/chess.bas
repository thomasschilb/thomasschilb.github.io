_TITLE "Chess 2017-11-22 T .bas     Ctrl+K for Keyboard input"
'2017-10-10 raw patch of Interface to Chess.bas post update with mouse troubles

' 22 10 2017 New fix to Incheck function, I hope the last!
' 22 10 2017  empowered promotion by mouse
' 22 10 2017  fix promotion visible only after move of black
' 22 10 2017 castle by mouse
' 22 10 2017  empowered castling control, now you cannot castle if they are in check
'             or across a square that is under Black control
' 22 10 2017 translated in sub Info_Help screen
' 22 10 2017  translate in sub Fellippe's Wait click and key
' 22 10 2017 added logical end to the main of program
' 22 10 2017 put away all code REMMED not yet used

'2017 10 24 changed board graphics, arranged alpha order subs, updated highlite square
' Thanks Adrian Huang
' http://www.thejoyfulprogrammer.com/qb64/forum/showthread.php?tid=401&rndtime=1508625987687357559

'2017 10 24 Incorporate TempodiBasic's legalShow and legalHide routines
' fix pawn promotions see Ppromote$
' count pieces captured and show with board
' install game recorder

' 27 10 2017 color of chessboard are CONST
' resizing square and character size to  42
' moving list of piece captured at top right
' moving output at bottom right
' new SUB ShowSetup that shows whole setup to choose pieces for white and black,
' or only pieces capturable (No king because when a King falls game stops!)
' or only pieces for promotion (Knight Bishop Rook Queen) for both colors
' now if Black resigns the flow of program ends after main do loop to let replay the game
' play again label structure and initialization instruction (it is possible to use a DO LOOP)
' Added ButtonMenuBar at bottom using MakeButton SUB
' Button QUIT working, button PLAY works for now let us play only as WHITE
' Build an area for list of moves
' build an area for output/feedback of program
' Changed Helpscreen instruction including mouse selection
' >>>> wow lots of new stuff

'2017-10-29/30 fixed dots in empty squares, highlight piece clicked, thing crawling under board while computer thinks
' now if we can only get the colors ;-)) Outer loop to restart game, elimate some boxes, less cluttered looking.
' change title to version = date easier to track

'2017 10 31 T  Yes I follow you in using date also if in my country I use DD-MM-YYYY   :-)
'  YES fixed BIG BUG about restart and Play Again lasting the last moves in memory... and in File Recorder

'2017-11-01 B review TempodiBasic's BIG BUG fix, clean up lines, comments and variables
' I (bplus) see some work also done in IO for checking checks, I assume.

'2017-11-03 B Move Intro to before main program loop, fix some things with promotion
' prompt for pieces, pWflag$, pBflag$ to add to move list

'2017-11-04 B hack AI this is just an experiment for my cat who is always curious specially
' because it exists in another universe.

'2017-11-06 A 2nd post (really posted 11-05) Added/revised code for rotating board to play Black.
' Adrain has change 5000 number to 9000 im several places and I don't know if this fixes castle
' It did fix notation in the moves list correctly

'2017-11-05 B  from Adrian's 2nd post 2017-11-06( posted 11-05) A #2   continuing with hackBlack hacks!
' I noticed that code changes were very alike and one fuction would save quite a bit of code FIXED
' I also noticed the captured pieces were backwards when Black plays FIXED
' I noticed Black cant castle yet BIGGEST FIX of them all!!!
' I noticed Ctrl+K for human playing Black did not work, well had to translate move back so
' IO can reverse again!!  FIXED!
' Check pawn promotion and track down source of mystery q added to computer's moves.
' Still allot of goofy things...

'2017-11-07 A - removed fake 1st move while playing black

'2017-11-07 B hack 2 using above mod but with EXIT SUB instead of GOTO
' fix capture counts so that only positive counts show
' Ah found source of allot of goofyness!  hackBlack > playBlack per Adrian
' I think I have this working correctly through Play Again Y/N?

'2017-11-07 T put away GOTO for label 100 to play again
' moved in main loop AI resign (strange as white it capture by King and then when you takes King it resign!!!
' GOOD first AI goes on playing without king :-)
'
'2017-11-07 2B removed 100 next to loop since no goto, fixed comments on separate line
' and added some comments, I think I have finally tracked down source of extra q's!!! FIXED

' 2017-11-10 T  fixed promotion  failure with strange choose made clicking on the other side of window of program
' at the Y of piece to get by promotion
'   Restored  MAXLEVEL at beginning of program to set power of AI
'
' 2017-11-10 2T cutting some old comments no more useful for use about issues yet resolved
' packing the 2 initboard to one (they do the same work with 2 different labels)
'
'2017-11-11 B Put T comments on separate line from code.
'Recommend making MAXLEVEL a CONST if we will not change it ever.
'Tell why two different boards are needed to initialize the board positions.
'Fix pWfalg$ again! that AI has no business changing BUT OK save ElSE block because AI
'may need to plan for eventual pawn promotion and assuming a Queen is smart assumption.
'
' 2017-11-13 T  fixed incheck failure and strange moves of king under check using a new shared flag Turn
' to let analize only the important pieces by INCHECK Function, they are different for White and for Black
' re-written in MAKEMOVE SUB (sub that makes the move on the board and check for promotion and makes the promotion if is the case
' the ELSE.. END IF part for white (Human) player is needed together INTFLAG  =1 humang chooses by himself piece in promotion, =0 autochoosed Queen
' also fixed extra q by inizilization of pWflag$ at start of SUB
'
'2017-11-15 B start work on Undo, Save and Load
' 2 functions cp2n(piece$), cn2p$(number), for converting a board to a bString$ letter and vice versa
' bString$ will get all board positions loaded in 64 character string
' bSetyp will setup a board from a bString$ used for UNDO, Save, Load and future SETUP
' Center text in a button
' Now reworked initBoard so initBlack sub can be eliminated and initBoard shrunk, now eliminated also!
' Now add stuff to make UNDO possible. new Boards$() array works along with Move$(), Boards$() has bString$ of board positions
' Incorp TempodiBasic changes to AI checking for Check (Chess 2_17-11-13 T) :
'    Use new glabal varaible Turn = 1 for White's and -1 for Black, might come in handy! Yes on loading Game
'        Eliminate the infinite crap I'd rather have AI King commiting suicide as a form of Resign for testing all other stuff
'           Except Then AI plays old trick of putting oppenent into Check for which human is not allowed to take AI KING because in check!!! phooey!
' Moved ShowButton Bar and showMoveList into ShowBd and gave showMoveList a diet
' No more File recorder, eliminate Datetime, fix UNDO for trying to go less than 1
' Remove InitBoard sub, all done in getInput button section

' Fix a ton of bugs to get all this integrated and working together but more keep popping up, blah!
' Make Result global to fix Y/N question to start over when Y
' Modify restart to clean slate the entire program, then use buttons to set particular settings needed
' Bug Loading a game right after Loading a game may cause an error
' Bug sometimes QB64 _FILEEXISTS says a real file that you typed correctly can't be found, just type it in again.
' I put a double _FILEEXISTS call in with delay between, helps but still the bug remains!!!
' Bug missing line when human loads a file playing black and starts game from there.
' Ugly fix that I doubt will work in other cases

'2017-11-16 A Tried to fix bug when AI is checkmated by modifying INCHECK function
'             Minor changes - removed 1 set of board labels. display pieces centrally on squares

'2017-11-16 B Adrian some nice changes to board but please no PlayAgain: label, no GOTO unless best way
' I do not like ending the whole application in the InCheck sub,  nor do I think one time result <-2500 is cause to quit??
' Remember AI checks many moves with InCheck, I am afraid it might quit first time it gets result < -2500 with better result left.
' Also I fix my omission with loadFlag code in IO, and it turns out with UNDO we have to clear the capture amounts, fixed.

'2017-11-18 A1: Changed White King Value to 4500, Black King value to -9000. Added test for AI's resignation in IO SUB. This should fix the AI check bug, and probably means that the
'           IN CHECK function need not check for checks to AI's king.

'2017-11-19 T: fixing the covering of the left border of buttonbar (Movelist too large passed from 700 to 680)
' 2017-11-22 T: fixing dummy _fileexists, it seems we don't need it yet
' 2017 11 22 T : coded manageDummySystem on save file, 1. now you can save only a game in progress  (no game = nothing to save)
'                                                      2. now you can overwrite an existing file only if you confirm to overwrite it
'                coded  feedback LoadFile in areaoutput


_DEFINE A-Z AS INTEGER
RANDOMIZE TIMER
CONST XMAX = 900
CONST YMAX = 600
CONST WHITE& = &HFFDDDDDD
CONST BLACK& = &HFF000000
CONST LITE& = &HFFFFFF00
CONST LITE2& = _RGB32(78, 161, 72)
CONST WHITES& = _RGB32(140, 160, 190)
CONST BLACKS& = _RGB32(0, 130, 70)
CONST SQ = 42
'T here (B out side of restart sub) we need a Maxlevel
CONST MAXLEVEL = 5
'B might as well make constant!

'B For fonts
COMMON SHARED FW, FH, normal&, maxCol, bArial&, bFW, bFH

'B For human playing Black
COMMON SHARED playBlack, bmoves$, bFirst

'B from original QB64 samples: chess.bas
DIM SHARED BOARD(0 TO 7, 0 TO 7)
DIM SHARED BESTA(0 TO 7), BESTB(0 TO 7), BESTX(0 TO 7), BESTY(0 TO 7)
DIM SHARED LEVEL, SCORE, result
DIM SHARED wcKsflag, wcQsflag, INTFLAG
DIM SHARED wcKsold, wcQsold

'B For saving moves to file
DIM SHARED whiteMove$, blackMove$, pWflag$, pBflag$, GameFile$, Turn

'B For displaying T's on screen list of moves, last 8 shown from Moves$() array
DIM SHARED InGame, countMove, loadFlag
REDIM SHARED Move$(1 TO 300)

'B for Undo
REDIM SHARED Boards$(1 TO 300)

'B Using updated Graphics Screen instead of Screen 0 text program
SCREEN _NEWIMAGE(XMAX, YMAX, 32)
_SCREENMOVE 360, 60

'B Checking fonts normal, big, and chess
'B load and check our normal font
normal& = _LOADFONT("C:\windows\fonts\arial.ttf", 20)
IF normal& <= 0 THEN PRINT "Trouble with arial.ttf size 16 file, goodbye.": SLEEP: END
_FONT normal&
FW = 11: FH = _FONTHEIGHT(normal&)
maxCol = XMAX / FW

'B load and check SQ size font
bArial& = _LOADFONT("C:\windows\fonts\arial.ttf", SQ, "MONOSPACE")
IF bArial& <= 0 THEN PRINT "Trouble with arial.ttf size "; SQ; " file, goodbye.": SLEEP: END
bFW = _FONTWIDTH(bArial&): bFH = _FONTHEIGHT(bArial&)

Intro
Wait_Click_Key
CLS
DO
    SCORE = 0
    CALL IO(A, b, x, Y, result)
    'B   HERE IS WHERE CHECKMATE NEEDS TO BE DETERMINED!!!
    IF result < -2500 THEN
        'T & B Human has won
        AreaOutput "I RESIGN!! YOU WIN!!!", " Play Again? Y/N "
        DO
            Revenge$ = UCASE$(INKEY$)
        LOOP UNTIL Revenge$ = "Y" OR Revenge$ = "N"
        IF Revenge$ = "N" THEN
            AreaOutput "Thanks for playing,", "Good Bye!"
            SLEEP 2
            SYSTEM
        END IF
        restart
        InGame = 0
    ELSE
        result = EVALUATE(-1, 10000)
        A = BESTA(1)
        b = BESTB(1)
        x = BESTX(1)
        Y = BESTY(1)
    END IF
    CALL SHOWBD
LOOP
END

'==========================================================

'B sub for user communications area, T has made it for two strings
SUB AreaOutput (outText$, out2$)
    LINE (480, 510)-(XMAX, YMAX), BLACK&, BF
    lp 26, 46, outText$
    lp 27, 46, out2$
END SUB

SUB BISHOP (A, B, XX(), YY(), NDX)
    ID = SGN(BOARD(B, A))
    FOR DXY = 1 TO 7
        X = A - DXY
        Y = B + DXY
        IF X < 0 OR X > 7 OR Y < 0 OR Y > 7 THEN EXIT FOR
        GOSUB 3
        IF BOARD(Y, X) <> 0 THEN EXIT FOR
    NEXT
    FOR DXY = 1 TO 7
        X = A + DXY
        Y = B + DXY
        IF X < 0 OR X > 7 OR Y < 0 OR Y > 7 THEN EXIT FOR
        GOSUB 3
        IF BOARD(Y, X) <> 0 THEN EXIT FOR
    NEXT
    FOR DXY = 1 TO 7
        X = A - DXY
        Y = B - DXY
        IF X < 0 OR X > 7 OR Y < 0 OR Y > 7 THEN EXIT FOR
        GOSUB 3
        IF BOARD(Y, X) <> 0 THEN EXIT FOR
    NEXT
    FOR DXY = 1 TO 7
        X = A + DXY
        Y = B - DXY
        IF X < 0 OR X > 7 OR Y < 0 OR Y > 7 THEN EXIT FOR
        GOSUB 3
        IF BOARD(Y, X) <> 0 THEN EXIT FOR
    NEXT
    EXIT SUB

    'sub gosub subroutine
    3 REM
    IF ID <> SGN(BOARD(Y, X)) THEN
        NDX = NDX + 1
        XX(NDX) = X
        YY(NDX) = Y
    END IF
    RETURN
END SUB

SUB bSetup (bStr$)
    FOR X = 0 TO 7
        FOR Y = 0 TO 7
            p$ = MID$(bStr$, 8 * X + Y + 1, 1)
            BOARD(X, Y) = cp2n(p$)
        NEXT
    NEXT
END SUB

FUNCTION bString$
    r$ = ""
    FOR X = 0 TO 7
        FOR Y = 0 TO 7
            num = BOARD(X, Y)
            r$ = r$ + cn2p$(num)
        NEXT
    NEXT
    bString$ = r$
END FUNCTION

FUNCTION Castleincheck (x)
    'T added to improve short castle control
    IF playBlack THEN
        BOARD(7, 1) = 4500
        'T first square acrossed
        null = INCHECK(x)
        BOARD(7, 1) = 0
        'T original square void
        IF null = 0 THEN
            'T if already in first test King is in check we skip second test
            BOARD(7, 2) = 4500
            'T second square acrossed
            null = INCHECK(x)
            BOARD(7, 2) = 0
        END IF
        Castleincheck = null
    ELSE
        BOARD(7, 6) = 4500
        'T first square acrossed
        null = INCHECK(x)
        BOARD(7, 6) = 0
        'T original square void
        IF null = 0 THEN
            'T if already in first test King is in check we skip second test
            BOARD(7, 5) = 4500
            'T second square acrossed
            null = INCHECK(x)
            BOARD(7, 5) = 0
        END IF
        Castleincheck = null
    END IF
END FUNCTION

FUNCTION CastleincheckL (x)
    'T added to improve long castle control
    IF playBlack THEN
        BOARD(7, 4) = 4500
        null = INCHECK(x)
        BOARD(7, 4) = 0
        'T original square void
        IF null = 0 THEN
            'T if already in first test King is in check we skip second test
            BOARD(7, 5) = 4500
            'T C1 square
            null = INCHECK(x)
            BOARD(7, 5) = 0
        END IF
        CastleincheckL = null
    ELSE
        BOARD(7, 3) = 4500
        'T or B or A D1 square
        null = INCHECK(x)
        BOARD(7, 3) = 0
        'T original square void
        IF null = 0 THEN
            'T if already in first test King is in check we skip second test
            BOARD(7, 2) = 4500
            'T C1 square
            null = INCHECK(x)
            BOARD(7, 2) = 0
        END IF
        CastleincheckL = null
    END IF
END FUNCTION

FUNCTION cn2p$ (n)
    SELECT CASE n
        CASE 0: r$ = "z"
        CASE 100: r$ = "P"
        CASE 270: r$ = "N"
        CASE 300: r$ = "B"
        CASE 500: r$ = "R"
        CASE 900: r$ = "Q"
        CASE 4500: r$ = "K"
        CASE -100: r$ = "p"
        CASE -270: r$ = "n"
        CASE -300: r$ = "b"
        CASE -500: r$ = "r"
        CASE -900: r$ = "q"
        CASE -9000: r$ = "k"
    END SELECT
    cn2p$ = r$
END FUNCTION

FUNCTION cp2n (piece$)
    SELECT CASE piece$
        CASE "z": r = 0
        CASE "P": r = 100
        CASE "N": r = 270
        CASE "B": r = 300
        CASE "R": r = 500
        CASE "Q": r = 900
        CASE "K": r = 4500
        CASE "p": r = -100
        CASE "n": r = -270
        CASE "b": r = -300
        CASE "r": r = -500
        CASE "q": r = -900
        CASE "k": r = -9000
    END SELECT
    cp2n = r
END FUNCTION

SUB cP (row, txt$)
    'B on row center Print txt$
    col = (maxCol - LEN(txt$)) / 2
    _PRINTSTRING ((XMAX - _PRINTWIDTH(txt$)) / 2, row * FH), txt$
END SUB

FUNCTION EVALUATE (ID, PRUNE)
    DIM XX(0 TO 26), YY(0 TO 26)
    LEVEL = LEVEL + 1
    BESTSCORE = 10000 * ID
    FOR b = 7 TO 0 STEP -1
        FOR A = 7 TO 0 STEP -1
            IF SGN(BOARD(b, A)) <> ID THEN GOTO 1
            'Orig IF (LEVEL = 1) THEN CALL SHOWMAN(A, B)
            'B this might be human versus human level?

            CALL MOVELIST(A, b, XX(), YY(), NDX)
            FOR I = 0 TO NDX
                X = XX(I)
                Y = YY(I)
                IF LEVEL = 1 THEN
                    AreaOutput "TRYING: " + CHR$(65 + A) + RIGHT$(STR$(8 - b), 1) + "-" + CHR$(65 + X) + RIGHT$(STR$(8 - Y), 1), ""
                    'B Might as well make this look nice too, without the space
                END IF
                OLDSCORE = SCORE
                MOVER = BOARD(b, A)
                TARGET = BOARD(Y, X)
                CALL MAKEMOVE(A, b, X, Y)
                IF (LEVEL < MAXLEVEL) THEN SCORE = SCORE + EVALUATE(-ID, BESTSCORE - TARGET + ID * (8 - ABS(4 - X) - ABS(4 - Y)))
                SCORE = SCORE + TARGET - ID * (8 - ABS(4 - X) - ABS(4 - Y))
                IF (ID < 0 AND SCORE > BESTSCORE) OR (ID > 0 AND SCORE < BESTSCORE) THEN
                    BESTA(LEVEL) = A
                    BESTB(LEVEL) = b
                    BESTX(LEVEL) = X
                    BESTY(LEVEL) = Y
                    BESTSCORE = SCORE
                    IF (ID < 0 AND BESTSCORE >= PRUNE) OR (ID > 0 AND BESTSCORE <= PRUNE) THEN
                        BOARD(b, A) = MOVER
                        BOARD(Y, X) = TARGET
                        SCORE = OLDSCORE
                        LEVEL = LEVEL - 1
                        EVALUATE = BESTSCORE
                        EXIT FUNCTION
                    END IF
                END IF
                BOARD(b, A) = MOVER
                BOARD(Y, X) = TARGET
                SCORE = OLDSCORE
            NEXT
        1 NEXT
    NEXT
    LEVEL = LEVEL - 1
    EVALUATE = BESTSCORE
END FUNCTION

FUNCTION getInput$
    DIM pieceChosen AS _BYTE
    DO
        'B Update board
        SHOWBD

        'B gather mouse input
        DO WHILE _MOUSEINPUT
            mouseButton = _MOUSEBUTTON(1)
            tx = _MOUSEX \ SQ - 1: ty = _MOUSEY \ SQ - 1
            ux = tx: uy = ty
        LOOP

        'T area of managing Button Bar
        IF _MOUSEBUTTON(1) THEN
            IF _MOUSEX > 700 THEN
                IF _MOUSEY < 120 THEN
                    'B PLAY WHITE
                    restart
                    InGame = -1
                    Turn = 1
                    playBlack = 0
                    bSetup "rnbqkbnrppppppppzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzPPPPPPPPRNBQKBNR"
                    AreaOutput "Your move.", ""
                    getInput$ = ""
                    EXIT FUNCTION
                ELSEIF _MOUSEY < 180 THEN
                    'B PLAY BLACK there was a FEN around here also

                    'T this is the FEN of initial game setup
                    '  [rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1]
                    restart
                    InGame = -1
                    Turn = -1
                    playBlack = -1
                    bSetup "rnbkqbnrppppppppzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzPPPPPPPPRNBKQBNR"
                    getInput$ = ""
                    EXIT FUNCTION
                ELSEIF _MOUSEY < 240 THEN
                    'B UNDO
                    IF countMove - 1 > 1 THEN
                        Move$(countMove) = ""
                        Boards$(countMove) = ""
                        countMove = countMove - 1
                        whiteMove$ = "": blackMove$ = "": bmoves$ = "": bFirst = -1
                        bSetup Boards$(countMove)
                        IF playBlack = 0 THEN AreaOutput "Your move.", ""
                        '_DISPLAY
                        EXIT FUNCTION
                    END IF
                ELSEIF _MOUSEY < 300 THEN
                    'B SAVE BOARD
                    'T if you are not in game what are you saving in a file?
                    IF InGame = 0 THEN EXIT FUNCTION
                    ' T file exists, overwirte? Y/N
                    DO
                        in$ = ""
                        in$ = screenInput(50 * FW, 4 * FH, "Enter Save Filename > ")
                        IF _FILEEXISTS(in$) = -1 AND in$ <> "" THEN
                            COLOR LITE&
                            AreaOutput "File exists...", " Overwrite Y/N?"
                            _DISPLAY
                            COLOR WHITE&
                            choice$ = UCASE$(INPUT$(1))
                            IF choice$ = "Y" THEN EXIT DO
                        ELSE
                            ' case _fileexists(in$) = 0
                            EXIT DO
                        END IF

                    LOOP

                    OPEN in$ FOR OUTPUT AS #1
                    IF playBlack THEN PRINT #1, "Black" ELSE PRINT #1, "White"
                    PRINT #1, blackMove$
                    'we need AI's move made if any since last Move$() entry
                    FOR i = 1 TO countMove
                        PRINT #1, Move$(i)
                    NEXT
                    FOR i = 1 TO countMove
                        PRINT #1, Boards$(i)
                    NEXT
                    CLOSE #1
                    AreaOutput "File " + ins$, "loaded"
                    _DELAY 1
                    IF playBlack = 0 THEN
                        AreaOutput "Your move.", ""
                    ELSE
                        bmove$ = blackMove$
                        bFirst = 0
                    END IF
                    getInput$ = ""
                    EXIT FUNCTION
                ELSEIF _MOUSEY < 360 THEN
                    'B  LOAD Board
                    in$ = screenInput(50 * FW, 4 * FH, "Enter Load Filename > ")
                    'B  for some damn reason the first time you try _FILEEXISTS with real file it says 0 nope!
                    'B                 but try again and is OK ?????????????????????????????????????????
                    'B                 So f... IT!
                    ' dummy = _FILEEXISTS(in$)
                    '_DELAY 1
                    'B  once is not enough, damn this sucks!!!!!!
                    'dummy = _FILEEXISTS(in$)
                    '_DELAY 1
                    'B  nope didn't help with 2nd call and delay, just try LOAD GAME again!
                    IF _FILEEXISTS(in$) = -1 THEN

                        count = 0
                        OPEN in$ FOR INPUT AS #1
                        WHILE EOF(1) = 0
                            INPUT #1, l$
                            count = count + 1
                        WEND
                        CLOSE #1

                        ' T feedback to user
                        COLOR LITE&
                        AreaOutput "File loaded", in$
                        COLOR WHITE&
                        _DISPLAY
                        _DELAY 1

                        restart
                        countMove = (count - 2) / 2
                        'B This gets needed data items before loading 2 arrays of size countMove
                        OPEN in$ FOR INPUT AS #1
                        INPUT #1, BW$
                        IF LEFT$(BW$, 1) = "B" THEN playBlack = -1 ELSE playBlack = 0
                        INPUT #1, blackMove$
                        'B  this gets AI's last move (if any) not recorded in Move$()
                        '   OK maybe we have to pretend the blackMove$ is whiteMove$ so IO can reverse it when recording in Move$()
                        FOR i = 1 TO countMove
                            INPUT #1, Move$(i)
                        NEXT
                        FOR i = 1 TO countMove
                            INPUT #1, Boards$(i)
                        NEXT
                        CLOSE #1
                        CLS
                        bSetup Boards$(countMove)
                        'B loadFlag is ugly way to fix a missing line in move list that occurs loading a game with human playing Black
                        IF playBlack = 0 THEN AreaOutput "Your move.", "" ELSE loadFlag = -1
                        InGame = -1
                    ELSE
                        AreaOutput in$, "File not found."
                    END IF
                ELSEIF _MOUSEY < 420 THEN
                    'B MANUAL SET
                ELSEIF _MOUSEY < 480 THEN
                    'T quit
                    getInput$ = "QUIT"
                    EXIT FUNCTION
                END IF
            END IF
        END IF

        IF InGame = -1 THEN
            IF pieceChosen = 0 THEN
                IF 1 <= ty AND ty <= 8 THEN
                    'Fellippe or B translate hovered coordinate to chess notation letter + digit
                    d$ = RIGHT$(STR$(9 - ty), 1)
                    IF 1 <= tx AND tx <= 8 THEN
                        l$ = CHR$(64 + tx)
                        ld$ = l$ + d$
                        'B letter + digit
                        ld2xy ld$, bx, by
                        'B translate notation to board$(x, y)
                        IF BOARD(by, bx) > 0 THEN
                            LegalShow bx, by
                            highLightSq bx, by, LITE2&
                            'Fellippe hover highlight
                            IF mouseButton THEN
                                DO WHILE mouseButton
                                    'Fellippe wait for release
                                    i = _MOUSEINPUT
                                    mouseButton = _MOUSEBUTTON(1)
                                    newtx = _MOUSEX \ SQ - 1: newty = _MOUSEY \ SQ - 1
                                LOOP
                                IF newtx = tx AND newty = ty THEN
                                    'Fellippe the mouse was released in the same square
                                    pieceChosen = -1: chosenBX = bx: chosenBY = by
                                END IF
                            END IF
                        END IF
                    END IF
                END IF
            ELSE
                LegalShow chosenBX, chosenBY
                highLightSq chosenBX, chosenBY, LITE&
                IF 1 <= uy AND uy <= 8 THEN
                    'B translate click to chess notation letter + digit
                    d2$ = RIGHT$(STR$(9 - uy), 1)
                    IF 1 <= ux AND ux <= 8 THEN
                        l2$ = CHR$(64 + ux)
                        ld2$ = l2$ + d2$
                        'B letter + digit
                        ld2xy ld2$, bx2, by2
                        highLightSq bx2, by2, LITE2&
                        'Fellippe hover highlight
                        IF mouseButton THEN
                            DO WHILE mouseButton
                                'Fellippe wait for release
                                i = _MOUSEINPUT
                                mouseButton = _MOUSEBUTTON(1)
                                newtx = _MOUSEX \ SQ - 1: newty = _MOUSEY \ SQ - 1
                            LOOP
                            IF newtx = tx AND newty = ty THEN
                                'Fellippe the mouse was released in the same square
                                IF ld$ <> ld2$ THEN
                                    getInput$ = ld$ + "-" + ld2$
                                    'T this let AI to castle for white
                                    IF BOARD(by, bx) = 4500 THEN
                                        IF ld$ = "E1" AND ld2$ = "G1" THEN getInput$ = "O-O"
                                        IF ld$ = "E1" AND ld2$ = "C1" THEN getInput$ = "O-O-O"
                                        IF playBlack = -1 THEN
                                            IF ld$ = "D1" AND ld2$ = "B1" THEN getInput$ = "O-O"
                                            IF ld$ = "D1" AND ld2$ = "F1" THEN getInput$ = "O-O-O"
                                        END IF
                                    END IF
                                    _AUTODISPLAY
                                    EXIT FUNCTION
                                ELSE
                                    LegalHide bx, by
                                    SHOWMAN bx, by
                                    EXIT DO
                                END IF
                                'B ld compare
                            END IF
                        END IF
                    END IF
                    'B ux compare
                END IF
                'B uy compare
            END IF
            'B piece chosen yet

            'B handle keyboard input
            k$ = INKEY$
            IF k$ <> "" THEN
                IF LEN(k$) = 1 THEN
                    IF ASC(k$) = 11 THEN
                        in$ = screenInput(50 * FW, 4 * FH, "(Esc to quit) Enter Move > ")
                        in$ = UCASE$(in$)
                        spac = INSTR(in$, " ")
                        IF spac THEN in$ = MID$(in$, 1, spac - 1) + "-" + MID$(in$, spac + 1)
                        IF playBlack THEN in$ = w2b$(in$)
                        getInput$ = in$
                        EXIT FUNCTION
                    ELSEIF ASC(k$) = 27 THEN
                        END
                    END IF
                END IF
            END IF
        END IF
        'B if InGame
        _DISPLAY
    LOOP
    lastLD$ = ""
    getInput$ = in$
END FUNCTION

SUB highLightSq (bx, by, c&)
    LINE ((bx + 2) * SQ, (by + 2) * SQ)-((bx + 3) * SQ, (by + 3) * SQ), , B
    LINE ((bx + 2) * SQ + 1, (by + 2) * SQ + 1)-((bx + 3) * SQ - 1, (by + 3) * SQ - 1), c&, B
    LINE ((bx + 2) * SQ + 2, (by + 2) * SQ + 2)-((bx + 3) * SQ - 2, (by + 3) * SQ - 2), c&, B
END SUB

FUNCTION INCHECK (X)
    DIM XX(27), YY(27), NDX
    FOR b = 0 TO 7
        FOR A = 0 TO 7

            IF BOARD(b, A) = 0 THEN GOTO 6
            'T original code BOARD(b,A) >= 0  if white piece or void square skip test
            'A: omit square skip test
            'B Adrian next line is OK, it just skips empty spaces in board

            CALL MOVELIST(A, b, XX(), YY(), NDX)
            FOR I = 0 TO NDX STEP 1
                X = XX(I)
                Y = YY(I)
                IF BOARD(Y, X) = 4500 AND Turn = 1 THEN
                    'B ^^^ 2017-11-13 T has added and turn = 1 but turn = 1 is same as playBlack = 0
                    AreaOutput "YOU ARE IN CHECK!", ""
                    INCHECK = 1
                    EXIT FUNCTION
                END IF
                IF BOARD(Y, X) = -9000 AND Turn = -1 THEN
                    'B ^^^ 2017-11-13 T has added and turn = -1 but turn = -1 is same as playBlack = -1
                    ' T in my last read of code posted playBack is used to note that Human plays as black
                    ' T Turn is used for knowing if the move  has been made by black Turn = -1 or by White Turn = 1
                    AreaOutput "I AM IN CHECK!", ""

                    'T this show Black status incheck
                    INCHECK = -1 'A: this is probably no longer needed
                    'T this should stop failed moves under check attack
                    'EXIT FUNCTION
                    'B exit now and get infinite loop?
                    ' T AI force must exit from loop
                END IF
            NEXT
        6 NEXT
    NEXT
    INCHECK = 0
END FUNCTION

SUB initBoard
    IF playBlack THEN
        b$ = "rnbkqbnrppppppppzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzPPPPPPPPRNBKQBNR"
    ELSE
        b$ = "rnbqkbnrppppppppzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzPPPPPPPPRNBQKBNR"
    END IF
    bSetup b$
END SUB

SUB Intro
    'T better have a subroutine that we can use as many as we want
    COLOR WHITE&, BLACK&
    cP 3, "QB64 CHESS"
    lp 5, 8, "CHESS is a game played between two players on a board of 64 squares."
    lp 6, 4, "Chess was first invented in its current form in Europe during the late"
    lp 7, 4, "fifteenth century. It evolved from much earlier forms invented in India"
    lp 8, 4, "and Persia."
    lp 9, 8, "The pieces are divided into Black and White.  Each player has 16 pieces:"
    lp 10, 4, "1 king, 1 queen, 2 rooks, 2 bishops, 2 knights, and 8 pawns.  White makes"
    lp 11, 4, "the first move.  The players alternate moving one piece at a time.  Pieces"
    lp 12, 4, "are moved to an unoccupied square, or moved onto a square occupied by an"
    lp 13, 4, "opponent's piece, capturing it.  When the king is under attack, he is in"
    lp 14, 4, "CHECK.  The player cannot put his king in check.  The object is to CHECKMATE"
    lp 15, 4, "the opponent.  This occurs when the king is in check and there is no way to"
    lp 16, 4, "remove the king from attack."
    lp 17, 8, "To move the pieces on the chessboard, click by mouse or type after Ctrl+K"
    lp 18, 4, "notation, e.g. E2-E4 (not in English notation like P-K4).  To castle, type O-O"
    lp 19, 4, "to castle kingside or O-O-O to castle queenside like in English notation."
    lp 20, 4, "To exit the game, type QUIT or press ESCAPE key."
    cP 25, "Click or press any key to continue."
END SUB

SUB IO (A, B, X, Y, RESULT)
    DIM XX(0 TO 26), YY(0 TO 26)
    IF InGame THEN
        'B ugly fix to get a missing line recorded in move list when load file and human playing black
        IF loadFlag AND blackMove$ <> "" THEN
            loadFlag = 0
            countMove = countMove + 1
            Move$(countMove) = blackMove$ + pBflag$ + "  " + whiteMove$ + pWflag$
            'B this above is so ugly I even have to reverse black and white to get it right!
            Boards$(countMove) = bString$
            'B this above was omitted in versions before 11-16, still not right???
        END IF

        IF A >= 0 THEN
            Turn = -1
            IF RESULT < -2500 THEN EXIT SUB 'AI should resign
            PIECE = BOARD(Y, X)
            CALL MAKEMOVE(A, B, X, Y)
            'T (chess2_17-11-13 T) this will fix illegal moves of AI under check
            NULL = INCHECK(0)
            'T (chess2_17-11-13 T) we must search for check after choosing a move

            'B Adrian, can't have game end here, many moves are checked can't quit if one is bad
            'IF NULL = -1 AND RESULT < -2500 THEN
            '    AreaOutput "AI resigns!", ""
            '    EXIT SUB
            'END IF

            IF NULL THEN
                'T (chess2_17-11-13 T) if there is a check for AI we must restore situation before move
                BOARD(B, A) = BOARD(Y, X)
                BOARD(Y, X) = PIECE
                EXIT SUB
                'T (chess2_17-11-13 T) if it is check move is illegal
            END IF
            'T this show Black status incheck

            mymove$ = CHR$(65 + A) + RIGHT$(STR$(8 - B), 1) + "-" + CHR$(65 + X) + RIGHT$(STR$(8 - Y), 1)

            'B ??? next line not used
            'AICHECK = 0 'reset AI check flag

            IF playBlack THEN mymove$ = w2b$(mymove$)
            AreaOutput "MY MOVE: " + mymove$, ""
            blackMove$ = mymove$
            IF whiteMove$ <> "" THEN
                IF playBlack THEN whiteMove$ = w2b$(whiteMove$)
            END IF
            WriteEntry
        END IF
        'B & T >>> it saves the last moves to file and to list I move this IF HERE TO GET THE COUPLE WHITE+BLACK

        IF PIECE <> 0 THEN
            s$ = "I TOOK YOUR "
            IF PIECE = 100 THEN s$ = s$ + "PAWN           "
            IF PIECE = 270 THEN s$ = s$ + "KNIGHT         "
            IF PIECE = 300 THEN s$ = s$ + "BISHOP         "
            IF PIECE = 500 THEN s$ = s$ + "ROOK           "
            IF PIECE = 900 THEN s$ = s$ + "QUEEN          "
            IF PIECE = 4500 THEN s$ = s$ + "KING          "
            AreaOutput "", s$
        END IF

    END IF

    DO
        'B I think this was help from Adrian, so we didn't have to fake a move
        IF playBlack = -1 AND countMove = 0 THEN countMove = 1: EXIT SUB

        'B Here we get Human's move but might be illegal so AI has to check before shown
        in$ = getInput$
        'T getinput$ takes user's input also for BUTTONBAR
        'B which is why we have to have to check InGame

        IF UCASE$(in$) = "QUIT" THEN END

        IF InGame = -1 THEN
            whiteMove$ = in$
            'B ^^^ Human's move who now plays Black or White, don't be fooled by variable name>
            'B Originally human always played white>
            Turn = 1
            IF UCASE$(in$) = "O-O" OR in$ = "0-0" THEN
                'T short castle rules... here we improve control of check and moves
                IF wcKsflag <> 0 THEN GOTO 16
                ' T it skips white castle king
                IF playBlack THEN
                    IF BOARD(7, 0) <> 500 THEN GOTO 16
                    IF BOARD(7, 1) <> 0 OR BOARD(7, 2) <> 0 THEN GOTO 16
                ELSE
                    IF BOARD(7, 7) <> 500 THEN GOTO 16
                    IF BOARD(7, 6) <> 0 OR BOARD(7, 5) <> 0 THEN GOTO 16
                END IF
                'T now we test if there is a check along the path of king
                NULL = Castleincheck(0)
                IF NULL = 0 THEN
                    'B you can castle king side
                    IF playBlack THEN
                        BOARD(7, 1) = 4500
                        BOARD(7, 3) = 0
                        BOARD(7, 2) = 500
                        BOARD(7, 0) = 0
                        wcKsflag = -1
                        'T black castle king side
                        whiteMove$ = "O-O"
                        EXIT SUB
                    ELSE
                        BOARD(7, 6) = 4500
                        BOARD(7, 4) = 0
                        BOARD(7, 5) = 500
                        BOARD(7, 7) = 0
                        wcKsflag = -1
                        'T white castle king side
                        whiteMove$ = "O-O"
                        EXIT SUB
                    END IF
                END IF
            END IF
            IF UCASE$(in$) = "O-O-O" OR in$ = "0-0-0" THEN
                'T long castle rules... here we improve control of check and moves
                IF wcQsflag <> 0 THEN GOTO 16
                IF playBlack THEN
                    IF BOARD(7, 7) <> 500 THEN GOTO 16
                    IF BOARD(7, 6) <> 0 OR BOARD(7, 5) <> 0 OR BOARD(7, 4) <> 0 THEN GOTO 16
                ELSE
                    IF BOARD(7, 0) <> 500 THEN GOTO 16
                    IF BOARD(7, 1) <> 0 OR BOARD(7, 2) <> 0 OR BOARD(7, 3) <> 0 THEN GOTO 16
                END IF
                'T now we test if there is a check along the path of king
                NULL = CastleincheckL(0)
                IF NULL = 0 THEN
                    'B you can castle queen side
                    IF playBlack THEN
                        BOARD(7, 5) = 4500
                        BOARD(7, 3) = 0
                        BOARD(7, 4) = 500
                        BOARD(7, 7) = 0
                        wcQsflag = -1
                        'T black castle queen side
                        whiteMove$ = "O-O-O"
                        EXIT SUB
                    ELSE
                        'T you can castle if there are no check to the king to the start or during the movement of castle
                        BOARD(7, 2) = 4500
                        BOARD(7, 4) = 0
                        BOARD(7, 3) = 500
                        BOARD(7, 0) = 0
                        wcQsflag = -1
                        'T white castle queen side
                        whiteMove$ = "O-O-O"
                        EXIT SUB
                    END IF
                END IF
            END IF
            IF LEN(in$) < 5 THEN GOTO 16
            B = 8 - (ASC(MID$(in$, 2, 1)) - 48)
            A = ASC(UCASE$(MID$(in$, 1, 1))) - 65
            X = ASC(UCASE$(MID$(in$, 4, 1))) - 65
            Y = 8 - (ASC(MID$(in$, 5, 1)) - 48)
            IF B > 7 OR B < 0 OR A > 7 OR A < 0 OR X > 7 OR X < 0 OR Y > 7 OR Y < 0 THEN GOTO 16
            IF BOARD(B, A) <= 0 THEN GOTO 16
            IF Y = 2 AND B = 3 AND (X = A - 1 OR X = A + 1) THEN
                IF BOARD(B, A) = 100 AND BOARD(Y, X) = 0 AND BOARD(Y + 1, X) = -100 THEN
                    IF BESTB(1) = 1 AND BESTA(1) = X THEN
                        MOVER = BOARD(B, A)
                        TARGET = BOARD(Y, X)
                        CALL MAKEMOVE(A, B, X, Y)
                        BOARD(Y + 1, X) = 0
                        ENPASSANT = -1
                        GOTO 15
                    END IF
                END IF
            END IF
            CALL MOVELIST(A, B, XX(), YY(), NDX)
            FOR K = 0 TO NDX STEP 1
                IF X = XX(K) AND Y = YY(K) THEN
                    MOVER = BOARD(B, A)
                    TARGET = BOARD(Y, X)

                    INTFLAG = -1
                    'B so this is where INTFLAG is set

                    CALL MAKEMOVE(A, B, X, Y)
                    IF MOVER = 4500 THEN
                        wcQsold = wcQsflag
                        wcKsold = wcKsflag
                        wcKsflag = -1
                        wcQsflag = -1
                    END IF
                    IF (A = 0) AND (B = 7) AND (MOVER = 500) THEN
                        wcQsold = wcQsflag
                        wcQsflag = -1
                    END IF
                    IF (A = 7) AND (B = 7) AND (MOVER = 500) THEN
                        wcKsold = wcKsflag
                        wcKsflag = -1
                    END IF

                    INTFLAG = 0
                    'B and this is where INTFLAG is unset!

                    15 IF INCHECK(0) = 0 THEN EXIT SUB

                    BOARD(B, A) = MOVER
                    BOARD(Y, X) = TARGET
                    IF ENPASSANT THEN BOARD(Y + 1, X) = -100: ENPASSANT = 0
                    IF (A = 0) AND (B = 7) AND (MOVER = 500) THEN wcQsflag = wcQsold
                    IF (A = 7) AND (B = 7) AND (MOVER = 500) THEN wcKsflag = wcKsold
                    IF MOVER = 4500 THEN wcQsflag = wcQsold
                    GOTO 16
                END IF
            NEXT
        END IF
        16

    LOOP
    'B OK so this keeps looping until white makes legal move?

END SUB

FUNCTION isWhite (x, y)
    'B for squares and old for chess font
    yes = 0
    IF y MOD 2 = 0 THEN
        IF x MOD 2 = 0 THEN
            yes = -1
        END IF
    ELSE
        IF x MOD 2 = 1 THEN
            yes = -1
        END IF
    END IF
    isWhite = yes
END FUNCTION

SUB KING (A, B, XX(), YY(), NDX)
    ID = SGN(BOARD(B, A))
    FOR DY = -1 TO 1
        IF B + DY < 0 OR B + DY > 7 THEN GOTO 12
        FOR DX = -1 TO 1
            IF A + DX < 0 OR A + DX > 7 THEN GOTO 11
            IF ID <> SGN(BOARD(B + DY, A + DX)) THEN
                NDX = NDX + 1
                XX(NDX) = A + DX
                YY(NDX) = B + DY
            END IF
        11 NEXT
    12 NEXT
END SUB

SUB KNIGHT (A, B, XX(), YY(), NDX)
    ID = SGN(BOARD(B, A))
    X = A - 1
    Y = B - 2
    GOSUB 5
    X = A - 2
    Y = B - 1
    GOSUB 5
    X = A + 1
    Y = B - 2
    GOSUB 5
    X = A + 2
    Y = B - 1
    GOSUB 5
    X = A - 1
    Y = B + 2
    GOSUB 5
    X = A - 2
    Y = B + 1
    GOSUB 5
    X = A + 1
    Y = B + 2
    GOSUB 5
    X = A + 2
    Y = B + 1
    GOSUB 5
    EXIT SUB
    5 REM
    IF X < 0 OR X > 7 OR Y < 0 OR Y > 7 THEN RETURN
    IF ID <> SGN(BOARD(Y, X)) THEN NDX = NDX + 1: XX(NDX) = X: YY(NDX) = Y
    RETURN
END SUB

SUB ld2xy (ld$, dx, dy)
    'B dx and dy are going to be changed to find
    'B position (and thus type) of piece on the board from ld$
    letter$ = UCASE$(LEFT$(ld$, 1))
    dx = ASC(letter$) - 65
    digit = VAL(RIGHT$(ld$, 1))
    dy = 8 - digit
END SUB

SUB LegalHide (x, y)
    DIM XX(0 TO 26), YY(0 TO 26)
    CALL MOVELIST(x, y, XX(), YY(), NDX)
    FOR a = 0 TO NDX STEP 1
        IF XX(a) >= 0 AND YY(a) >= 0 THEN SHOWMAN YY(a), XX(a)
    NEXT
END SUB

'T THIS SUB calculates legal position of piece in the board cell x,y
SUB LegalShow (x, y)
    DIM XX(0 TO 26), YY(0 TO 26)
    CALL MOVELIST(x, y, XX(), YY(), NDX)
    FOR a = 0 TO NDX STEP 1
        IF XX(a) >= 0 AND YY(a) >= 0 THEN highLightSq XX(a), YY(a), LITE2&
    NEXT
END SUB

'B graphics version of Locate col, row : Print txt$
SUB lp (row, col, txt$)
    _PRINTSTRING (col * FW, row * FH), txt$
END SUB

SUB MakeButton (x1, y1, x2, y2, txt$, Col&)
    LINE (x1, y1)-(x2, y2), Col&, BF
    LINE (x1, y1)-(x2, y2), WHITE&, B
    LINE (x1 + 4, y2 - 4)-(x2 - 4, y2 - 4), _RGB32(222, 238, 227), B
    LINE (x2 - 4, y2 - 4)-(x2 - 4, y1 + 4), _RGB32(222, 238, 227), B
    _PRINTMODE _KEEPBACKGROUND
    'B VVV let's print button labels in middle of button
    _PRINTSTRING (x1 + 15, y2 - 1.35 * FH), txt$
    _PRINTMODE _FILLBACKGROUND
END SUB

SUB MAKEMOVE (A, B, X, Y)
    'B makemove is called many times, the last decides whether pBflag$ gets set or NOT
    'B the pWflag$ should only be set by user, no automatic setting allowed by AI.
    pBflag$ = ""
    BOARD(Y, X) = BOARD(B, A)
    BOARD(B, A) = 0
    IF Y = 0 AND BOARD(Y, X) = 100 THEN
        ' T it is the row 8
        IF INTFLAG THEN
            DO
                AreaOutput "Promote to:", ""
                I$ = Ppromote$
                SELECT CASE UCASE$(I$)
                    CASE "KNIGHT", "N", "KT", "KT.", "N."
                        PROMOTE = 270: pWflag$ = "N"
                    CASE "BISHOP", "B", "B."
                        PROMOTE = 300: pWflag$ = "B"
                    CASE "ROOK", "R", "R."
                        PROMOTE = 500: pWflag$ = "R"
                    CASE "QUEEN", "Q", "Q."
                        PROMOTE = 900: pWflag$ = "Q"
                END SELECT
            LOOP UNTIL PROMOTE <> 0
            IF playBlack THEN pWflag$ = LCASE$(pWflag$)
            'B       only the human can set the pWflag$

            BOARD(Y, X) = PROMOTE
            CLS
            SHOWBD
            _DISPLAY
        ELSE
            BOARD(Y, X) = 900
            'B ^^^^ OK AI need the line for checking FUTURE!!! moves
        END IF
    END IF

    IF Y = 7 AND BOARD(Y, X) = -100 THEN
        rap = -1
        BOARD(Y, X) = -900
        IF playBlack THEN pBflag$ = "Q" ELSE pBflag$ = "q"
    END IF

END SUB

SUB MOVELIST (A, B, XX(), YY(), NDX)
    PIECE = INT(ABS(BOARD(B, A)))
    NDX = -1
    SELECT CASE PIECE
        CASE IS = 100
            CALL PAWN(A, B, XX(), YY(), NDX)
        CASE IS = 270
            CALL KNIGHT(A, B, XX(), YY(), NDX)
        CASE IS = 300
            CALL BISHOP(A, B, XX(), YY(), NDX)
        CASE IS = 500
            CALL ROOK(A, B, XX(), YY(), NDX)
        CASE IS = 900
            CALL QUEEN(A, B, XX(), YY(), NDX)
        CASE IS = 4500
            CALL KING(A, B, XX(), YY(), NDX)
        CASE IS = 9000
            CALL KING(A, B, XX(), YY(), NDX)
    END SELECT
END SUB

SUB PAWN (A, B, XX(), YY(), NDX)
    ID = SGN(BOARD(B, A))
    ' T ID 1 for white piece and -1 for black piece
    IF (A - 1) >= 0 AND (A - 1) <= 7 AND (B - ID) >= 0 AND (B - ID) <= 7 THEN
        IF SGN(BOARD((B - ID), (A - 1))) = -ID THEN
            NDX = NDX + 1
            XX(NDX) = A - 1
            YY(NDX) = B - ID
        END IF
    END IF
    IF (A + 1) >= 0 AND (A + 1) <= 7 AND (B - ID) >= 0 AND (B - ID) <= 7 THEN
        IF SGN(BOARD((B - ID), (A + 1))) = -ID THEN
            NDX = NDX + 1
            XX(NDX) = A + 1
            YY(NDX) = B - ID
        END IF
    END IF
    IF A >= 0 AND A <= 7 AND (B - ID) >= 0 AND (B - ID) <= 7 THEN
        IF BOARD((B - ID), A) = 0 THEN
            NDX = NDX + 1
            XX(NDX) = A
            YY(NDX) = B - ID
            IF (ID < 0 AND B = 1) OR (ID > 0 AND B = 6) THEN
                IF BOARD((B - ID - ID), A) = 0 THEN
                    NDX = NDX + 1
                    XX(NDX) = A
                    YY(NDX) = B - ID - ID
                END IF
            END IF
        END IF
    END IF

END SUB

'B a pawn needs promotion to a piece, which? use mouse or keyboard
FUNCTION Ppromote$
    inp$ = "": ky = 0: oldtext$ = prompt$ + " {" + inp$ + "}"
    newText$ = oldtext$
    DO WHILE ky <> 13
        i = _MOUSEINPUT
        ty = (_MOUSEY + 24) / SQ
        ' T we must control also X dimension not only Y dimension for mouse in Area Promotion
        IF _MOUSEBUTTON(1) = -1 AND (_MOUSEX >= 500 AND _MOUSEX <= 700) THEN
            IF ty > 1 THEN
                IF ty = 2 THEN inp$ = "Q": EXIT DO
                IF ty = 3 THEN inp$ = "R": EXIT DO
                IF ty = 4 THEN inp$ = "B": EXIT DO
                IF ty = 5 THEN inp$ = "N": EXIT DO
            ELSE
                inp$ = ""
                'T no good click
            END IF
        END IF
        AreaOutput "Promote Enter Q R B N", newText$
        _DISPLAY
        oldtext$ = newText$
        k$ = INKEY$
        IF LEN(k$) THEN
            ky = ASC(RIGHT$(k$, 1))
            IF 31 < ky AND ky < 127 THEN
                inp$ = inp$ + CHR$(ky)
            ELSEIF ky = 8 THEN
                IF LEN(inp$) THEN inp$ = LEFT$(inp$, LEN(inp$) - 1)
            END IF
            newText$ = prompt$ + " {" + inp$ + "}"
        END IF
    LOOP
    Ppromote$ = inp$
    'B don't worry about case, it gets checked later
END FUNCTION

SUB QUEEN (A, B, XX(), YY(), NDX)
    CALL BISHOP(A, B, XX(), YY(), NDX)
    CALL ROOK(A, B, XX(), YY(), NDX)
END SUB

SUB restart
    'B restart variables
    CLS
    ERASE BOARD
    REDIM Move$(1 TO 300)
    REDIM Boards$(1 TO 300)
    'B need to start array at 1 not 0
    result = -2500
    wcKsflag = 0: wcQsflag = 0: wcKsold = 0: wcQsold = 0
    LEVEL = 0: INTFLAG = 0: countMove = 0
    whiteMove$ = "": blackMove$ = "": bmoves$ = "": bFirst = -1
END SUB

SUB ROOK (A, B, XX(), YY(), NDX)
    ID = SGN(BOARD(B, A))
    FOR X = A - 1 TO 0 STEP -1
        IF ID <> SGN(BOARD(B, X)) THEN
            NDX = NDX + 1
            XX(NDX) = X
            YY(NDX) = B
        END IF
        IF (BOARD(B, X)) <> 0 THEN EXIT FOR
    NEXT
    FOR X = A + 1 TO 7 STEP 1
        IF ID <> SGN(BOARD(B, X)) THEN
            NDX = NDX + 1
            XX(NDX) = X
            YY(NDX) = B
        END IF
        IF (BOARD(B, X)) <> 0 THEN EXIT FOR
    NEXT
    FOR Y = B - 1 TO 0 STEP -1
        IF ID <> SGN(BOARD(Y, A)) THEN
            NDX = NDX + 1
            XX(NDX) = A
            YY(NDX) = Y
        END IF
        IF (BOARD(Y, A)) <> 0 THEN EXIT FOR
    NEXT
    FOR Y = B + 1 TO 7 STEP 1
        IF ID <> SGN(BOARD(Y, A)) THEN
            NDX = NDX + 1
            XX(NDX) = A
            YY(NDX) = Y
        END IF
        IF (BOARD(Y, A)) <> 0 THEN EXIT FOR
    NEXT
END SUB

'B This is INPUT for graphic screens
FUNCTION screenInput$ (pixelX, pixelY, prompt$)
    inp$ = ""
    ky = 0: oldtext$ = prompt$ + " {" + inp$ + "}"
    newText$ = oldtext$
    COLOR LITE&
    WHILE ky <> 13
        AreaOutput newText$, ""
        _DISPLAY
        oldtext$ = newText$
        k$ = INKEY$
        IF LEN(k$) THEN
            ky = ASC(RIGHT$(k$, 1))
            IF 31 < ky AND ky < 127 THEN
                inp$ = inp$ + CHR$(ky)
            ELSEIF ky = 8 THEN
                IF LEN(inp$) THEN inp$ = LEFT$(inp$, LEN(inp$) - 1)
            END IF
            newText$ = prompt$ + " {" + inp$ + "}    "
        END IF
    WEND
    COLOR WHITE&
    screenInput$ = inp$
END FUNCTION

'B show entire board captured pieces also used for pawn promotion, Move List, Buttons, Debug Info
SUB SHOWBD
    COLOR WHITE&, 0
    _FONT bArial&
    'B print board labels for files
    LOCATE 2, 3:
    IF playBlack = -1 THEN PRINT "HGFEDCBA" ELSE PRINT "ABCDEFGH";
    'LOCATE 11, 3:                                                          ' A: display 1 set of labels only
    'IF playBlack = -1 THEN PRINT "HGFEDCBA" ELSE PRINT "ABCDEFGH";
    'B print board labels for ranks
    FOR i = 8 TO 1 STEP -1
        BLR$ = RIGHT$(STR$(i), 1)
        IF playBlack THEN BLR$ = w2b$(BLR$)
        LOCATE 8 - i + 3, 2: PRINT BLR$;
        '    LOCATE 8 - i + 3, 11: PRINT BLR$;
    NEXT
    'B Count captures by start of standard set on board and deduct each piece on board
    DIM c(-6 TO 6)
    c(-6) = 1: c(-5) = 2: c(-4) = 2: c(-3) = 2: c(-2) = 8: c(-1) = 1
    c(6) = 1: c(5) = 2: c(4) = 2: c(3) = 2: c(2) = 8: c(1) = 1
    FOR x = 0 TO 7
        FOR y = 0 TO 7
            SHOWMAN x, y
            _FONT bArial&
            SELECT CASE BOARD(x, y)
                CASE -900: IF c(-6) THEN c(-6) = c(-6) - 1
                CASE -500: IF c(-5) THEN c(-5) = c(-5) - 1
                CASE -300: IF c(-4) THEN c(-4) = c(-4) - 1
                CASE -270: IF c(-3) THEN c(-3) = c(-3) - 1
                CASE -100: IF c(-2) THEN c(-2) = c(-2) - 1
                CASE -9000: IF c(-1) THEN c(-1) = c(-1) - 1
                CASE 4500: IF c(1) THEN c(1) = c(1) - 1
                CASE 100: IF c(2) THEN c(2) = c(2) - 1
                CASE 270: IF c(3) THEN c(3) = c(3) - 1
                CASE 300: IF c(4) THEN c(4) = c(4) - 1
                CASE 500: IF c(5) THEN c(5) = c(5) - 1
                CASE 900: IF c(6) THEN c(6) = c(6) - 1
            END SELECT
        NEXT
    NEXT
    'B below need to blackout captures in case UNDO undoes one
    LINE (12 * SQ, 0)-(700, 9 * SQ), BLACK&, BF
    'Draw Capture pieces section
    FOR b = 0 TO 4
        FOR a = 1 TO 2
            IF isWhite(a, b) THEN COLOR WHITES& ELSE COLOR BLACKS&
            LINE (((a * 2) + 10) * SQ, (b + 1) * SQ)-STEP(SQ, SQ), , BF
            PRESET (((a * 2) + 10) * SQ + 8, (b + 1) * SQ + 36) 'A: centralise pieces
            IF a = 2 THEN DRAW "C" + STR$(BLACK&) ELSE DRAW "C" + STR$(WHITE&)
            SELECT CASE b
                'A  draw outlines for captured area
                CASE 0: DRAW "R26U5H2L6E9U11G4H6G4H4G6H4D11F9L6G2D5"
                CASE 1: DRAW "R26U5H2L5U7E3R4U10L6D3L4U3L6D3L4U3L6D10R4F3D7L5G2D5"
                CASE 2: DRAW "R26U5H2L8E6U9H2G8H2E8H2L6G6D9F6L8G2D5"
                CASE 3: DRAW "R26U5H2U4E2U9H6L9G10D4F2R4E3R4G8L4G2D5"
                CASE 4: DRAW "R26U5H2L6U7E3U6H3L10G3D6F3D7L6G2D5"
                CASE 5: DRAW "R26U5H2L5E7U6H4L5G3U5R2U2L2U2L2D2L2D2R2D5H3L5G4D6F7L5G2D5"
            END SELECT
            DRAW "BE2"
            'A  MOVE PEN INSIDE
            IF a = 2 THEN DRAW "P" + STR$(BLACK&) + "," + STR$(BLACK&)
            IF a = 1 THEN DRAW "P" + STR$(WHITE&) + "," + STR$(WHITE&)
            COLOR WHITE&, BLACK&
            IF a = 1 THEN cindex = 6 - b ELSE cindex = -1 * (6 - b)
            IF playBlack THEN cindex = cindex * -1
            digit$ = RIGHT$(STR$(c(cindex)), 1)
            IF digit$ <> "0" THEN LOCATE b + 2, (a * 2) + 12: PRINT digit$;
        NEXT
    NEXT
    COLOR WHITE&, BLACK&
    _FONT normal&
    showButtonBar
    showMoveList
    'B Some debug stuff also needed for UNDO  Save file
    LINE (0, 25 * FH)-(46 * FW, YMAX), BLACK&, BF
    lp 25, 2, "Last move by AI: " + blackMove$
    lp 26, 2, "Move Count:" + STR$(countMove) + "   Turn:" + STR$(Turn) + "   Result:" + STR$(result)
    lp 27, 2, "Castle: K flag:" + STR$(wcKsflag) + "   Q flag:" + STR$(wcQsflag) + "   K old:" + STR$(wcKsold) + "   Q old:" + STR$(wcQsold)
    lp 28, 2, "Last move by Human: " + whiteMove$
END SUB

SUB showButtonBar
    MakeButton 700, 60, 880, 100, "PLAY WHITE", LITE2&
    MakeButton 700, 120, 880, 160, "PLAY BLACK", LITE2&
    MakeButton 700, 180, 880, 220, "UNDO", LITE2&
    MakeButton 700, 240, 880, 280, "SAVE GAME", LITE2&
    MakeButton 700, 300, 880, 340, "LOAD GAME", LITE2&
    MakeButton 700, 360, 880, 400, "MANUAL SETUP", LITE2&
    MakeButton 700, 420, 880, 460, "QUIT", LITE2&
END SUB

'B set this up with Adrian's Draw Strings
SUB SHOWMAN (A, B)
    IF isWhite(B, A) THEN COLOR WHITES& ELSE COLOR BLACKS&
    LINE ((A + 2) * SQ, (B + 2) * SQ)-STEP(SQ, SQ), , BF
    ZZ = ABS(BOARD(B, A))
    IF ZZ THEN
        PRESET ((A + 2) * SQ + 8, (B + 2) * SQ + 36) 'A: centralise pieces
        IF BOARD(B, A) < 0 THEN
            IF playBlack THEN DRAW "C" + STR$(WHITE&) ELSE DRAW "C" + STR$(BLACK&)
        ELSE
            IF playBlack THEN DRAW "C" + STR$(BLACK&) ELSE DRAW "C" + STR$(WHITE&)
        END IF
        SELECT CASE ZZ
            'A  draw outlines for pieces on board
            CASE 100: DRAW "R26U5H2L6U7E3U6H3L10G3D6F3D7L6G2D5"
            CASE 500: DRAW "R26U5H2L5U7E3R4U10L6D3L4U3L6D3L4U3L6D10R4F3D7L5G2D5"
            CASE 270: DRAW "R26U5H2U4E2U9H6L9G10D4F2R4E3R4G8L4G2D5"
            CASE 300: DRAW "R26U5H2L8E6U9H2G8H2E8H2L6G6D9F6L8G2D5"
            CASE 900: DRAW "R26U5H2L6E9U11G4H6G4H4G6H4D11F9L6G2D5"
            CASE 4500: DRAW "R26U5H2L5E7U6H4L5G3U5R2U2L2U2L2D2L2D2R2D5H3L5G4D6F7L5G2D5"
            CASE 9000: DRAW "R26U5H2L5E7U6H4L5G3U5R2U2L2U2L2D2L2D2R2D5H3L5G4D6F7L5G2D5"
        END SELECT
        DRAW "BE2"
        'A  MOVE PEN INSIDE and color fill
        IF BOARD(B, A) < 0 THEN
            IF playBlack THEN DRAW "P" + STR$(WHITE&) + "," + STR$(WHITE&) ELSE DRAW "P" + STR$(BLACK&) + "," + STR$(BLACK&)
        END IF
        IF BOARD(B, A) > 0 THEN
            IF playBlack THEN DRAW "P" + STR$(BLACK&) + "," + STR$(BLACK&) ELSE DRAW "P" + STR$(WHITE&) + "," + STR$(WHITE&)
        END IF
    END IF
    COLOR WHITE&, BLACK&
    _FONT normal&
END SUB

'B  T set this up to show last 8 moves of White and Black
SUB showMoveList
    IF countMove < 9 THEN z = 8 ELSE z = countMove
    LINE (500, 300)-(680, 500), BLACK&, BF ' T if we use 700 it covers left border of buttonbar
    COLOR _RGB(0, 180, 220)
    FOR a = 0 TO 7
        lp 22 - a, 46, Move$(z - a)
    NEXT
    COLOR WHITE&
END SUB

'B convert BINGO for human playing Black
FUNCTION w2b$ (s$)
    b$ = ""
    FOR i = 1 TO LEN(s$)
        here = INSTR("ABCDEFGH12345678", MID$(s$, i, 1))
        IF here THEN b$ = b$ + MID$("HGFEDCBA87654321", here, 1) ELSE b$ = b$ + MID$(s$, i, 1)
    NEXT
    w2b$ = b$
END FUNCTION

SUB Wait_Click_Key
    'B handy sub to reuse in other programs
    DO
        k = _KEYHIT
        WHILE _MOUSEINPUT: WEND
        _LIMIT 30
    LOOP UNTIL k <> 0 OR _MOUSEBUTTON(1)
END SUB

SUB WriteEntry
    'B  Record game in both Move$() and Boards$() at countMove
    IF playBlack THEN
        IF bFirst THEN
            bFirst = 0
            bmoves$ = blackMove$ + pBflag$
        ELSE
            r$ = bmoves$ + "   " + whiteMove$ + pWflag$
            countMove = countMove + 1
            Move$(countMove) = r$
            bmoves$ = blackMove$ + pBflag$
        END IF
    ELSE
        countMove = countMove + 1
        Move$(countMove) = whiteMove$ + pWflag$ + " " + blackMove$ + pBflag$
    END IF
    Boards$(countMove) = bString$
    'B clear flags for promoted pawns
    pWflag$ = "": pBflag$ = ""
END SUB

