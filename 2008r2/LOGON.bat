@ECHO OFF
NET USE * /delete /y

@ECHO **************************************************************************
@ECHO *                                                                        *
@ECHO * Mapping SGS Network Drives. Please do not close this window.           *
@ECHO * This window will automatically close when mapping is completed.        *
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
  NET USE P: \\YEMOJA\quickbooks
)

:END
