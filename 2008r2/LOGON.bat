@ECHO OFF
NET USE * /delete /y

REM http://clintboessen.blogspot.com/2011/02/ifmemberexe-doesnt-work-windows.html

:PUBLIC

NET USER /domain %username% | find "Public Shares"
IF NOT ERRORLEVEL 1 (
  NET USE P: \\LAKSHMI\public
)

:QUICKBOOKS

NET USER /domain %username% | find "Quickbooks Shares"
IF NOT ERRORLEVEL  1 (
  NET USE Q: \\YOMEJA\quickbooks
)


:ACADEMICS

:ADMISSIONS

:DEVELOPMENT

:LEADERSHIP

:FACULTY

:PAYROLL

:STUDENTS

:END
