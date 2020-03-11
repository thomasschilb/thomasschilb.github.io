_TITLE "Aquarium with swaying kelp"
'QB64 X 64 version 1.2 20180228/86  from git b301f92
'2018-07-30 translated from
' Aquarium with swaying kelp.bas  SmallBASIC 0.12.9 [B+=MGA] 2017-04-16
'from
'aquarium with swaying kelp2.sdlbas [B+=MGA] 2016-10-14
'thanks to Andy Amaya for Kelp growing idea
'2016-10-15 kelp2 grows faster, mod or fix sway?


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

'   Press SpaceBar to grow new Kelp Bed, press escape to quit

'   Press + for more fish, - for less fish

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

CONST xmax = 1260
CONST ymax = 720
CONST swayLimit = 6
CONST maxFish = 500

SCREEN _NEWIMAGE(xmax, ymax, 32)
_FULLSCREEN
RANDOMIZE TIMER

TYPE fishType
    x AS SINGLE
    y AS SINGLE
    dx AS SINGLE
    sz AS SINGLE
    red AS SINGLE
    green AS SINGLE
    blue AS SINGLE
END TYPE

DIM SHARED kelp(xmax, ymax), f(maxFish) AS fishType
DIM SHARED fishFactor, restartFlag, nFish

nFish = 25 'for starters

restart:
restartFlag = 0
fishFactor = 50 ^ (1 / nFish) 'let's use a power lesson
growKelp
FOR i = 0 TO nFish
    newFish i, 1
NEXT
aquarium
IF restartFlag THEN GOTO restart


SUB growKelp ()
    ERASE kelp
    kelps = rand(25, 45)
    FOR x = 1 TO kelps
        kelp(rand(0, xmax), ymax) = rand(1, 15)
    NEXT
    FOR y = ymax - 1 TO 0 STEP -1
        FOR x = 0 TO xmax
            IF kelp(x, y + 1) THEN
                r = rand(1, 23)
                SELECT CASE r
                    CASE 1, 2, 3, 18 '1 branch node
                        IF x - 1 >= 0 THEN kelp(x - 1, y) = kelp(x, y + 1)
                    CASE 4, 5, 6, 7, 8, 9, 21 '1 branch node
                        kelp(x, y) = kelp(x, y + 1)
                    CASE 10, 11, 12, 20 '1 branch node
                        IF x + 1 <= xmax THEN kelp(x + 1, y) = kelp(x, y + 1)
                    CASE 13, 14, 15, 16, 17, 19 '2 branch node
                        IF x - 1 >= 0 THEN kelp(x - 1, y) = kelp(x, y + 1)
                        IF x + 1 <= xmax THEN kelp(x + 1, y) = kelp(x, y + 1)
                END SELECT
            END IF
        NEXT
    NEXT
END SUB

SUB showKelp (z)
    FOR y = 0 TO ymax
        dy = (_PI(y / 180) + z) * (1 - y / ymax)
        xoff = swayLimit * SIN(dy)
        FOR x = 0 TO xmax
            IF kelp(x, y) > 0 AND kelp(x, y) < 16 THEN
                COLOR _RGB32(0, kelp(x, y) * 16, 0)
                recf x + xoff, y, x + xoff + 1, y + 1
            END IF
        NEXT
    NEXT
END SUB

SUB newFish (i, tfStart)
    'the size and speed of a fish depends upon it's i number
    'it only has to be setup if tfStart
    IF tfStart THEN 'starting app place fish anywhere in sight
        f(i).sz = 10 + fishFactor ^ i
        f(i).dx = .2 * f(i).sz
        f(i).x = rand(0, xmax)
        IF RND < .5 THEN f(i).dx = f(i).dx * -1
    ELSE
        'choose a side to come in from fix x and dx accordingly
        IF RND < .5 THEN
            IF f(i).dx < 0 THEN f(i).dx = f(i).dx * -1
            f(i).x = 0
        ELSE
            IF f(i).dx > 0 THEN f(i).dx = f(i).dx * -1
            f(i).x = xmax
        END IF
    END IF
    f(i).y = rand(f(i).sz, ymax - f(i).sz)
    f(i).red = RND ^ 2: f(i).green = RND ^ 2: f(i).blue = RND ^ 2
