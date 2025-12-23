@echo off
REM ============================================
REM Script de Build para Windows
REM Admin Panel - Aplicación de Gestión de Tareas
REM ============================================

echo.
echo ============================================
echo   Admin Panel - Compilar a .EXE
echo ============================================
echo.
echo.

REM Verificar Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python no encontrado. Por favor instale Python 3.10+
    pause
    exit /b 1
)

REM Verificar pip
pip --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] pip no encontrado.
    pause
    exit /b 1
)

echo [INFO] Instalando dependencias...
pip install -r requirements.txt
if errorlevel 1 (
    echo [ERROR] Error al instalar dependencias
    pause
    exit /b 1
)

echo [INFO] Instalando PyInstaller...
pip install pyinstaller
if errorlevel 1 (
    echo [ERROR] Error al instalar PyInstaller
    pause
    exit /b 1
)

echo.
echo [INFO] Creando ejecutable...
echo.

REM Crear ejecutable
pyinstaller ^
    --name="AdminPanel" ^
    --windowed ^
    --onefile ^
    --add-data="src/resources;resources" ^
    --hidden-import="PySide6.QtCore" ^
    --hidden-import="PySide6.QtGui" ^
    --hidden-import="PySide6.QtWidgets" ^
    --hidden-import="sqlalchemy" ^
REM Verificar que exista el venv
if not exist ".venv\Scripts\python.exe" (
    echo [ERROR] Entorno virtual no encontrado
    echo Por favor, ejecuta primero: python -m venv .venv
    pause
    exit /b 1
)

echo [1/2] Instalando PyInstaller...
.venv\Scripts\pip.exe install -q pyinstaller

echo [2/2] Generando ejecutable...
.venv\Scripts\python.exe build_exe.py

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ============================================
    echo   EXITO! Aplicacion compilada
    echo ============================================
    echo.
    echo El ejecutable se encuentra en:
    echo   dist_final\AdminPanel.exe
    echo.
    pause
) else (
    echo [ERROR] Error al crear ejecutable
    pause
    exit /b 1
)
