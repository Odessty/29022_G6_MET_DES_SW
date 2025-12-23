# Guía para Generar el .EXE de la Aplicación

## Requisitos Previos

1. **Python 3.10+** instalado en tu sistema
2. **Virtualenv activado** con todas las dependencias instaladas
3. Estar en el directorio raíz del proyecto

## Pasos para Compilar

### Opción 1: Usando Script Batch (Recomendado para Windows)

1. Abre el explorador de archivos
2. Navega a la carpeta raíz del proyecto: `C:\Universidad\3er Semestre\app`
3. Haz doble clic en **`build.bat`**
4. Espera a que se complete el proceso (puede tomar 5-10 minutos)
5. El ejecutable estará en la carpeta **`dist_final`**

### Opción 2: Usando Terminal (PowerShell)

```powershell
# 1. Navega a la carpeta del proyecto
cd "C:\Universidad\3er Semestre\app"

# 2. Activa el entorno virtual (si no lo está)
.\.venv\Scripts\Activate.ps1

# 3. Instala PyInstaller
pip install pyinstaller

# 4. Ejecuta el script de build
python build_exe.py
```

### Opción 3: Comando PyInstaller Directo

```powershell
# Navega a la carpeta del proyecto
cd "C:\Universidad\3er Semestre\app"

# Ejecuta PyInstaller
pyinstaller --name AdminPanel `
    --onefile `
    --windowed `
    --add-data "src/resources;resources" `
    --add-data "src/views;views" `
    --add-data "src/services;services" `
    --add-data "src/models;models" `
    --add-data "src/utils;utils" `
    --collect-all=PySide6 `
    --hidden-import=PySide6 `
    --hidden-import=PySide6.QtCore `
    --hidden-import=PySide6.QtGui `
    --hidden-import=PySide6.QtWidgets `
    src/app.py
```

## Resultado

Una vez completado, encontrarás:

- **`dist_final/AdminPanel.exe`** - Ejecutable listo para distribuir
- **`dist_final/README.txt`** - Instrucciones para el usuario
- **`dist/`** - Carpeta de compilación (puedes eliminarla)
- **`build/`** - Carpeta temporal (puedes eliminarla)

## Distribución

Para distribuir la aplicación:

1. Copia la carpeta **`dist_final`** a donde quieras distribuirla
2. Renómbrala según tu preferencia (ej: `AdminPanel_v1.0`)
3. Empaqueta en un `.zip` si lo deseas
4. Distribuye al usuario

## Credenciales de Prueba

El usuario puede usar estas credenciales para probar:

**Administrador:**
- Email: `admin@admin.com`
- Contraseña: `admin123`

**Usuario Normal:**
- Email: `user@test.com`
- Contraseña: `user123`

## Posibles Problemas

### Error: "pyinstaller no encontrado"
```powershell
pip install pyinstaller
```

### Error: "Module not found"
Asegúrate de que todas las dependencias de `requirements.txt` están instaladas:
```powershell
pip install -r requirements.txt
```

### El .exe no inicia
- Verifica que tengas Visual C++ Runtime instalado
- Intenta ejecutar desde terminal para ver el error exacto
- Descarga el Visual C++ Redistributable de Microsoft

### Tamaño del ejecutable muy grande
Es normal con PySide6. El tamaño típico es 200-300 MB.

## Optimizaciones Disponibles

Si quieres reducir el tamaño:

```powershell
# Usar UPX para comprimir (requiere descargar UPX)
pyinstaller --upx-dir=ruta/a/upx ... src/app.py
```

## Automatizar Builds Futuros

Puedes crear un script que incluya versionado:

```powershell
$version = "1.0.0"
$timestamp = Get-Date -Format "yyyy-MM-dd_HHmm"
$outputDir = "releases\AdminPanel_v${version}_${timestamp}"

# ... crear la carpeta y compilar...
```

## Soporte

Para problemas con PyInstaller, consulta:
- [Documentación oficial de PyInstaller](https://pyinstaller.org/)
- [PySide6 + PyInstaller Guide](https://doc.qt.io/qt-6/pyinstaller.html)
