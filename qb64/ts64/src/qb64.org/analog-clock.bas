'** NOTES **



' Ideas to add
'
' if SL_EVENT_TRIGGER then 'check for event that was sent (add event triggers)
' - possible link sounds to events
' add gravity, attraction, repulsion  SL_SET_PHYSICS
' add mass, elasticity (bounciness?)   ^  ^  ^
' add arc calculator for things like a swinging vine or radar scope
' ability to link sprites, when one moves the other moves, break apart when collision happens SL_LINK_SPRITE
' give sprites path-following ability (bezier curves?) SL_FOLLOW_PATH
' divide work space into cells and detect when sprites enter/leave a cell
' stand-alone program to develop sprite sheets (inform)        \
' stand-alone program to develop celled work spaces (inform)   /  combine these into one program?
' when sprite interact their mass, elascticity, etc. govern the way the move and fall
' - I will need help from a math major for this

' Planned additions
'
' get sprite width and height (both actual and collision box) SL_GET_ACTUAL_WIDTH, SL_GET_ACTUAL_HEIGHT, SL_GET_COLLISION_WIDTH, SL_GET_COLLISION_HEIGHT
' set Z depth of sprite for different planes/layers (possibly incorporate this into zoom?)
' - need to figure out how to rotate collision box along with sprites, not too hard
' - this will require line segment intersection algorithms for collision detection, yikes! hard, probably need help
' - possibly link sounds to collisions SL_LINK_COLLIDE_SOUND
' Parallaxing layers  SL_CREATE_PARALLAX, SL_UPDATE_PARALLAX
' Game font printing
' Sprite tiling, square for sure, isometric?

' Things to improve
'
' Naming convention of constants and their values
' Use integers wherever possible
' allow SINGLE value rotation angles for accuracy but convert to integer before sprite rotation
' - using only integer now, may not be precise enough for future improvements

' Investigate
'
' Use of _MAPTRIANGLE for 3D rotation   SL_ROTATE_3D
' _HARDWARE vs _HARDWARE1

' Remember
'
' Any code added that is OS dependant needs to detect the OS running first
' - try to create routines that are OS dependant for all OS'



OPTION _EXPLICIT ' need to remove before publishing library!!

'*
'* constant declarations
'*

'      CONSTANT NAME                   DESCRIPTION                                                       FUNCTIONS / SUBROUTINES THAT MAY USE THIS CONSTANT
' 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
CONST SL_RESET = -32767 '   reset a function or subroutine              SL_ROTATE_SPRITE, SL_FLIP_SPRITE, SL_ZOOM_SPRITE, SL_SET_ZOOM, SL_CHANGE_AUTOROTATION, SL_CHANGE_AUTOMOTION, SL_CHANGE_ROTATION_SPEED, SL_SET_COLLISION
CONST SL_NOFLIP = 0 '       sprite will use no flipping                 SL_FLIP_SPRITE
CONST SL_HORIZONTAL = 1 '   sprite will be flipped horizontally         SL_FLIP_SPRITE
CONST SL_VERTICAL = 2 '     sprite will be flipped vertically           SL_FLIP_SPRITE
CONST SL_FLIPBOTH = 3 '     sprite will be flipped both direction       SL_FLIP_SPRITE
CONST SL_USESHEET = -1 '    use sheet's transparency info (.PNG)        SL_NEW_SHEET
CONST SL_SET = 0 '          manually set transparency                   SL_NEW_SHEET
CONST SL_NONE = 1 '         don't use transparency with sheet           SL_NEW_SHEET
CONST SL_NOSAVE = 0 '       sprite will not save background             SL_NEW_SPRITE, SL_SET_SOFTWARE
CONST SL_SAVE = -1 '        sprite will save background                 SL_NEW_SPRITE, SL_SET_SOFTWARE
CONST SL_HARDWARE = 0 '     sprite in hardware mode                     SL_NEW_SPRITE, SL_update_auto_sprites
CONST SL_SOFTWARE = -1 '    sprite in software mode                     SL_NEW_SPRITE, SL_update_auto_sprites
CONST SL_START = -1 '       enable auto motion / rotation               SL_CHANGE_AUTOMOTION, SL_CHANGE_AUTOROTATION, SL_SET_AUTOANIMATION, SL_SET_ANIMATION, SL_SET_MOTION, SL_SET_ROTATION
CONST SL_STOP = 0 '         disable auto motion / rotation              SL_CHANGE_AUTOMOTION, SL_CHANGE_AUTOROTATION, SL_SET_AUTOANIMATION, SL_SET_ANIMATION, SL_SET_MOTION, SL_SET_ROTATION, SL_CHANGE_ROTATION_SPEED
CONST SL_FORWARD = 0 '      animation cells proceed forward             SL_SET_ANIMATION
CONST SL_BACKWARD = 1 '     animation cells proceed backwards           SL_SET_ANIMATION
CONST SL_BACKFORTH = 2 '    animation cells toggle forward/backward     SL_SET_ANIMATION
CONST SL_CURRENTCELL = -1 ' use current cell as starting cell           SL_SET_ANIMATION, SL_CHANGE_ANIMATION_CELLS
CONST SL_SHOW = -1 '        sprite will be shown on screen              SL_SET_SPRITE_VISIBLE, SL_SET_LAYER_VISIBLE
CONST SL_HIDE = 0 '         sprite will not be shown on screen          SL_SET_SPRITE_VISIBLE, SL_SET_LAYER_VISIBLE
CONST SL_NODETECT = 0 '     sprite uses no collision detection          SL_SET_COLLISION
CONST SL_BOXDETECT = 1 '    sprite uses box collision detect            SL_SET_COLLISION
CONST SL_ROUNDDETECT = 2 '  sprite uses round collision detect '        SL_SET_COLLISION
CONST SL_PIXELDETECT = 3 '  sprite uses pixel perfect collision detect  SL_SET_COLLISION
CONST SL_ALL = -1 '         check for all sprites                       SL_GET_COLLISION, SL_GET_MOUSE, SL_CLEAR_LAYER
CONST SL_NOMOUSE = 0 '      no mouse interaction with sprite            SL_GET_MOUSE
CONST SL_HOVER = 1 '        mouse pointer hovering over sprite          SL_GET_MOUSE
CONST SL_LEFTCLICK = 2 '    left mouse button clicked on sprite         SL_GET_MOUSE
CONST SL_RIGHTCLICK = 3 '   right mouse button clicked on sprite        SL_GET_MOUSE
CONST SL_CENTERCLICK = 4 '  center mouse button clicked on sprite       SL_GET_MOUSE

'*
'* type declarations
'*

TYPE SL_SHEET ' 컴컴컴컴컴컴컴컴컴컴컴� SPRITE SHEET DATABASE 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
    software AS LONG '                  software sprite image
    mask AS LONG '                      software mask image
    swidth AS INTEGER '                 width of sprite
    sheight AS INTEGER '                height of sprite
    transparency AS INTEGER '           -1 (TRUE) if sheet uses transparency
    clearcolor AS _UNSIGNED LONG '      transparent color of image
END TYPE ' 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

TYPE SL_XY ' 컴컴컴컴컴컴컴컴컴컴컴컴컴 X,Y LOCATIONS 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
    real AS SINGLE '                    single values of sprite x,y center point
    int AS INTEGER '                    integer values of sprite x,y center point
    actual AS INTEGER '                 integer values of sprite upper left x,y location
    back AS INTEGER '                   integer values of sprite's background image x,y location
    dir AS SINGLE '                     single values of sprite x,y motion vectors
END TYPE ' 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

TYPE SL_IMAGE ' 컴컴컴컴컴컴컴컴컴컴컴� IMAGES 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
    hardware AS LONG '                  hardware sprite image
    software AS LONG '                  software sprite image
    mask AS LONG '                      software sprite mask image
    back AS LONG '                      software sprite saved background image
END TYPE ' 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

TYPE SL_ANIM ' 컴컴컴컴컴컴컴컴컴컴컴컴 ANIMATION SETTINGS 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
    cell AS INTEGER '                   current animation cell
    cellfrom AS INTEGER '               starting animation cell
    cellto AS INTEGER '                 ending animation cell
    dir AS INTEGER '                    animation direction
    mode AS INTEGER '                   animation mode (forward, backward, back/forth)
    framerate AS INTEGER '              sprite animation frame rate
    frame AS INTEGER '                  animation frame counter
    skip AS INTEGER '                   how often to skip a frame to achieve framerate
    auto AS INTEGER '                   auto-animation on/off
END TYPE ' 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

TYPE SL_MOTION ' 컴컴컴컴컴컴컴컴컴컴컴 MOTION SETTINGS 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
    auto AS INTEGER '                   -1 (TRUE) if auto-motion turned on
    speed AS SINGLE '                   speed of sprite during motion
    angle AS INTEGER '                  direction of sprite during motion (0 - 359)
END TYPE ' 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

TYPE SL_ROTATION ' 컴컴컴컴컴컴컴컴컴컴 ROTATION SETTINGS 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
    auto AS INTEGER '                   -1 (TRUE) if auto-rotation turned on
    speed AS INTEGER '                  spin rate in degrees of sprite (0 - 359)
    angle AS INTEGER '                  current rotation angle of sprite
END TYPE ' 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

TYPE SL_COLLISION ' 컴컴컴컴컴컴컴컴컴� COLLISION SETTINGS 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
    detect AS INTEGER '                 type of detection this sprite uses (box, round, ellipse, pixel)
    box AS INTEGER '                    -1 (TRUE) if a box collision detected
    round AS INTEGER '                  -1 (TRUE) if a round collision detected
    pixel AS INTEGER '                  -1 (TRUE) if a pixel perfect collision detected
    with AS INTEGER '                   the sprite collision happened with
    radius AS INTEGER '                 radius of round collision area
    x1 AS INTEGER '                     collision box upper left x
    x2 AS INTEGER '                     collision box lower right x
    y1 AS INTEGER '                     collision box upper left y
    y2 AS INTEGER '                     collision box lower right y
    cwidth AS INTEGER '                 width of collision box
    cheight AS INTEGER '                height of collision box
    xpoint AS INTEGER '                 x location of collision
    ypoint AS INTEGER '                 y location of collision
END TYPE ' 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

TYPE SL_MOUSE ' 컴컴컴컴컴컴컴컴컴컴컴� MOUSE SETTINGS 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
    event AS INTEGER '                  last event on sprite (hover, click, etc)
    x AS INTEGER '                      x location of mouse on sprite
    y AS INTEGER '                      y location of mouse on sprite
    xa AS INTEGER '                     x location of mouse on screen
    ya AS INTEGER '                     y location of mouse on screen
END TYPE ' 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

TYPE SL_SPRITE ' 컴컴컴컴컴컴컴컴컴컴컴 SPRITE DATABASE 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
    inuse AS INTEGER '                  this array index in use
    x AS SL_XY '                        x coordinate locations
    y AS SL_XY '                        y coordinate locations
    gfx AS SL_IMAGE '                   image graphics
    animation AS SL_ANIM '              animation settings
    motion AS SL_MOTION '               motion settings
    rotation AS SL_ROTATION '           rotation settings
    collision AS SL_COLLISION '         collision settings
    mouse AS SL_MOUSE '                 mouse interaction settings
    sheet AS INTEGER '                  sheet sprite belongs to
    cell AS INTEGER '                   current sprite cell
    swidth AS INTEGER '                 width of sprite
    sheight AS INTEGER '                height of sprite
    restore AS INTEGER '                -1 (TRUE) if sprite restores background
    flip AS INTEGER '                   flip horizontally, vertically, or both
    transparency AS INTEGER '           -1 (TRUE) if sprite uses transparency
    zoom AS INTEGER '                   zoom level of sprite (1% - x%)
    software AS INTEGER '               -1 (TRUE) if sprite is to be treated as software image
    score AS INTEGER '                  point score of sprite
    visible AS INTEGER '                -1 (TRUE) if sprite visible
    layer AS INTEGER '                  the layer the sprite belongs to
END TYPE ' 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

TYPE SL_ANGLE ' 컴컴컴컴컴컴컴컴컴컴컴� ROTATION ANGLE & COLLISION BOX DATABASE 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
    x1 AS INTEGER '                     collision box upper left x
    x2 AS INTEGER '                     collision box lower right x
    y1 AS INTEGER '                     collision box upper left y
    y2 AS INTEGER '                     collision box lower right y
    cwidth AS INTEGER '                 collision box width
    cheight AS INTEGER '                collision box height
    radius AS INTEGER '                 collision circle radius
    rwidth AS INTEGER '                 rotated sprite width
    rheight AS INTEGER '                rotated sprite height
    px0 AS INTEGER '                    rectangular rotation coordinates
    px1 AS INTEGER
    px2 AS INTEGER
    px3 AS INTEGER
    py0 AS INTEGER
    py1 AS INTEGER
    py2 AS INTEGER
    py3 AS INTEGER
END TYPE ' 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

TYPE SL_LAYERS ' 컴컴컴컴컴컴컴컴컴컴컴 LAYER DATABASE 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
    image AS LONG '                     software image of screen layer
    visible AS INTEGER '                -1 (TRUE) if layer is visible
END TYPE ' 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

TYPE SL_GLOBAL ' 컴컴컴컴컴컴컴컴컴컴컴 GLOBALS DATABASE 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
    layer AS INTEGER '                  active layer
    swidth AS INTEGER '                 screen width
    sheight AS INTEGER '                screen height
    framerate AS INTEGER '              global frame rate
    source AS INTEGER '                 current source layer
    destination AS INTEGER '            current destination layer
END TYPE ' 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

'*
'* global dynamic array declarations
'*

REDIM SL_sheet(1, 1) AS SL_SHEET '      sheet#, cell# - master sheet array
REDIM SL_angle(1, 1, 359) AS SL_ANGLE ' sheet#, cell#, angle# - master sheet precalculated angle array
REDIM SL_sprite(1) AS SL_SPRITE '       master working sprite array
REDIM SL_layer(1) AS SL_LAYERS '        image layer array

'
'*
'* global variable declarations
'*

DIM SL_global AS SL_GLOBAL

'*
'* main code (for testing)
'*

$RESIZE:ON

DIM handsheet AS INTEGER '      clock hand sprite sheet
DIM hour AS INTEGER '           hour hand sprite
DIM minute AS INTEGER '         minute hand sprite
DIM second AS INTEGER '         second hand sprite
DIM face AS LONG '              clock face image
DIM h, m, s AS INTEGER '        current hour. minute, second values
DIM current, temp AS LONG '     current SL_SCREEN and a temp screen
DIM square, center AS INTEGER ' width, height, and center of screen
DIM zoom AS INTEGER '           zoom level of sprites
DIM frame AS INTEGER '          frame counter
DIM olds AS INTEGER '           the previous second

square = 551
center = 276
SL_SCREEN square, square, 1 '                                                                           set window size and layers
_DELAY .2 '                                                                                             need to wait for _RESIZE below
temp = _RESIZE '                                                                                        clear resize flag
_TITLE "Sprite Library Clock Demo" '                                                                    give window a title
handsheet = SL_NEW_SHEET("hands73x533.png", 73, 533, SL_SET, _RGB32(255, 0, 255)) '                     load the clock hands
hour = SL_NEW_SPRITE(1, handsheet, 2, SL_HARDWARE, SL_NOSAVE) '                                         get the hour hand
minute = SL_NEW_SPRITE(1, handsheet, 1, SL_HARDWARE, SL_NOSAVE) '                                       get the minute hand
second = SL_NEW_SPRITE(1, handsheet, 3, SL_HARDWARE, SL_NOSAVE) '                                       get the second hand
face = _LOADIMAGE("face.png", 32) '                                                                     load the clock face
_PUTIMAGE , face '                                                                                      display the clock face
SL_SET_FRAMERATE 6 '                                                                                    set the global frame rate (must be 6 FPS)
DO
    _LIMIT SL_GET_FRAMERATE '                                                                           maintain global frame rate
    h = VAL(TIME$) '                                                                                    get current hour value
    IF h > 11 THEN h = h - 12 '                                                                         keep a 12 hour clock
    m = VAL(MID$(TIME$, 4, 2)) '                                                                        get current minute value
    s = VAL(MID$(TIME$, 7, 2)) '                                                                        get current second value
    frame = frame + 1 '                                                                                 increment frame counter
    IF s <> olds THEN '                                                                                 new second?
        frame = 0 '                                                                                     yes, reset frame counter
        olds = s '                                                                                      remember this second value
    END IF
    SL_ROTATE_SPRITE hour, 30 * h + m \ 2 '                                                             rotate hour hand into position
    SL_ROTATE_SPRITE minute, 6 * m + s \ 10 '                                                           rotate minute hand into position
    SL_ROTATE_SPRITE second, 6 * s + frame '                                                            rotate second hand into position
    SL_PUT_SPRITE center, center, hour '                                                                display the hour hand
    SL_PUT_SPRITE center, center, minute '                                                              display the minute hand
    SL_PUT_SPRITE center, center, second '                                                              display the second hand
    IF _RESIZE THEN '                                                                                   did user resize screen?
        current = _SOURCE '                                                                             yes, get the current screen pointer
        temp = _COPYIMAGE(_SOURCE, 32) '                                                                make a copy of the current screen
        SCREEN temp '                                                                                   make the copy active
        _FREEIMAGE current '                                                                            free the old current screen
        SL_SCREEN _RESIZEWIDTH, _RESIZEWIDTH, 1 '                                                       create the new current screen (square _RESIZEWIDTH)
        _PUTIMAGE (0, 0)-(_WIDTH(_SOURCE) - 1, _HEIGHT(_SOURCE) - 1), face '                            stretch the clock face onto it
        _FREEIMAGE temp '                                                                               no longer need copy of old current screen
        zoom = _WIDTH(_SOURCE) / square * 100 '                                                         calculate sprite zoom level
        SL_SET_ZOOM hour, zoom '                                                                        zoom the sprites to match new dimensions
        SL_SET_ZOOM minute, zoom
        SL_SET_ZOOM second, zoom
        center = _WIDTH(_SOURCE) \ 2 '                                                                  new center point for clock hands
    END IF
    SL_DISPLAY '                                                                                        merge layers and display
LOOP UNTIL _KEYHIT '                                                                                    leave when key hit
SL_FREE_SPRITE hour '                                                                                   free sprites from memory
SL_FREE_SPRITE minute
SL_FREE_SPRITE second
'SL_FREE_SHEET handsheet '                                                                              free sprite sheet images (coming soon)
SYSTEM '                                                                                                return to OS


