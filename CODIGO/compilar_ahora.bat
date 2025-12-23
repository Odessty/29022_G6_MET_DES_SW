@echo off
setlocal enabledelayedexpansion

echo.
echo ============================================
echo   Compilando AdminPanel
echo   Espera 3-5 minutos SIN INTERRUPCIONES
echo ============================================
echo.

cd /d "%~dp0"

REM Limpiar
if exist dist rmdir /s /q dist >nul 2>&1
if exist build rmdir /s /q build >nul 2>&1
if exist dist_final rmdir /s /q dist_final >nul 2>&1

REM Compilar
call .venv\Scripts\pyinstaller.exe --name AdminPanel --onedir --windowed --add-data "src;." -y src\app.py

REM Verificar
if exist "dist\AdminPanel\AdminPanel.exe" (
    echo.
    echo ✓ COMPILACION EXITOSA!
    echo.
    
    mkdir dist_final >nul 2>&1
    xcopy "dist\AdminPanel" "dist_final\" /e /i /y /q
    
    echo El ejecutable esta en: dist_final\AdminPanel.exe
    echo.
    echo Puedes compartir la carpeta dist_final con otros usuarios.
    echo.
) else (
    echo.
    echo X ERROR: El ejecutable no se creo
    echo.
)

pause
