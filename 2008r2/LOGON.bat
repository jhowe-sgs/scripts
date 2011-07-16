@ECHO OFF
NET USE * /delete /y

@ECHO **************************************************************************
@ECHO *                                                                        *
@ECHO * Mapping SGS Network Drives. Please do not close this window.           *
@ECHO * This window will automatically close when mapping is complete.         *
@ECHO *                                                                        *
@ECHO **************************************************************************

:PUBLIC

NET USER /domain %username% | find "Public Shares"
IF NOT ERRORLEVEL 1 (
  NET USE P: \\LAKSHMI\public
)

:QUICKBOOKS

NET USER /domain %username% | find "Quickbooks Shares"
IF NOT ERRORLEVEL 1 (
  NET USE Q: \\YEMOJA\quickbooks
)

:BUSINESS

NET USER /domain %username% | find "Business Shares"
IF NOT ERRORLEVEL 1 (
  NET USE N: \\YEMOJA\business
)

:HR

NET USER /domain %username% | find "Human Resources Shares"
IF NOT ERRORLEVEL 1 (
  NET USE R: \\YEMOJA\human-resources
)

:ACADEMICS

NET USER /domain %username% | find "Academics Shares"
IF NOT ERRORLEVEL 1 (
  NET USE X: \\LAKSHMI\academics
)

:ADMISSIONS

NET USER /domain %username% | find "Admissions Shares"
IF NOT ERRORLEVEL 1 (
  NET USE M: \\LAKSHMI\admissions
)

:DEVELOPMENT

NET USER /domain %username% | find "Development Shares"
IF NOT ERRORLEVEL 1 (
  NET USE V: \\LAKSHMI\development
)

:LEADERSHIP

NET USER /domain %username% | find "Leadership Shares"
IF NOT ERRORLEVEL 1 (
  NET USE L: \\LAKSHMI\leadership
)

:FACULTY
:STUDENTS
:END