'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴
'                                                                       ----------==========                ==========----------
'                                                                       ----------========== LAYER ROUTINES ==========----------
'                                                                       ----------==========                ==========----------
'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_SCREEN (swidth AS INTEGER, sheight AS INTEGER, layers AS INTEGER) '                                                                                                                    SL_SCREEN
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_layer() AS SL_LAYERS '    master layer array
    SHARED SL_global AS SL_GLOBAL '     common globals array

    ' declare local variables

    DIM layer AS INTEGER '              layer counter

    ' perform error checks

    IF layers < 1 THEN '                                                                                creating at least one layer?
        SL_error "SL_SCREEN", 26, "" '                                                                  no, report error to programmer
    END IF

    REDIM SL_layer(layers) AS SL_LAYERS '                                                               increase layer array to match requested number of layers
    SL_global.swidth = swidth '                                                                         set screen width
    SL_global.sheight = sheight '                                                                       set screen height
    layer = 0 '                                                                                         reset layer counter

    DO '                                                                                                cycle through layers
        SL_layer(layer).image = _NEWIMAGE(swidth, sheight, 32) '                                        create layer software image
        SL_layer(layer).visible = -1 '                                                          (TRUE)  layer is visible
        layer = layer + 1 '                                                                             increment layer counter
    LOOP UNTIL layer = UBOUND(SL_layer) + 1 '                                                           leave when all layers created

    SL_SET_DESTINATION_LAYER 1 '                                                                        set destination layer
    SL_SET_SOURCE_LAYER 1 '                                                                             set source layer
    SCREEN SL_layer(0).image '                                                                          initialize layer 0 working screen

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_DISPLAY () '                                                                                                                                                                          SL_DISPLAY
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_layer() AS SL_LAYERS '    master layer array
    SHARED SL_global AS SL_GLOBAL '     common globals array

    ' declare local variables

    DIM layer AS INTEGER '              layer counter
    DIM odest AS INTEGER '              original destination
    DIM merge AS LONG '                 software image to merge all layers onto
    DIM hardware AS LONG '              hardware image of merged layers to place on working screen

    SL_update_auto_sprites -1 '                                                          (SL_SOFTWARE)  update all software automatic sprites
    'odest = _DEST '                                                                                     save original destination
    _DEST SL_layer(0).image '                                                                           working screen is destination
    _SOURCE SL_layer(0).image
    merge = _NEWIMAGE(SL_global.swidth, SL_global.sheight, 32) '                                        create screen to merge layers
    layer = UBOUND(SL_layer) '                                                                          reset layer counter

    DO '                                                                                                cycle through layers backwards (high to low)
        IF SL_layer(layer).visible THEN '                                                               is this layer visible?
            _PUTIMAGE , SL_layer(layer).image, merge '                                                  merge this layer
        END IF
        layer = layer - 1 '                                                                             decrement layer counter
    LOOP UNTIL layer = 0 '                                                                              leave when all layers merged

    hardware = _COPYIMAGE(merge, 33) '                                                                  create hardware image of merged layers
    _PUTIMAGE , hardware '                                                                              place hardware image on working screen
    _FREEIMAGE merge '                                                                                  merged software image no longer needed
    _FREEIMAGE hardware '                                                                               merged hardware image no longer needed
    SL_update_auto_sprites 0 '                                                           (SL_HARDWARE)  update all hardware automatic sprites

    '_DEST odest '                                                                                       restore original destination
    _DISPLAY '                                                                                          update display screen with changes

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_SET_DESTINATION_LAYER (layer AS INTEGER) '                                                                                                                              SL_SET_DESTINATION_LAYER
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_layer() AS SL_LAYERS '    master layer array
    SHARED SL_global AS SL_GLOBAL '     common globals array

    ' perform error checks

    IF layer <> -32767 THEN '                                                               (SL_RESET)  reset to working image?
        IF NOT SL_VALID_LAYER(layer) THEN '                                                             no, valid layer?
            SL_error "SL_SET_DESTINATION_LAYER", 25, "" '                                               no, report error to programmer
        ELSE '                                                                                          yes, valid layer
            _DEST SL_layer(layer).image '                                                               set destination as layer software image
            SL_global.destination = layer '                                                             save new destination layer
        END IF
    ELSE '                                                                                              yes, reset layer
        _DEST SL_layer(1).image '                                                                       set destination as layer 1 software image
        SL_global.destination = 1 '                                                                     save new destination layer
    END IF

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_SET_SOURCE_LAYER (layer AS INTEGER) '                                                                                                                                        SL_SET_SOURCE_LAYER
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_layer() AS SL_LAYERS '    master layer array
    SHARED SL_global AS SL_GLOBAL '     common globals array

    ' perform error checks

    IF layer <> -32767 THEN '                                                               (SL_RESET)  reset to working image?
        IF NOT SL_VALID_LAYER(layer) THEN '                                                             no, valid layer?
            SL_error "SL_SET_SOURCE_LAYER", 25, "" '                                                    no, report error to programmer
        ELSE '                                                                                          yes, valid layer
            _SOURCE SL_layer(layer).image '                                                             set source as layer software image
            SL_global.source = layer '                                                                  save new source layer
        END IF
    ELSE '                                                                                              yes, reset layer
        _SOURCE SL_layer(1).image '                                                                     set source as layer 1 software image
        SL_global.source = 1 '                                                                          save new source layer
    END IF

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_DESTINATION_LAYER () '                                                                                                                                         SL_GET_DESTINATION_LAYER
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_global AS SL_GLOBAL '     common globals array

    SL_GET_DESTINATION_LAYER = SL_global.destination '                                                  return current destination layer

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_SOURCE_LAYER () '                                                                                                                                                   SL_GET_SOURCE_LAYER
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_global AS SL_GLOBAL '     common globals array

    SL_GET_SOURCE_LAYER = SL_global.source '                                                            return current source layer

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_CLEAR_LAYER (layer AS INTEGER) '                                                                                                                                                  SL_CLEAR_LAYER
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_layer() AS SL_LAYERS '    master layer array
    SHARED SL_global AS SL_GLOBAL '     common globals array

    ' declare local variables

    DIM layers AS INTEGER '             layer counter

    ' perform error checks

    IF layer <> -1 THEN '                                                                     (SL_ALL)  clear all layers?
        IF NOT SL_VALID_LAYER(layer) THEN '                                                             no, valid layer?
            SL_error "SL_CLEAR_LAYER", 25, "" '                                                         no, report error to programmer
        END IF
        _FREEIMAGE SL_layer(layer).image '                                                              free the layer's software image from memory
        SL_layer(layer).image = _NEWIMAGE(SL_global.swidth, SL_global.sheight, 32) '                    create a new software layer
    ELSE '                                                                                              yes, clear all layers
        layers = 0 '                                                                                    reset layer counter
        DO
            layers = layers + 1 '                                                                       increment layer counter
            _FREEIMAGE SL_layer(layers).image '                                                         free the layer's software image from memory
            SL_layer(layers).image = _NEWIMAGE(SL_global.swidth, SL_global.sheight, 32) '               create a new software layer
        LOOP UNTIL layers = UBOUND(SL_layer) '                                                          leave when all layers cleared
    END IF

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_VALID_LAYER (layer AS INTEGER) '                                                                                                                                             SL_VALID_LAYER
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_layer() AS SL_LAYERS '    master layer array

    IF layer < 1 OR layer > UBOUND(SL_layer) THEN '                                                     valid layer?
        SL_VALID_LAYER = 0 '                                                                   (FALSE)  no, return invalid
    ELSE '                                                                                              yes
        SL_VALID_LAYER = -1 '                                                                   (TRUE)  return valid
    END IF

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_SCREEN_WIDTH () '                                                                                                                                                           SL_SCREEN_WIDTH
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_global AS SL_GLOBAL '     common globals array

    SL_SCREEN_WIDTH = SL_global.swidth '                                                                return screen width

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_SCREEN_HEIGHT () '                                                                                                                                                         SL_SCREEN_HEIGHT
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_global AS SL_GLOBAL '     common globals array

    SL_SCREEN_HEIGHT = SL_global.sheight '                                                              return screen height

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_SET_LAYER_VISBILE (layer AS INTEGER, visible AS INTEGER) '                                                                                                                  SL_SET_LAYER_VISIBLE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_layer() AS SL_LAYERS '    master layer array

    ' perform error checks

    IF NOT SL_VALID_LAYER(layer) THEN '                                                                 no, valid layer?
        SL_error "SL_SET_LAYER_VISIBLE", 25, "" '                                                       no, report error to programmer
    END IF
    IF (visible < -1) OR (visible > 0) THEN '                                      (SL_SHOW & SL_HIDE)  valid visible behavior requested?
        SL_error "SL_SET_LAYER_VISIBLE", 20, "" '                                                       no, report error to programmer
    END IF

    SL_layer(layer).visible = visible '                                                                 set layer visibility

END SUB

'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴
'                                                                       ----------==========                ==========----------
'                                                                       ----------========== MOUSE ROUTINES ==========----------
'                                                                       ----------==========                ==========----------
'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_MOUSE (handle AS INTEGER) '                                                                                                                                                SL_GET_MOUSE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' declare local variables

    DIM sprite AS INTEGER '             sprite counter to cycle through array
    DIM event AS INTEGER '              -1 (TRUE) if an event was recorded

    ' perform error checks

    IF handle <> -1 THEN '                                                                    (SL_ALL)  check all sprites for mouse interaction?
        IF NOT SL_VALID_SPRITE(handle) THEN '                                                           no, is this a valid sprite?
            SL_error "SL_GET_MOUSE", 1, "" '                                                            no, report error to programmer
        END IF
        IF NOT SL_sprite(handle).visible THEN '                                                         is sprite visible?
            EXIT FUNCTION '                                                                             no, leave function
        END IF
    END IF
    IF handle = -1 THEN '                                                                     (SL_ALL)  check all sprites?
        sprite = 1 '                                                                                    yes, start with first index
    ELSE '                                                                                              no, check a single sprite
        sprite = handle '                                                                               start with that sprite
    END IF

    DO '                                                                                                cycle through sprite array
        IF SL_sprite(handle).inuse AND SL_sprite(handle).visible THEN '                                 is sprite in use and visible?
            SL_sprite(handle).mouse.event = 0 '                                                         yes, reset mouse settings
            SL_sprite(handle).mouse.x = 0
            SL_sprite(handle).mouse.y = 0
            SL_sprite(handle).mouse.xa = 0
            SL_sprite(handle).mouse.ya = 0
            WHILE _MOUSEINPUT: WEND '                                                                   get latest mouse information
            IF _MOUSEX >= SL_sprite(sprite).collision.x1 THEN '                                         is mouse pointer on sprite?
                IF _MOUSEX <= SL_sprite(sprite).collision.x2 THEN
                    IF _MOUSEY >= SL_sprite(sprite).collision.y1 THEN
                        IF _MOUSEY <= SL_sprite(sprite).collision.y2 THEN
                            event = -1 '                                                                yes, remember that an event occurred
                            SL_sprite(sprite).mouse.xa = _MOUSEX '                                      screen location of mouse x
                            SL_sprite(sprite).mouse.ya = _MOUSEY '                                      screen location of mouse y
                            SL_sprite(sprite).mouse.x = _MOUSEX - SL_sprite(sprite).x.actual '          sprite location of mouse x
                            SL_sprite(sprite).mouse.y = _MOUSEY - SL_sprite(sprite).y.actual '          sprite location of mouse y
                            IF _MOUSEBUTTON(1) THEN '                                                   is left button clicked?
                                SL_GET_MOUSE = 2 '                                      (SL_LEFTCLICK)  yes, return value
                                SL_sprite(sprite).mouse.event = 2 '                     (SL_LEFTCLICK)  record mouse event
                            ELSEIF _MOUSEBUTTON(2) THEN '                                               no, is right button clicked?
                                SL_GET_MOUSE = 3 '                                     (SL_RIGHTCLICK)  yes, return value
                                SL_sprite(sprite).mouse.event = 3 '                    (SL_RIGHTCLICK)  record mouse event
                            ELSEIF _MOUSEBUTTON(3) THEN '                                               no, is center button clicked?
                                SL_GET_MOUSE = 4 '                                    (SL_CENTERCLICK)  yes, return value
                                SL_sprite(sprite).mouse.event = 4 '                   (SL_CENTERCLICK)  record mouse event
                            ELSE '                                                                      no, mouse is just hovering
                                SL_GET_MOUSE = 1 '                                          (SL_HOVER)  return value
                                SL_sprite(sprite).mouse.event = 1 '                         (SL_HOVER)  record mouse event
                            END IF
                        END IF
                    END IF
                END IF
            END IF
        END IF
        sprite = sprite + 1 '                                                                           increment sprite counter
    LOOP UNTIL sprite = (UBOUND(SL_sprite) + 1) OR (handle = -1) '                                      leave when full array or single sprite checked

    IF handle = -1 THEN '                                                                     (SL_ALL)  were all sprites checked?
        IF event THEN '                                                                                 yes, was there an event with any of them?
            SL_GET_MOUSE = -1 '                                                                 (TRUE)  return that an event occurred
        ELSE '                                                                                          no events recorded
            SL_GET_MOUSE = 0 '                                                                 (FALSE)  return that no events occurred
        END IF
    END IF

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_MOUSE_EVENT (handle AS INTEGER) '                                                                                                                                    SL_GET_MOUSE_EVENT
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_MOUSE_EVENT", 1, "" '                                                          no, report error to programmer
    END IF

    SL_GET_MOUSE_EVENT = SL_sprite(handle).mouse.event '                                                return mouse event
    SL_sprite(handle).mouse.event = 0 '                                                                 reset now that value retrieved

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_MOUSE_SPRITEX (handle AS INTEGER) '                                                                                                                                SL_GET_MOUSE_SPRITEX
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_MOUSE_SPRITEX", 1, "" '                                                        no, report error to programmer
    END IF

    SL_GET_MOUSE_SPRITEX = SL_sprite(handle).mouse.x '                                                  return x value of mouse on sprite
    SL_sprite(handle).mouse.x = 0 '                                                                     reset now that value retrieved

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_MOUSE_SPRITEY (handle AS INTEGER) '                                                                                                                                SL_GET_MOUSE_SPRITEY
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_MOUSE_SPRITEY", 1, "" '                                                        no, report error to programmer
    END IF

    SL_GET_MOUSE_SPRITEY = SL_sprite(handle).mouse.y '                                                  return y value of mouse on sprite
    SL_sprite(handle).mouse.y = 0 '                                                                     reset now that value retrieved

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_MOUSE_ACTUALX (handle AS INTEGER) '                                                                                                                                SL_GET_MOUSE_ACTUALX
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_MOUSE_ACTUALX", 1, "" '                                                        no, report error to programmer
    END IF

    SL_GET_MOUSE_ACTUALX = SL_sprite(handle).mouse.xa '                                                 return x value of mouse on screen
    SL_sprite(handle).mouse.xa = 0 '                                                                    reset now that value retrieved

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_MOUSE_ACTUALY (handle AS INTEGER) '                                                                                                                                SL_GET_MOUSE_ACTUALY
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_MOUSE_ACTUALY", 1, "" '                                                        no, report error to programmer
    END IF

    SL_GET_MOUSE_ACTUALY = SL_sprite(handle).mouse.ya '                                                 return y value of mouse on screen
    SL_sprite(handle).mouse.ya = 0 '                                                                    reset now that value retrieved

END FUNCTION

