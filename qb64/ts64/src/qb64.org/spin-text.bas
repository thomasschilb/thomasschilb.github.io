SCREEN _NEWIMAGE(256, 256, 32)

Sprite = TextToImage("EXAMPLE", 16, &HFFFF0000, 0, 0)


DO
    CLS
    DisplayImage Sprite, 128, 128, angle, 0
    angle = angle + 4
    _DISPLAY
    _LIMIT 30
LOOP UNTIL _KEYHIT





FUNCTION TextToImage& (text$, font&, fc&, bfc&, mode AS _BYTE)
    'text$ is the text that we wish to transform into an image.
    'font& is the handle of the font we want to use.
    'fc& is the color of the font we want to use.
    'bfc& is the background color of the font.

    'Mode 1 is print forwards
    'Mode 2 is print backwards
    'Mode 3 is print from top to bottom
    'Mode 4 is print from bottom up
    'Mode 0 got lost somewhere, but it's OK.  We check to see if our mode is < 1 or > 4 and compensate automatically if it is to make it one (default).

    IF mode < 1 OR mode > 4 THEN mode = 1
    dc& = _DEFAULTCOLOR: bgc& = _BACKGROUNDCOLOR
    D = _DEST
    F = _FONT
    IF font& <> 0 THEN _FONT font&
    IF mode < 3 THEN
        'print the text lengthwise
        w& = _PRINTWIDTH(text$): h& = _FONTHEIGHT
    ELSE
        'print the text vertically
        FOR i = 1 TO LEN(text$)
            IF w& < _PRINTWIDTH(MID$(text$, i, 1)) THEN w& = _PRINTWIDTH(MID$(text$, i, 1))
        NEXT
        h& = _FONTHEIGHT * (LEN(text$))
    END IF

    TextToImage& = _NEWIMAGE(w&, h&, 32)
    _DEST TextToImage&
    IF font& <> 0 THEN _FONT font&
    COLOR fc&, bfc&

    SELECT CASE mode
        CASE 1
            'Print text forward
            _PRINTSTRING (0, 0), text$
        CASE 2
            'Print text backwards
            temp$ = ""
            FOR i = 0 TO LEN(text$) - 1
                temp$ = temp$ + MID$(text$, LEN(text$) - i, 1)
            NEXT
            _PRINTSTRING (0, 0), temp$
        CASE 3
            'Print text upwards
            'first lets reverse the text, so it's easy to place
            temp$ = ""
            FOR i = 0 TO LEN(text$) - 1
                temp$ = temp$ + MID$(text$, LEN(text$) - i, 1)
            NEXT
            'then put it where it belongs
            FOR i = 1 TO LEN(text$)
                fx = (w& - _PRINTWIDTH(MID$(temp$, i, 1))) / 2 + .99 'This is to center any non-monospaced letters so they look better
                _PRINTSTRING (fx, _FONTHEIGHT * (i - 1)), MID$(temp$, i, 1)
            NEXT
        CASE 4
            'Print text downwards
            FOR i = 1 TO LEN(text$)
                fx = (w& - _PRINTWIDTH(MID$(text$, i, 1))) / 2 + .99 'This is to center any non-monospaced letters so they look better
                _PRINTSTRING (fx, _FONTHEIGHT * (i - 1)), MID$(text$, i, 1)
            NEXT
    END SELECT
    _DEST D
    COLOR dc&, bgc&
    _FONT F
END FUNCTION





SUB DisplayImage (Image AS LONG, x AS INTEGER, y AS INTEGER, angle AS SINGLE, mode AS _BYTE)
    'Image is the image handle which we use to reference our image.
    'x,y is the X/Y coordinates where we want the image to be at on the screen.
    'angle is the angle which we wish to rotate the image.
    'mode determines HOW we place the image at point X,Y.
    'Mode 0 we center the image at point X,Y
    'Mode 1 we place the Top Left corner of oour image at point X,Y
    'Mode 2 is Bottom Left
    'Mode 3 is Top Right
    'Mode 4 is Bottom Right


    DIM px(3) AS INTEGER, py(3) AS INTEGER, w AS INTEGER, h AS INTEGER
    DIM sinr AS SINGLE, cosr AS SINGLE, i AS _BYTE
    w = _WIDTH(Image): h = _HEIGHT(Image)
    SELECT CASE mode
        CASE 0 'center
            px(0) = -w \ 2: py(0) = -h \ 2: px(3) = w \ 2: py(3) = -h \ 2
            px(1) = -w \ 2: py(1) = h \ 2: px(2) = w \ 2: py(2) = h \ 2
        CASE 1 'top left
            px(0) = 0: py(0) = 0: px(3) = w: py(3) = 0
            px(1) = 0: py(1) = h: px(2) = w: py(2) = h
        CASE 2 'bottom left
            px(0) = 0: py(0) = -h: px(3) = w: py(3) = -h
            px(1) = 0: py(1) = 0: px(2) = w: py(2) = 0
        CASE 3 'top right
            px(0) = -w: py(0) = 0: px(3) = 0: py(3) = 0
            px(1) = -w: py(1) = h: px(2) = 0: py(2) = h
        CASE 4 'bottom right
            px(0) = -w: py(0) = -h: px(3) = 0: py(3) = -h
            px(1) = -w: py(1) = 0: px(2) = 0: py(2) = 0
    END SELECT
    sinr = SIN(angle / 57.2957795131): cosr = COS(angle / 57.2957795131)
    FOR i = 0 TO 3
        x2 = (px(i) * cosr + sinr * py(i)) + x: y2 = (py(i) * cosr - px(i) * sinr) + y
        px(i) = x2: py(i) = y2
    NEXT
    _MAPTRIANGLE (0, 0)-(0, h - 1)-(w - 1, h - 1), Image TO(px(0), py(0))-(px(1), py(1))-(px(2), py(2))
    _MAPTRIANGLE (0, 0)-(w - 1, 0)-(w - 1, h - 1), Image TO(px(0), py(0))-(px(3), py(3))-(px(2), py(2))
END SUB

