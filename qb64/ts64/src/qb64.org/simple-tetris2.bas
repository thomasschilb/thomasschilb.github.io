RANDOMIZE TIMER
DEFLNG A-Z

DIM SHARED piece(6, 3, 1)
DIM SHARED piece_color(6)
DIM SHARED size, sw, sh

size = 30
sw = 10
sh = 18

REDIM SHARED board(sw - 1, sh - 1)

piece(0, 0, 0) = 0: piece(0, 1, 0) = 1: piece(0, 2, 0) = 1: piece(0, 3, 0) = 0
piece(0, 0, 1) = 0: piece(0, 1, 1) = 1: piece(0, 2, 1) = 1: piece(0, 3, 1) = 0

piece(1, 0, 0) = 1: piece(1, 1, 0) = 1: piece(1, 2, 0) = 1: piece(1, 3, 0) = 1
piece(1, 0, 1) = 0: piece(1, 1, 1) = 0: piece(1, 2, 1) = 0: piece(1, 3, 1) = 0

piece(2, 0, 0) = 0: piece(2, 1, 0) = 0: piece(2, 2, 0) = 1: piece(2, 3, 0) = 1
piece(2, 0, 1) = 0: piece(2, 1, 1) = 1: piece(2, 2, 1) = 1: piece(2, 3, 1) = 0

piece(3, 0, 0) = 0: piece(3, 1, 0) = 1: piece(3, 2, 0) = 1: piece(3, 3, 0) = 0
piece(3, 0, 1) = 0: piece(3, 1, 1) = 0: piece(3, 2, 1) = 1: piece(3, 3, 1) = 1

piece(4, 0, 0) = 0: piece(4, 1, 0) = 1: piece(4, 2, 0) = 1: piece(4, 3, 0) = 1
piece(4, 0, 1) = 0: piece(4, 1, 1) = 0: piece(4, 2, 1) = 1: piece(4, 3, 1) = 0

piece(5, 0, 0) = 0: piece(5, 1, 0) = 1: piece(5, 2, 0) = 1: piece(5, 3, 0) = 1
piece(5, 0, 1) = 0: piece(5, 1, 1) = 1: piece(5, 2, 1) = 0: piece(5, 3, 1) = 0

piece(6, 0, 0) = 0: piece(6, 1, 0) = 1: piece(6, 2, 0) = 1: piece(6, 3, 0) = 1
piece(6, 0, 1) = 0: piece(6, 1, 1) = 0: piece(6, 2, 1) = 0: piece(6, 3, 1) = 1

SCREEN _NEWIMAGE((sw + 6) * size, sh * size, 32)

piece_color(0) = _RGB(0, 200, 0)
piece_color(1) = _RGB(200, 0, 0)
piece_color(2) = _RGB(156, 85, 211)
piece_color(3) = _RGB(219, 112, 147)
piece_color(4) = _RGB(0, 100, 250)
piece_color(5) = _RGB(230, 197, 92)
piece_color(6) = _RGB(0, 128, 128)

DIM t AS DOUBLE

redraw = -1

speed = 3
lines = 0
pause = 0
putpiece = 0
startx = (sw - 4) / 2

new_px = (sw + 1) * size
new_py = 2 * size


new_pn = INT(RND * 7)
px = startx
py = 1
rot = 0


title$ = "LINES = " + LTRIM$(STR$(lines)) + ", SPEED = " + LTRIM$(STR$(speed))
_TITLE title$

t = TIMER