'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴
'                                                                     ----------==========                    ==========----------
'                                                                     ----------========== COLLISION ROUTINES ==========----------
'                                                                     ----------==========                    ==========----------
'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_COLLISION (handle1 AS INTEGER, handle2 AS INTEGER) '                                                                                                                   SL_GET_COLLISION
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' declare local variables

    DIM sprite AS INTEGER '             sprite counter in loop

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle1) THEN '                                                              is this a valid sprite?
        SL_error "SL_GET_COLLISION", 1, "" '                                                            no, report error to programmer
    END IF
    IF handle2 <> -1 THEN '                                                                   (SL_ALL)  check for collision with all sprites?
        IF NOT SL_VALID_SPRITE(handle2) THEN '                                                          no, is this a valid sprite?
            SL_error "SL_GET_COLLISION", 1, "" '                                                        no, report error to programmer
        END IF
        IF SL_sprite(handle2).collision.detect = 0 THEN '                                               collision detection turned on?
            SL_error "SL_GET_COLLISION", 22, "" '                                                       no, report error to programmer
        END IF
        'IF SL_sprite(handle1).collision.detect <> SL_sprite(handle2).collision.detect THEN '            both sprites use same detection method?
        '    SL_error "SL_GET_COLLISION", 23, "" '                                                       no, report error to programmer
        'END IF
    END IF
    IF SL_sprite(handle1).collision.detect = 0 THEN '                                                   collision detection turned on?
        SL_error "SL_GET_COLLISION", 21, "" '                                                           no, report error to programmer
    END IF

    SELECT CASE SL_sprite(handle1).collision.detect
        CASE 1 '                                                                              (SL_BOX)  box detection
            IF handle2 <> -1 THEN '                                                           (SL_ALL)  check all sprites for collision?
                SL_sprite(handle1).collision.box = SL_box_collision(SL_sprite(handle1).collision.x1,_
                                                                    SL_sprite(handle1).collision.y1,_
                                                                    SL_sprite(handle1).collision.cwidth,_
                                                                    SL_sprite(handle1).collision.cheight,_
                                                                    SL_sprite(handle2).collision.x2,_
                                                                    SL_sprite(handle2).collision.y2,_
                                                                    SL_sprite(handle2).collision.cwidth,_
                                                                    SL_sprite(handle2).collision.cheight) ' no, check for a box collision of two sprites
                IF SL_sprite(handle1).collision.box THEN '                                              was there a collision?
                    SL_sprite(handle1).collision.with = handle2 '                                       yes, record sprite that was collided with
                    SL_sprite(handle2).collision.with = handle1 '                                       tell the other sprite who it collided with
                    SL_GET_COLLISION = handle2 '                                                (TRUE)  return that a collision happened
                END IF
            ELSE '                                                                                      yes, check all sprites
                sprite = 0 '                                                                            reset sprite counter
                DO '                                                                                    cycle through sprite array
                    sprite = sprite + 1 '                                                               increment sprite counter
                    IF SL_sprite(sprite).inuse AND SL_sprite(sprite).collision.detect THEN '            is sprite in use and using collision detection?
                        SL_sprite(handle1).collision.box = SL_box_collision(SL_sprite(handle1).collision.x1,_
                                                                            SL_sprite(handle1).collision.y1,_
                                                                            SL_sprite(handle1).collision.cwidth,_
                                                                            SL_sprite(handle1).collision.cheight,_
                                                                            SL_sprite(sprite).collision.x2,_
                                                                            SL_sprite(sprite).collision.y2,_
                                                                            SL_sprite(sprite).collision.cwidth,_
                                                                            SL_sprite(sprite).collision.cheight) ' yes, check for a box collision of two sprites
                        IF SL_sprite(handle1).collision.box THEN '                                      box collision detected?
                            SL_sprite(handle1).collision.with = sprite '                                yes, record sprite that was collided with
                            SL_sprite(sprite).collision.with = handle1 '                                tell the other sprite who it collided with
                            SL_GET_COLLISION = sprite '                                         (TRUE)  return that collision happened
                            sprite = UBOUND(SL_sprite) '                                                no need to check further
                        END IF
                    END IF
                LOOP UNTIL sprite = UBOUND(SL_sprite) '                                                 leave when end of array reached
            END IF
        CASE 2 '                                                                            (SL_ROUND)  round collision
            IF handle2 <> -1 THEN '                                                           (SL_ALL)  check all sprites for collision?
                SL_sprite(handle1).collision.round = sl_round_collision(SL_sprite(handle1).x.int,_
                                                                        SL_sprite(handle1).y.int,_
                                                                        SL_sprite(handle1).collision.radius,_
                                                                        SL_SPRITE(handle2).x.int,_
                                                                        SL_sprite(handle2).y.int,_
                                                                        SL_sprite(handle2).collision.radius) ' no, check for a round collision of two sprites
                IF SL_sprite(handle1).collision.round THEN '                                            was there a collision?
                    SL_sprite(handle1).collision.with = handle2 '                                       yes, record sprite that was collided with
                    SL_sprite(handle2).collision.with = handle1 '                                       tell the other sprite who it collided with
                    SL_GET_COLLISION = handle2 '                                                (TRUE)  return that a collision happened
                END IF
            ELSE '                                                                                      yes, check all sprites
                sprite = 0 '                                                                            reset sprite counter
                DO '                                                                                    cycle through sprite array
                    sprite = sprite + 1 '                                                               increment sprite counter
                    IF SL_sprite(sprite).inuse AND SL_sprite(sprite).collision.detect THEN '            is sprite in use and using collision detection?
                        SL_sprite(handle1).collision.round = sl_round_collision(SL_sprite(handle1).x.int,_
                                                                                SL_sprite(handle1).y.int,_
                                                                                SL_sprite(handle1).collision.radius,_
                                                                                SL_sprite(sprite).x.int,_
                                                                                SL_sprite(sprite).y.int,_
                                                                                SL_sprite(sprite).collision.radius) ' yes, check for a round collision of two sprites
                        IF SL_sprite(handle1).collision.round THEN '                                    round collision detected?
                            SL_sprite(handle1).collision.with = sprite '                                yes, record sprite that was collided with
                            SL_sprite(sprite).collision.with = handle1 '                                tell the other sprite who it collided with
                            SL_GET_COLLISION = sprite '                                         (TRUE)  return that collision happened
                            sprite = UBOUND(SL_sprite) '                                                no need to check further
                        END IF
                    END IF
                LOOP UNTIL sprite = UBOUND(SL_sprite) '                                                 leave when end of array reached
            END IF
        CASE 3 '                                                                            (SL_PIXEL)  pixel perfect collision
            IF handle2 <> -1 THEN '                                                           (SL_ALL)  check all sprites for collision?
                SL_sprite(handle1).collision.pixel = SL_PIXEL_COLLISION(handle1, handle2) '             yes, check for a pixel collision of two sprites
                IF SL_sprite(handle1).collision.pixel THEN '                                            pixel collision detected?
                    SL_sprite(handle1).collision.with = handle2 '                                       yes, record sprite that was collided with
                    SL_sprite(handle2).collision.with = handle1 '                                       tell the other sprite who it collided with
                    SL_GET_COLLISION = handle2 '                                                (TRUE)  return that collision happened
                END IF
            ELSE '                                                                                      yes, check all sprites
                sprite = 0 '                                                                            reset sprite counter
                DO '                                                                                    cycle through sprite array
                    sprite = sprite + 1 '                                                               increment sprite counter
                    IF SL_sprite(sprite).inuse AND SL_sprite(sprite).collision.detect THEN '            is sprite in use and using collision detection? (may need to see if mask available too) <--------------- LOOK
                        SL_sprite(handle1).collision.pixel = SL_PIXEL_COLLISION(handle1, sprite) '      yes, check for a pixel collision of two sprites
                        IF SL_sprite(handle1).collision.pixel THEN '                                    pixel collision detected?
                            SL_sprite(handle1).collision.with = sprite '                                yes, record sprite that was collided with
                            SL_sprite(sprite).collision.with = handle1 '                                tell the other sprite who it collided with
                            SL_GET_COLLISION = sprite '                                         (TRUE)  return that collision happened
                            sprite = UBOUND(SL_sprite) '                                                no need to check further
                        END IF
                    END IF
                LOOP UNTIL sprite = UBOUND(SL_sprite) '                                                 leave when end of array reached
            END IF
    END SELECT

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_ROUND_COLLISION (x1 AS INTEGER, y1 AS INTEGER, r1 AS INTEGER, x2 AS INTEGER, y2 AS INTEGER, r2 AS INTEGER) '                                                             SL_ROUND_COLLISION
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    IF SL_GET_DISTANCE_POINT_TO_POINT(x1, y1, x2, y2) < r1 + r2 THEN '                                  is distance less than both radii added together?
        SL_ROUND_COLLISION = -1 '                                                               (TRUE)  yes, return a collision
    END IF

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_BOX_COLLISION (x1 AS INTEGER, y1 AS INTEGER, w1 AS INTEGER, h1 AS INTEGER, x2 AS INTEGER, y2 AS INTEGER, w2 AS INTEGER, h2 AS INTEGER) '                                   SL_BOX_COLLISION
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    IF x1 <= x2 + w2 THEN '                                                                             is x1 within box 2's width?
        IF x1 + w1 >= x2 THEN '                                                                         yes, is x2 within box 1's width?
            IF y1 <= y2 + h2 THEN '                                                                     yes, is y1 within box 2's height?
                IF y1 + h1 >= y2 THEN '                                                                 yes, is y2 within box 1's height?
                    SL_BOX_COLLISION = -1 '                                                     (TRUE)  yes, return a collision
                END IF
            END IF
        END IF
    END IF

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_PIXEL_COLLISION (handle1 AS INTEGER, handle2 AS INTEGER) '                                                                                                               SL_PIXEL_COLLISION
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' declare local variables

    DIM leftx AS INTEGER '              upper left x location of box collision area
    DIM rightx AS INTEGER '             lower right x location of box collision area
    DIM topy AS INTEGER '               upper left y location of box collision area
    DIM bottomy AS INTEGER '            lower right y location of box collision area
    DIM masks AS LONG '                 box collision area image to place masks
    DIM h1x AS INTEGER '                center point x offset for first sprite mask image
    DIM h2x AS INTEGER '                center point x offset for second sprite mask image
    DIM h1y AS INTEGER '                center point y offset for first sprite mask image
    DIM h2y AS INTEGER '                center point y offset for second sprite mask image
    DIM odest AS LONG '                 original destination
    DIM osource AS LONG '               original source
    DIM x AS INTEGER '                  counter to cycle through width of mask image
    DIM y AS INTEGER '                  counter to cycle throuogh height of mask image

    ' perform error checks

    IF (NOT SL_VALID_SPRITE(handle1)) OR (NOT SL_VALID_SPRITE(handle2)) THEN '                          are these valid sprites?
        SL_error "SL_PIXEL_COLLISION", 1, "" '                                                          no, report error to programmer
    END IF

    ' if there is no box collision then no need to check for pixel collision

    IF  SL_box_collision(SL_sprite(handle1).collision.x1, SL_sprite(handle1).collision.y1,_
                           SL_sprite(handle1).collision.cwidth, SL_sprite(handle1).collision.cheight,_
                           SL_sprite(handle2).collision.x2, SL_sprite(handle2).collision.y2,_
                           SL_sprite(handle2).collision.cwidth, SL_sprite(handle2).collision.cheight) THEN 'is there a box collision?
        leftx = SL_max(SL_sprite(handle1).collision.x1, SL_sprite(handle2).collision.x1) '              yes, get collision area coordinates
        rightx = SL_min(SL_sprite(handle1).collision.x1 + SL_sprite(handle1).collision.cwidth,_
                        SL_sprite(handle2).collision.x1 + SL_sprite(handle2).collision.cwidth)
        topy = SL_max(SL_sprite(handle1).collision.y1, SL_sprite(handle2).collision.y1)
        bottomy = SL_min(SL_sprite(handle1).collision.y1 + SL_sprite(handle1).collision.cheight,_
                         SL_sprite(handle2).collision.y1 + SL_sprite(handle2).collision.cheight)

        odest = _DEST '                                                                                 save original destination
        osource = _SOURCE '                                                                             save original source
        masks = _NEWIMAGE(rightx - leftx, bottomy - topy, 32) '                                         create image of same size to hold image masks
        h1x = SL_sprite(handle1).x.int - leftx '                                                        get image mask center point offsets from collision area upper left x,y
        h1y = SL_sprite(handle1).y.int - topy
        h2x = SL_sprite(handle2).x.int - leftx
        h2y = SL_sprite(handle2).y.int - topy
        _DEST masks '                                                                                   masks are to be drawn on new image
        _SOURCE masks '                                                                                 pixels are to be examined on new image
        _PUTIMAGE (-h1x, -h1y), SL_sprite(handle1).gfx.mask '                                           draw first sprite mask onto image
        _PUTIMAGE (-h2x, -h2y), SL_sprite(handle2).gfx.mask '                                           draw second sprite mask onto image
        x = 0 '                                                                                         reset width couonter

        DO '                                                                                            cycle through width of image
            y = 0 '                                                                                     reset height counter
            DO '                                                                                        cycle through height of image
                IF POINT(x, y) = _RGBA32(0, 0, 0, 0) THEN '                                             is this a black pixel? <----------------------------------- used saved clearcolor instead?  LOOK
                    SL_sprite(handle1).collision.with = handle2 '                                       yes, record sprite that was collided with
                    SL_sprite(handle2).collision.with = handle1 '                                       tell the other sprite who it collided with
                    SL_PIXEL_COLLISION = handle2 '                                              (TRUE)  return that collision happened
                    y = _HEIGHT(masks) - 1 '                                                            no need to continue loop
                    x = _WIDTH(masks) - 1 '                                                             no need to continue loop
                END IF
                y = y + 1 '                                                                             increment height counter
            LOOP UNTIL y = _HEIGHT(masks) '                                                             leave when full height cycled
            x = x + 1 '                                                                                 increment width counter
        LOOP UNTIL x = _WIDTH(masks) '                                                                  leave when full width cycled

        _SOURCE osource '                                                                               restore original source
        _DEST odest '                                                                                   restore original destination
        _FREEIMAGE masks '                                                                              mask image no longer needed
    END IF

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_SET_COLLISION (handle AS INTEGER, method AS INTEGER) '                                                                                                                          SL_SET_COLLISION
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_SET_COLLISION", 1, "" '                                                            no, report error to programmer
    END IF
    IF method = -32767 THEN '                                                               (SL_RESET)  reset collision detection?
        SL_sprite(handle).collision.detect = 0 '                                         (SL_NODETECT)  yes, reset detection
    ELSEIF method < 0 OR method > 3 THEN ' (SL_NODETECT, SL_BOXDETECT, SL_ROUNDDETECT, SL_PIXELDETECT)  invalid mode?
        SL_error "SL_SET_COLLISION", 24, "" '                                                           yes, report error to programmer
    ELSE '                                                                                              no
        SL_sprite(handle).collision.detect = method '                                                   set collision detection mode
    END IF

END SUB

