@echo off
title Auto OTServ Restarter

:begin
tasklist /FI "IMAGENAME eq the.exe" 2>NUL | find /I /N "the.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo the.exe is executing.
) else (
    echo theforgottenserver.exe is not executing. Restarting...
    start "" the.exe
)

timeout /t 5 >nul
goto begin