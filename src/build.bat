@echo off
echo Building 3D Renderer for NES...

REM Set paths to ca65 tools
set CA65_PATH=..\cc65\bin
set CA65=%CA65_PATH%\ca65.exe
set LD65=%CA65_PATH%\ld65.exe

REM Check if tools exist
if not exist "%CA65%" (
    echo Error: ca65.exe not found at %CA65%
    echo Please make sure the cc65 tools are in the correct location
    pause
    exit /b 1
)

if not exist "%LD65%" (
    echo Error: ld65.exe not found at %LD65%
    echo Please make sure the cc65 tools are in the correct location
    pause
    exit /b 1
)

REM Assemble the source file
echo Assembling 3DRenderer.asm...
"%CA65%" --cpu 6502x -o 3DRenderer.o 3DRenderer.asm

if errorlevel 1 (
    echo Assembly failed!
    pause
    exit /b 1
)

REM Link to create the NES ROM
echo Linking to create 3DRenderer.nes...
"%LD65%" -C nes.cfg -o 3DRenderer.nes 3DRenderer.o

if errorlevel 1 (
    echo Linking failed!
    pause
    exit /b 1
)

echo Build successful! 3DRenderer.nes created.
pause
