@echo off

REM Set up VS
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars32.bat"

REM Assemble
ml /c /coff /I "C:\Irvine" Static_Grid.asm

IF ERRORLEVEL 1 (
    echo.
    echo Assembly failed!
    pause
    exit /b 1
)

REM Link
link /SUBSYSTEM:CONSOLE /LIBPATH:"C:\Irvine" Static_Grid.obj Irvine32.lib kernel32.lib user32.lib

IF ERRORLEVEL 1 (
    echo.
    echo Linking failed!
    pause
    exit /b 1
)

echo.
echo Compilation successful!
echo Executable: Static_Grid.exe

pause
