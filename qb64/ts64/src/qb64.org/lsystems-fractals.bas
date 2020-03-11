'Coded By Ashish in QB64
'Twiter : @KingOfCoders
_TITLE "Fractals [Part 2 : L-System]"

SCREEN _NEWIMAGE(800, 600, 32)

TYPE rule_type
    token AS STRING * 1
    replace AS STRING * 256
END TYPE


DIM SHARED fractalsName(11) AS STRING
DIM SHARED fractalRules(14) AS rule_type


fractalsName(0) = "Board": fractalRules(0).token = "F": fractalRules(0).replace = "FF+F+F+F+FF"
fractalsName(1) = "Crystal": fractalRules(1).token = "F": fractalRules(1).replace = "FF+F++F+F"
fractalsName(2) = "Peano Curve": fractalRules(2).token = "X": fractalRules(2).replace = "XFYFX+F+YFXFY-F-XFYFX": fractalRules(3).token = "Y": fractalRules(3).replace = "YFXFY-F-XFYFX+F+YFXFY"
fractalsName(3) = "Quadratic Gosper": fractalRules(4).token = "X": fractalRules(4).replace = "XFX-YF-YF+FX+FX-YF-YFFX+YF+FXFXYF-FX+YF+FXFX+YF-FXYF-YF-FX+FX+YFYF-": fractalRules(5).token = "Y": fractalRules(5).replace = "+FXFX-YF-YF+FX+FXYF+FX-YFYF-FX-YF+FXYFYF-FX-YFFX+FX+YF-YF-FX+FX+YFY"
fractalsName(4) = "Quadratic Snowflake": fractalRules(6).token = "F": fractalRules(6).replace = "F-F+F+F-F"
fractalsName(5) = "Quadratic Koch Island": fractalRules(7).token = "F": fractalRules(7).replace = "F-FF+FF+F+F-F-FF+F+F-F-FF-FF+F"
fractalsName(6) = "Square Sierpinski": fractalRules(8).token = "X": fractalRules(8).replace = "XF-F+F-XF+F+XF-F+F-X"
fractalsName(7) = "Triangle": fractalRules(9).token = "F": fractalRules(9).replace = "F-F+F"
fractalsName(8) = "Von Koch Snowflake": fractalRules(10).token = "F": fractalRules(10).replace = "F-F++F-F"
fractalsName(9) = "Hilbert": fractalRules(11).token = "X": fractalRules(11).replace = "-YF+XFX+FY-": fractalRules(12).token = "Y": fractalRules(12).replace = "+XF-YFY-FX+"
fractalsName(10) = "Cross": fractalRules(13).token = "F": fractalRules(13).replace = "F+F-F+F+F"
fractalsName(11) = "Pentaplexity": fractalRules(14).token = "F": fractalRules(14).replace = "F++F++F|F-F++F"


