@echo off
REM Compilar AdminPanel con PyInstaller - Versión simplificada

echo.
echo ============================================
echo   Compilando AdminPanel...
echo   Por favor, espera (esto puede tomar 3-5 min)
echo ============================================
echo.

REM Asegurarse de que estamos en la carpeta correcta
cd /d "%~dp0"

REM Limpiar compilaciones anteriores
if exist "dist" rmdir /s /q "dist"
if exist "build" rmdir /s /q "build"
if exist "dist_final" rmdir /s /q "dist_final"

REM Compilar con PyInstaller
.venv\Scripts\pyinstaller.exe ^
  --name AdminPanel ^
  --onedir ^
  --windowed ^
  --add-data "src;src" ^
  --add-data "src\resources;resources" ^
  --hidden-import=main_window ^
  --hidden-import=views ^
  --hidden-import=services ^
  --hidden-import=models ^
  --hidden-import=utils ^
  --hidden-import=controllers ^
  --collect-all=PySide6 ^
  --noupx ^
  src\app.py

REM Verificar si fue exitoso
if exist "dist\AdminPanel\AdminPanel.exe" (
    echo.
    echo ============================================
    echo   EXITO! Aplicacion compilada
    echo ============================================
    
    REM Crear carpeta dist_final
    mkdir dist_final
    xcopy "dist\AdminPanel\*" "dist_final\" /e /i /y
    
    REM Crear README
    (
        echo Admin Panel - Aplicacion de Gestion
        echo.
        echo Credenciales de Prueba:
        echo.
        echo Admin:
        echo   Email: admin@admin.com
        echo   Contraseña: admin123
        echo.
        echo Usuario Normal:
        echo   Email: user@test.com
        echo   Contraseña: user123
    ) > dist_final\README.txt
    
    echo.
    echo El ejecutable esta en: dist_final\AdminPanel.exe
    echo.
) else (
    echo.
    echo ERROR: No se creo el ejecutable correctamente
    echo.
)

pause
