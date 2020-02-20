
_TITLE "Screen 0 as LED"

CONST ROUND = 0, SQUARE = 1

TYPE Sign
    Screen AS LONG ' the Sign screen to show on screen
    Image AS LONG '  the Sign image to work on in the background
    Mask AS LONG '   the Sign mask to place over the Sign image
END TYPE

DIM SHARED Sign AS Sign

MAKELED 640, 400, 2, ROUND

DIM SHARED Parts(46) AS STRING
'OPEN "Robot.dat" FOR INPUT AS #1

FOR p = 1 TO 45
    READ Parts(p)
NEXT

CLOSE #1

SCREEN Sign.Screen

Start = Main

FUNCTION Main
    DIM Touch AS STRING

    DIM Title AS STRING
    Title = SPACE$(80) + "Screen 0 as LED using code from Terry Ritchie's LED Maker. "

    tPos = 1
    WHILE NOT Quit
        _DEST Sign.Image
        COLOR _RGB(0, 255, 255)

        LOCATE 1, 1
        PRINT MID$(Title, tPos, 80);

        AnimBot

        _DEST 0
        _PUTIMAGE , Sign.Image
        _PUTIMAGE , Sign.Mask

        tPos = tPos + 1
        IF tPos > LEN(Title) THEN tPos = 1

        Touch = INKEY$
        IF Touch = CHR$(27) THEN SYSTEM

        _DISPLAY
        _LIMIT 10
    WEND
END FUNCTION

SUB AnimBot
    ' Save Arm and Leg Positions
    SHARED arm
    SHARED leg

    DIM temp AS STRING

    ' Get Arm and Leg Positions
    temp = MID$("0010203020100102030201", 2 * arm + 1, 2)

    b1 = VAL(LEFT$(temp, 1))
    b2 = VAL(RIGHT$(temp, 1))

    ' Show Buddy the Robot
    Buddy 20, 1, 1, 1, b1, b2, b2, b1

    ' Increase his Arm and Leg Positions
    arm = arm + 1: IF arm > 10 THEN arm = 0
    leg = leg + 1: IF leg > 10 THEN leg = 0
END SUB

SUB MAKELED (w AS INTEGER, h AS INTEGER, pSize AS INTEGER, pShape AS INTEGER)
    DIM x AS INTEGER
    DIM y AS INTEGER

    DIM c AS INTEGER
    c = 8

    DIM LEDPixel AS LONG
    DIM OriginalDest AS LONG
    OriginalDest = _DEST

    Sign.Screen = _NEWIMAGE(w * pSize, h * pSize, 32)
    Sign.Image = _NEWIMAGE(w, h, 32)
    Sign.Mask = _COPYIMAGE(Sign.Screen)
    LEDPixel = _NEWIMAGE(pSize, pSize, 32)

    _DEST LEDPixel
    LINE (0, 0)-(pSize - 1, pSize - 1), _RGB32(c, c, c), BF

    SELECT CASE pShape
        CASE ROUND
            CIRCLE (pSize \ 2, pSize \ 2), pSize \ 2 - 1, _RGB32(0, 0, 2)
            PAINT (pSize \ 2, pSize \ 2), _RGB32(0, 0, 1), _RGB32(0, 0, 2)

        CASE SQUARE
            LINE (1, 1)-(pSize - 1, pSize - 1), _RGB32(0, 0, 2), B
            LINE (2, 2)-(pSize - 2, pSize - 2), _RGB32(0, 0, 1), BF
    END SELECT

    _DEST Sign.Mask
    FOR x = 0 TO w * pSize - 1 STEP pSize
        FOR y = 0 TO h * pSize - 1 STEP pSize
            _PUTIMAGE (x, y), LEDPixel&
        NEXT y
    NEXT x

    FOR x = 0 TO w * pSize - 1 STEP pSize * 8
        LINE (x, 0)-(x, h * pSize - 1), _RGB32(c, c, c)
    NEXT x

    FOR y = 0 TO h * pSize - 1 STEP pSize * 8
        LINE (0, y)-(w * pSize - 1, y), _RGB32(c, c, c)
    NEXT y

    _SETALPHA 0, _RGB32(0, 0, 1)
    _SETALPHA 63, _RGB32(0, 0, 2)

    _DEST OriginalDest
    _FREEIMAGE LEDPixel
END SUB

