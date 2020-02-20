DIM SHARED xspacing, w, theta, amplitude, period, dx
xspacing = 16
theta = 0.0
amplitude = 75.0
period = 500.0

TYPE t
    y AS SINGLE
    a AS SINGLE
END TYPE

SCREEN _NEWIMAGE(710, 400, 32)
w = _WIDTH + 8
dx = (_PI(2) / period) * xspacing
DIM SHARED yvalues(INT(w / xspacing)) AS t

FOR i = 1 TO UBOUND(yvalues)
    yvalues(i).a = yvalues(i - 1).a + 1
NEXT

DO
    CLS
    calcWave
    renderWave
    _DISPLAY
    _LIMIT 60
LOOP

SUB calcWave
    '// Increment theta (try different values for
    '// 'angular velocity' here)
    theta = theta + 0.02

    '// For every x value, calculate a y value with sine function
    x = theta
    FOR i = 0 TO UBOUND(yvalues)
        yvalues(i).y = _HEIGHT / 2 + SIN(x) * amplitude
        yvalues(i).a = yvalues(i).a + .1
        x = x + dx
    NEXT
END SUB

SUB renderWave
    '// A simple way to draw the wave with an ellipse at each location
    FOR x = 0 TO UBOUND(yvalues)
        c~& = hsb(yvalues(x).a MOD 360, 127, 127, 127)
        CircleFill x * xspacing, height / 2 + yvalues(x).y, 50, c~&
    NEXT
END SUB

FUNCTION hsb~& (__H AS _FLOAT, __S AS _FLOAT, __B AS _FLOAT, A AS _FLOAT)
    DIM H AS _FLOAT, S AS _FLOAT, B AS _FLOAT

    H = map(__H, 0, 255, 0, 360)
    S = map(__S, 0, 255, 0, 1)
    B = map(__B, 0, 255, 0, 1)

    IF S = 0 THEN
        hsb~& = _RGBA32(B * 255, B * 255, B * 255, A)
        EXIT FUNCTION
    END IF

    DIM fmx AS _FLOAT, fmn AS _FLOAT
    DIM fmd AS _FLOAT, iSextant AS INTEGER
    DIM imx AS INTEGER, imd AS INTEGER, imn AS INTEGER

    IF B > .5 THEN
        fmx = B - (B * S) + S
        fmn = B + (B * S) - S
    ELSE
        fmx = B + (B * S)
        fmn = B - (B * S)
    END IF

    iSextant = INT(H / 60)

    IF H >= 300 THEN
        H = H - 360
    END IF

    H = H / 60
    H = H - (2 * INT(((iSextant + 1) MOD 6) / 2))

    IF iSextant MOD 2 = 0 THEN
        fmd = (H * (fmx - fmn)) + fmn
    ELSE
        fmd = fmn - (H * (fmx - fmn))
    END IF

    imx = _ROUND(fmx * 255)
    imd = _ROUND(fmd * 255)
    imn = _ROUND(fmn * 255)

    SELECT CASE INT(iSextant)
        CASE 1
            hsb~& = _RGBA32(imd, imx, imn, A)
        CASE 2
            hsb~& = _RGBA32(imn, imx, imd, A)
        CASE 3
            hsb~& = _RGBA32(imn, imd, imx, A)
        CASE 4
            hsb~& = _RGBA32(imd, imn, imx, A)
        CASE 5
            hsb~& = _RGBA32(imx, imn, imd, A)
        CASE ELSE
            hsb~& = _RGBA32(imx, imd, imn, A)
    END SELECT

END FUNCTION

FUNCTION map! (value!, minRange!, maxRange!, newMinRange!, newMaxRange!)
    map! = ((value! - minRange!) / (maxRange! - minRange!)) * (newMaxRange! - newMinRange!) + newMinRange!
END FUNCTION

SUB CircleFill (x AS LONG, y AS LONG, R AS LONG, C AS _UNSIGNED LONG)
    x0 = R
    y0 = 0
    e = 0
    DO WHILE y0 < x0
        IF e <= 0 THEN
            y0 = y0 + 1
            LINE (x - x0, y + y0)-(x + x0, y + y0), C, BF
            LINE (x - x0, y - y0)-(x + x0, y - y0), C, BF
            e = e + 2 * y0
        ELSE
            LINE (x - y0, y - x0)-(x + y0, y - x0), C, BF
            LINE (x - y0, y + x0)-(x + y0, y + x0), C, BF
            x0 = x0 - 1
            e = e - 2 * x0
        END IF
    LOOP
    LINE (x - R, y)-(x + R, y), C, BF
END SUB

