_TITLE "Mouse down, drag ball, release...  Boing" 'B+ 2019-01-08 from
'boing.bas for SmallBASIC 2015-07-25 MGA/B+
'coloring mods

CONST xmax = 1200
CONST ymax = 700
SCREEN _NEWIMAGE(xmax, ymax, 32)
_SCREENMOVE 80, 20

DIM s(1 TO 4, 1 TO 2)
s(1, 1) = 0: s(1, 2) = 50
s(2, 1) = 0: s(2, 2) = ymax - 50
s(3, 1) = xmax + 30: s(3, 2) = 50
s(4, 1) = xmax + 30: s(4, 2) = ymax - 50
oldtx = 0: oldtyty = 0: da = .03
boingx = 0: boingy = 0
WHILE 1
    WHILE _MOUSEINPUT: WEND
    mb = _MOUSEBUTTON(1)
    IF mb THEN
        tx = _MOUSEX + 20
        ty = _MOUSEY
    ELSE
        tx = xmax / 2
        ty = ymax / 2
        IF tx <> oldtx OR ty <> oldty THEN
            boingx = 3 * (tx - oldtx) / 4
            boingy = 3 * (ty - oldty) / 4
        ELSE
            boingx = -3 * boingx / 4
            boingy = -3 * boingy / 4
        END IF
        tx = tx + boingx
        ty = ty + boingy
    END IF
    a = 0
    oldtx = tx
    oldty = ty
    CLS
    FOR corner = 1 TO 4
        s1x = s(corner, 1)
        s1y = s(corner, 2)
        dx = (tx - s1x) / 2000
        dy = (ty - s1y) / 2000
        x = tx - 20
        y = ty
        FOR i = 1 TO 2000
            sx = 20 * COS(a) + x
            sy = 20 * SIN(a) + y
            LINE (sx, sy + 5)-(sx + 4, sy + 5), _RGB32(118, 118, 118), BF
            LINE (sx, sy + 4)-(sx + 4, sy + 4), _RGB32(148, 148, 148), BF
            LINE (sx, sy + 3)-(sx + 4, sy + 3), _RGB32(238, 238, 238), BF
            LINE (sx, sy + 2)-(sx + 4, sy + 3), _RGB32(208, 208, 208), BF
            LINE (sx, sy + 1)-(sx + 4, sy + 1), _RGB32(168, 168, 168), BF
            LINE (sx, sy)-(sx + 4, sy), _RGB32(108, 108, 108), BF
            LINE (sx, sy - 1)-(sx + 4, sy - 1), _RGB32(68, 68, 68), BF
            x = x - dx: y = y - dy
            a = a + da
        NEXT
    NEXT
    FOR r = 50 TO 1 STEP -1
        g = (50 - r) * 5 + 5
        COLOR _RGB32(g, g, g)
        fcirc tx - 20, ty, r
    NEXT
    _DISPLAY
    _LIMIT 15
WEND

'Steve McNeil's  copied from his forum   note: Radius is too common a name
SUB fcirc (CX AS LONG, CY AS LONG, R AS LONG)
    DIM subRadius AS LONG, RadiusError AS LONG
    DIM X AS LONG, Y AS LONG

    subRadius = ABS(R)
    RadiusError = -subRadius
    X = subRadius
    Y = 0

    IF subRadius = 0 THEN PSET (CX, CY): EXIT SUB

    ' Draw the middle span here so we don't draw it twice in the main loop,
    ' which would be a problem with blending turned on.
    LINE (CX - X, CY)-(CX + X, CY), , BF

    WHILE X > Y
        RadiusError = RadiusError + Y * 2 + 1
        IF RadiusError >= 0 THEN
            IF X <> Y + 1 THEN
                LINE (CX - Y, CY - X)-(CX + Y, CY - X), , BF
                LINE (CX - Y, CY + X)-(CX + Y, CY + X), , BF
            END IF
            X = X - 1
            RadiusError = RadiusError - X * 2
        END IF
        Y = Y + 1
        LINE (CX - X, CY - Y)-(CX + X, CY - Y), , BF
        LINE (CX - X, CY + Y)-(CX + X, CY + Y), , BF
    WEND
END SUB

