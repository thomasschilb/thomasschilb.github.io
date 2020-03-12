'Wavy with Plama.bas for QB64 fork (B+=MGA) 2017-05-05
' Wavy with Plasma Treatment.bas SmallBASIC 0.12.9 (B+=MGA) 2017-05-03
' from: animated circles started by Admin at SdlBasic 2017-05-03
' I added Plasma treatment and spacebar  changer


'===================================================================

' Instructions: press spacebar for new injection of plasma

'==================================================================

RANDOMIZE TIMER
CONST sqr12! = .5 ^ .5
CONST xmax = 1100
CONST ymax = 700
CONST DPI = 3.141516 * 2
CONST PHIDELTA = DPI / 15
CONST PHISTEP = DPI / 50
CONST RADIUS = 20
CONST SMALL_R = 20
CONST DISTANCE = 23
CONST W = xmax
CONST H = ymax

SCREEN _NEWIMAGE(xmax, ymax, 32)
_TITLE "Wavy with Plasma trans by bplus, Press Spacebar for New Plasma Injection."
DIM SHARED cN AS DOUBLE
DIM SHARED pR, pG, pB AS INTEGER
DIM x, y, xball, yball AS INTEGER
DIM current_phi, phiIndex, phi AS DOUBLE
current_phi = 0
cN = 1
resetPlasma
WHILE 1
    CLS
    _LIMIT 10
    IF _KEYHIT = 32 THEN cN = 1: resetPlasma
    current_phi = current_phi + PHISTEP
    FOR x = 0 TO (W + RADIUS) STEP DISTANCE
        FOR y = 0 TO (H + RADIUS) STEP DISTANCE
            'COLOR _RGB(120, 80, 80)
            'CIRCLE (x, y), RADIUS
            phiIndex = ((x + y) MOD (2 * W)) / RADIUS
            phi = phiIndex * PHIDELTA + current_phi
            xball = COS(phi) * RADIUS + x
            yball = SIN(phi) * RADIUS + y
            changePlasma
            'LINE (x, y)-(xball, yball)
            fcirc2 xball, yball, SMALL_R
        NEXT
    NEXT
    _DISPLAY
WEND

SUB changePlasma ()
    cN = cN + 1
    COLOR _RGB(127 + 127 * SIN(pR * cN), 127 + 127 * SIN(pG * cN), 127 + 127 * SIN(pB * cN))
END SUB

SUB resetPlasma ()
    pR = RND ^ 2: pG = RND ^ 2: pB = RND ^ 2
END SUB

'========================================== sqrSeg Method for filled circle
SUB fcirc2 (xx%, yy%, r%)
    'const sqr12! = .5^.5  'in main const section
    r2% = r% * r%
    sqr12r% = sqr12! * r%
    LINE (xx% - sqr12r%, yy% - sqr12r%)-(xx% + sqr12r%, yy% + sqr12r%), , BF
    FOR x% = 0 TO sqr12r%
        y% = SQR(r2% - x% * x%)
        LINE (xx% - x%, yy% + sqr12r%)-(xx% - x%, yy% + y%)
        LINE (xx% - x%, yy% - sqr12r%)-(xx% - x%, yy% - y%)
        LINE (xx% + x%, yy% + sqr12r%)-(xx% + x%, yy% + y%)
        LINE (xx% + x%, yy% - sqr12r%)-(xx% + x%, yy% - y%)
    NEXT
    FOR x% = sqr12r% TO r%
        y% = SQR(r2% - x% * x%)
        LINE (xx% - x%, yy% + y%)-(xx% - x%, yy% - y%)
        LINE (xx% + x%, yy% + y%)-(xx% + x%, yy% - y%)
    NEXT
END SUB

SUB fcirc (xx%, yy%, r%)
    r2% = r% * r%
    FOR x% = 0 TO r%
        y% = INT(SQR(r2% - x% * x%))
        LINE (xx% - x%, yy% + y%)-(xx% - x%, yy% - y%)
        LINE (xx% + x%, yy% + y%)-(xx% + x%, yy% - y%)
    NEXT
END SUB

