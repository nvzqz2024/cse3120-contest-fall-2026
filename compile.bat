
@echo off

REM Assemble
ml /c /coff Static_Grid.asm

IF ERRORLEVEL 1 (
    echo.
    echo Assembly failed!
    pause
    exit /b 1
)

REM Link
link /SUBSYSTEM:CONSOLE program.obj

IF ERRORLEVEL 1 (
    echo.
    echo Linking failed!
    pause
    exit /b 1
)

echo.
echo Compilation successful!
echo Executable: terminaltomb.exe

pause
