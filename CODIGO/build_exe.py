#!/usr/bin/env python3
"""
Script para construir el .exe de la aplicación usando PyInstaller
"""

import os
import sys
import subprocess
import shutil
from pathlib import Path

def main():
    """Construye el ejecutable de la aplicación."""
    
    # Obtener directorio base
    base_dir = Path(__file__).parent
    src_dir = base_dir / "src"
    dist_dir = base_dir / "dist"
    build_dir = base_dir / "build"
    
    print("=" * 60)
    print("COMPILANDO APLICACIÓN A .EXE")
    print("=" * 60)
    
    # Limpiar directorios anteriores
    print("\n[1/5] Limpiando directorios anteriores...")
    for directory in [dist_dir, build_dir]:
        if directory.exists():
            shutil.rmtree(directory)
            print(f"  ✓ Eliminado: {directory}")
    
    # Crear comando PyInstaller
    print("\n[2/5] Preparando PyInstaller...")
    
    spec_file = base_dir / "app.spec"
    icon_path = src_dir / "resources" / "icons" / "app.ico"
    
    # Crear spec file si no existe
    if not spec_file.exists():
        print("  ✓ Generando configuración de build...")
        
        # Comando básico - Usar --onedir para compilar más rápido
        cmd = [
            sys.executable,
            "-m", "PyInstaller",
            "--name", "AdminPanel",
            "--onedir",  # Más rápido que --onefile
            "--windowed",
            "-p", str(src_dir),
            "--add-data", f"{src_dir};src",
            "--add-data", f"{src_dir / 'resources'};resources",
            "--hidden-import=main_window",
            "--hidden-import=views",
            "--hidden-import=services",
            "--hidden-import=models",
            "--hidden-import=utils",
            "--hidden-import=controllers",
            "--hidden-import=PySide6",
            "--hidden-import=PySide6.QtCore",
            "--hidden-import=PySide6.QtGui",
            "--hidden-import=PySide6.QtWidgets",
            "--collect-all=PySide6",
            "--noupx",  # No comprimir para evitar problemas
            str(src_dir / "app.py")
        ]
        
        # Agregar icono si existe
        if icon_path.exists():
            cmd.insert(-1, "--icon")
            cmd.insert(-1, str(icon_path))
    else:
        print("  ✓ Usando spec file existente")
        cmd = [sys.executable, "-m", "PyInstaller", str(spec_file)]
    
    # Ejecutar PyInstaller
    print("\n[3/5] Compilando con PyInstaller...")
    try:
        result = subprocess.run(cmd, cwd=str(base_dir), check=True)
        if result.returncode == 0:
            print("  ✓ Compilación exitosa")
        else:
            print(f"  ✗ Error en compilación: {result.returncode}")
            return False
    except subprocess.CalledProcessError as e:
        print(f"  ✗ Error ejecutando PyInstaller: {e}")
        return False
    
    # Verificar que se creó el ejecutable
    print("\n[4/5] Verificando ejecutable...")
    exe_path = dist_dir / "AdminPanel.exe"
    if exe_path.exists():
        size_mb = exe_path.stat().st_size / (1024 * 1024)
        print(f"  ✓ Ejecutable creado: {exe_path}")
        print(f"  ✓ Tamaño: {size_mb:.2f} MB")
    else:
        print(f"  ✗ No se encontró el ejecutable en {exe_path}")
        return False
    
    # Crear carpeta de distribución limpia
    print("\n[5/5] Preparando distribución...")
    dist_clean = base_dir / "dist_final"
    if dist_clean.exists():
        shutil.rmtree(dist_clean)
    dist_clean.mkdir()
    
    # Copiar ejecutable
    shutil.copy(exe_path, dist_clean / "AdminPanel.exe")
    
    # Crear README
    readme_content = """# Admin Panel - Aplicación de Gestión

## Requisitos del Sistema
- Windows 7 o superior
- 500 MB de espacio en disco
- 2 GB de RAM mínimo

## Instalación
1. Descarga el archivo `AdminPanel.exe`
2. Ejecuta el instalador
3. Sigue las instrucciones en pantalla

## Credenciales de Prueba

### Administrador
- Email: admin@admin.com
- Contraseña: admin123

### Usuario Normal
- Email: user@test.com
- Contraseña: user123

## Funcionalidades

### Para Administradores
- Gestión completa de usuarios (crear, editar, eliminar)
- Gestión de documentos PDF
- Análisis de facturas
- Ver reportes
- Configuración del sistema

### Para Usuarios Normales
- Subir y gestionar documentos PDF
- Analizar facturas
- Ver su perfil
- Cambiar contraseña
- Acceso a reportes

## Características Principales

✓ Interfaz moderna y responsiva
✓ Autenticación segura
✓ Validación de datos en tiempo real
✓ Paginación de documentos
✓ Tema claro/oscuro
✓ Notificaciones en tiempo real
✓ Gestión de sesiones

## Soporte
Para reportar problemas o sugerencias, contacta al equipo de desarrollo.
"""
    
    with open(dist_clean / "README.txt", "w", encoding="utf-8") as f:
        f.write(readme_content)
    
    print(f"  ✓ Distribución lista en: {dist_clean}")
    
    print("\n" + "=" * 60)
    print("✓ COMPILACIÓN COMPLETADA EXITOSAMENTE")
    print("=" * 60)
    print(f"\nEl archivo ejecutable está en:")
    print(f"  {dist_clean / 'AdminPanel.exe'}")
    print("\nPuede distribuir la carpeta 'dist_final' a otros usuarios.")
    
    return True

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
