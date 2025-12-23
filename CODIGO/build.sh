#!/bin/bash
# ============================================
# Script de Build para Linux/macOS
# Admin Panel - Aplicación de Gestión de Tareas
# ============================================

echo ""
echo "============================================"
echo "  Admin Panel - Build Script"
echo "============================================"
echo ""

# Verificar Python
if ! command -v python3 &> /dev/null; then
    echo "[ERROR] Python3 no encontrado. Por favor instale Python 3.10+"
    exit 1
fi

# Verificar pip
if ! command -v pip3 &> /dev/null; then
    echo "[ERROR] pip3 no encontrado."
    exit 1
fi

echo "[INFO] Instalando dependencias..."
pip3 install -r requirements.txt
if [ $? -ne 0 ]; then
    echo "[ERROR] Error al instalar dependencias"
    exit 1
fi

echo "[INFO] Instalando PyInstaller..."
pip3 install pyinstaller
if [ $? -ne 0 ]; then
    echo "[ERROR] Error al instalar PyInstaller"
    exit 1
fi

echo ""
echo "[INFO] Creando ejecutable..."
echo ""

# Crear ejecutable
pyinstaller \
    --name="AdminPanel" \
    --windowed \
    --onefile \
    --add-data="src/resources:resources" \
    --hidden-import="PySide6.QtCore" \
    --hidden-import="PySide6.QtGui" \
    --hidden-import="PySide6.QtWidgets" \
    --hidden-import="sqlalchemy" \
    src/app.py

if [ $? -ne 0 ]; then
    echo "[ERROR] Error al crear ejecutable"
    exit 1
fi

echo ""
echo "============================================"
echo "  Build completado exitosamente!"
echo "============================================"
echo ""
echo "El ejecutable se encuentra en: dist/AdminPanel"
echo ""

# Hacer ejecutable
chmod +x dist/AdminPanel 2>/dev/null