'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴
'                                                                     ----------==========                    ==========----------
'                                                                     ----------========== ANIMATION ROUTINES ==========----------
'                                                                     ----------==========                    ==========----------
'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_SET_FRAMERATE (framerate AS INTEGER) '                                                                                                                                          SL_SET_FRAMERATE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array
    SHARED SL_global AS SL_GLOBAL

    ' declare local variables

    DIM handle AS INTEGER '             counter to cycle through sprite handles

    ' perform error checks

    IF framerate < 1 THEN '                                                                             valid frame rate?
        SL_error "SL_SET_FRAMERATE", 10, "" '                                                           no, report error to programmer
    END IF

    ' set local variables

    SL_global.framerate = framerate '                                                                   set global frame rate
    handle = 0 '                                                                                        reset handle counter

    DO '                                                                                                update all available sprites
        handle = handle + 1 '                                                                           increment sprite pointer
        IF SL_sprite(handle).inuse THEN '                                                               is this sprite in use?
            IF SL_sprite(handle).animation.framerate THEN '                                             yes, does it contain an animation frame rate?
                IF framerate < SL_sprite(handle).animation.framerate THEN '                             is new global frame rate less than sprite's frame rate?
                    SL_sprite(handle).animation.framerate = framerate '                                 yes, set sprite's frame rate to global frame rate
                END IF
                IF framerate = SL_sprite(handle).animation.framerate THEN '                             animation and global frame rates the same?
                    SL_sprite(handle).animation.skip = 0 '                                              yes, nothing needs to be done with frames
                ELSEIF SL_sprite(handle).animation.framerate >= framerate \ 2 THEN '                    no, sprite frame rate 1/2 or less of master frame rate?
                    SL_sprite(handle).animation.skip = framerate \ (framerate - SL_sprite(handle).animation.framerate) ' yes, calculate every frame to skip
                ELSE '                                                                                  no, sprite frame rate is greater than 1/2 of master frame rate
                    SL_sprite(handle).animation.skip = framerate \ SL_sprite(handle).animation.framerate ' calculate every frame to draw
                END IF
            END IF
        END IF
    LOOP UNTIL handle = UBOUND(SL_sprite) '                                                             leave when all sprites updated

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_FRAMERATE () '                                                                                                                                                         SL_GET_FRAMERATE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_global AS SL_GLOBAL

    SL_GET_FRAMERATE = SL_global.framerate '                                                            return global frame rate

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_NEXT_ANIMATION_CELL (handle AS INTEGER) '                                                                                                                                 SL_NEXT_ANIMATION_CELL
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array
    SHARED SL_sheet() AS SL_SHEET '     master sprite sheet array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_NEXT_ANIMATION_CELL", 1, "" '                                                      no, report error to programmer
    END IF
    IF NOT SL_sprite(handle).animation.cellfrom THEN '                                                  has animation been assigned to this sprite?
        SL_error "SL_NEXT_ANIMATION_CELL", 15, "" '                                                     no, report error to programmer
    END IF
    IF SL_sprite(handle).animation.auto THEN '                                                          is this sprite under auto animation control?
        SL_error "SL_NEXT_ANIMATION_CELL", 18, "" '                                                     yes, report error to programmer
    END IF

    SELECT CASE SL_sprite(handle).animation.mode '                                                      which animation mode is this sprite using?
        CASE 0 '                                                                          (SL_FORWARD)  move forward through the cells
            SL_sprite(handle).animation.cell = SL_sprite(handle).animation.cell + 1 '                   increment animation cell
            IF SL_sprite(handle).animation.cell > SL_sprite(handle).animation.cellto THEN '             passed the last cell?
                SL_sprite(handle).animation.cell = SL_sprite(handle).animation.cellfrom '               yes, go back to first cell
            END IF
        CASE 1 '                                                                         (SL_BACKWARD)  move backward through the cells
            SL_sprite(handle).animation.cell = SL_sprite(handle).animation.cell - 1 '                   decrement animation cell
            IF SL_sprite(handle).animation.cell < SL_sprite(handle).animation.cellfrom THEN '           passed the first cell?
                SL_sprite(handle).animation.cell = SL_sprite(handle).animation.cellto '                 yes, go back to last cell
            END IF
        CASE 2 '                                                                        (SL_BACKFORTH)  ping-pong back and forth through the cells
            SL_sprite(handle).animation.cell = SL_sprite(handle).animation.cell + SL_sprite(handle).animation.dir ' increment/decrement animation cell
            IF SL_sprite(handle).animation.cell = SL_sprite(handle).animation.cellto OR _
               SL_sprite(handle).animation.cell = SL_sprite(handle).animation.cellfrom THEN '           is this the first or last cell?
                SL_sprite(handle).animation.dir = -SL_sprite(handle).animation.dir '                    yes, reverse animation direction
            END IF
    END SELECT
    SL_sprite(handle).cell = SL_sprite(handle).animation.cell '                                         update current sprite cell
    IF SL_sprite(handle).rotation.angle AND (NOT SL_sprite(handle).rotation.auto) THEN '                is this animation currently rotated but not automatic?
        SL_ROTATE_SPRITE handle, SL_sprite(handle).rotation.angle '                                     yes, this new cell will need manually rotated as well
    ELSE '                                                                                              no rotation, but still needs image updated
        _FREEIMAGE SL_sprite(handle).gfx.software '                                                     remove current software image from memory
        SL_sprite(handle).gfx.software = _COPYIMAGE(SL_sheet(SL_sprite(handle).sheet, SL_sprite(handle).cell).software, 32) ' get new software image
        IF SL_sprite(handle).gfx.mask THEN '                                                            is there a mask with this image?
            _FREEIMAGE SL_sprite(handle).gfx.mask '                                                     yes, remove the software mask image from memory
            SL_sprite(handle).gfx.mask = _COPYIMAGE(SL_sheet(SL_sprite(handle).sheet, SL_sprite(handle).cell).mask, 32) ' get new software mask image
        END IF
    END IF

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_CHANGE_ANIMATION_CELLS (handle AS INTEGER, cellfrom AS INTEGER, cellto AS INTEGER) '                                                                                   SL_CHANGE_ANIMATION_CELLS
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array
    SHARED SL_sheet() AS SL_SHEET '     master sprite sheet array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_CHANGE_ANIMATION_CELLS", 1, "" '                                                   no, report error to programmer
    END IF
    IF NOT SL_sprite(handle).animation.cellfrom THEN '                                                  has animation been assigned to this sprite?
        SL_error "SL_CHANGE_ANIMATION_CELLS", 15, "" '                                                  no, report error to programmer
    END IF
    IF NOT SL_VALID_CELL(SL_sprite(handle).sheet, cellfrom) THEN '                                      no, is this a valid cell request?
        SL_error "SL_CHANGE_ANIMATION_CELLS", 13, "" '                                                  no, report error to rpogrammer
    END IF
    IF NOT SL_VALID_CELL(SL_sprite(handle).sheet, cellto) THEN '                                        is this valid cell request?
        SL_error "SL_CHANGE_ANIMATION_CELLS", 13, "" '                                                  no, report error to programmer
    END IF

    SL_sprite(handle).animation.cellfrom = cellfrom '                                                   set first cell in animation
    SL_sprite(handle).animation.cellto = cellto '                                                       set last cell in animation
    SL_sprite(handle).animation.cell = cellfrom '                                                       set current animation cell to first cell
    SL_sprite(handle).cell = cellfrom '                                                                 set current sprite cell to first cell

    IF SL_sprite(handle).animation.cellto < SL_sprite(handle).animation.cellfrom THEN '                 is cellto greater than cellfrom?
        SL_error "SL_CHANGE_ANIMATION_CELLS", 19, "" '                                                  no, report error to programmer
    END IF

    IF SL_sprite(handle).rotation.angle AND (NOT SL_sprite(handle).rotation.auto) THEN '                is this animation currently rotated but not automatic?
        SL_ROTATE_SPRITE handle, SL_sprite(handle).rotation.angle '                                     yes, this new cell will need manually rotated as well
    ELSE '                                                                                              no rotation, but still needs image updated
        _FREEIMAGE SL_sprite(handle).gfx.software '                                                     remove current software image from memory
        SL_sprite(handle).gfx.software = _COPYIMAGE(SL_sheet(SL_sprite(handle).sheet, SL_sprite(handle).cell).software, 32) ' get new software image
        IF SL_sprite(handle).gfx.mask THEN '                                                            is there a mask with this image?
            _FREEIMAGE SL_sprite(handle).gfx.mask '                                                     yes, remove the software mask image from memory
            SL_sprite(handle).gfx.mask = _COPYIMAGE(SL_sheet(SL_sprite(handle).sheet, SL_sprite(handle).cell).mask, 32) ' get new software mask image
        END IF
    END IF

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_CHANGE_ANIMATION_FRAMERATE (handle AS INTEGER, framerate AS INTEGER) '                                                                                             SL_CHANGE_ANIMATION_FRAMERATE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array
    SHARED SL_global AS SL_GLOBAL '     common globals array

    ' perform error checks

    IF framerate < 1 OR framerate > SL_global.framerate THEN '                                          valid frame rate supplied?
        SL_error "SL_CHANGE_ANIMATION_FRAMERATE", 11, "" '                                              no, report error to programmer
    END IF

    SL_sprite(handle).animation.framerate = framerate '                                                 save sprite frame rate
    IF SL_global.framerate = framerate THEN '                                                           animation and global frame rates the same?
        SL_sprite(handle).animation.skip = 0 '                                                          yes, nothing needs to be done with frames
    ELSEIF framerate >= SL_global.framerate \ 2 THEN '                                                  no, sprite frame rate 1/2 or less of master frame rate?
        SL_sprite(handle).animation.skip = SL_global.framerate \ (SL_global.framerate - framerate) '    yes, calculate every frame to skip
    ELSE '                                                                                              no, sprite frame rate is greater than 1/2 of master frame rate
        SL_sprite(handle).animation.skip = SL_global.framerate \ framerate '                            calculate every frame to draw
    END IF

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_CHANGE_AUTOANIMATION (handle AS INTEGER, auto AS INTEGER) '                                                                                                              SL_CHANGE_AUTOANIMATION
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_CHANGE_AUTOANIMATION", 1, "" '                                                     no, report error to programmer
    END IF
    IF auto < -1 OR auto > 0 THEN '                                                                     valid auto animation value?
        SL_error "SL_CHANGE_ANIMATION", 14, "" '                                                        no, report error to programmer
    END IF

    SL_sprite(handle).animation.auto = auto '                                     (SL_START & SL_STOP)  set auto-animation

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_SET_ANIMATION (handle AS INTEGER, cellfrom AS INTEGER, cellto AS INTEGER, mode AS INTEGER, framerate AS INTEGER, auto AS INTEGER) '                                             SL_SET_ANIMATION
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array
    SHARED SL_global AS SL_GLOBAL '     common globals array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_SET_ANIMATION", 1, "" '                                                            no, report error to programmer
    END IF
    IF framerate < 1 OR framerate > SL_global.framerate THEN '                                          valid frame rate supplied?
        SL_error "SL_SET_ANIMATION", 11, "" '                                                           no, report error to programmer
    END IF
    IF mode < 0 OR mode > 2 THEN '                                                                      valid animation mode supplied?
        SL_error "SL_SET_ANIMATION", 12, "" '                                                           no, report error to programmer
    END IF
    IF cellfrom <> -1 THEN '                                                          (SL_CURRENTCELL)  is the current cell being requested for cellfrom?
        IF cellfrom < 1 OR (NOT SL_VALID_CELL(SL_sprite(handle).sheet, cellfrom)) THEN '                no, is this a valid cell request? <----------------------------- line need modified?   LOOK
            SL_error "SL_SET_ANIMATION", 13, "" '                                                       no, report error to rpogrammer
        END IF
    END IF
    IF cellto < 1 OR (NOT SL_VALID_CELL(SL_sprite(handle).sheet, cellto)) THEN '                        is this valid cell request?
        SL_error "SL_SET_ANIMATION", 13, "" '                                                           no, report error to programmer
    END IF
    IF auto < -1 OR auto > 0 THEN '                                                                     valid auto animation value?
        SL_error "SL_SET_ANIMATION", 14, "" '                                                           no, report error to programmer
    END IF

    IF cellfrom = -1 THEN '                                                           (SL_CURRENTCELL)  use current cell as start cell?
        SL_sprite(handle).animation.cellfrom = SL_sprite(handle).animation.cell '                       yes, set first cell as current cell
    ELSE '                                                                                              no
        SL_sprite(handle).animation.cell = cellfrom '                                                   set starting cell
        SL_sprite(handle).animation.cellfrom = cellfrom '                                               set first cell in animation
    END IF
    SL_sprite(handle).animation.cellto = cellto '                                                       set last cell in animation

    IF cellto <= cellfrom THEN '                                                                        is cellto greater than cellfrom?
        SL_error "SL_SET_ANIMATION", 19, "" '                                                           no, report error to programmer
    END IF

    SL_sprite(handle).animation.framerate = framerate '                                                 save sprite frame rate
    IF SL_global.framerate = framerate THEN '                                                           animation and global frame rates the same?
        SL_sprite(handle).animation.skip = 0 '                                                          yes, nothing needs to be done with frames
    ELSEIF framerate >= SL_global.framerate \ 2 THEN '                                                  no, sprite frame rate 1/2 or less of master frame rate?
        SL_sprite(handle).animation.skip = SL_global.framerate \ (SL_global.framerate - framerate) '    yes, calculate every frame to skip
    ELSE '                                                                                              no, sprite frame rate is greater than 1/2 of master frame rate
        SL_sprite(handle).animation.skip = SL_global.framerate \ framerate '                            calculate every frame to draw
    END IF
    SL_sprite(handle).animation.frame = 0 '                                                             reset skip frame counter
    SL_sprite(handle).animation.mode = mode '                (SL_FORWARD & SL_BACKWARD & SL_BACKFORTH)  set animation mode
    IF mode = 0 OR mode = 2 THEN '                                        (SL_FORWARD or SL_BACKFORTH)  forward or back and forth?
        SL_sprite(handle).animation.dir = 1 '                                                           yes, set animation direction forward
    ELSE '                                                                               (SL_BACKWARD)  no, backward
        SL_sprite(handle).animation.dir = -1 '                                                          set animation direction backward
    END IF
    SL_sprite(handle).animation.auto = auto '                                     (SL_START & SL_STOP)  set auto-animation

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_CELL (handle AS INTEGER) '                                                                                                                                                  SL_GET_CELL
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_CELL", 1, "" '                                                                 no, report error to programmer
    END IF

    SL_GET_CELL = SL_sprite(handle).animation.cell '                                                    return animation cell of this sprite < --------------------- animation or sprite cell?   LOOK

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_VALID_CELL (sheet AS INTEGER, cell AS INTEGER) '                                                                                                                              SL_VALID_CELL
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sheet() AS SL_SHEET '    master sprite sheet array

    IF NOT SL_VALID_SHEET(sheet) THEN '                                                                 is this a valid sheet?
        SL_error "SL_VALID_CELL", 5, "" '                                                               no, report error to programmer
    END IF

    IF (cell < 1) OR (cell > UBOUND(SL_sheet, 2)) THEN '                                                is cell withing range of cells on sheet?
        SL_VALID_CELL = 0 '                                                                    (FALSE)  no, return false for invalid cell
    ELSE '                                                                                              yes, within total cells
        SL_VALID_CELL = -1 '                                                                    (TRUE)  return true for valid cell
    END IF

END FUNCTION

'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴
'                                                                       ----------==========                 ==========----------
'                                                                       ----------========== MOTION ROUTINES ==========----------
'                                                                       ----------==========                 ==========----------
'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_REVERSE_MOTIONX (handle AS INTEGER) '                                                                                                                                         SL_REVERSE_MOTIONX
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_REVERSE_MOTIONX", 1, "" '                                                          no, report error to programmer
    END IF

    SL_sprite(handle).x.dir = -SL_sprite(handle).x.dir '                                                reverse x motion direction

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_REVERSE_MOTIONY (handle AS INTEGER) '                                                                                                                                         SL_REVERSE_MOTIONY
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_REVERSE_MOTIONY", 1, "" '                                                          no, report error to programmer
    END IF

    SL_sprite(handle).y.dir = -SL_sprite(handle).y.dir '                                                reverse y motion direction

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_MOTIONX (handle AS INTEGER) '                                                                                                                                            SL_GET_MOTIONX
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_MOTIONX", 1, "" '                                                              no, report error to programmer
    END IF

    SL_GET_MOTIONX = SL_sprite(handle).x.dir '                                                          return x motion direction

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_MOTIONY (handle AS INTEGER) '                                                                                                                                            SL_GET_MOTIONY
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_MOTIONY", 1, "" '                                                              no, report error to programmer
    END IF

    SL_GET_MOTIONY = SL_sprite(handle).y.dir '                                                          return y motion direction

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_SET_MOTIONX (handle AS INTEGER, xdir AS SINGLE) '                                                                                                                                 SL_SET_MOTIONX
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_SET_MOTIONX", 1, "" '                                                              no, report error to programmer
    END IF

    SL_sprite(handle).x.dir = xdir '                                                                    set x motion direction

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_SET_MOTIONY (handle AS INTEGER, ydir AS SINGLE) '                                                                                                                                 SL_SET_MOTIONY
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_SET_MOTIONY", 1, "" '                                                              no, report error to programmer
    END IF

    SL_sprite(handle).y.dir = ydir '                                                                    set y motion direction

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_UPDATE_MOTION (handle AS INTEGER) '                                                                                                                                             SL_UPDATE_MOTION
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_UPDATE_MOTION", 1, "" '                                                            no, report error to programmer
    END IF
    IF SL_sprite(handle).motion.auto THEN '                                                             attempt to move sprite under automatic control?
        SL_error "SL_UPDATE_MOTION", 16, "" '                                                           yes, report error to programmer
    END IF

    SL_sprite(handle).x.real = SL_sprite(handle).x.real + SL_sprite(handle).x.dir '                     update x location
    SL_sprite(handle).y.real = SL_sprite(handle).y.real + SL_sprite(handle).y.dir '                     update y location
    SL_PUT_SPRITE SL_sprite(handle).x.real, SL_sprite(handle).y.real, handle '                          update sprite location

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_SET_MOTION (handle AS INTEGER, degrees AS INTEGER, speed AS SINGLE, auto AS INTEGER) '                                                                                            SL_SET_MOTION
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_SET_MOTION", 1, "" '                                                               no, report error to programmer
    END IF
    IF auto < -1 OR auto > 0 THEN '                                               (SL_START & SL_STOP)  valid on/off switch supplied?
        SL_error "SL_SET_MOTION", 7, "" '                                                               no, report error to programmer
    END IF

    SL_sprite(handle).motion.speed = speed '                                                            set motion speed of sprite
    SL_CHANGE_MOTION_DIRECTION handle, SL_FIX_DEGREES(degrees) '                                        set motion angle of sprite
    SL_sprite(handle).motion.auto = auto '                                        (SL_START & SL_STOP)  set auto-motion of sprite

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_CHANGE_MOTION_DIRECTION (handle AS INTEGER, degrees AS INTEGER) '                                                                                                     SL_CHANGE_MOTION_DIRECTION
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' delcare local variables

    DIM degree AS INTEGER '             degree angle passed in

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_CHANGE_MOTION_DIRECTION", 1, "" '                                                  no, report error to programmer
    END IF

    degree = SL_FIX_DEGREES(degrees) '                                                                  get degree angle passed in
    SL_sprite(handle).motion.angle = degree '                                                           set motion degree angle
    SL_sprite(handle).x.dir = SIN(degree * .017453292) * SL_sprite(handle).motion.speed '               calculate x vector
    SL_sprite(handle).y.dir = -COS(degree * .017453292) * SL_sprite(handle).motion.speed '              calculate y vector

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_MOTION_DIRECTION (handle AS INTEGER) '                                                                                                                          SL_GET_MOTION_DIRECTION
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_MOTION_DIRECTION", 1, "" '                                                     no, report error to programmer
    END IF

    SL_GET_MOTION_DIRECTION = SL_sprite(handle).motion.angle '                                          return direction sprite currently set to

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_CHANGE_MOTION_SPEED (handle AS INTEGER, speed AS SINGLE) '                                                                                                                SL_CHANGE_MOTION_SPEED
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_CHANGE_MOTION_SPEED", 1, "" '                                                      no, report error to programmer
    END IF

    SL_sprite(handle).motion.speed = speed '                                                            set sprite motion speed
    SL_sprite(handle).x.dir = SIN(SL_sprite(handle).motion.angle * .017453292) * speed '                calculate x vector
    SL_sprite(handle).y.dir = -COS(SL_sprite(handle).motion.angle * .017453292) * speed '               calculate y vector

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_MOTION_SPEED (handle AS INTEGER) '                                                                                                                                  SL_GET_MOTION_SPEED
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_MOTION_SPEED", 1, "" '                                                         no, report error to programmer
    END IF

    SL_GET_MOTION_SPEED = SL_sprite(handle).motion.speed '                                              return current sprite motion speed

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_CHANGE_AUTOMOTION (handle AS INTEGER, auto AS INTEGER) '                                                                                                                    SL_CHANGE_AUTOMOTION
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_CHANGE_AUTOMOTION", 1, "" '                                                        no, report error to programmer
    END IF
    IF auto = -32767 THEN '                                                                 (SL_RESET)  reset auto motion?
        SL_sprite(handle).motion.auto = 0 '                                                  (SL_STOP)  yes, turn auto motion off
    ELSEIF auto < -1 OR auto > 0 THEN '                                           (SL_START & SL_STOP)  valid on/off switch supplied?
        SL_error "SL_CHANGE_AUTOMOTION", 7, "" '                                                        no, report error to programmer
    ELSE '                                                                                              yes
        SL_sprite(handle).motion.auto = auto '                                          (TRUE & FALSE)  set auto motion status
    END IF

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_AUTOMOTION (handle AS INTEGER) '                                                                                                                                      SL_GET_AUTOMOTION
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_AUTOMOTION", 1, "" '                                                           no, report error to programmer
    END IF

    SL_GET_AUTOMOTION = SL_sprite(handle).motion.auto '                                 (TRUE & FALSE)  return auto motion status

END FUNCTION

'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴
'                                                                      ----------==========                   ==========----------
'                                                                      ----------========== ROTATION ROUTINES ==========----------
'                                                                      ----------==========                   ==========----------
'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_UPDATE_ROTATION (handle AS INTEGER) '                                                                                                                                         SL_UPDATE_ROTATION
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_UPDATE_ROTATION", 1, "" '                                                          no, report error to programmer
    END IF
    IF SL_sprite(handle).rotation.auto THEN '                                                           attempt to rotate sprite under automatic control?
        SL_error "SL_UPDATE_ROTATION", 17, "" '                                                         yes, report error to programmer
    END IF

    SL_ROTATE_SPRITE handle, SL_sprite(handle).rotation.angle + SL_sprite(handle).rotation.speed '      rotate sprite to next degree angle
    SL_PUT_SPRITE SL_sprite(handle).x.real, SL_sprite(handle).y.real, handle '                          update sprite rotation

END SUB


