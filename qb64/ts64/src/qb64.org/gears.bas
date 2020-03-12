_TITLE "Gear 1.bas for QB64 by B+ started  2018-05-22"
'QB64 version 2017 1106/82 (the day before they switched to version 1.2)
CONST xmax = 800
CONST ymax = 600
DIM SHARED pi
pi = _PI
CONST bhr = 20
SCREEN _NEWIMAGE(xmax, ymax, 32)
_SCREENMOVE 360, 60
sq = 20
nt1 = 16
k1 = _RGB32(250, 150, 0)
r1 = gearRadius(nt1, sq)
nt2 = nt1 * 2
k2 = _RGB32(255, 255, 0)
r2 = gearRadius(nt2, sq)
iA2 = pi / nt2
FOR rao = 0 TO pi * 2 STEP pi / 180
    CLS
    gear 600, 300, nt1, sq, rao, k1
    gear 600 - r1 - r2 - sq, 300, nt2, sq, -.5 * rao - iA2, k2
    _DISPLAY
    _LIMIT 25
NEXT

FUNCTION gearRadius (nteeth, sqtooth)
    gearRadius = .5 * sqtooth / SIN(.5 * pi / nteeth)
END FUNCTION

SUB gear (x, y, nteeth, sqtooth, raOffset, K AS _UNSIGNED LONG)
    radius = .5 * sqtooth / SIN(.5 * pi / nteeth)
    FOR ra = 0 TO 2 * pi STEP 2 * pi / nteeth
        x2 = x + (radius + sqtooth) * COS(ra + raOffset)
        y2 = y + (radius + sqtooth) * SIN(ra + raOffset)
        thic x, y, x2, y2, sqtooth, K
    NEXT
    'to speed things up and reduce blicking just do a circle fill x, y already set and pen color too
    FOR ra = pi / nteeth TO 2 * pi STEP 2 * pi / nteeth
        x2 = x + radius * COS(ra + raOffset)
        y2 = y + radius * SIN(ra + raOffset)
        thic x, y, x2, y2, sqtooth, K
    NEXT
    COLOR _RGB32(155, 70, 35)
    fcirc x, y, .9 * radius
    K1 = _RGB(0, 0, 0)
    COLOR K1
    fcirc x, y, bhr
    thic x, y, x + (bhr + sqtooth) * COS(raOffset), y + (bhr + sqtooth) * SIN(raOffset), sqtooth, K1
END SUB

SUB thic (x1, y1, x2, y2, thick, K AS _UNSIGNED LONG)
    t2 = thick / 2
    IF t2 < 1 THEN t2 = 1
    a = _ATAN2(y2 - y1, x2 - x1)
    x3 = x1 + t2 * COS(a + _PI(.5))
    y3 = y1 + t2 * SIN(a + _PI(.5))
    x4 = x1 + t2 * COS(a - _PI(.5))
    y4 = y1 + t2 * SIN(a - _PI(.5))
    x5 = x2 + t2 * COS(a + _PI(.5))
    y5 = y2 + t2 * SIN(a + _PI(.5))
    x6 = x2 + t2 * COS(a - _PI(.5))
    y6 = y2 + t2 * SIN(a - _PI(.5))
    filltri x6, y6, x4, y4, x3, y3, K
    filltri x3, y3, x5, y5, x6, y6, K
END SUB


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

' found at QB64.net:    http://www.qb64.net/forum/index.php?topic=14425.0
SUB filltri (x1, y1, x2, y2, x3, y3, K AS _UNSIGNED LONG)
    a& = _NEWIMAGE(1, 1, 32)
    _DEST a&
    PSET (0, 0), K
    _DEST 0
    _MAPTRIANGLE _SEAMLESS(0, 0)-(0, 0)-(0, 0), a& TO(x1, y1)-(x2, y2)-(x3, y3)
    _FREEIMAGE a& '<<< this is important!
END SUB

