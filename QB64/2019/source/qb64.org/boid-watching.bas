_TITLE "Boid Watching   by bplus 2018-04-28"
'QB64 version 2017 1106/82 (the day before they switched to version 1.2)
'from
'Boid Watching.txt for JB 2.0 B+ 2018-04-28
'from
'networking.bas  SmallBASIC 0.12.9 [B+=MGA] 2017-04-14
' combined with
'Mouse school critter attract or repell.txt for JB 2.0 B+ 2018-04-26
' plus what I picked up generally from the videos

CONST xmax = 1200
CONST ymax = 700
SCREEN _NEWIMAGE(xmax, ymax, 32)
_SCREENMOVE 100, 40
RANDOMIZE TIMER


'Boid behavior based on several modes

centerMode = 1 ' on / off
cf = .01 'centering factor how strong a pull from 0 to 1  .01 is week .1 pretty strong!

headMode = 1 ' on / off
sway = _PI / 6 'just turn neighbor towards neighbor
hf = .2 'heading factor how strong an influence  0 to 1

spaceMode = 1 ' on / off
spacing = 15 'space amount approx

noise = 0 'general randomness added to movements individualism

Boids = 20

DIM SHARED x(Boids), y(Boids), a(Boids), r(Boids), c&(Boids), predator

FOR i = 1 TO Boids
    newCritter i
NEXT

WHILE 1
    CLS
    IF INKEY$ = "q" THEN END
    FOR i = 1 TO Boids
        m = _MOUSEINPUT: mb = _MOUSEBUTTON(1): mx = _MOUSEX: my = _MOUSEY

        FOR j = i + 1 TO Boids

            IF distance(x(i), y(i), x(j), y(j)) < 100 THEN

                'sway the neighbors towards each other
                IF headMode THEN
                    IF a(i) > a(j) THEN
                        a(i) = a(i) - sway * hf
                        a(j) = a(j) + sway * hf
                    ELSE
                        a(i) = a(i) + sway * hf
                        a(j) = a(j) - sway * hf
                    END IF
                END IF

                'stickiness stay close to neighbors, close distance between
                IF centerMode THEN
                    IF x(i) > x(j) THEN
                        x(i) = x(i) - cf * (x(i) - x(j))
                        x(j) = x(j) + cf * (x(i) - x(j))
                    ELSE
                        x(i) = x(i) + cf * (x(j) - x(i))
                        x(j) = x(j) - cf * (x(j) - x(i))
                    END IF
                    IF y(i) > y(j) THEN
                        y(i) = y(i) - cf * (y(i) - y(j))
                        y(j) = y(j) + cf * (y(i) - y(j))
                    ELSE
                        y(i) = y(i) + cf * (y(j) - y(i))
                        y(j) = y(j) - cf * (y(j) - y(i))
                    END IF
                END IF

                'don't let them bunch up
                IF spaceMode THEN
                    ' The following is STATIC's adjustment of ball positions if overlapping
                    ' before calcultion of new positions from collision
                    ' Displacement vector and its magnitude.  Thanks STxAxTIC !
                    nx = x(j) - x(i)
                    ny = y(j) - y(i)
                    nm = SQR(nx ^ 2 + ny ^ 2)
                    IF nm < spacing + 20 THEN
                        nx = nx / nm
                        ny = ny / nm
                        ' Regardless of momentum exchange, separate the balls along the lone connecting them.
                        WHILE nm < spacing + 30
                            x(j) = x(j) + .1 * spacing * nx
                            y(j) = y(j) + .1 * spacing * ny
                            x(i) = x(i) - .1 * spacing * nx
                            y(i) = y(i) - .1 * spacing * ny
                            nx = x(j) - x(i)
                            ny = y(j) - y(i)
                            nm = SQR(nx ^ 2 + ny ^ 2)
                            nx = nx / nm
                            ny = ny / nm
                        WEND
                    END IF 'spacer
                END IF 'space Mode
            END IF 'distance
        NEXT
        IF x(i) < 30 OR x(i) > xmax - 30 OR y(i) < 30 OR y(i) > ymax - 30 THEN a(i) = a(i) + sway
        'out of sight
        IF x(i) < -1 * r(i) OR x(i) > xmax + r(i) OR y(i) < -1 * r(i) OR y(i) > ymax + r(i) THEN 'start new
            newCritter i
        END IF
        IF distance(x(i), y(i), mx, my) < 75 THEN
            a(i) = _ATAN2(my - y(i), mx - x(i)) + _PI
            predatorMode = 1
        ELSE
            predatorMode = 0
        END IF

        'update points
        x(i) = x(i) + 10 * COS(a(i)) + RND * noise - .5 * noise
        y(i) = y(i) + 10 * SIN(a(i)) + RND * noise - .5 * noise

        critter i

    NEXT
    'mouse predator
    COLOR _RGB32(160, 0, 0)
    fcirc mx, my, 25

    _DISPLAY
    _LIMIT 20
WEND

SUB newCritter (index)
    x(index) = rand(0, xmax)
    y(index) = rand(0, ymax)
    a(index) = -2 * _PI * RND
    r(index) = rand(10, 15)
    c&(index) = _RGB32(rand(64, 155), rand(64, 155), rand(64, 155))
END SUB

SUB critter (i)
    COLOR c&(i)
    fcirc x(i), y(i), r(i)
    IF predator THEN
        x1 = x(i) + .75 * r(i) * COS(a(i) - _PI(1 / 9) + _PI)
        y1 = y(i) + .75 * r(i) * SIN(a(i) - _PI(1 / 9) + _PI)
        x2 = x(i) + .75 * r(i) * COS(a(i) + _PI(1 / 9) + _PI)
        y2 = y(i) + .75 * r(i) * SIN(a(i) + _PI(1 / 9) + _PI)
    ELSE
        x1 = x(i) + .75 * r(i) * COS(a(i) - _PI(1 / 9))
        y1 = y(i) + .75 * r(i) * SIN(a(i) - _PI(1 / 9))
        x2 = x(i) + .75 * r(i) * COS(a(i) + _PI(1 / 9))
        y2 = y(i) + .75 * r(i) * SIN(a(i) + _PI(1 / 9))
    END IF
    COLOR _RGB32(255, 255, 255)
    fcirc x1, y1, .25 * r(i)
    fcirc x2, y2, .25 * r(i)
    IF predator THEN
        x3 = x1 + .125 * r(i) * COS(a(i) + _PI)
        y3 = y1 + .125 * r(i) * SIN(a(i) + _PI)
        x4 = x2 + .125 * r(i) * COS(a(i) + _PI)
        y4 = y2 + .125 * r(i) * SIN(a(i) + _PI)
    ELSE
        x3 = x1 + .125 * r(i) * COS(a(i))
        y3 = y1 + .125 * r(i) * SIN(a(i))
        x4 = x2 + .125 * r(i) * COS(a(i))
        y4 = y2 + .125 * r(i) * SIN(a(i))
    END IF
    COLOR _RGB32(0, 0, 0)
    fcirc x3, y3, .125 * r(i)
    fcirc x4, y4, .125 * r(i)
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

FUNCTION rand% (lo%, hi%)
    rand% = INT(RND * (hi% - lo% + 1)) + lo%
END FUNCTION

FUNCTION distance (x1, y1, x2, y2)
    distance = ((x1 - x2) ^ 2 + (y1 - y2) ^ 2) ^ .5
END FUNCTION

FUNCTION rdir ()
    IF RND < .5 THEN rdir = -1 ELSE rdir = 1
END FUNCTION