'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_SET_ROTATION (handle AS INTEGER, degrees AS INTEGER, speed AS INTEGER, auto AS INTEGER) '                                                                                        SL_SET_ROTATION
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_SET_ROTATION", 1, "" '                                                             no, report error to programmer
    END IF
    IF auto < -1 OR auto > 0 THEN '                                               (SL_START & SL_STOP)  valid on/off switch supplied?
        SL_error "SL_SET_ROTATION", 8, "" '                                                             no, report error to programmer
    END IF
    IF ABS(degrees) > 359 THEN '                                                                        degree requested between -359 and 359?
        SL_error "SL_SET_ROTATION", 9, "" '                                                             no, report error to programmer
    END IF

    SL_sprite(handle).rotation.speed = speed '                                                          set rotation speed
    SL_ROTATE_SPRITE handle, degrees '                                                                  set start angle
    SL_sprite(handle).rotation.auto = auto '                                                            set auto-rotation

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_CHANGE_AUTOROTATION (handle AS INTEGER, auto AS INTEGER) '                                                                                                                SL_CHANGE_AUTOROTATION
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_CHANGE_AUTOROTATION", 1, "" '                                                      no, report error to programmer
    END IF
    IF auto = -32767 THEN '                                                                 (SL_RESET)  reset auto rotate?
        SL_sprite(handle).rotation.auto = 0 '                                                  (FALSE)  yes, turn auto rotation off
    ELSEIF auto < -1 OR auto > 0 THEN '                                           (SL_START & SL_STOP)  valid on/off switch supplied?
        SL_error "SL_CHANGE_AUTOROTATION", 8, "" '                                                      no, report error to programmer
    ELSE '                                                                                              yes
        SL_sprite(handle).rotation.auto = auto '                                        (TRUE & FALSE)  set auto rotation status
    END IF

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_AUTOROTATION (handle AS INTEGER) '                                                                                                                                  SL_GET_AUTOROTATION
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_AUTOROTATION", 1, "" '                                                         no, report error to programmer
    END IF

    SL_GET_AUTOROTATION = SL_sprite(handle).rotation.auto '                             (TRUE & FALSE)  return auto rotation status

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_CHANGE_ROTATION_SPEED (handle AS INTEGER, degrees AS INTEGER) '                                                                                                         SL_CHANGE_ROTATION_SPEED
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_CHANGE_ROTATION_SPEED", 1, "" '                                                    no, report error to programmer
    END IF
    IF degrees = -32767 THEN '                                                              (SL_RESET)  reset requested?
        SL_sprite(handle).rotation.speed = 0 '                                               (SL_STOP)  turn auto spin off
    ELSEIF ABS(degrees) > 359 THEN '                                                                    degree requested between -359 and 359?
        SL_error "SL_CHANGE_ROTATION_SPEED", 9, "" '                                                    no, report error to programmer
    ELSE '                                                                                              yes
        SL_sprite(handle).rotation.speed = degrees '                                                    set sprite spin rate
    END IF

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_ROTATION_SPEED (handle AS INTEGER) '                                                                                                                              SL_GET_ROTATION_SPEED
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_ROTATION_SPEED", 1, "" '                                                       no, report error to programmer
    END IF

    SL_GET_ROTATION_SPEED = SL_sprite(handle).rotation.speed '                                          return current sprite spin rate

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_ROTATE_SPRITE (handle AS INTEGER, degrees AS INTEGER) '                                                                                                                         SL_ROTATE_SPRITE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sheet() AS SL_SHEET '     master sprite sheet array
    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array
    SHARED SL_angle() AS SL_ANGLE '     master rotation array

    ' declare local variables

    DIM sw AS INTEGER '                 width of sprite to be drawn
    DIM sh AS INTEGER '                 height of sprite to be drawn
    DIM rw AS INTEGER '                 precalculated rotated sprite width
    DIM rh AS INTEGER '                 precalculated rotated sprite height
    DIM px0 AS INTEGER '                precalculated triangular coordinates
    DIM px1 AS INTEGER
    DIM px2 AS INTEGER
    DIM px3 AS INTEGER
    DIM py0 AS INTEGER
    DIM py1 AS INTEGER
    DIM py2 AS INTEGER
    DIM py3 AS INTEGER
    DIM image AS LONG '                 software sprite image
    DIM mask AS LONG '                  software sprite image mask
    DIM degree AS INTEGER '             angle of rotation

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_ROTATE_SPRITE", 1, "" '                                                            no, report error to programmer
    END IF

    ' check if rotation necessary

    degree = SL_FIX_DEGREES(degrees) '                                                                  correct degree angle if needed

    ' get default images and dimensions from sprite sheet

    image = SL_sheet(SL_sprite(handle).sheet, SL_sprite(handle).cell).software '                        get image from sprite sheet
    mask = SL_sheet(SL_sprite(handle).sheet, SL_sprite(handle).cell).mask '                             get mask from sprite sheet
    sw = SL_sheet(SL_sprite(handle).sheet, SL_sprite(handle).cell).swidth '                             get default sprite width from sprite sheet
    sh = SL_sheet(SL_sprite(handle).sheet, SL_sprite(handle).cell).sheight '                            get default sprite height from sprite sheet

    ' free existing images from memory

    _FREEIMAGE SL_sprite(handle).gfx.software '                                                         free software sprite image
    IF SL_sprite(handle).gfx.mask THEN _FREEIMAGE SL_sprite(handle).gfx.mask '                          free software mask image

    ' remove rotation (reset) if requested

    IF degrees = -32767 OR degree = 0 THEN '                                                (SL_RESET)  reset sprite rotation?
        SL_sprite(handle).rotation.angle = 0 '                                                          yes, reset rotation angle
        SL_sprite(handle).swidth = sw '                                                                 save sprite's width
        SL_sprite(handle).sheight = sh '                                                                save prite's height
        SL_sprite(handle).gfx.software = _COPYIMAGE(image, 32) '                                        copy software image from sprite sheet
        IF SL_sprite(handle).transparency THEN '                                                        does this sprite have a mask?
            SL_sprite(handle).gfx.mask = _COPYIMAGE(mask, 32) '                                         yes, copy software mask from sprite sheet
        END IF
        EXIT SUB '                                                                                      no rotation needed, leave subroutine
    END IF

    ' rotate sprite

    rw = SL_angle(SL_sprite(handle).sheet, SL_sprite(handle).cell, degree).rwidth '                     get precalculated rotated sprite width
    rh = SL_angle(SL_sprite(handle).sheet, SL_sprite(handle).cell, degree).rheight '                    get precalculated rotated sprite height
    px0 = SL_angle(SL_sprite(handle).sheet, SL_sprite(handle).cell, degree).px0 '                       get precalculated triangular coordinates
    px1 = SL_angle(SL_sprite(handle).sheet, SL_sprite(handle).cell, degree).px1
    px2 = SL_angle(SL_sprite(handle).sheet, SL_sprite(handle).cell, degree).px2
    px3 = SL_angle(SL_sprite(handle).sheet, SL_sprite(handle).cell, degree).px3
    py0 = SL_angle(SL_sprite(handle).sheet, SL_sprite(handle).cell, degree).py0
    py1 = SL_angle(SL_sprite(handle).sheet, SL_sprite(handle).cell, degree).py1
    py2 = SL_angle(SL_sprite(handle).sheet, SL_sprite(handle).cell, degree).py2
    py3 = SL_angle(SL_sprite(handle).sheet, SL_sprite(handle).cell, degree).py3

    SL_sprite(handle).gfx.software = _NEWIMAGE(rw, rh, 32) '                                            create new software sprite image
    _MAPTRIANGLE (0, 0)-(0, sh - 1)-(sw - 1, sh - 1), image TO(px0, py0)-(px1, py1)-(px2, py2), SL_sprite(handle).gfx.software ' map rotated sprite onto image
    _MAPTRIANGLE (0, 0)-(sw - 1, 0)-(sw - 1, sh - 1), image TO(px0, py0)-(px3, py3)-(px2, py2), SL_sprite(handle).gfx.software
    IF SL_sprite(handle).transparency THEN '                                                            does this sprite have a mask?
        SL_sprite(handle).gfx.mask = _NEWIMAGE(rw, rh, 32) '                                            yes, create new software mask image
        _MAPTRIANGLE (0, 0)-(0, sh - 1)-(sw - 1, sh - 1), mask TO(px0, py0)-(px1, py1)-(px2, py2), SL_sprite(handle).gfx.mask '  map rotated mask onto image
        _MAPTRIANGLE (0, 0)-(sw - 1, 0)-(sw - 1, sh - 1), mask TO(px0, py0)-(px3, py3)-(px2, py2), SL_sprite(handle).gfx.mask
    END IF
    SL_sprite(handle).swidth = rw '                                                                     save sprite's rotated width
    SL_sprite(handle).sheight = rh '                                                                    save sprite's rotated height
    SL_sprite(handle).rotation.angle = degree '                                                         save sprite's degree of rotation


END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_ROTATION_ANGLE (handle AS INTEGER) '                                                                                                                              SL_GET_ROTATION_ANGLE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_ROTATION_ANGLE", 1, "" '                                                       no, report error to programmer
    END IF

    SL_GET_ROTATION_ANGLE = SL_sprite(handle).rotation.angle '                                          return current angle of rotation

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_FIX_DEGREES (degrees AS INTEGER) '                                                                                                                                           SL_FIX_DEGREES
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' Credits: this function uses code contriibuted by codeguy
    '          https://www.qb64.org/forum/index.php?topic=537.15

    'declare local variables

    DIM degree AS INTEGER '             degree angle passed in

    ' set local variables

    degree = degrees MOD 360 '                                                                          get -359 to 359
    IF degree < 0 THEN '                                                                                need to make positive?
        SL_FIX_DEGREES = degree + 360 '                                                                 yes, correct value and return degree angle
    ELSE
        SL_FIX_DEGREES = degree '                                                                       no correction needed, return degree angle
    END IF

END FUNCTION


'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴
'                                                                      ----------==========                   ==========----------
'                                                                      ----------========== LOCATION ROUTINES ==========----------
'                                                                      ----------==========                   ==========----------
'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴


'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_REALX (handle AS INTEGER) '                                                                                                                                                SL_GET_REALX
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_REALX", 1, "" '                                                                no, report error to programmer
    END IF

    SL_GET_REALX = SL_sprite(handle).x.real '                                                           return real number center point x

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_REALY (handle AS INTEGER) '                                                                                                                                                SL_GET_REALY
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_REALY", 1, "" '                                                                no, report error to programmer
    END IF

    SL_GET_REALY = SL_sprite(handle).y.real '                                                           return real number center point y

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_INTX (handle AS INTEGER) '                                                                                                                                                  SL_GET_INTX
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_INTX", 1, "" '                                                                 no, report error to programmer
    END IF

    SL_GET_INTX = SL_sprite(handle).x.int '                                                             return integer number center point x

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_INTY (handle AS INTEGER) '                                                                                                                                                  SL_GET_INTY
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_INTY", 1, "" '                                                                 no, report error to programmer
    END IF

    SL_GET_INTY = SL_sprite(handle).y.int '                                                             return integer number center point x

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_ACTUALX (handle AS INTEGER) '                                                                                                                                            SL_GET_ACTUALX
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_ACTUALX", 1, "" '                                                              no, report error to programmer
    END IF

    SL_GET_ACTUALX = SL_sprite(handle).x.actual '                                                       return integer number upper left point x

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_ACTUALY (handle AS INTEGER) '                                                                                                                                            SL_GET_ACTUALY
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_ACTUALY", 1, "" '                                                              no, report error to programmer
    END IF

    SL_GET_ACTUALY = SL_sprite(handle).y.actual '                                                       return integer number upper left point y

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_DISTANCE_POINT_TO_POINT (x1 AS INTEGER, y1 AS INTEGER, x2 AS INTEGER, y2 AS INTEGER) '                                                                   SL_GET_DISTANCE_POINT_TO_POINT
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    'declare local variables

    DIM a AS INTEGER '                  side a of triangle
    DIM b AS INTEGER '                  side b of triangle

    'solve for c (hypotenuse)

    a = x1 - x2 '                                                                                       get length of side a
    b = y1 = y2 '                                                                                       get length of side b

    SL_GET_DISTANCE_POINT_TO_POINT = INT(SQR(a * a + b * b)) '                                          return length of side c

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_DISTANCE_TO_SPRITE (handle1 AS INTEGER, handle2 AS INTEGER) '                                                                                                 SL_GET_DISTANCE_TO_SPRITE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    'perform error checks

    IF (NOT SL_VALID_SPRITE(handle1)) OR (NOT SL_VALID_SPRITE(handle2)) THEN '                          are these valid sprites?
        SL_error "SL_GET_DISTANCE_TO_SPRITE", 1, "" '                                                   no, report error to programmer
    END IF

    SL_GET_DISTANCE_TO_SPRITE = SL_GET_DISTANCE_POINT_TO_POINT(SL_sprite(handle1).x.int, SL_sprite(handle1).y.int, _
                                                               SL_sprite(handle2).x.int, SL_sprite(handle2).y.int) '  return distance to sprite 2

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_DISTANCE_TO_POINT (handle AS INTEGER, x AS INTEGER, y AS INTEGER) '                                                                                            SL_GET_DISTANCE_TO_POINT
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    'perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_DISTANCE_TO_POINT", 1, "" '                                                    no, report error to programmer
    END IF

    SL_GET_DISTANCE_TO_POINT = SL_GET_DISTANCE_POINT_TO_POINT(SL_sprite(handle).x.int, SL_sprite(handle).y.int, x, y) ' return distance to point

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_ANGLE_POINT_TO_POINT (x1 AS INTEGER, y1 AS INTEGER, x2 AS INTEGER, y2 AS INTEGER) '                                                                         SL_GET_ANGLE_POINT_TO_POINT
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    'declare local variables

    DIM angle AS INTEGER '              angle from first x,y location to second x,y location

    IF y1 = y2 THEN '                                                                                   both y values same?
        IF x1 = x2 THEN '                                                                               yes, both x values same?
            EXIT FUNCTION '                                                                             yes, there is no angle (0), leave
        END IF
        IF x2 > x1 THEN '                                                                               is second x to the right of first x?
            SL_GET_ANGLE_POINT_TO_POINT = 90 '                                                          yes, the angle must be 90 degrees
        ELSE '                                                                                          no, second x is to the left of first x
            SL_GET_ANGLE_POINT_TO_POINT = 270 '                                                         the angle must be 270 degrees
        END IF
        EXIT FUNCTION '                                                                                 leave function, angle computed
    END IF
    IF x1 = x2 THEN '                                                                                   both x values same?
        IF y2 > y1 THEN '                                                                               yes, is second y lower than first y?
            SL_GET_ANGLE_POINT_TO_POINT = 180 '                                                         yes, the angle must be 180
        END IF
        EXIT FUNCTION '                                                                                 leave function, angle computed (angle is 0 if no calculation done)
    END IF
    angle = ATN((x2 - x1) / (y2 - y1)) * -57.2957795131 '                                               calculate initial angle
    IF y2 < y1 THEN '                                                                                   is second y higher than first y?
        IF x2 > x1 THEN '                                                                               yes, is second x to right of first x?
            SL_GET_ANGLE_POINT_TO_POINT = angle '                                                       yes, angle needs no adjustment
        ELSE '                                                                                          no, second x is to left of first x
            SL_GET_ANGLE_POINT_TO_POINT = angle + 360 '                                                 adjust angle accordingly
        END IF
    ELSE '                                                                                              no, second y is lower than first y
        SL_GET_ANGLE_POINT_TO_POINT = angle + 180 '                                                     adjust angle accordingly
    END IF

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_ANGLE_TO_SPRITE (handle1 AS INTEGER, handle2 AS INTEGER) '                                                                                                       SL_GET_ANGLE_TO_SPRITE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    'perform error checks

    IF (NOT SL_VALID_SPRITE(handle1)) OR (NOT SL_VALID_SPRITE(handle2)) THEN '                          are these valid sprites?
        SL_error "SL_GET_ANGLE_TO_SPRITE", 1, "" '                                                      no, report error to programmer
    END IF

    SL_GET_ANGLE_TO_SPRITE = SL_GET_ANGLE_POINT_TO_POINT(SL_sprite(handle1).x.int, SL_sprite(handle1).y.int, _
                                                         SL_sprite(handle2).x.int, SL_sprite(handle2).y.int) ' return angle to sprite 2

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_ANGLE_FROM_SPRITE (handle1 AS INTEGER, handle2 AS INTEGER) '                                                                                                   SL_GET_ANGLE_FROM_SPRITE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    'perform error checks

    IF (NOT SL_VALID_SPRITE(handle1)) OR (NOT SL_VALID_SPRITE(handle2)) THEN '                          are these valid sprites?
        SL_error "SL_GET_ANGLE_FROM_SPRITE", 1, "" '                                                    no, report error to programmer
    END IF

    SL_GET_ANGLE_FROM_SPRITE = SL_GET_ANGLE_POINT_TO_POINT(SL_sprite(handle2).x.int, SL_sprite(handle2).y.int, _
                                                           SL_sprite(handle1).x.int, SL_sprite(handle1).y.int) '  return angle from sprite 2

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_ANGLE_TO_POINT (handle AS INTEGER, x AS INTEGER, y AS INTEGER) '                                                                                                  SL_GET_ANGLE_TO_POINT
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    'perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_ANGLE_TO_POINT", 1, "" '                                                       no, report error to programmer
    END IF

    SL_GET_ANGLE_TO_POINT = SL_GET_ANGLE_POINT_TO_POINT(SL_sprite(handle).x.int, SL_sprite(handle).y.int, x, y) ' return angle to point x,y

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_ANGLE_FROM_POINT (handle AS INTEGER, x AS INTEGER, y AS INTEGER) '                                                                                              SL_GET_ANGLE_FROM_POINT
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    'perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_ANGLE_FROM_POINT", 1, "" '                                                     no, report error to programmer
    END IF

    SL_GET_ANGLE_FROM_POINT = SL_GET_ANGLE_POINT_TO_POINT(x, y, SL_sprite(handle).x.int, SL_sprite(handle).y.int) 'return angle from point x,y

END FUNCTION

'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴
'                                                                       ----------==========                 ==========----------
'                                                                       ----------========== SPRITE ROUTINES ==========----------
'                                                                       ----------==========                 ==========----------
'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_SET_SPRITE_VISIBLE (handle AS INTEGER, visible AS INTEGER) '                                                                                                               SL_SET_SPRITE_VISIBLE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_SET_SPRITE_VISIBLE", 1, "" '                                                       no, report error to programmer
    END IF
    IF (visible < -1) OR (visible > 0) THEN '                                      (SL_SHOW & SL_HIDE)  valid visible behavior requested?
        SL_error "SL_SET_SPRITE_VISIBLE", 20, "" '                                                      no, report error to programmer
    END IF

    SL_sprite(handle).visible = visible '                                          (SL_SHOW & SL_HIDE)  set visible mode

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_COPY_SPRITE (handle AS INTEGER) '                                                                                                                                            SL_COPY_SPRITE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' declare local variables

    DIM newhandle AS INTEGER '          handle of copied sprite

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_COPY_SPRITE", 1, "" '                                                              no, report error to programmer
    END IF

    newhandle = 0 '                                                                                     initialize new handle counter

    ' increase sprite array's size if needed

    DO '                                                                                                look for next available handle
        newhandle = newhandle + 1 '                                                                     increment to next handle value
    LOOP UNTIL (NOT SL_sprite(newhandle).inuse) OR newhandle = UBOUND(SL_sprite) '                      stop looking when valid handle found
    IF SL_sprite(newhandle).inuse THEN '                                                                is the last array element in use?
        newhandle = newhandle + 1 '                                                                     yes, increment to next handle value
        REDIM _PRESERVE SL_sprite(newhandle) AS SL_SPRITE '                                             increase the size of the sprite array
    END IF

    ' copy new sprite

    SL_sprite(newhandle) = SL_sprite(handle) '                                                          copy entire sprite contents
    SL_sprite(newhandle).gfx.hardware = _COPYIMAGE(SL_sprite(handle).gfx.hardware, 33) '                create an actual copy of the hardware sprite
    SL_sprite(newhandle).gfx.software = _COPYIMAGE(SL_sprite(handle).gfx.software, 32) '                create an actual copy of the software image
    IF SL_sprite(handle).gfx.mask THEN '                                                                does the original contain a mask image?
        SL_sprite(newhandle).gfx.mask = _COPYIMAGE(SL_sprite(handle).gfx.mask, 32) '                    yes, create an actual copy of the software mask image
    END IF

    SL_COPY_SPRITE = newhandle '                                                                        return new sprite's handle pointer

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_STAMP_SPRITE (layer AS INTEGER, x AS INTEGER, y AS INTEGER, sheet AS INTEGER, cell AS INTEGER, degrees AS INTEGER, flip AS INTEGER, zoom AS INTEGER) '                           SL_STAMP_SPRITE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sheet() AS SL_SHEET '     master sprite sheet array
    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' declare local variables

    DIM tempsprite AS LONG '            temporary sprite to stamp

    ' perform error checks

    IF NOT SL_VALID_SHEET(sheet) THEN '                                                                 is this a valid sheet?
        SL_error "SL_STAMP_SPRITE", 5, "" '                                                             no, report error to programmer
    END IF
    IF NOT SL_VALID_CELL(sheet, cell) THEN '                                                            valid cell?
        SL_error "SL_STAMP_SPRITE", 13, "" '                                                            no, report error to programmer
    END IF
    IF flip < 0 OR flip > 3 THEN '                                                                      valid flip behavior requested?
        SL_error "SL_STAMP_SPRITE", 3, "" '                                                             no, report error to programmer
    END IF
    IF zoom < 1 THEN '                                                                                  valid zoom level requested?
        SL_error "SL_STAMP_SPRITE", 4, "" '                                                             no, report error to programmer
    END IF
    IF NOT SL_VALID_LAYER(layer) THEN '                                                                 valid layer?
        SL_error "SL_STAMP_SPRITE", 25, "" '                                                            no, report error to programmer
    END IF

    tempsprite = SL_NEW_SPRITE(layer, sheet, cell, 0, 0) '                                              create new temporary software sprite
    SL_sprite(tempsprite).rotation.speed = SL_FIX_DEGREES(degrees) '                                    set speed of rotation
    SL_sprite(tempsprite).flip = flip '                                                                 set flipping behavior
    SL_sprite(tempsprite).zoom = zoom '                                                                 set zoom level
    SL_PUT_SPRITE x, y, tempsprite '                                                                    place sprite on current destination
    SL_FREE_SPRITE tempsprite '                                                                         temporary sprite no longer needed