DO
    place_new new_pn, new_px, new_py, 0, size
    IF (TIMER - t) > (1 / speed) AND NOT pause THEN
        IF valid(pn, px, py + 1, rot) THEN py = py + 1 ELSE putpiece = -1

        t = TIMER
        redraw = -1
    END IF

    IF putpiece THEN
        IF valid(pn, px, py, rot) THEN
            n = place(pn, px, py, rot)
            IF n THEN
                lines = lines + n
                title$ = "LINES = " + LTRIM$(STR$(lines)) + ", SPEED = " + LTRIM$(STR$(speed))
                _TITLE title$
            END IF
        END IF

        pn = new_pn

        new_pn = INT(RND * 7)

        place_new new_pn, new_px, new_py, 0, size


        px = startx
        py = 0
        rot = 0

        putpiece = 0
        redraw = -1

        IF NOT valid(pn, px, py, rot) THEN
            FOR y = 0 TO sh - 1
                FOR x = 0 TO sw - 1
                    board(x, y) = 0
                NEXT
            NEXT
            lines = 0
            title$ = "LINES = " + LTRIM$(STR$(lines)) + ", SPEED = " + LTRIM$(STR$(speed))
            _TITLE title$
        END IF
    END IF

    IF redraw THEN
        LINE (0, 0)-(sw * size, sh * size), _RGB(0, 0, 0), BF
        FOR y = 0 TO sh - 1
            FOR x = 0 TO sw - 1
                IF board(x, y) <> 0 THEN
                    LINE (x * size, y * size)-STEP(size - 2, size - 2), piece_color(board(x, y) - 1), BF
                ELSE
                    LINE (x * size, y * size)-STEP(size - 2, size - 2), _RGB(50, 50, 50), B
                END IF
            NEXT
        NEXT

        FOR y = 0 TO 1
            FOR x = 0 TO 3
                rotate xx, yy, x, y, pn, rot
                IF piece(pn, x, y) THEN LINE ((px + xx) * size, (py + yy) * size)-STEP(size - 2, size - 2), piece_color(pn), BF
            NEXT
        NEXT
        _DISPLAY
        redraw = 0
    END IF

    k = _KEYHIT
    IF k THEN
        shift = _KEYDOWN(100304) OR _KEYDOWN(100303)
        SELECT CASE k
            CASE 18432 'up
                IF valid(pn, px, py, (rot + 1) MOD 4) THEN rot = (rot + 1) MOD 4
                pause = 0
            CASE 19200 'left
                IF shift THEN
                    FOR xx = 0 TO sw - 1
                        IF NOT valid(pn, px - xx, py, rot) THEN EXIT FOR
                    NEXT
                    px = px - xx + 1
                ELSE
                    IF valid(pn, px - 1, py, rot) THEN px = px - 1
                END IF
                pause = 0
            CASE 19712 'right
                IF shift THEN
                    FOR xx = px TO sw - 1
                        IF NOT valid(pn, xx, py, rot) THEN EXIT FOR
                    NEXT
                    px = xx - 1
                ELSE
                    IF valid(pn, px + 1, py, rot) THEN px = px + 1
                END IF
                pause = 0
            CASE 20480, 32 'down
                IF shift OR k = 32 THEN
                    FOR yy = py TO sh - 1
                        IF NOT valid(pn, px, yy, rot) THEN EXIT FOR
                    NEXT
                    py = yy - 1
                    putpiece = -1
                ELSE
                    IF valid(pn, px, py + 1, rot) THEN py = py + 1
                END IF
                pause = 0
            CASE 112 'p
                pause = NOT pause
            CASE 13 'enter
                FOR y = 0 TO sh - 1
                    FOR x = 0 TO sw - 1
                        board(x, y) = 0
                    NEXT
                NEXT
                pn = INT(RND * 7)
                px = startx
                py = 0
                rot = 0
                putpiece = 0
                lines = 0
                title$ = "LINES = " + LTRIM$(STR$(lines)) + ", SPEED = " + LTRIM$(STR$(speed))
                _TITLE title$
            CASE 43, 61 'plus
                IF speed < 100 THEN
                    speed = speed + 1
                    title$ = "LINES = " + LTRIM$(STR$(lines)) + ", SPEED = " + LTRIM$(STR$(speed))
                    _TITLE title$
                END IF
            CASE 95, 45
                IF speed > 1 THEN
                    speed = speed - 1
                    title$ = "LINES = " + LTRIM$(STR$(lines)) + ", SPEED = " + LTRIM$(STR$(speed))
                    _TITLE title$
                END IF
            CASE 27
                EXIT DO
        END SELECT

        redraw = -1
    END IF
