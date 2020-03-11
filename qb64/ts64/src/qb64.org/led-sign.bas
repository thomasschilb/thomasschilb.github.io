'********************************
'*                              *
'* LED Maker  by  Terry Ritchie *
'*                              *
'********************************

CONST ROUND = 0, SQUARE = 1

TYPE LED
    Screen AS LONG ' the LED screen to show on screen
    Image AS LONG '  the LED image to work on in the background
    Mask AS LONG '   the LED mask to place over the LED image
END TYPE

DIM LED AS LED
DIM News$
DIM Mpos%

News$ = "                Breaking News!                QB64.org is awesome! "

MAKELED 128, 16, 10, ROUND '                                                   create LED screen
SCREEN LED.Screen '                                                            set LED screen as view screen
_TITLE "LED Scrolling Sign" '                                                  give screen a title
Mpos% = 0 '                                                                    reset message position pointer
DO
    _LIMIT 5 '                                                                 5 frames per second
    _DEST LED.Image '                                                          set small image as destination
    COLOR _RGB32(255, 255, 0) '                                                set text color to yellow
    Mpos% = Mpos% + 1 '                                                        increment message pointer
    IF Mpos% > LEN(News$) THEN Mpos% = 1 '                                     reset pointer at end of message
    LOCATE 1, 1 '                                                              position cursor
    PRINT MID$(News$, Mpos%, 16); '                                            display portion of message
    _DEST 0 '                                                                  set LED screen back to destination
    _PUTIMAGE , LED.Image '                                                    stretch the small image across screen
    _PUTIMAGE , LED.Mask '                                                     place LED mask over image
    _DISPLAY '                                                                 viola', the screen looks pixelized
LOOP UNTIL INKEY$ <> ""

'----------------------------------------------------------------------------------------------------------------------
'                                                                                                               MAKELED
SUB MAKELED (w%, h%, psize%, pshape%)

    SHARED LED AS LED '  need access to LED screen properties

    DIM OriginalDest& '  calling routine destination
    DIM LEDPixel& '      temporary image to hold single LED pixel

    OriginalDest& = _DEST '                                                        remember calling routine destination
    LED.Screen = _NEWIMAGE(w% * psize%, h% * psize%, 32) '                         create LED screen image holder
    LED.Image = _NEWIMAGE(w%, h%, 32) '                                            create LED work image
    LED.Mask = _COPYIMAGE(LED.Screen) '                                            create LED matrix image mask
    LEDPixel& = _NEWIMAGE(psize%, psize%, 32) '                                    create LED pixel
    _DEST LEDPixel& '                                                              set LED pixel as destination image
    CLS '                                                                          remove 0,0,0 alpha transparency
    LINE (0, 0)-(psize% - 1, psize% - 1), _RGB32(10, 10, 10), BF '                 set background color
    SELECT CASE pshape% '                                                          which pixel shape should be created?
        CASE ROUND '                                                               round pixels
            CIRCLE (psize% \ 2, psize% \ 2), psize% \ 2 - 1, _RGB32(0, 0, 2) '     create round pixel in center of image
            PAINT (psize% \ 2, psize% \ 2), _RGB32(0, 0, 1), _RGB32(0, 0, 2) '     fill the pixel in
        CASE SQUARE '                                                              square pixels
            LINE (1, 1)-(psize% - 1, psize% - 1), _RGB32(0, 0, 2), B '            create square pixel in center of image
            LINE (2, 2)-(psize% - 2, psize% - 2), _RGB32(0, 0, 1), BF
    END SELECT
    _DEST LED.Mask '                                                               set LED mask as destination image
    CLS '                                                                          remove 0,0,0 alpha transparency
    FOR x% = 0 TO w% * psize% - 1 STEP psize% '                                    cycle through horizontal pixel positions
        FOR y% = 0 TO h% * psize% - 1 STEP psize% '                                cycle through vertical pixel positions
            _PUTIMAGE (x%, y%), LEDPixel& '                                        place a pixel image
        NEXT y%
    NEXT x%
    FOR x% = 0 TO w% * psize% - 1 STEP psize% * 8 '                                cycle every 8 horizontal pixels
        LINE (x%, 0)-(x%, h% * psize% - 1), _RGB32(0, 0, 0) '                      draw a divider line
    NEXT x%
    FOR y% = 0 TO h% * psize% - 1 STEP psize% * 8 '                                cycle every 8 vertical pixels
        LINE (0, y%)-(w% * psize% - 1, y%), _RGB32(0, 0, 0) '                      draw a divider line
    NEXT y%
    _SETALPHA 0, _RGB32(0, 0, 1) '                                                 set transparency color of mask
    _SETALPHA 63, _RGB32(0, 0, 2)
    _DEST OriginalDest& '                                                          return to calling routine destination
    _FREEIMAGE LEDPixel& '                                                         removel pixel image from memory

END SUB

'----------------------------------------------------------------------------------------------------------------------