END SUB


'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_SET_SOFTWARE (handle AS INTEGER, restores AS INTEGER) '                                                                                                                          SL_SET_SOFTWARE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    'perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_SET_SOFTWARE", 1, "" '                                                             no, report error to programmer
    END IF
    IF restores < -1 OR restores > 0 THEN '                                                             valid background restoration behavior requested?
        SL_error "SL_SET_SOFTWARE", 2, "" '                                                             no, report error to programmer
    END IF

    SL_sprite(handle).software = -1 '                                                    (SL_SOFTWARE)  set sprite to software mode
    SL_sprite(handle).restore = restores '                                       (SL_SAVE & SL_NOSAVE)  set background saving behavior

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_SET_HARDWARE (handle AS INTEGER) '                                                                                                                                               SL_SET_HARDWARE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    'perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_SET_HARDWARE", 1, "" '                                                             no, report error to programmer
    END IF

    SL_sprite(handle).software = 0 '                                                     (SL_HARDWARE)  set sprite to hardware mode

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_SET_ZOOM (handle AS INTEGER, zoom AS INTEGER) '                                                                                                                                      SL_SET_ZOOM
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_SET_ZOOM", 1, "" '                                                                 no, report error to programmer
    END IF
    IF zoom = -32767 THEN '                                                                 (SL_RESET)  reset zoom level?
        SL_sprite(handle).zoom = 100 '                                                                  yes, reset level to normal
    ELSEIF zoom < 1 THEN '                                                                              valid zoom level requested?
        SL_error "SL_SET_ZOOM", 4, "" '                                                                 no, report error to programmer
    ELSE '                                                                                              yes
        SL_sprite(handle).zoom = zoom '                                                                 set zoom level
    END IF

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_FLIP_SPRITE (handle AS INTEGER, flip AS INTEGER) '                                                                                                                                SL_FLIP_SPRITE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_FLIP_SPRITE", 1, "" '                                                              no, report error to programmer
    END IF
    IF flip = -32767 THEN '                                                                 (SL_RESET)  reset flipping behavior?
        SL_sprite(handle).flip = 0 '                                                       (SL_NOFLIP)  yes, reset flip value
    ELSEIF flip < 0 OR flip > 3 THEN '                                                                  valid flip behavior requested?
        SL_error "SL_FLIP_SPRITE", 3, "" '                                                              no, report error to programmer
    ELSE '                                                                                              yes
        SL_sprite(handle).flip = flip '           (SL_NOFLIP, SL_HORIZONTAL, SL_VERTICAL, SL_FLIPBOTH)  set flipping behavior
    END IF

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_PUT_SPRITE (x AS SINGLE, y AS SINGLE, handle AS INTEGER) '                                                                                                                         SL_PUT_SPRITE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array
    SHARED SL_angle() AS SL_ANGLE '     master rotation array

    ' declare local variables

    DIM xa AS INTEGER '                 actual x location of sprite on screen
    DIM ya AS INTEGER '                 actual y location of sprite on screen
    DIM sw AS INTEGER '                 width of sprite to be drawn
    DIM sh AS INTEGER '                 height of sprite to be drawn
    DIM rw AS INTEGER '                 precalculated rotated sprite width
    DIM rh AS INTEGER '                 precalculated rotated sprite height
    DIM px0 AS INTEGER '                precalculated triangular coordinates
    DIM px1 AS INTEGER
    DIM px2 AS INTEGER
    DIM px3 AS INTEGER
    DIM py0 AS INTEGER
    DIM py1 AS INTEGER
    DIM py2 AS INTEGER
    DIM py3 AS INTEGER
    DIM image AS LONG '                 software sprite image
    DIM mask AS LONG '                  software sprite image mask
    DIM sprite AS LONG '                hardware sprite image
    DIM odest AS LONG '                 original destination layer
    DIM osource AS LONG '               original source layer
    DIM zoomfactor AS SINGLE '          zoom multiplication factor
    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_PUT_SPRITE", 1, "" '                                                               no, report error to programmer
    END IF

    'local variable setup

    'odest = _DEST '                                                                                     save original destination
    'osource = _SOURCE '                                                                                 save original source
    odest = SL_GET_DESTINATION_LAYER
    osource = SL_GET_SOURCE_LAYER

    SL_sprite(handle).x.real = x '                                                            (SINGLE)  save requested x center location
    SL_sprite(handle).y.real = y '                                                            (SINGLE)  save requested y center location
    SL_sprite(handle).x.int = INT(x) '                                                       (INTEGER)  save screen x center location
    SL_sprite(handle).y.int = INT(y) '                                                       (INTEGER)  save screen y center location
    sw = SL_sprite(handle).swidth '                                                                     get current sprite width
    sh = SL_sprite(handle).sheight '                                                                    get current sprite height

    'update hardware image

    _FREEIMAGE SL_sprite(handle).gfx.hardware '                                                         free previous hardware sprite image
    SL_sprite(handle).gfx.hardware = _COPYIMAGE(SL_sprite(handle).gfx.software, 33) '                   create new hardware sprite of image

    IF SL_sprite(handle).restore THEN '                                                                 is sprite holding a background image?
        IF SL_sprite(handle).gfx.back THEN '                                                            yes, has a background image been saved yet?
            SL_SET_DESTINATION_LAYER SL_sprite(handle).layer '                                          yes, set destination layer
            _PUTIMAGE (SL_sprite(handle).x.back, SL_sprite(handle).y.back), SL_sprite(handle).gfx.back 'replace background with image
            _FREEIMAGE SL_sprite(handle).gfx.back '                                                     free hardware background image
        END IF
        IF NOT SL_sprite(handle).software THEN '                                                        was the sprite type changed?
            SL_sprite(handle).restore = 0 '                                                (SL_NOSAVE)  yes, stop saving background
        END IF
    END IF

    'adjust zoom level if needed

    IF SL_sprite(handle).zoom <> 100 THEN '                                                             zoom sprite in/out?
        zoomfactor = SL_sprite(handle).zoom / 100
        'sw = sw * SL_sprite(handle).zoom * .01 '\ 100 '                                                        yes, calculate new zoom width
        'sh = sh * SL_sprite(handle).zoom * .01 '\ 100 '                                                        calculate new zoom height
        sw = sw * zoomfactor '                                                                          yes, calculate new zoom width
        sh = sh * zoomfactor '                                                                          calculate new zoom height
    ELSE
        zoomfactor = 1
    END IF

    'calculate actual sprite screen coordinates

    xa = SL_sprite(handle).x.int - sw \ 2 '                                                             calculate actual screen x location from center
    ya = SL_sprite(handle).y.int - sh \ 2 '                                                             calculate actual screen y location from center
    SL_sprite(handle).x.actual = xa '                                                        (INTEGER)  save actual screen x location
    SL_sprite(handle).y.actual = ya '                                                        (INTEGER)  save actual screen y location

    ' update collision box location based on actual x,y location, radius, and zoom factor

    SL_sprite(handle).collision.x1 = xa + SL_angle(SL_sprite(handle).sheet, SL_sprite(handle).cell, SL_sprite(handle).rotation.angle).x1 * zoomfactor
    SL_sprite(handle).collision.x2 = xa + SL_angle(SL_sprite(handle).sheet, SL_sprite(handle).cell, SL_sprite(handle).rotation.angle).x2 * zoomfactor
    SL_sprite(handle).collision.y1 = ya + SL_angle(SL_sprite(handle).sheet, SL_sprite(handle).cell, SL_sprite(handle).rotation.angle).y1 * zoomfactor
    SL_sprite(handle).collision.y2 = ya + SL_angle(SL_sprite(handle).sheet, SL_sprite(handle).cell, SL_sprite(handle).rotation.angle).y2 * zoomfactor
    SL_sprite(handle).collision.radius = SL_angle(SL_sprite(handle).sheet, SL_sprite(handle).cell, SL_sprite(handle).rotation.angle).radius * zoomfactor

    'get background image before placing sprite if necessary

    IF SL_sprite(handle).restore THEN '                                                                 is this sprite storing background images?
        SL_sprite(handle).gfx.back = _NEWIMAGE(sw, sh, 32) '                                            yes, create background image
        SL_SET_SOURCE_LAYER SL_sprite(handle).layer '                                                   set the source layer
        _PUTIMAGE , _SOURCE, SL_sprite(handle).gfx.back, (xa, ya)-(xa + sw - 1, ya + sh - 1) '          get background area from current source layer
        SL_sprite(handle).x.back = xa '                                                                 record background x location
        SL_sprite(handle).y.back = ya '                                                                 record background y location
    END IF

    'use hardware or software image

    IF SL_sprite(handle).software THEN '                                                                is this a software sprite?
        sprite = SL_sprite(handle).gfx.software '                                                       yes, use the software image
        SL_SET_DESTINATION_LAYER SL_sprite(handle).layer '                                              set the destination layer
    ELSE '                                                                                              no
        sprite = SL_sprite(handle).gfx.hardware '                                                       use the hardware image
        SL_SET_DESTINATION_LAYER 1 '                                                                    set the destination layer to first as default
    END IF

    ' place sprite on the current destination with desired flip method

    IF SL_sprite(handle).visible THEN '                                            (SL_SHOW & SL_HIDE)  show this sprite?
        SELECT CASE SL_sprite(handle).flip '                                                            yes, which flipping style is selected?
            CASE 0 '                                                                       (SL_NOFLIP)  normal, no flipping
                _PUTIMAGE (xa, ya)-(xa + sw - 1, ya + sh - 1), sprite '                                 draw normal sprite
            CASE 1 '                                                                   (SL_HORIZONTAL)  flip horizontally
                _PUTIMAGE (xa + sw - 1, ya)-(xa, ya + sh - 1), sprite '                                 draw horizontally flipped sprite
            CASE 2 '                                                                     (SL_VERTICAL)  flip vertically
                _PUTIMAGE (xa, ya + sh - 1)-(xa + sw - 1, ya), sprite '                                 draw vertically flipped sprite
            CASE 3 '                                                                     (SL_FLIPBOTH)  flip vertically and horizontally
                _PUTIMAGE (xa + sw - 1, ya + sh - 1)-(xa, ya), sprite '                                 draw horizontally and vertically flipped sprite
        END SELECT
    END IF

    '_SOURCE osource '                                                                                   restore original source
    '_DEST odest '                                                                                       restore original destination
    SL_SET_SOURCE_LAYER osource
    SL_SET_DESTINATION_LAYER odest

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_NEW_SPRITE (layer AS INTEGER, sheet AS INTEGER, cell AS INTEGER, software AS INTEGER, restores AS INTEGER) '                                                                  SL_NEW_SPRITE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sheet() AS SL_SHEET '     master sprite sheet array
    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' declare local variables

    DIM handle AS INTEGER '             handle (pointer) number of new sprite

    ' perform error checks

    IF NOT SL_VALID_SHEET(sheet) THEN '                                                                 is this a valid sprite sheet?
        SL_error "SL_NEW_SPRITE", 5, "" '                                                               no, report error to programmer
    END IF
    IF NOT SL_VALID_CELL(sheet, cell) THEN '                                                            valid cell?
        SL_error "SL_NEW_SPRITE", 13, "" '                                                              no, report error to programmer
    END IF
    IF NOT SL_VALID_LAYER(layer) THEN '                                                                 valid layer?
        SL_error "SL_NEW_SPRITE", 25, "" '                                                              no, report error to programmer
    END IF
    IF restores < -1 OR restores > 0 THEN '                                                             valid background restoration behavior requested?
        SL_error "SL_NEW_SPRITE", 2, "" '                                                               no, report error to programmer
    END IF
    IF software < -1 OR software > 0 THEN '                                                             valid hardware / software setting requested?
        SL_error "SL_NEW_SPRITE", 112, "" '                                                             no, report error to programmer
    END IF
    IF (NOT software) AND restores THEN '                                                               hardware image that restores background?
        SL_error "SL_NEW_SPRITE", 113, "" '                                                             yes, report error to programmer
    END IF

    ' local variable setup

    handle = 0 '                                                                                        initialize handle value

    ' increase sprite array's size if needed

    DO '                                                                                                look for next available handle
        handle = handle + 1 '                                                                           increment to next handle value
    LOOP UNTIL (NOT SL_sprite(handle).inuse) OR handle = UBOUND(SL_sprite) '                            stop looking when valid handle found
    IF SL_sprite(handle).inuse THEN '                                                                   is the last array element in use?
        handle = handle + 1 '                                                                           yes, increment to next handle value
        REDIM _PRESERVE SL_sprite(handle) AS SL_SPRITE '                                                increase the size of the sprite array
    END IF

    ' populate sprite array, general settings

    SL_sprite(handle).inuse = -1 '                                                              (TRUE)  mark array index as in use
    SL_sprite(handle).sheet = sheet '                                                                   point to sheet where sprite resides
    SL_sprite(handle).cell = cell '                                                                     cell sprite is located in on sheet
    SL_sprite(handle).software = software '                                (SL_SOFTWARE & SL_HARDWARE)  sprite treated as software or hardware image
    SL_sprite(handle).restore = restores '                                       (SL_SAVE & SL_NOSAVE)  background restore behavior of sprite
    SL_sprite(handle).swidth = SL_sheet(sheet, cell).swidth '                                           get width of sprite
    SL_sprite(handle).sheight = SL_sheet(sheet, cell).sheight '                                         get height of sprite
    SL_sprite(handle).flip = 0 '                                                                        no sprite flipping
    SL_sprite(handle).zoom = 100 '                                                                      zoom normal at 100%
    SL_sprite(handle).score = 0 '                                                                       no point score
    SL_sprite(handle).visible = -1 '                                                            (TRUE)  sprite visible on screen
    SL_sprite(handle).layer = layer '                                                                   set sprite's layer


    ' mouse settings

    SL_sprite(handle).mouse.event = 0 '(SL_NOMOUSE, SL_HOVER, SL_LEFTCLICK, SL_RIGHTCLICK, SL_CENTERCLICK) reset mouse interaction
    SL_sprite(handle).mouse.x = 0 '                                                                     reset mouse pointer locations
    SL_sprite(handle).mouse.y = 0
    SL_sprite(handle).mouse.xa = 0
    SL_sprite(handle).mouse.ya = 0

    ' collision settings

    SL_sprite(handle).collision.detect = 0 '                                                            reset collision detection method selected
    SL_sprite(handle).collision.box = 0 '                                                      (FALSE)  reset box collision detected
    SL_sprite(handle).collision.round = 0 '                                                    (FALSE)  reset round collision detected
    SL_sprite(handle).collision.pixel = 0 '                                                    (FALSE)  reset pixel perfect collision detected
    SL_sprite(handle).collision.with = 0 '                                                              reset collision detected
    SL_sprite(handle).collision.xpoint = 0 '                                                            reset collision x point
    SL_sprite(handle).collision.ypoint = 0 '                                                            reset collision y point
    SL_sprite(handle).collision.radius = 0 '                                                            reset round collision radius
    SL_sprite(handle).collision.x1 = 0 '                                                                reset sprite's collision box boundaries
    SL_sprite(handle).collision.y1 = 0
    SL_sprite(handle).collision.x2 = 0
    SL_sprite(handle).collision.y2 = 0
    SL_sprite(handle).collision.cwidth = 0 '                                                            reset collision box width
    SL_sprite(handle).collision.cheight = 0 '                                                           reset collision box height

    ' animation settings

    SL_sprite(handle).animation.cell = cell '                                                           the animation cell this sprite is in
    SL_sprite(handle).animation.cellfrom = 0 '                                                          reset sprite beginning animation cell
    SL_sprite(handle).animation.cellto = 0 '                                                            reset sprite ending animation cell
    SL_sprite(handle).animation.dir = 0 '                      (SL_FORWARD, SL_BACKWARD & SLBACKFORTH)  reset sprite animation direction
    SL_sprite(handle).animation.mode = 0 '                                                              reset sprite animation mode
    SL_sprite(handle).animation.frame = 0 '                                                             reset sprite animation frame counter
    SL_sprite(handle).animation.skip = 0 '                                                              reset sprite animation skip rate
    SL_sprite(handle).animation.auto = 0 '                                                     (FALSE)  sprite has no auto animation

    ' x,y location settings

    SL_sprite(handle).x.real = 0 '                                                                      reset x location of sprite (center x)
    SL_sprite(handle).y.real = 0 '                                                                      reset y location of sprite (center y)
    SL_sprite(handle).x.int = 0 '                                                                       reset x location of sprite on screen INT(xreal) (center x)
    SL_sprite(handle).y.int = 0 '                                                                       reset y location of sprite on screen INT(yreal) (center y)
    SL_sprite(handle).x.actual = 0 '                                                                    reset x location of sprite on screen (upper left x)
    SL_sprite(handle).y.actual = 0 '                                                                    reset y location of sprite on screen (upper left y)
    SL_sprite(handle).x.dir = 0 '                                                                       x direction during motion
    SL_sprite(handle).y.dir = 0 '                                                                       y direction during motion

    ' graphics image settings

    SL_sprite(handle).gfx.back = 0 '                                                                    no background image saved yet
    SL_sprite(handle).gfx.hardware = _COPYIMAGE(SL_sheet(sheet, cell).software, 33) '                   create hardware sprite image
    SL_sprite(handle).gfx.software = _COPYIMAGE(SL_sheet(sheet, cell).software, 32) '                   copy software sprite image from sheet
    IF SL_sheet(sheet, cell).transparency THEN '                                                        does this sprite use transparency?
        SL_sprite(handle).gfx.mask = _COPYIMAGE(SL_sheet(sheet, cell).mask, 32) '                       yes, copy software sprite mask image from sheet
        SL_sprite(handle).transparency = -1 '                                                   (TRUE)  remember this sprite has a transparency layer
    ELSE '                                                                                              no transparency
        SL_sprite(handle).gfx.mask = 0 '                                                                no mask will be brought in
        SL_sprite(handle).transparency = 0 '                                                   (FALSE)  remember this sprite has no transparency layer
    END IF

    ' rotation settings

    SL_sprite(handle).rotation.angle = 0 '                                                              no sprite rotation angle
    SL_sprite(handle).rotation.speed = 0 '                                                              no spin rate
    SL_sprite(handle).rotation.auto = 0 '                                                      (FALSE)  auto rotation disabled

    ' motion settings

    SL_sprite(handle).motion.speed = 0 '                                                                speed during motion
    SL_sprite(handle).motion.angle = 0 '                                                                direction during motion (0 - 359)
    SL_sprite(handle).motion.auto = 0 '                                                        (FALSE)  auto motion disabled

    SL_NEW_SPRITE = handle '                                                                            return pointer value of new sprite

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_FREE_SPRITE (handle AS INTEGER) '                                                                                                                                                 SL_FREE_SPRITE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' check for errors

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_FREE_SPRITE", 1, "" '                                                              no, report error to programmer
    END IF

    ' restore background if this sprite saving background

    IF SL_sprite(handle).restore THEN '                                                                 is there a background image to restore?
        _PUTIMAGE (SL_sprite(handle).x.back, SL_sprite(handle).y.back), SL_sprite(handle).gfx.back '    yes, restore the image
        _FREEIMAGE SL_sprite(handle).gfx.back '                                                         free background image
    END IF

    ' free all image data associated with sprite

    IF SL_sprite(handle).gfx.back THEN _FREEIMAGE SL_sprite(handle).gfx.back '                          free background image if present
    IF SL_sprite(handle).gfx.mask THEN _FREEIMAGE SL_sprite(handle).gfx.mask '                          free sprite mask image if present
    _FREEIMAGE SL_sprite(handle).gfx.hardware '                                                         free hardware sprite image
    _FREEIMAGE SL_sprite(handle).gfx.software '                                                         free software sprite image

    IF (handle = UBOUND(sl_sprite)) AND (handle <> 1) THEN '                                            is handle the last element in array?
        REDIM _PRESERVE SL_sprite(handle - 1) AS SL_SPRITE '                                            yes, remove index and resize array
    ELSE '                                                                                              no, index somewhere else
        SL_sprite(handle).inuse = 0 '                                                          (FALSE)  mark index as usable later
    END IF

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_VALID_SPRITE (handle AS INTEGER) '                                                                                                                                         SL_VALID_SPRITE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    IF (handle > UBOUND(SL_SPRITE)) OR (NOT SL_sprite(handle).inuse) OR (handle < 1) THEN '              is this a valid sprite handle?
        SL_VALID_SPRITE = 0 '                                                                   (FALSE)  no, return 0
    ELSE '                                                                                               yes, it is valid
        SL_VALID_SPRITE = -1 '                                                                   (TRUE)  return -1
    END IF

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_SET_SCORE (handle AS INTEGER, score AS INTEGER) '                                                                                                                                   SL_SET_SCORE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_SET_SCORE", 1, "" '                                                                no, report error to programmer
    END IF

    SL_sprite(handle).score = score '                                                                   set sprite score

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_GET_SCORE (handle AS INTEGER) '                                                                                                                                                SL_GET_SCORE
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array

    ' perform error checks

    IF NOT SL_VALID_SPRITE(handle) THEN '                                                               is this a valid sprite?
        SL_error "SL_GET_SCORE", 1, "" '                                                                no, report error to programmer
    END IF

    SL_GET_SCORE = SL_sprite(handle).score '                                                            return sprite score