LOOP
SYSTEM

SUB rotate (xx, yy, x, y, pn, rot)
    SELECT CASE pn
        CASE 0
            rot_new = rot
        CASE 1 TO 3
            rot_new = rot MOD 2
        CASE 4 TO 6
            rot_new = rot
    END SELECT

    SELECT CASE rot_new
        CASE 0
            xx = x
            yy = y
        CASE 1
            xx = y + 2
            yy = 2 - x
        CASE 2
            xx = 4 - x
            yy = 1 - y
        CASE 3
            xx = 2 - y
            yy = x - 1
    END SELECT
END SUB

FUNCTION valid (pn, px, py, rot)
    FOR y = 0 TO 1
        FOR x = 0 TO 3
            rotate xx, yy, x, y, pn, rot
            IF py + yy >= 0 THEN
                IF piece(pn, x, y) THEN
                    IF (px + xx >= sw) OR (px + xx < 0) THEN
                        valid = 0
                        EXIT FUNCTION
                    END IF
                    IF (py + yy >= sh) THEN
                        valid = 0
                        EXIT FUNCTION
                    END IF
                    IF (py >= 0) THEN
                        IF board(px + xx, py + yy) THEN
                            valid = 0
                            EXIT FUNCTION
                        END IF
                    END IF
                END IF
            END IF
        NEXT
    NEXT

    valid = -1
END FUNCTION

FUNCTION place (pn, px, py, rot)
    lines = 0

    FOR y = 0 TO 1
        FOR x = 0 TO 3
            rotate xx, yy, x, y, pn, rot
            IF py + yy >= 0 THEN IF piece(pn, x, y) THEN board(px + xx, py + yy) = pn + 1
        NEXT
    NEXT

    'clear lines
    FOR y = py - 1 TO py + 2
        IF y >= 0 AND y < sh THEN
            clr = -1
            FOR x = 0 TO sw - 1
                IF board(x, y) = 0 THEN
                    clr = 0
                    EXIT FOR
                END IF
            NEXT

            IF clr THEN
                lines = lines + 1
                FOR yy = y TO 1 STEP -1
                    FOR x = 0 TO sw - 1
                        board(x, yy) = board(x, yy - 1)
                    NEXT
                NEXT
            END IF
        END IF
    NEXT

    place = lines
END FUNCTION

SUB place_new (new_pn, new_px, new_py, rot, size)

    FOR x = 0 TO 3 'new_px TO (new_px + 4) * size STEP size
        FOR y = 0 TO 1 'new_py TO (new_py + 2) * size STEP size
            LINE (new_px + size * x, new_py + size * y)-(new_px + (size * x) + size - 2, new_py + (size * y) + size - 2), _RGB(0, 0, 0), BF
        NEXT
    NEXT

    FOR x = 0 TO 3 'new_px TO (new_px + 4) * size STEP size
        FOR y = 0 TO 1 'new_py TO (new_py + 2) * size STEP size
            LINE (new_px + size * x, new_py + size * y)-(new_px + (size * x) + size - 2, new_py + (size * y) + size - 2), _RGB(25, 25, 25), B
        NEXT
    NEXT

    FOR x = 0 TO 3 'new_px TO (new_px + 4) * size STEP size
        FOR y = 0 TO 1 'new_py TO (new_py + 2) * size STEP size
            IF piece(new_pn, x, y) THEN
                LINE (new_px + size * x, new_py + size * y)-(new_px + (size * x) + size - 2, new_py + (size * y) + size - 2), piece_color(new_pn), BF
            END IF
        NEXT
    NEXT
    _DISPLAY

END SUB

