# Admin Panel - Aplicación de Gestión de Tareas

<div align="center">

![Python](https://img.shields.io/badge/Python-3.10+-blue.svg)
![PySide6](https://img.shields.io/badge/PySide6-Qt6-green.svg)
![SQLAlchemy](https://img.shields.io/badge/SQLAlchemy-2.0+-orange.svg)
![License](https://img.shields.io/badge/License-MIT-purple.svg)

**Aplicación de escritorio moderna con interfaz gráfica avanzada, animaciones fluidas y arquitectura modular.**

</div>

---

## 📋 Tabla de Contenidos

- [Características](#-características)
- [Requisitos](#-requisitos)
- [Instalación](#-instalación)
- [Uso](#-uso)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Historias de Usuario](#-historias-de-usuario)
- [Configuración](#-configuración)
- [Desarrollo](#-desarrollo)
- [Testing](#-testing)
- [Build y Distribución](#-build-y-distribución)
- [Licencia](#-licencia)

---

## ✨ Características

### Funcionalidades Principales

- 🔐 **Sistema de Autenticación Completo**
  - Login con validación
  - Registro de nuevos usuarios
  - Recuperación de contraseña
  - Gestión de sesiones

- 📊 **Dashboard Animado**
  - Estadísticas en tiempo real
  - Gráficos interactivos
  - Resumen de actividad

- ✅ **Gestión de Tareas (CRUD)**
  - Crear, editar, eliminar tareas
  - Estados: Pendiente, En Progreso, Completada, Cancelada
  - Prioridades: Alta, Media, Baja
  - Fechas de vencimiento

- 👥 **Gestión de Usuarios**
  - Roles: Admin, Manager, Usuario
  - Activar/desactivar usuarios
  - Perfiles editables

- 🔔 **Sistema de Notificaciones Toast**
  - Tipos: Info, Éxito, Advertencia, Error
  - Animaciones de entrada/salida
  - Posición configurable

- 🎨 **Temas Claro/Oscuro**
  - Cambio dinámico sin reinicio
  - Estilos modernos Neo-UI
  - Iconografía SVG consistente

- 📤 **Exportación de Datos**
  - Formato CSV
  - Formato JSON
  - Reportes personalizados

---

## 📦 Requisitos

### Sistema
- **Python**: 3.10 o superior
- **Sistema Operativo**: Windows 10+, macOS 10.14+, Linux (Ubuntu 20.04+)

### Dependencias Principales
```
PySide6>=6.5.0
SQLAlchemy>=2.0.0
python-dotenv>=1.0.0
pydantic>=2.0.0
```

---

## 🚀 Instalación

### 1. Clonar o descargar el proyecto

```bash
cd app
```

### 2. Crear entorno virtual (recomendado)

```bash
# Windows
python -m venv venv
venv\Scripts\activate

# macOS/Linux
python3 -m venv venv
source venv/bin/activate
```

### 3. Instalar dependencias

```bash
pip install -r requirements.txt
```

### 4. Configurar variables de entorno (opcional)

```bash
# Copiar archivo de ejemplo
cp .env.example .env

# Editar con tu configuración de base de datos
# Si no se configura, la app funciona en modo demo (en memoria)
```

### 5. Ejecutar la aplicación

```bash
python src/app.py
```

---

## 💻 Uso

### Modo Demo

La aplicación funciona en **modo demo** por defecto, sin necesidad de configurar una base de datos. Los datos se almacenan en memoria y se reinician al cerrar la aplicación.

**Credenciales de prueba:**
- Email: `admin@demo.com`
- Contraseña: `Admin123!`

### Modo Producción

Para usar una base de datos persistente, configura el archivo `.env`:

```env
DB_URL=postgresql://user:password@localhost:5432/admin_panel
# O SQLite:
DB_URL=sqlite:///data/app.db
```

---

## 📁 Estructura del Proyecto

```
app/
├── requirements.txt          # Dependencias del proyecto
├── .env.example             # Plantilla de configuración
├── README.md                # Este archivo
├── HU_MAPPING.md           # Mapeo de Historias de Usuario
│
└── src/
    ├── app.py               # Punto de entrada
    ├── main_window.py       # Ventana principal
    │
    ├── models/              # Modelos de datos
    │   ├── __init__.py
    │   └── models.py        # User, Task, Settings
    │
    ├── views/               # Interfaces de usuario
    │   ├── __init__.py
    │   ├── login_view.py
    │   ├── register_view.py
    │   ├── recovery_view.py
    │   ├── dashboard_view.py
    │   ├── tasks_view.py
    │   ├── users_view.py
    │   ├── profile_view.py
    │   ├── settings_view.py
    │   └── reports_view.py
    │
    ├── controllers/         # Lógica de negocio
    │   ├── __init__.py
    │   ├── auth_controller.py
    │   ├── task_controller.py
    │   ├── user_controller.py
    │   ├── settings_controller.py
    │   └── export_controller.py
    │
    ├── services/            # Servicios y acceso a datos
    │   ├── __init__.py
    │   ├── db.py
    │   ├── auth_service.py
    │   ├── task_service.py
    │   ├── export_service.py
    │   └── config_service.py
    │
    ├── utils/               # Utilidades
    │   ├── __init__.py
    │   ├── animations.py
    │   ├── notifications.py
    │   └── helpers.py
    │
    ├── resources/           # Recursos estáticos
    │   ├── __init__.py
    │   ├── styles/
    │   │   ├── dark_theme.qss
    │   │   └── light_theme.qss
    │   └── icons/
    │       └── *.svg
    │
    └── tests/               # Pruebas unitarias
        ├── __init__.py
        ├── test_auth_service.py
        ├── test_task_service.py
        └── test_helpers.py
```

---

## 📖 Historias de Usuario

| ID | Historia | Archivo(s) Principal(es) |
|----|----------|--------------------------|
| HU001 | Autenticación de usuario | `login_view.py`, `auth_service.py` |
| HU002 | Recuperación de contraseña | `recovery_view.py`, `auth_service.py` |
| HU003 | Registro de usuarios | `register_view.py`, `users_view.py` |
| HU004 | Dashboard animado | `dashboard_view.py`, `animations.py` |
| HU005 | Gestión de tareas | `tasks_view.py`, `task_service.py` |
| HU006 | Notificaciones toast | `notifications.py` |
| HU007 | Cambio de tema | `settings_view.py`, `*.qss` |
| HU008 | Perfil de usuario | `profile_view.py`, `auth_service.py` |
| HU009 | Exportación de datos | `reports_view.py`, `export_service.py` |
| HU010 | Configuración general | `settings_view.py`, `config_service.py` |

Ver [HU_MAPPING.md](HU_MAPPING.md) para detalles completos.

---

## ⚙️ Configuración

### Variables de Entorno

| Variable | Descripción | Valor por Defecto |
|----------|-------------|-------------------|
| `DB_URL` | URL de conexión a base de datos | `None` (modo demo) |
| `DEBUG` | Modo de depuración | `False` |
| `LOG_LEVEL` | Nivel de logging | `INFO` |

### Configuración de Usuario

Las preferencias del usuario se guardan automáticamente:

- **Tema**: Claro/Oscuro
- **Notificaciones**: Habilitadas/Deshabilitadas
- **Timeout de sesión**: 5-480 minutos
- **Idioma**: Español/Inglés

---

## 🛠️ Desarrollo

### Requisitos de Desarrollo

```bash
pip install -r requirements.txt
pip install pytest pytest-cov black flake8
```

### Estilo de Código

El proyecto sigue PEP 8. Usar Black para formateo:

```bash
black src/
```

### Agregar Nuevas Vistas

1. Crear archivo en `src/views/nuevo_view.py`
2. Heredar de `QWidget` e implementar `animate_in()`
3. Agregar señales para navegación
4. Registrar en `main_window.py`
5. Actualizar `views/__init__.py`

### Agregar Nuevos Servicios

1. Crear archivo en `src/services/nuevo_service.py`
2. Implementar patrón Singleton si es necesario
3. Agregar modo demo con datos en memoria
4. Agregar tests en `src/tests/`
5. Actualizar `services/__init__.py`

---

## 🧪 Testing

### Ejecutar Tests

```bash
# Todos los tests
pytest src/tests/ -v

# Con cobertura
pytest src/tests/ --cov=src --cov-report=html

# Tests específicos
pytest src/tests/test_auth_service.py -v
```

### Estructura de Tests

- `test_auth_service.py`: Pruebas de autenticación
- `test_task_service.py`: Pruebas de gestión de tareas
- `test_helpers.py`: Pruebas de utilidades y validadores

---

## 📦 Build y Distribución

### Crear Ejecutable con PyInstaller

```bash
# Instalar PyInstaller
pip install pyinstaller

# Crear ejecutable (Windows)
pyinstaller --name="AdminPanel" --windowed --onefile src/app.py

# Con icono personalizado
pyinstaller --name="AdminPanel" --windowed --onefile --icon=src/resources/icons/app_icon.ico src/app.py
```

### Scripts de Build

**Windows (build.bat):**
```batch
@echo off
pip install pyinstaller
pyinstaller --name="AdminPanel" --windowed --onefile src/app.py
echo Build completado. Ejecutable en dist/AdminPanel.exe
```

**Linux/macOS (build.sh):**
```bash
#!/bin/bash
pip install pyinstaller
pyinstaller --name="AdminPanel" --windowed --onefile src/app.py
echo "Build completado. Ejecutable en dist/AdminPanel"
```

---

## 📝 Notas de la Versión

### v1.0.0 (Actual)
- ✅ Sistema de autenticación completo
- ✅ Dashboard con estadísticas
- ✅ CRUD de tareas
- ✅ Gestión de usuarios
- ✅ Temas claro/oscuro
- ✅ Notificaciones toast
- ✅ Exportación CSV/JSON
- ✅ Modo demo (sin DB)

### Próximas Mejoras (v1.1.0)
- [ ] Filtros avanzados en tareas
- [ ] Gráficos con Matplotlib/Plotly
- [ ] Sistema de etiquetas
- [ ] Adjuntos en tareas
- [ ] Modo offline completo

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver [LICENSE](LICENSE) para más detalles.

---

## 👥 Contribuciones

Las contribuciones son bienvenidas. Por favor:

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Crea un Pull Request

---

<div align="center">

**Desarrollado con ❤️ usando Python y PySide6**

</div>