END FUNCTION


'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴
'                                                                       ----------==========                ==========----------
'                                                                       ----------========== SHEET ROUTINES ==========----------
'                                                                       ----------==========                ==========----------
'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴


'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_NEW_SHEET (filename AS STRING, swidth AS INTEGER, sheight AS INTEGER, transparency AS INTEGER, transcolor AS _UNSIGNED LONG) '                                                 SL_NEW_SHEET
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' The saving/loading of rotational data file added from an idea by Bplus
    ' https://www.qb64.org/forum/index.php?topic=537.30

    ' declare global variables

    SHARED SL_sheet() AS SL_SHEET '     master sprite sheet array
    SHARED SL_angle() AS SL_ANGLE '     precalculated rotation table

    ' declare local variables

    DIM handle AS INTEGER '             handle (pointer) number of new sprite sheet
    DIM x AS INTEGER '                  generic counter to cycle through sheet sprite columns
    DIM y AS INTEGER '                  generic counter to cycle through sheet sprite rows
    DIM osource AS LONG '               original source image before this function was called
    DIM odest AS LONG '                 original destination image before this function was called
    DIM pixel AS _UNSIGNED LONG '       pixel color at each coordinate in sprite sheet
    DIM alpha AS _UNSIGNED LONG '       alpha level of current pixel
    DIM top AS INTEGER '                upper boundary of sprite image
    DIM bottom AS INTEGER '             lower boundary of sprite image
    DIM left AS INTEGER '               left boundary of sprite image
    DIM right AS INTEGER '              right boundary of sprite image
    DIM sheetimage AS LONG '            sprite sheet image
    DIM sheetwidth AS INTEGER '         width of sprite sheet in pixels
    DIM sheetheight AS INTEGER '        height of sprite sheet in pixels
    DIM rows AS INTEGER '               number of sprite rows contained on sheet
    DIM columns AS INTEGER '            number of sprite columns contained on sheet
    DIM clearcolor AS _UNSIGNED LONG '  transcolor passed in will be modified
    DIM tempsprite AS LONG '            temporary sprite image
    DIM px(3) AS SINGLE '               polar x coordinates of maptriangle
    DIM py(3) AS SINGLE '               polar y coordinates of maptriangle
    DIM sinr AS SINGLE '                sin rotation calculation
    DIM cosr AS SINGLE '                cosine rotation calculation
    DIM bx1 AS SINGLE '                 boundaries of collision box
    DIM bx2 AS SINGLE
    DIM by1 AS SINGLE
    DIM by2 AS SINGLE
    DIM x2 AS SINGLE '                  new computed polar coordinates
    DIM y2 AS SINGLE
    DIM cells AS INTEGER '              total number of cells on sheet
    DIM cell AS INTEGER '               cell counter
    DIM degree AS INTEGER '             degree counter
    DIM polar AS INTEGER '              polar coordinate counter
    DIM xoffset AS INTEGER '            x offset to rotated center
    DIM yoffset AS INTEGER '            y offset to rotated center
    DIM xwidth AS INTEGER '             sprite width counter
    DIM yheight AS INTEGER '            sprite height counter
    DIM rotfile AS STRING '             name of rotation data file
    DIM preloaded AS INTEGER '          -1 (TRUE) if rotation data preloaded
    DIM filenum AS INTEGER '            FREEFILE number

    ' perform error checks

    IF NOT _FILEEXISTS(filename) THEN '                                                                 does the sprite sheet exist?
        SL_error "SL_NEW_SHEET", 100, filename '                                                        no, report error to programmer
    END IF
    IF ABS(transparency) > 1 THEN '                                                                     valid transparency setting?
        SL_error "SL_NEW_SHEET", 101, "" '                                                              no, report error to programmer
    END IF
    IF swidth < 1 OR sheight < 1 THEN '                                                                 valid sprite width/height supplied?
        SL_error "SL_NEW_SHEET", 102, "" '                                                              no, report error to programmer
    END IF
    IF transparency = -1 AND UCASE$(RIGHT$(filename, 4)) <> ".PNG" THEN '                               wrong file type for transparency?
        SL_error "SL_NEW_SHEET", 103, UCASE$(RIGHT$(filename, 4)) '                                     yes, report error to programmer
    END IF

    ' local variable setup

    sheetimage = _LOADIMAGE(filename, 32) '                                                             load sprite sheet file
    sheetwidth = _WIDTH(sheetimage) '                                                                   get width of sheet
    sheetheight = _HEIGHT(sheetimage) '                                                                 get height of sheet
    columns = sheetwidth \ swidth '                                                                     get number of whole columns of sprites
    rows = sheetheight \ sheight '                                                                      get number of whole rows of sprites
    cells = rows * columns '                                                                            calculate total number of cells on sheet

    IF columns < 1 OR rows < 1 THEN '                                                                   at least one sprite column and row on sheet?
        SL_error "SL_NEW_SHEET", 104, "" '                                                              no, report error to programmer
    END IF

    osource = _SOURCE '                                                                                 remember current source image
    odest = _DEST '                                                                                     remember current destination image
    handle = 0 '                                                                                        initialize handle value
    clearcolor = transcolor '                                                                           get background/transparent color passed in

    ' increase sheet array's 1st dimension if needed to create a new sprite sheet

    DO '                                                                                                look for the next available handle
        handle = handle + 1 '                                                                           increment the handle value
    LOOP UNTIL (NOT SL_sheet(handle, 0).software) OR handle = UBOUND(SL_sheet) '                        stop looking when valid handle value found
    IF SL_sheet(handle, 0).software = -1 THEN '                                                 (TRUE)  is the last array element in use?
        handle = handle + 1 '                                                                           yes, increment the handle value
        REDIM _PRESERVE SL_sheet(handle, UBOUND(SL_sheet, 2)) AS SL_SHEET '                             create new sheet in sprite array
        REDIM _PRESERVE SL_angle(handle, UBOUND(SL_angle, 2), 359) AS SL_ANGLE '                        increase rotation array to match
    END IF

    ' increase sheet array's 2nd dimension if needed to match number of cells

    IF cells > UBOUND(SL_sheet, 2) THEN '                                                               more cells in this sheet than others?
        REDIM _PRESERVE SL_sheet(handle, cells) AS SL_SHEET '                                           yes, increase the array's 2nd dimension to match
        REDIM _PRESERVE SL_angle(handle, cells, 359) AS SL_ANGLE '                                      increase rotation array to match
    END IF

    ' the variables in SL_sheet(x, 0) will serve a dual purpose
    ' SL_sheet(x, 0).image will contain either -1 (true) or 0 (false) to indicate the first dimension of the array is in use.

    SL_sheet(handle, 0).software = -1 '                                                         (TRUE)  mark as in use

    ' identify transparency of sprite sheet if requested

    IF transparency = -1 THEN '                                                          (SL_USESHEET)  sheet have alpha channel?
        x = 0 '                                                                                         yes, start at upper left x of sheet
        y = 0 '                                                                                         start at upper left y of sheet
        alpha = 255 '                                                                                   assume no alpha channel
        _SOURCE sheetimage '                                                                            set sprite sheet image as source image
        DO '                                                                                            start looping through the sheet's pixels
            pixel = POINT(x, y) '                                                                       get the pixel's color attributes
            alpha = _ALPHA32(pixel) '                                                                   get the alpha level (0 - 255)
            IF alpha = 0 THEN EXIT DO '                                                                 if it is transparent then leave the loop
            x = x + 1 '                                                                                 move right one pixel
            IF x > sheetwidth THEN '                                                                    have we gone off the sheet?
                x = 0 '                                                                                 yes, reset back to the left beginning
                y = y + 1 '                                                                             move down one pixel
            END IF
        LOOP UNTIL y > sheetheight '                                                                    don't stop until the entire sheet has been checked
        IF alpha = 0 THEN '                                                                             did we find a transparent pixel?
            tempsprite = _NEWIMAGE(1, 1, 32) '                                                          yes, create a temporary image         * why did I have to do
            _CLEARCOLOR pixel, tempsprite '                                                             set pixel found as transparent        * this hack to get
            clearcolor = _CLEARCOLOR(tempsprite) '                                                      get the transparent color from image  * clearcolor to come out
            _FREEIMAGE tempsprite '                                                                     temporary image no longer needed      * to the right value?
        ELSE '                                                                                          no transparency found within sheet
            transparency = 1 '                                                                          set sheet to having no alpha channel
        END IF
    ELSEIF transparency = 0 THEN '                                                            (SL_SET)  manually set alpha channel?
        _CLEARCOLOR clearcolor, sheetimage '                                                            yes, set color as transparent
        clearcolor = _CLEARCOLOR(sheetimage) '                                                          get the transparent color ************* again, why this hack?
    END IF

    ' preload rotational data if it exists

    rotfile = LEFT$(filename, INSTR(filename, ".") - 1) + ".rot" '                                      the name of the rotational data file
    IF _FILEEXISTS(rotfile) THEN '                                                                      does it exist?
        preloaded = -1 '                                                                                yes, remember that data has been preloaded
        filenum = FREEFILE
        OPEN rotfile FOR BINARY AS filenum '                                                            open it for reading
        FOR x = 1 TO cells '                                                                            cycle through all animation cells
            FOR y = 0 TO 359 '                                                                          and their associated rotational data
                GET #1, , SL_angle(handle, x, y) '                                                      get the data
            NEXT y
        NEXT x
        CLOSE filenum '                                                                                 close the file
    END IF

    ' load sprites from sheet and place into sprite array

    x = 0 '                                                                                             reset column counter
    DO '                                                                                                cycle through sheet's columns
        x = x + 1 '                                                                                     increment column counter
        y = 0 '                                                                                         reset row counter
        DO '                                                                                            cycle through sheet's rows
            y = y + 1 '                                                                                 increment row counter
            cell = (y - 1) * columns + x '                                                              calculate current cell number
            SL_sheet(handle, cell).software = _NEWIMAGE(swidth, sheight, 32) '                          create software sprite image

            SL_sheet(handle, cell).swidth = swidth
            SL_sheet(handle, cell).sheight = sheight


            IF transparency < 1 THEN '                                                                  should a mask be created?
                SL_sheet(handle, cell).mask = _NEWIMAGE(swidth, sheight, 32) '                          yes, create software sprite mask image
                _DEST SL_sheet(handle, cell).mask '                                                     write to the mask image
            ELSE '                                                                                      no software mask image
                SL_sheet(handle, cell).transparency = 0 '                                      (FALSE)  set sprite as having no transparency
            END IF
            _PUTIMAGE , sheetimage, SL_sheet(handle, cell).software,_
                ((x - 1) * swidth, (y - 1) * sheight)-_
                ((x - 1) * swidth + swidth - 1, (y - 1) * sheight + sheight - 1) '                      copy sprite from sheet and place in sprite image

            ' precalculate collision boundaries and update sprite mask if needed

            _SOURCE SL_sheet(handle, cell).software '                                                   work from the software sprite image
            top = sheight - 1 '                                                                         set initial collision boundary markers
            left = swidth - 1
            bottom = 0
            right = 0

            xwidth = 0 '                                                                                reset width counter
            DO '                                                                                        cycle through width of sprite
                yheight = 0 '                                                                           reset height counter
                DO '                                                                                    cycle through height of sprite
                    IF POINT(xwidth, yheight) <> clearcolor THEN '                                      is this pixel a transparent/background color?
                        IF xwidth < left THEN left = xwidth '                                           no, save position if left-most pixel
                        IF yheight < top THEN top = yheight '                                           save position if top-most pixel
                        IF xwidth > right THEN right = xwidth '                                         save position if right-most pixel
                        IF yheight > bottom THEN bottom = yheight '                                     save position if bbottom-most pixel
                    END IF
                    IF transparency < 1 THEN '                                                          update software sprite mask?
                        IF POINT(xwidth, yheight) = clearcolor THEN '                                   yes, is this pixel a transparent/background color?
                            PSET (xwidth, yheight), _RGB32(255, 255, 255) '                             yes, set as white on the mask image
                        END IF
                    END IF
                    yheight = yheight + 1 '                                                             increment height counter
                LOOP UNTIL yheight = sheight '                                                          leave when height of sprite reached (-1)
                xwidth = xwidth + 1 '                                                                   increment width counter
            LOOP UNTIL xwidth = swidth '                                                                leave when width of sprite reached (-1)

            SL_angle(handle, cell, 0).x1 = left '                                                       collision box top left x
            SL_angle(handle, cell, 0).y1 = top '                                                        collision box top left y
            SL_angle(handle, cell, 0).x2 = right '                                                      collision box bottom right x
            SL_angle(handle, cell, 0).y2 = bottom '                                                     collision box bottom right y
            SL_angle(handle, cell, 0).cwidth = right - left '                                           remember collision box width
            SL_angle(handle, cell, 0).cheight = bottom - top '                                          remember collision box height
            SL_angle(handle, cell, 0).radius = (SL_angle(handle, cell, 0).cwidth + SL_angle(handle, cell, 0).cheight) \ 4 ' calculate round collision radius

            IF NOT preloaded THEN

                degree = 0 '                                                                            reset degree counter
                DO '                                                                                    cycle from 1 to 359 degrees
                    degree = degree + 1 '                                                               increment degree counter
                    'px(0) = (-swidth + 1) / 2 '                                                         upper left  x polar coordinate of sprite
                    'py(0) = (-sheight + 1) / 2 '                                                        upper left  y polar coordinate of sprite
                    px(0) = -swidth / 2 '                                                               upper left  x polar coordinate of sprite
                    py(0) = -sheight / 2 '                                                              upper left  y polar coordinate of sprite
                    px(1) = px(0) '                                                                     lower left  x polar coordinate of sprite
                    'py(1) = (sheight -1) / 2 '                                                          lower left  y polar coordinate of sprite
                    'px(2) = (swidth - 1) / 2 '                                                          lower right x polar coordinate of sprite
                    py(1) = sheight / 2 '                                                               lower left  y polar coordinate of sprite
                    px(2) = swidth / 2 '                                                                lower right x polar coordinate of sprite
                    py(2) = py(1) '                                                                     lower right y polar coordinate of sprite
                    px(3) = px(2) '                                                                     upper right x polar coordinate of sprite
                    py(3) = py(0) '                                                                     upper right y polar coordinate of sprite
                    sinr = SIN(-degree / 57.2957795131) '                                               calculate the sin of rotation
                    cosr = COS(-degree / 57.2957795131) '                                               calculate the cosine of rotation
                    bx1 = 0 '                                                                           upper left x boundary of sprite
                    by1 = 0 '                                                                           upper left y boundary of sprite
                    bx2 = 0 '                                                                           lower right x boundary of sprite
                    by2 = 0 '                                                                           lower right y boundary of sprite

                    polar = 0 '                                                                         reset counter
                    DO '                                                                                cycle through all four polar coordinates (0 to 3)
                        x2 = (px(polar) * cosr + sinr * py(polar)) '                                    compute new polar coordinate location
                        y2 = (py(polar) * cosr - px(polar) * sinr) '                                    compute new polar coordinate location
                        px(polar) = x2 '                                                                save the new polar coordinate
                        py(polar) = y2 '                                                                save the new polar coordinate
                        IF px(polar) < bx1 THEN bx1 = px(polar) '                                       save lowest  x value seen \  NOTE: use for
                        IF px(polar) > bx2 THEN bx2 = px(polar) '                                       save highest x value seen  \ background image         <--------------------- LOOK
                        IF py(polar) < by1 THEN by1 = py(polar) '                                       save lowest  y value seen  / rectangle coordinates
                        IF py(polar) > by2 THEN by2 = py(polar) '                                       save highest y value seen /
                        polar = polar + 1 '                                                             increment counter
                    LOOP UNTIL polar = 4 '                                                              leave when all coordinates calculated

                    SL_angle(handle, cell, degree).rwidth = bx2 - bx1 + 1 '                             calculate width of rotated sprite
                    SL_angle(handle, cell, degree).rheight = by2 - by1 + 1 '                            calculate height of rotated sprite
                    xoffset = SL_angle(handle, cell, degree).rwidth \ 2 '                               calculate x offset
                    yoffset = SL_angle(handle, cell, degree).rheight \ 2 '                              calculate y offset
                    SL_angle(handle, cell, degree).px0 = px(0) + xoffset '                              add offsets to coordinates
                    SL_angle(handle, cell, degree).px1 = px(1) + xoffset
                    SL_angle(handle, cell, degree).px2 = px(2) + xoffset
                    SL_angle(handle, cell, degree).px3 = px(3) + xoffset
                    SL_angle(handle, cell, degree).py0 = py(0) + yoffset
                    SL_angle(handle, cell, degree).py1 = py(1) + yoffset
                    SL_angle(handle, cell, degree).py2 = py(2) + yoffset
                    SL_angle(handle, cell, degree).py3 = py(3) + yoffset

                    ' rotate image here to get rotated collision box info

                    tempsprite = _NEWIMAGE(SL_angle(handle, cell, degree).rwidth, SL_angle(handle, cell, degree).rheight, 32) ' create temp image using precalculated width/height
                _MAPTRIANGLE (0, 0)-(0, sheight - 1)-(swidth - 1, sheight - 1), SL_sheet(handle, cell).software TO _
                             (SL_angle(handle, cell, degree).px0, SL_angle(handle, cell, degree).py0)-(SL_angle(handle, cell, degree).px1,_
                              SL_angle(handle, cell, degree).py1)-(SL_angle(handle, cell, degree).px2, SL_angle(handle, cell, degree).py2), tempsprite ' map rotated sprite onto temp image
                _MAPTRIANGLE (0, 0)-(swidth - 1, 0)-(swidth - 1, sheight - 1), SL_sheet(handle, cell).software TO _
                             (SL_angle(handle, cell, degree).px0, SL_angle(handle, cell, degree).py0)-(SL_angle(handle, cell, degree).px3,_
                              SL_angle(handle, cell, degree).py3)-(SL_angle(handle, cell, degree).px2, SL_angle(handle, cell, degree).py2), tempsprite

                    ' precalculate rotated collision boundaries

                    _SOURCE tempsprite '                                                                work from the temp image
                    top = SL_angle(handle, cell, degree).rheight - 1 '                                  set initial collision boundary markers
                    left = SL_angle(handle, cell, degree).rwidth - 1
                    bottom = 0
                    right = 0

                    xwidth = 0 '                                                                        reset width counter
                    DO '                                                                                cycle through width of rotated sprite
                        yheight = 0 '                                                                   reset height counter
                        DO '                                                                            cycle through height of rotated sprite
                            IF POINT(xwidth, yheight) <> clearcolor THEN '                              is this pixel a transparent/background color?
                                IF xwidth < left THEN left = xwidth '                                   no, save position if left-most pixel
                                IF yheight < top THEN top = yheight '                                   save position if top-most pixel
                                IF xwidth > right THEN right = xwidth '                                 save position if right-most pixel
                                IF yheight > bottom THEN bottom = yheight '                             save position if bbottom-most pixel
                            END IF
                            yheight = yheight + 1 '                                                     increment height counter
                        LOOP UNTIL yheight = SL_angle(handle, cell, degree).rheight '                   leave when height of rotated sprite reached (-1)
                        xwidth = xwidth + 1 '                                                           increment width counter
                    LOOP UNTIL xwidth = SL_angle(handle, cell, degree).rwidth '                         leave when width of rotated sprite reached (-1)

                    _FREEIMAGE tempsprite '                                                             temp image no longer needed
                    SL_angle(handle, cell, degree).x1 = left '                                          collision box top left x
                    SL_angle(handle, cell, degree).y1 = top '                                           collision box top left y
                    SL_angle(handle, cell, degree).x2 = right '                                         collision box bottom right x
                    SL_angle(handle, cell, degree).y2 = bottom '                                        collision box bottom right y
                    SL_angle(handle, cell, degree).cwidth = right - left '                              remember collision box width
                    SL_angle(handle, cell, degree).cheight = bottom - top '                             remember collision box height
                    SL_angle(handle, cell, degree).radius = (SL_angle(handle, cell, degree).cwidth + SL_angle(handle, cell, degree).cheight) \ 4 ' calculate round collision radius
                LOOP UNTIL degree = 359 '                                                               leave when all degree angles calculated

            END IF ' preloaded

        LOOP UNTIL y = rows '                                                                           leave when all rows processed
    LOOP UNTIL x = columns '                                                                            leave when all columns processed

    _FREEIMAGE sheetimage '                                                                             sprite sheet image no longer needed

    _SOURCE osource '                                                                                   return source to current
    _DEST odest '                                                                                       return destination to current

    IF NOT _FILEEXISTS(rotfile) THEN '                                                                  does it exist?
        filenum = FREEFILE
        OPEN rotfile FOR BINARY AS filenum '                                                            no, open it for writing
        FOR x = 1 TO cells '                                                                            cycle through all sprite cells
            FOR y = 0 TO 359 '                                                                          and their rotational angles
                PUT #1, , SL_angle(handle, x, y) '                                                      put the data
            NEXT y
        NEXT x
        CLOSE filenum '                                                                                 close the file
    END IF

    SL_NEW_SHEET = handle '                                                                             return the handle number pointing to this sheet

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_VALID_SHEET (sheet AS INTEGER) '                                                                                                                                             SL_VALID_SHEET
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sheet() AS SL_SHEET '    master sprite sheet array

    IF (sheet > UBOUND(SL_sheet)) OR (sheet < 1) THEN '                                                 is this a valid sheet?
        SL_VALID_SHEET = 0 '                                                                   (FALSE)  no, return false
    ELSEIF NOT SL_sheet(sheet, 0).software THEN '                                                       is sprite sheet in use?
        SL_VALID_SHEET = 0 '                                                                   (FALSE)  no, return false
    ELSE '                                                                                              everything checks out
        SL_VALID_SHEET = -1 '                                                                   (TRUE)  return true
    END IF

