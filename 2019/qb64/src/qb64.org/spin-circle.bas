_TITLE "Do the dots in disk look like they are spinning?" ' B+ 2019-01-12
'try an optical illusion saw on Internet

CONST xmax = 600
CONST ymax = 600
SCREEN _NEWIMAGE(xmax, ymax, 32)
_SCREENMOVE 300, 60

x0 = xmax / 2: y0 = ymax / 2: a24 = _PI(2 / 24): r = 240
WHILE _KEYHIT <> 27
    IF loopcnt < 2 THEN stopit = 11
    IF loopcnt = 2 THEN stopit = 0
    IF loopcnt > 2 THEN
        IF stopit < 11 THEN stopit = stopit + 1
    END IF
    FOR a = 0 TO _PI(2) STEP _PI / 180
        COLOR _RGB32(128, 0, 0): fcirc x0, y0, 251
        FOR i = 0 TO stopit
            IF loopcnt > 1 THEN
                xs = x0 + r * COS(a24 * i)
                ys = y0 + r * SIN(a24 * i)
                xe = x0 + r * COS(a24 * i + _PI)
                ye = y0 + r * SIN(a24 * i + _PI)
                LINE (xs, ys)-(xe, ye), _RGB32(255, 255, 255)
            END IF
            x = x0 + COS(a + _PI(i / 12)) * r * COS(a24 * i)
            y = y0 + COS(a + _PI(i / 12)) * r * SIN(a24 * i)
            COLOR _RGB32(255, 255, 255)
            fcirc x, y, 10
        NEXT
        _DISPLAY
        _LIMIT 90
    NEXT
    loopcnt = loopcnt + 1
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

