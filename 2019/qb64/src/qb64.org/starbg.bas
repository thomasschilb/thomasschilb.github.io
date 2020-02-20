SCREEN _NEWIMAGE(800, 600, 32)
DIM SHARED hide AS LONG

Image& = _LOADIMAGE("restart.png", 32)
hide& = _NEWIMAGE(_WIDTH(Image&), _HEIGHT(Image&), 32)
DO

    SELECT CASE Quad_Button(400, 300, Image&, 200, 0, 120) ' set alpha channel (transparency), 0 is full transparent, 255 is NOT transparent
        CASE 0: LOCATE 1, 1: PRINT "Button not pressed"
        CASE 1: LOCATE 1, 1: PRINT "Button pressed    "
        CASE 2: LOCATE 1, 1: PRINT "Mouse on position "
    END SELECT
    _DISPLAY
LOOP UNTIL _KEYHIT = 27



FUNCTION Quad_Button (X AS INTEGER, Y AS INTEGER, ButtonImage AS LONG, OFF_Color, ON_Color, On_PosColor AS LONG)
    WHILE _MOUSEINPUT: WEND
    _DEST hide&: LINE (0, 0)-(_WIDTH, _HEIGHT), _RGB32(0, 0, 0), BF: _DEST 0
    IF _MOUSEX >= X AND _MOUSEX <= X + _WIDTH(ButtonImage&) AND _MOUSEY >= Y AND _MOUSEY <= Y + _HEIGHT(ButtonImage&) THEN
        IF _MOUSEBUTTON(1) THEN GOSUB Button_Active
        GOSUB OnPosition
    END IF

    _SETALPHA OFF_Color, _RGB32(0, 0, 0), hide&
    _PUTIMAGE (X, Y), ButtonImage&
    _PUTIMAGE (X, Y), hide&
    _LIMIT 30
    Quad_Button = 0: EXIT FUNCTION

    OnPosition:
    _SETALPHA On_PosColor, _RGB32(0, 0, 0), hide&
    _PUTIMAGE (X, Y), ButtonImage&
    _PUTIMAGE (X, Y), hide&
    Quad_Button = 2: EXIT FUNCTION
    RETURN

    Button_Active:
    _SETALPHA ON_Color, _RGB32(0, 0, 0), hide&
    _PUTIMAGE (X, Y), ButtonImage&
    _PUTIMAGE (X, Y), hide&
    Quad_Button = 1
    EXIT FUNCTION
END FUNCTION