END SUB

SUB drawfish (i)
    f(i).x = f(i).x + f(i).dx
    IF f(i).x < 0 - 1.5 * f(i).sz OR f(i).x > xmax + 1.5 * f(i).sz THEN newFish i, 0
    f(i).y = f(i).y + rand(-4, 4) * f(i).sz / 60
    FOR ra = 1 TO f(i).sz
        COLOR _RGB32(127 + 127 * SIN(f(i).red * .5 * ra), 127 + 127 * SIN(f(i).green * .5 * ra), 127 + 127 * SIN(f(i).blue * .5 * ra))
        IF f(i).dx < 0 THEN
            recf f(i).x + ra, f(i).y - ra, f(i).x + ra, f(i).y + ra
        ELSE
            recf f(i).x - ra, f(i).y - ra, f(i).x - ra, f(i).y + ra
        END IF
    NEXT
    FOR ra = 3 TO .3 * f(i).sz
        COLOR _RGB32(127 + 127 * SIN(f(i).red * 2 * ra), 127 + 127 * SIN(f(i).green * 2 * ra), 127 + 127 * SIN(f(i).blue * 2 * ra))
        IF f(i).dx < 0 THEN
            recf f(i).x + f(i).sz + ra, f(i).y - ra, f(i).x + f(i).sz + ra, f(i).y + ra
        ELSE
            recf f(i).x - f(i).sz - ra, f(i).y - ra, f(i).x - f(i).sz - ra, f(i).y + ra
        END IF
    NEXT
    IF f(i).dx < 0 THEN
        COLOR _RGB32(0, 0, 0): fcirc f(i).x + .2 * f(i).sz, f(i).y, .09 * f(i).sz
        COLOR _RGB32(255, 255, 0): CIRCLE (f(i).x + .2 * f(i).sz, f(i).y), .07 * f(i).sz
    ELSE
        COLOR _RGB32(0, 0, 0): fcirc f(i).x - .2 * f(i).sz, f(i).y, .09 * f(i).sz
        COLOR _RGB32(255, 255, 0): CIRCLE (f(i).x - .2 * f(i).sz, f(i).y), .07 * f(i).sz
    END IF
END SUB

SUB aquarium ()
    dz = .25: z = 0: hf = INT(9 * nFish / 10)
    WHILE NOT _KEYDOWN(27)
        IF _KEYDOWN(32) THEN restartFlag = 1: EXIT SUB
        IF _KEYDOWN(43) THEN 'plus more fish
            IF 2 * nFish <= maxFish THEN nFish = 2 * nFish + 5: restartFlag = 1: EXIT SUB
        END IF
        IF _KEYDOWN(95) THEN 'minus less fish
            IF nFish \ 2 >= 5 THEN nFish = nFish \ 2: restartFlag = 1: EXIT SUB
        END IF

        FOR i = 0 TO ymax
            COLOR _RGB32(0, 0, 255 - (i / ymax) * 255)
            ln 0, i, xmax, i
        NEXT
        FOR i = 0 TO hf 'draw some fish behind kelp
            drawfish (i)
        NEXT
        z = z + dz
        IF z > swayLimit OR z < -1 * swayLimit THEN dz = dz * -1
        showKelp (z)
        FOR i = hf + 1 TO nFish 'draw the rest of the fish
            drawfish (i)
        NEXT

        _DISPLAY
        _LIMIT 10
    WEND
END SUB

FUNCTION rand% (lo%, hi%)
    rand% = INT(RND * (hi% - lo% + 1)) + lo%
END FUNCTION

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

SUB ln (x1, y1, x2, y2)
    LINE (x1, y1)-(x2, y2)
END SUB

SUB rec (x1, y1, x2, y2)
    LINE (x1, y1)-(x2, y2), , B
END SUB

SUB recf (x1, y1, x2, y2)
    LINE (x1, y1)-(x2, y2), , BF
END SUB

