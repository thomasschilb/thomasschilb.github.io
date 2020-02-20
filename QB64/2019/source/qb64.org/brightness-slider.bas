SCREEN 12
startPos = 50
endPos = 590
currentPos = startPos
colorValue = 9
COLOR colorValue
LINE (50, 239)-(590, 241), colorValue, BF
LINE (startPos - 1, 230)-(startPos + 1, 250), colorValue, BF
MOUSE 1
Text$ = "Current Background Brightness:" + STR$(FIX(Brightness)) + "."
LOCATE 13, 40 - (LEN(Text$) / 2)
PRINT Text$
LOCATE 13, (40 + (LEN(Text$) / 2)) - 3
PRINT RTRIM$(STR$(FIX(Brightness))); ". "
DO
    MOUSE 3
    SELECT CASE B
        CASE 1
            IF H >= startPos AND H <= endPos AND V >= 230 AND V <= 250 THEN
                DO WHILE B = 1
                    MOUSE 3
                    IF H >= startPos AND H <= endPos THEN
                        LINE (currentPos - 1, 230)-(currentPos + 1, 238), 0, BF
                        LINE (currentPos - 1, 242)-(currentPos + 1, 250), 0, BF
                        currentPos = H
                        Brightness = (currentPos - 50) / (540 / 63)
                        OUT &H3C8, 0
                        OUT &H3C9, Brightness
                        OUT &H3C9, Brightness
                        OUT &H3C9, Brightness
                        LINE (currentPos - 1, 230)-(currentPos + 1, 250), colorValue, BF
                        LOCATE 13, (40 + (LEN(Text$) / 2)) - 3
                        PRINT RTRIM$(STR$(FIX(Brightness))); ". "
                    END IF
                LOOP
            END IF
    END SELECT
LOOP
SUB MOUSE (Funk)
    SHARED B, H, V
    STATIC Crsr
    IF Funk = 1 THEN Crsr = 1
    IF Funk = 2 AND Crsr = 0 THEN EXIT SUB
    IF Funk = 2 AND Crsr = 1 THEN: Crsr = 0
    POKE 100, 184: POKE 101, Funk: POKE 102, 0
    POKE 103, 205: POKE 104, 51: POKE 105, 137
    POKE 106, 30: POKE 107, 170: POKE 108, 10
    POKE 109, 137: POKE 110, 14: POKE 111, 187
    POKE 112, 11: POKE 113, 137: POKE 114, 22
    POKE 115, 204: POKE 116, 12: POKE 117, 203
    CALL ABSOLUTE(100)
    B = PEEK(&HAAA)
    H2 = PEEK(&HBBC)
    H2 = H2 * 256
    H = PEEK(&HBBB) + H2
    V = PEEK(&HCCC) + PEEK(&HCCD) * 256
END SUB