END FUNCTION


'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴
'                                                                      ----------==========                   ==========----------
'                                                                      ----------========== INTERNAL USE ONLY ==========----------
'                                                                      ----------==========                   ==========----------
'袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴


'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_update_auto_sprites (software AS INTEGER) '                                                                                                                               SL_update_auto_sprites
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    ' declare global variables

    SHARED SL_sprite() AS SL_SPRITE '   master working sprite array
    SHARED SL_global AS SL_GLOBAL '     common globals array

    ' declare local variables

    DIM handle AS INTEGER '             handle of sprite
    DIM nextcell AS SINGLE '            draw (-1 TRUE) or skip (0 FALSE) next animation cell

    ' local variable setup

    handle = 0 '                                                                                        initialize handle counter

    DO '                                                                                                cycle through all sprite indexes
        handle = handle + 1 '                                                                           increment to next sprite handle
        IF SL_sprite(handle).software = software THEN '                                                 hardware or software type equal to requested type?
            IF SL_sprite(handle).inuse AND (SL_sprite(handle).motion.auto OR _
                                            SL_sprite(handle).rotation.auto OR _
                                            SL_sprite(handle).animation.auto) THEN '                    yes, is this sprite being used and automagically controlled?

                ' auto motion

                IF SL_sprite(handle).motion.auto THEN '                                                 yes, is auto motion enabled?
                    SL_sprite(handle).x.real = SL_sprite(handle).x.real + SL_sprite(handle).x.dir '     yes, update x location
                    SL_sprite(handle).y.real = SL_sprite(handle).y.real + SL_sprite(handle).y.dir '     update y location
                END IF


                ' auto animation

                IF SL_sprite(handle).animation.auto THEN '                                              is auto animation enabled?
                    IF SL_sprite(handle).animation.skip = 0 THEN '                                      yes, always go to next cell?
                        nextcell = -1 '                                                         (TRUE)  yes, draw next cell
                    ELSE '                                                                              no

                        ' decide to draw or skip next cell

                        SL_sprite(handle).animation.frame = SL_sprite(handle).animation.frame + 1 '     increment frame counter
                        IF SL_sprite(handle).animation.skip = SL_sprite(handle).animation.frame THEN '  time to skip or go to next cell?
                            SL_sprite(handle).animation.frame = 0 '                                     yes, reset the frame counter
                            IF SL_sprite(handle).animation.framerate >= SL_global.framerate \ 2 THEN '  should this cell be skipped?
                                nextcell = 0 '                                                 (FALSE)  yes, skip next cell
                            ELSE '                                                                      no
                                nextcell = -1 '                                                 (TRUE)  go to next cell
                            END IF
                        ELSEIF SL_sprite(handle).animation.framerate >= SL_global.framerate \ 2 THEN '  no, is sprite frame rate equal or greater than half global frame rate?
                            nextcell = -1 '                                                             yes, go to next cell
                        END IF
                    END IF

                    ' draw next cell

                    IF nextcell THEN '                                                                  update animation cell?
                        SELECT CASE SL_sprite(handle).animation.mode '                                  which animation mode is this sprite using?
                            CASE 0 '                                                      (SL_FORWARD)  move forward through the cells
                                SL_sprite(handle).animation.cell = SL_sprite(handle).animation.cell + 1 ' increment animation cell
                                IF SL_sprite(handle).animation.cell > SL_sprite(handle).animation.cellto THEN ' passed the last cell?
                                    SL_sprite(handle).animation.cell = SL_sprite(handle).animation.cellfrom ' yes, go back to first cell
                                END IF
                            CASE 1 '                                                     (SL_BACKWARD)  move backward through the cells
                                SL_sprite(handle).animation.cell = SL_sprite(handle).animation.cell - 1 ' decrement animation cell
                                IF SL_sprite(handle).animation.cell < SL_sprite(handle).animation.cellfrom THEN ' passed the first cell?
                                    SL_sprite(handle).animation.cell = SL_sprite(handle).animation.cellto ' yes, go back to last cell
                                END IF
                            CASE 2 '                                                    (SL_BACKFORTH)  ping-pong back and forth through the cells
                                SL_sprite(handle).animation.cell = SL_sprite(handle).animation.cell + SL_sprite(handle).animation.dir ' increment/decrement animation cell
                                IF SL_sprite(handle).animation.cell = SL_sprite(handle).animation.cellto OR _
                                    SL_sprite(handle).animation.cell = SL_sprite(handle).animation.cellfrom THEN ' is this the first or last cell?
                                    SL_sprite(handle).animation.dir = -SL_sprite(handle).animation.dir 'yes, reverse animation direction
                                END IF
                        END SELECT
                        SL_sprite(handle).cell = SL_sprite(handle).animation.cell '                     update current sprite cell
                        IF SL_sprite(handle).rotation.angle AND (NOT SL_sprite(handle).rotation.auto) THEN ' is this animation currently rotated but not automatic?
                            SL_ROTATE_SPRITE handle, SL_sprite(handle).rotation.angle '                 yes, this new cell will need manually rotated as well
                        END IF
                    END IF
                END IF

                ' auto rotation

                IF SL_sprite(handle).rotation.auto THEN '                                               is auto rotation enabled?
                    SL_ROTATE_SPRITE handle, SL_sprite(handle).rotation.angle + SL_sprite(handle).rotation.speed ' yes, rotate sprite to next degree angle
                END IF

                SL_PUT_SPRITE SL_sprite(handle).x.real, SL_sprite(handle).y.real, handle '              update sprite motion location, rotation, and animation
            END IF
        END IF
    LOOP UNTIL handle = UBOUND(SL_sprite) '                                                             leave when all indexes checked

END SUB

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_min (a AS INTEGER, b AS INTEGER) '                                                                                                                                                   SL_min
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    IF a < b THEN '                                                                                     is a the smaller number?
        SL_min = a '                                                                                    yes, return a
    ELSE '                                                                                              no, b is smaller number
        SL_min = b '                                                                                    return b (or a = b)
    END IF

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
FUNCTION SL_max (a AS INTEGER, b AS INTEGER) '                                                                                                                                                   SL_max
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    IF a > b THEN '                                                                                     is a the larger number?
        SL_max = a '                                                                                    yes, return a
    ELSE '                                                                                              no, b is the larger number
        SL_max = b '                                                                                    return b (or a = b)
    END IF

END FUNCTION

'    컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
SUB SL_error (routine AS STRING, errno AS INTEGER, info AS STRING) '                                                                                                                           SL_error
    '컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴

    SCREEN 0, 0, 0, 0 '                                                                                 go to a pure text screen
    _FONT 16 '                                                                                          set the standard screen 0 font
    IF _FULLSCREEN THEN _FULLSCREEN _OFF '                                                              turn off full screen if on
    _AUTODISPLAY '                                                                                      auto update the display
    CLS '                                                                                               clear the screen
    COLOR 10, 0
    PRINT "                   **************************************" '                                 print error header
    PRINT "                   ** Sprite Library Error Encountered **"
    PRINT "                   **************************************"
    PRINT
    COLOR 15, 0
    PRINT " "; routine;
    COLOR 7, 0
    PRINT " has reported error";
    COLOR 30, 0
    PRINT STR$(errno)
    COLOR 7, 0
    PRINT
    SELECT CASE errno '                                                                                 which error number is being reported?

        ' general purpose errors for all subs/functions

        CASE 1
            PRINT "- the requested sprite does not exist"
        CASE 2
            PRINT "- invalid background restore setting supplied - valid settings are"
            PRINT "- : -1 (constant SL_SAVE)"
            PRINT "- :  0 (constant SL_NOSAVE)"
        CASE 3
            PRINT "- invalid flip setting supplied - valid settings are"
            PRINT "- : 0 (constant SL_NOFLIP or SL_RESET)"
            PRINT "- : 1 (constant SL_HORIZONTAL)"
            PRINT "- : 2 (constant SL_VERTICAL)"
            PRINT "- : 3 (constant SL_FLIPBOTH)"
        CASE 4
            PRINT "- invalid zoom level setting supplied"
            PRINT "- zoom level must be greater than zero (0)"
        CASE 5
            PRINT "- the specified sprite sheet is not in use or does not exist"
        CASE 6
            PRINT "- invalid row or column selected for specified sprite sheet"
        CASE 7
            PRINT "- invalid auto motion behavior requested - valid settings are"
            PRINT "- : -1 (constant SL_START)"
            PRINT "- :  0 (constant SL_STOP)"
        CASE 8
            PRINT "- invalid auto rotation behavior requested - valid settings are"
            PRINT "- : -1 (constant SL_START)"
            PRINT "- :  0 (constant SL_STOP)"
        CASE 9
            PRINT "- rotation speed must be between -359 and 359 degrees"
        CASE 10
            PRINT "- frame rate must be greater than zero (0)"
        CASE 11
            PRINT "- frame rate must be greater than zero (0) and less than or equal"
            PRINT "- to the global frame rate"
        CASE 12
            PRINT "- incorrect animation direction mode setting - valid settings are"
            PRINT "- : 0 (constant SL_FORWARD)"
            PRINT "- : 1 (constant SL_BACKWARD)"
            PRINT "- : 2 (constant CL_BACKFORTH"
        CASE 13
            PRINT "- invalid cell value given - it must be greater than 0 and less"
            PRINT "- than or equal to the total number of animation cells on a sheet"
        CASE 14
            PRINT "- invalid auto animation behavior requested - valid settings are"
            PRINT "- : -1 (constant SL_START)"
            PRINT "- :  0 (constant SL_STOP)"
        CASE 15
            PRINT "- animation has not been assigned to this sprite - use"
            PRINT "- SL_SET_ANIMATION to assign animation to this sprite"
        CASE 16
            PRINT "- this srpite is already under auto motion control"
            PRINT "- use SL_CHANGE_AUTOMOTION to disable auto motion control"
        CASE 17
            PRINT "- this sprite is already under auto rotation control"
            PRINT "- use SL_CHANGE_AUTOROTATION to disable auto rotation control"
        CASE 18
            PRINT "- this sprite is already under auto animation control"
            PRINT "- use SL_CHNAGE_AUTOANIMATION to disable auto animation control"
        CASE 19
            PRINT "- the destination cell must be greater than the starting cell"
        CASE 20
            PRINT "- invalid visible setting reguested - valid setting are"
            PRINT "- : -1 (constant SL_SHOW)"
            PRINT "- :  0 (constant SL_HIDE)"
        CASE 21
            PRINT "- the sprite being checked for collisions has no collision detection"
            PRINT "- enabled - use SL_XXXXXXXXXX to turn on collision detection for"
            PRINT "- the sprite"
        CASE 22
            PRINT "- the sprite being checked for a collision with has no collision"
            PRINT "- detection enabled - use SL_XXXXXXX to turn on collision detection"
            PRINT "- for the sprite"
        CASE 23
            PRINT "- both sprites must have the same collision detection method"
        CASE 24
            PRINT "- invalid collision detection mode requested - valid settings are"
            PRINT "- : 0 (constant SL_NODETECT or SL_RESET)"
            PRINT "- : 1 (constant SL_BOXDETECT)"
            PRINT "- : 2 (constant SL_ROUNDDETECT)"
            PRINT "- : 3 (constant SL_PIXELDETECT)"
        CASE 25
            PRINT "- invalid layer requested - the layer does not exist"
        CASE 26
            PRINT "- you must create at least one (1) layer"

            ' errors belonging to SL_NEW_SHEET (100 - 109)

        CASE 100
            PRINT "- "; CHR$(34); info; CHR$(34); " sprite sheet does not exist"
            PRINT "- check path or spelling"
        CASE 101
            PRINT "- invalid transparency setting supplied - valid settings are"
            PRINT "- : -1 (constant SL_USESHEET)"
            PRINT "- :  0 (constant SL_SET)"
            PRINT "- :  1 (constant SL_NONE)"
        CASE 102
            PRINT "- sprite width and/or height must be greater than zero"
        CASE 103
            PRINT "- selecting to use a sheet's transparency only works with .PNG files"
            PRINT "- the function was passed a "; info; " file."
        CASE 104
            PRINT "- there must be at least one column and one row of sprites on sheet"
            PRINT "- the sheet being loaded does not meet these minimums"

            'errors belonging to SL_NEW_SPRITE (110 - 119)

            'CASE 110
            '    PRINT "- the specified sprite sheet is not in use or does not exist"
            'CASE 111
            '    PRINT "- invalid row or column selected for specified sprite sheet"
        CASE 112
            PRINT "- invalid hardware / software setting supplied - valid settings are"
            PRINT "- : -1 (constant SL_SOFTWARE)"
            PRINT "- :  0 (constant SL_HARDWARE)"
        CASE 113
            PRINT "- there is no need to restore the background with hardware sprites"
            PRINT "- change background restore setting to zero (0) (constant SL_NOSAVE)"

    END SELECT
    COLOR 12, 0
    PRINT
    PRINT " See sprite library doumentation for further explanation."
    COLOR 7, 0
    DO: LOOP UNTIL INKEY$ = "" '                                                                        clear the keyboard buffer
    END '                                                                                               end the program

END SUB