DO
    choice = getChoice
    IF choice >= 0 AND choice <= UBOUND(fractalsName) THEN
        _TITLE _TITLE$ + " " + fractalsName(choice)
        SELECT CASE choice
            CASE 0
                g$ = prepareGrammer("F+F+F+F", 0, 0, 5)
                angle! = 90
            CASE 1
                g$ = prepareGrammer("F+F+F+F", 1, 1, 5)
                angle! = 90
            CASE 2
                g$ = prepareGrammer("X", 2, 3, 4)
                angle! = 90
            CASE 3
                g$ = prepareGrammer("-YF", 4, 5, 3)
                angle! = 90
            CASE 4
                g$ = prepareGrammer("F", 6, 6, 5)
                angle! = 90
            CASE 5
                g$ = prepareGrammer("F+F+F+F", 7, 7, 3)
                angle! = 90
            CASE 6
                g$ = prepareGrammer("F+XF+F+XF", 8, 8, 5)
                angle! = 90
            CASE 7
                g$ = prepareGrammer("F", 9, 9, 7)
                angle! = 120
            CASE 8
                g$ = prepareGrammer("F++F++F", 10, 10, 5)
                angle! = 60
            CASE 9
                g$ = prepareGrammer("X", 11, 12, 7)
                angle! = 90
            CASE 10
                g$ = prepareGrammer("F+F+F+F", 13, 13, 6)
                angle! = 90
            CASE 11
                g$ = prepareGrammer("F++F++F++F++F", 14, 14, 5)
                angle! = 36

        END SELECT
        showControl
        x = 100
        y = 100
        r = 3
        DO
            CLS

            IF _KEYDOWN(ASC("w")) THEN y = y - 2
            IF _KEYDOWN(ASC("s")) THEN y = y + 2
            IF _KEYDOWN(ASC("a")) THEN x = x - 2
            IF _KEYDOWN(ASC("d")) THEN x = x + 2
            IF _KEYDOWN(ASC("q")) THEN r = r + .1
            IF _KEYDOWN(ASC("e")) AND r > 1 THEN r = r - .1
            IF _KEYDOWN(27) THEN _AUTODISPLAY: EXIT DO
            drawFractal g$, angle!, r, x, y

            _LIMIT 40
            _DISPLAY

        LOOP
    ELSE
        PRINT "Wrong Choice"
        _DELAY 1
    END IF
    _KEYCLEAR
LOOP

FUNCTION prepareGrammer$ (axm$, s, e, N)
    DIM fractalRule(e - s) AS rule_type
    FOR i = s TO e
        fractalRule(i - s).token = fractalRules(i).token
        fractalRule(i - s).replace = RTRIM$(fractalRules(i).replace)
    NEXT
    prepareGrammer$ = generateGrammer$(axm$, fractalRule(), N)
END FUNCTION

FUNCTION getChoice ()
    _TITLE "Fractals [Part 2 : L-System]"
    CLS
    FOR i = 0 TO UBOUND(fractalsName)
        PRINT i + 1; ". "; fractalsName(i)
    NEXT
    INPUT "Enter the fractal No. : ", getChoice
    getChoice = getChoice - 1
END FUNCTION

'######################################################
'Fractal related subroutine
SUB showControl ()
    CLS
    PRINT "Use 'w' and 's' to move up and down"
    PRINT "Use 'a' and 'd' to move left and rigth"
    PRINT "Use 'q' and 'e' to zoom-in and zoom-out"
    PRINT "Use 'Esc' to goto fractal menu"
    PRINT "Hit a Key"
    SLEEP
END SUB

SUB drawFractal (grammer$, ang!, r, x, y)
    ang2! = 0
    px = x
    py = y
    FOR i = 1 TO LEN(grammer$)
        ca$ = MID$(grammer$, i, 1)
        SELECT CASE ca$
            CASE "F"
                xx = COS(_D2R(ang2!)) * r + px
                yy = SIN(_D2R(ang2!)) * r + py
                LINE (px, py)-(xx, yy)
                px = xx
                py = yy
            CASE "+"
                ang2! = ang2! + ang!
            CASE "-"
                ang2! = ang2! - ang!
            CASE "|"
                ang2! = ang2! + 180
            CASE "f"
                xx = COS(_D2R(ang2!)) * r + px
                yy = SIN(_D2R(ang2!)) * r + py
                px = xx
                py = yy
        END SELECT
    NEXT
END SUB

'L-System Function
FUNCTION generateGrammer$ (axiom$, rule() AS rule_type, n~&)
    axiom2$ = axiom$
    axiom3$ = ""
    DO
        FOR i = 1 TO LEN(axiom2$)
            ca$ = MID$(axiom2$, i, 1)
            nca$ = ca$
            FOR j = 0 TO UBOUND(rule)
                IF rule(j).token = ca$ THEN
                    nca$ = RTRIM$(rule(j).replace)
                    EXIT FOR
                END IF
            NEXT
            axiom3$ = axiom3$ + nca$
        NEXT
        axiom2$ = axiom3$
        axiom3$ = ""
        count = count + 1
        PRINT ".";
    LOOP UNTIL count >= n~&
    generateGrammer$ = axiom2$
END FUNCTION