SUB Scroll (Text AS STRING)
    DIM Touch AS STRING

    DIM Title AS STRING
    Title = SPACE$(16) + "Multi-Line LED "

    DIM tPos AS INTEGER
    textPos = 1
    titlePos = 1

    WHILE tPos < LEN(Text)
        _DEST Sign.Image
        COLOR _RGB32(255, 215, 32)

        LOCATE 1, 1
        PRINT MID$(Title, titlePos, 16);

        LOCATE 2, 1
        PRINT MID$(Text, textPos, 16);

        _DEST 0
        _PUTIMAGE , Sign.Image
        _PUTIMAGE , Sign.Mask

        textPos = textPos + 1
        titlePos = titlePos + 1
        IF titlePos > 31 THEN titlePos = 1

        Touch = INKEY$
        IF Touch = CHR$(27) THEN SYSTEM

        _DISPLAY
        _LIMIT 6
    WEND
END SUB

SUB Buddy (botX, botY, headV, bodyV, ArmV1, ArmV2, LegV1, LegV2)
    COLOR _RGB(255, 218, 185)

    ' Head
    FOR head = 1 TO 6
        LOCATE botY + (head - 1), botX + 8
        PRINT MID$(Parts(head), 24 * headV + 1, 24);
    NEXT

    ' Body
    FOR body = 7 TO 19
        LOCATE botY + (body - 1), botX + 7
        PRINT MID$(Parts(body), 26 * bodyV + 1, 26);
    NEXT

    ' Arms
    FOR arm = 20 TO 29
        ' Left Arm
        LOCATE botY + (arm - 13), botX
        PRINT MID$(Parts(arm), 7 * ArmV1 + 1, 7);

        ' Right Arm
        LOCATE botY + (arm - 13), botX + 33
        PRINT MID$(Parts(arm + 10), 7 * ArmV2 + 1, 7);
    NEXT

    ' Legs
    FOR leg = 40 TO 45
        ' Left Leg
        LOCATE botY + (leg - 21), botX + 10
        PRINT MID$(Parts(leg), 10 * LegV1 + 1, 10);

        ' Right Leg
        LOCATE botY + (leg - 21), botX + 20
        PRINT MID$(Parts(leg), 10 * LegV2 + 1, 10);
    NEXT

    ' Eyes
    COLOR _RGB(135, 206, 235)
    LOCATE botY + 1, botX + 15: PRINT "0";
    LOCATE botY + 1, botX + 24: PRINT "0";
END SUB

DATA "     .---.    .---.          .---.    .---."
DATA "    |     |__|     |        (((0)))--(((0)))"
DATA " _.'                `._  _.'_`---'_/\_`---'_`._"
DATA "|_:                  :_||_:   ____________   :_|"
DATA "  |                  |    |   \__________/   |"
DATA "  |__________________|    |__________________|"
DATA "__..-'              `-..____..-'              `-..____..-'              `-..__"
DATA " |                      |  | .------------------. |  | .------------------. |"
DATA " |                      |  | |\________________/| |  | |\________________/| |"
DATA " |                      |  | ||   __  __  __   || |  | ||                || |"
DATA ".|                      |..| ||  '--''--''--'  || |..| ||                || |."
DATA " |                      |  | ||  .----------.  || |  | ||                || |"
DATA " |                      |  | ||  `----------'  || |  | ||                || |"
DATA " |                      |  | ||   _        _   || |  | ||                || |"
DATA " |                      |  | ||  (_)  ()  (_)  || |  | ||                || |"
DATA " |                      |  | ||________________|| |  | ||________________|| |"
DATA " |                      |  | |/________________\| |  | |/________________\| |"
DATA " |______________________|  |______________________|  |______________________|"
DATA " `\____________________/'  `\____________________/'  `\____________________/'"
DATA "    .-|    .-|    .-|    .-|"
DATA "  ./ :|  ./ :|  ./ :|  ./ :|"
DATA " /`.\:| /`.\:| /`.\:| /`.\:|"
DATA "|`-._\:|`-._\:|`-._\:|`-._\:"
DATA ":    : |    | |    | :.--.:"
DATA "|    | |    | :.--.: (`-'|)"
DATA "|    | :.--.: (`-'|)  `--'"
DATA ":.--.: (`-'|)  `--'"
DATA "(`-'|)  `--'"
DATA " `--'"
DATA "|-.    |-.    |-.    |-."
DATA "|: \.  |: \.  |: \.  |: \."
DATA "|:/,'\ |:/,'\ |:/,'\ |:/,'\"
DATA ":/_.-'::/_.-'::/_.-'::/_.-':"
DATA " :    : |    | |    | :,--.:"
DATA " |    | |    | :,--.: (|`-')"
DATA " |    | :,--.: (|`-')  `--'"
DATA " :,--.: (|`-')  `--'"
DATA " (|`-')  `--'"
DATA "  `--'"
DATA " (______)  (______)  (______)  (______)"
DATA " (______)  (______)  (______) |        |"
DATA " (______)  (______) |        |`--------'"
DATA " (______) |        |`--------'"
DATA "|        |`--------'"
DATA "`--------'"

