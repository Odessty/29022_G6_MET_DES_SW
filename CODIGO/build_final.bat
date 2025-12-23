@echo off
REM Compilar AdminPanel - Version SIMPLIFICADA

echo.
echo ============================================
echo   Compilando AdminPanel...
echo ============================================
echo.

cd /d "%~dp0"

REM Limpiar
if exist "dist" rmdir /s /q "dist" 2>nul
if exist "build" rmdir /s /q "build" 2>nul
if exist "dist_final" rmdir /s /q "dist_final" 2>nul

REM Compilar SOLO con lo esencial
.venv\Scripts\pyinstaller.exe ^
  --name AdminPanel ^
  --onedir ^
  --windowed ^
  --add-data "src;." ^
  --collect-all=PySide6 ^
  src\app.py

REM Si fue exitoso
if exist "dist\AdminPanel\AdminPanel.exe" (
    echo.
    echo EXITO!
    mkdir dist_final 2>nul
    xcopy "dist\AdminPanel" "dist_final\" /e /i /y >nul
    
    echo El ejecutable esta en: dist_final\AdminPanel.exe
    echo.
) else (
    echo ERROR en la compilacion
)

pause
