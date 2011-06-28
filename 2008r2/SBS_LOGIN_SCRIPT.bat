REM @ECHO OFF
REM NET USE * /delete /y
REM

REM http://clintboessen.blogspot.com/2011/02/ifmemberexe-doesnt-work-windows.html

:PUBLIC

NET USER /domain %username% | find "Public Shares"
IF NOT ERRORLEVEL = 1 (
  NET USE P: \\LAKSHMI\public
)

GOTO END

:END
