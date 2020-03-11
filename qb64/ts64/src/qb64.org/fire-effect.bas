'Simple Fire Effect coded By Ashish. Just for Practice :D
'http://lodev.org/cgtutor/fire.html
RANDOMIZE TIMER
_TITLE "Fire Effect"
SCREEN _NEWIMAGE(300, 300, 32)

DIM fireBuffer(_WIDTH + 2, _HEIGHT), colorPal(256) AS _UNSIGNED LONG

'creating our palette for fire
FOR i = 255 TO 0 STEP -1
    IF i <= 255 AND i >= 200 THEN 'white to yellow
        colorPal(i) = _RGB(map(i, 255, 200, 255, 255), map(i, 255, 200, 255, 242), map(i, 255, 200, 255, 0))
    ELSEIF i <= 201 AND i >= 90 THEN 'yellow to orange
        colorPal(i) = _RGB(map(i, 201, 90, 255, 221), map(i, 201, 90, 242, 140), map(i, 201, 90, 0, 0))
    ELSEIF i <= 89 AND i >= 79 THEN 'orange to dark orange red
        colorPal(i) = _RGB(map(i, 89, 79, 221, 183), map(i, 89, 79, 140, 45), map(i, 89, 79, 0, 0))
    ELSEIF i <= 78 AND i >= 48 THEN 'dark orange red to dark grey
        colorPal(i) = _RGB(map(i, 78, 48, 183, 10), map(i, 78, 48, 45, 10), map(i, 78, 48, 0, 10))
    ELSEIF i <= 47 AND i >= 27 THEN 'dark grey to light grey
        colorPal(i) = _RGBA(map(i, 47, 27, 10, 40), map(i, 47, 27, 10, 40), map(i, 47, 27, 10, 40), map(i, 47, 27, 255, 100))
    ELSEIF i <= 26 AND i >= 0 THEN 'light grey to black
        colorPal(i) = _RGBA(map(i, 26, 0, 40, 0), map(i, 26, 0, 40, 0), map(i, 26, 0, 40, 0), map(i, 26, 0, 100, 0))
    END IF
NEXT
'creating an image,  placing  a text, and storing the white pixel in an array
tmp& = _NEWIMAGE(94, 20, 32)
_DEST tmp&
_PRINTSTRING (5, 0), "QB64 Rocks!"
_DEST 0
_PUTIMAGE (0, 100)-(282, 160), tmp&
FOR i = 100 TO 160
    FOR j = 0 TO 282
        IF POINT(j, i) = _RGB(255, 255, 255) THEN n = n + 1
NEXT j, i
DIM textPixelPosX(n), textPixelPosY(n)
n = 1
FOR i = 100 TO 160
    FOR j = 0 TO 282
        IF POINT(j, i) = _RGB(255, 255, 255) THEN textPixelPosX(n) = j: textPixelPosY(n) = i: n = n + 1
NEXT j, i

t# = TIMER
DO
    IF TIMER - t# > 1.8 THEN
        xOff = p5random(-100, 100)
        yOff = p5random(-70, 70)
        'using stored pixel array to display fire text
        FOR i = 0 TO n - 1
            xx = textPixelPosX(i) + xOff
            yy = textPixelPosY(i) + yOff
            IF xx > 1 AND xx < _WIDTH - 1 AND yy > 1 AND yy < _HEIGHT - 1 THEN fireBuffer(xx, yy) = p5random(100, 255)
        NEXT
        t# = TIMER
    END IF
    CLS
    FOR x = 0 TO _WIDTH
        fireBuffer(x, _HEIGHT - 1) = p5random(10, 255)
    NEXT
    FOR y = 0 TO _HEIGHT - 2
        FOR x = 1 TO _WIDTH - 1
            fireBuffer(x, y) = (fireBuffer(x - 1, y + 1) + fireBuffer(x, y + 1) + fireBuffer(x + 1, y + 1) + fireBuffer(x, y + 2)) * .2441
    NEXT x, y

    FOR x = 0 TO _WIDTH - 1
        FOR y = 0 TO _HEIGHT - 1
            PSET (x, y), colorPal(INT(fireBuffer(x, y)))
    NEXT y, x
    _DISPLAY
    _LIMIT 60
LOOP

'taken from p5js.bas
'https://bit.ly/p5jsbas
FUNCTION map! (value!, minRange!, maxRange!, newMinRange!, newMaxRange!)
    map! = ((value! - minRange!) / (maxRange! - minRange!)) * (newMaxRange! - newMinRange!) + newMinRange!
END FUNCTION

FUNCTION p5random! (mn!, mx!)
    IF mn! > mx! THEN
        SWAP mn!, mx!
    END IF
    p5random! = RND * (mx! - mn!) + mn!
END FUNCTION

