'Simple scanner
'This could be a little faster :/
FOR port = 0 TO 65535
    port$ = STR$(port)
    _TITLE ("Scanning port " + port$ + " of 35535")
    p = _OPENCLIENT("TCP/IP:" + port$ + ":localhost")
    IF p THEN
        PRINT port$ + " - listening!"
    END IF
    CLOSE p
NEXT port

