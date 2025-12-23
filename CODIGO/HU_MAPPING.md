# Mapeo de Historias de Usuario

Este documento detalla cómo cada Historia de Usuario (HU) se implementa en el código fuente.

---

## HU001 - Autenticación de Usuario

**Como** usuario registrado  
**Quiero** poder iniciar sesión con mi email y contraseña  
**Para** acceder a las funcionalidades del sistema

### Archivos Involucrados

| Archivo | Propósito |
|---------|-----------|
| `src/views/login_view.py` | Interfaz de login con campos email/password |
| `src/services/auth_service.py` | Lógica de autenticación y validación |
| `src/controllers/auth_controller.py` | Controlador que conecta vista con servicio |
| `src/utils/helpers.py` | Validadores de email y password |

### Criterios de Aceptación

- [x] Formulario con campos email y contraseña
- [x] Validación de formato de email
- [x] Mensaje de error para credenciales inválidas
- [x] Redirección a dashboard tras login exitoso
- [x] Animación de entrada del formulario

### Código Clave

```python
# login_view.py - Señales emitidas
login_success = Signal(dict)  # Emitida con datos del usuario
register_requested = Signal()  # Para ir a registro
recovery_requested = Signal()  # Para recuperar contraseña
```

---

## HU002 - Recuperación de Contraseña

**Como** usuario que olvidó su contraseña  
**Quiero** poder solicitar un enlace de recuperación  
**Para** restablecer mi acceso al sistema

### Archivos Involucrados

| Archivo | Propósito |
|---------|-----------|
| `src/views/recovery_view.py` | Formulario de recuperación |
| `src/services/auth_service.py` | Método `request_password_recovery()` |
| `src/controllers/auth_controller.py` | Método `recover_password()` |

### Criterios de Aceptación

- [x] Formulario con campo de email
- [x] Validación de email registrado
- [x] Mensaje de confirmación de envío
- [x] Opción de volver al login
- [x] Animación de entrada

### Código Clave

```python
# auth_service.py
def request_password_recovery(self, email: str) -> Tuple[bool, str]:
    # En modo demo, simula el envío
    # En producción, enviaría email real
```

---

## HU003 - Registro de Usuarios

**Como** administrador  
**Quiero** poder registrar nuevos usuarios  
**Para** dar acceso al sistema a mi equipo

### Archivos Involucrados

| Archivo | Propósito |
|---------|-----------|
| `src/views/register_view.py` | Formulario de auto-registro |
| `src/views/users_view.py` | CRUD completo de usuarios (admin) |
| `src/services/auth_service.py` | Método `register()` |
| `src/controllers/user_controller.py` | Gestión de usuarios |

### Criterios de Aceptación

- [x] Formulario con nombre, email, contraseña
- [x] Validación de contraseña segura
- [x] Confirmación de contraseña
- [x] Verificación de email único
- [x] Asignación de roles (admin)
- [x] Lista de usuarios con acciones

### Código Clave

```python
# users_view.py - Diálogo de creación
class UserDialog(QDialog):
    # Campos: nombre, email, password, rol
    # Validaciones integradas
```

---

## HU004 - Dashboard Animado

**Como** usuario autenticado  
**Quiero** ver un dashboard con resumen de información  
**Para** tener una vista rápida del estado del sistema

### Archivos Involucrados

| Archivo | Propósito |
|---------|-----------|
| `src/views/dashboard_view.py` | Vista del dashboard |
| `src/utils/animations.py` | Animaciones de entrada |
| `src/services/task_service.py` | Datos de tareas |

### Criterios de Aceptación

- [x] Tarjetas con estadísticas (total tareas, completadas, etc.)
- [x] Animación de entrada escalonada (staggered)
- [x] Efecto de fade-in en elementos
- [x] Gráfico de resumen (placeholder)
- [x] Actividad reciente

### Código Clave

```python
# animations.py
class AnimationHelper:
    @staticmethod
    def staggered_fade_in(widgets, delay_between=100):
        # Anima widgets uno por uno con delay
```

---

## HU005 - Gestión de Tareas

**Como** usuario  
**Quiero** crear, editar, eliminar y ver tareas  
**Para** organizar mi trabajo

### Archivos Involucrados

| Archivo | Propósito |
|---------|-----------|
| `src/views/tasks_view.py` | Vista CRUD de tareas |
| `src/services/task_service.py` | Operaciones de datos |
| `src/controllers/task_controller.py` | Lógica de negocio |
| `src/models/models.py` | Modelo Task, enums de estado/prioridad |

### Criterios de Aceptación

- [x] Lista de tareas con búsqueda
- [x] Filtros por estado y prioridad
- [x] Crear tarea con título, descripción, prioridad, fecha
- [x] Editar tarea existente
- [x] Eliminar tarea con confirmación
- [x] Cambiar estado de tarea
- [x] Indicadores visuales de prioridad

### Código Clave

```python
# models.py
class TaskStatus(str, Enum):
    PENDING = "pending"
    IN_PROGRESS = "in_progress"
    COMPLETED = "completed"
    CANCELLED = "cancelled"

class TaskPriority(str, Enum):
    LOW = "low"
    MEDIUM = "medium"
    HIGH = "high"
```

---

## HU006 - Notificaciones Toast

**Como** usuario  
**Quiero** recibir notificaciones visuales de las acciones  
**Para** saber si mis operaciones fueron exitosas

### Archivos Involucrados

| Archivo | Propósito |
|---------|-----------|
| `src/utils/notifications.py` | Sistema de notificaciones toast |
| `src/main_window.py` | NotificationManager integrado |

### Criterios de Aceptación

- [x] Notificaciones tipo toast (esquina superior derecha)
- [x] Tipos: info, success, warning, error
- [x] Iconos y colores diferenciados
- [x] Animación de entrada (slide + fade)
- [x] Auto-cierre con timeout configurable
- [x] Botón de cerrar manual

### Código Clave

```python
# notifications.py
class ToastNotification(QFrame):
    TYPES = {
        "info": ("#3498db", "ℹ"),
        "success": ("#27ae60", "✓"),
        "warning": ("#f39c12", "⚠"),
        "error": ("#e74c3c", "✕")
    }
```

---

## HU007 - Cambio de Tema

**Como** usuario  
**Quiero** poder cambiar entre tema claro y oscuro  
**Para** personalizar la apariencia según mi preferencia

### Archivos Involucrados

| Archivo | Propósito |
|---------|-----------|
| `src/views/settings_view.py` | Control de tema |
| `src/main_window.py` | Aplicación de tema |
| `src/resources/styles/dark_theme.qss` | Estilos oscuros |
| `src/resources/styles/light_theme.qss` | Estilos claros |
| `src/services/config_service.py` | Persistencia de preferencia |

### Criterios de Aceptación

- [x] Toggle o selector de tema
- [x] Cambio dinámico sin reinicio
- [x] Persistencia de preferencia
- [x] Icono de sol/luna en header
- [x] Estilos consistentes en toda la app

### Código Clave

```python
# main_window.py
def _apply_theme(self, theme: str):
    theme_file = f"resources/styles/{theme}_theme.qss"
    with open(theme_file, 'r') as f:
        self.setStyleSheet(f.read())
```

---

## HU008 - Perfil de Usuario

**Como** usuario autenticado  
**Quiero** poder ver y editar mi perfil  
**Para** mantener mi información actualizada

### Archivos Involucrados

| Archivo | Propósito |
|---------|-----------|
| `src/views/profile_view.py` | Vista de perfil |
| `src/services/auth_service.py` | Actualización de datos |
| `src/controllers/auth_controller.py` | Cambio de contraseña |

### Criterios de Aceptación

- [x] Mostrar nombre, email, rol
- [x] Editar nombre
- [x] Cambiar contraseña (actual + nueva + confirmar)
- [x] Validación de contraseña segura
- [x] Mensaje de confirmación de cambios

### Código Clave

```python
# profile_view.py
def _save_profile(self):
    # Actualiza nombre
    # Valida y cambia contraseña si se proporciona
```

---

## HU009 - Exportación de Datos

**Como** usuario con permisos  
**Quiero** exportar datos a CSV/JSON  
**Para** generar reportes o backups

### Archivos Involucrados

| Archivo | Propósito |
|---------|-----------|
| `src/views/reports_view.py` | Vista de reportes |
| `src/services/export_service.py` | Generación de archivos |
| `src/controllers/export_controller.py` | Lógica de exportación |

### Criterios de Aceptación

- [x] Selector de tipo de datos (tareas, usuarios)
- [x] Selector de formato (CSV, JSON)
- [x] Vista previa de datos
- [x] Diálogo de guardar archivo
- [x] Notificación de éxito/error

### Código Clave

```python
# export_service.py
class ExportService:
    def export_to_csv(self, data: List[dict], filename: str) -> str
    def export_to_json(self, data: List[dict], filename: str) -> str
```

---

## HU010 - Configuración General

**Como** administrador  
**Quiero** configurar ajustes generales del sistema  
**Para** personalizar el comportamiento de la aplicación

### Archivos Involucrados

| Archivo | Propósito |
|---------|-----------|
| `src/views/settings_view.py` | Vista de configuración |
| `src/services/config_service.py` | Gestión de settings |
| `src/controllers/settings_controller.py` | Lógica de configuración |

### Criterios de Aceptación

- [x] Configuración de tema (HU007)
- [x] Toggle de notificaciones
- [x] Timeout de sesión (slider/spinbox)
- [x] Selector de idioma (placeholder)
- [x] Botón de guardar cambios
- [x] Botón de restaurar valores por defecto

### Código Clave

```python
# config_service.py
class ConfigService:
    DEFAULT_SETTINGS = {
        "theme": "dark",
        "notifications_enabled": True,
        "session_timeout": 30,
        "language": "es",
        "auto_save": True
    }
```

---

## Matriz de Trazabilidad

| Componente | HU001 | HU002 | HU003 | HU004 | HU005 | HU006 | HU007 | HU008 | HU009 | HU010 |
|------------|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|
| login_view.py | ✓ | | | | | | | | | |
| register_view.py | | | ✓ | | | | | | | |
| recovery_view.py | | ✓ | | | | | | | | |
| dashboard_view.py | | | | ✓ | | | | | | |
| tasks_view.py | | | | | ✓ | | | | | |
| users_view.py | | | ✓ | | | | | | | |
| profile_view.py | | | | | | | | ✓ | | |
| settings_view.py | | | | | | | ✓ | | | ✓ |
| reports_view.py | | | | | | | | | ✓ | |
| auth_service.py | ✓ | ✓ | ✓ | | | | | ✓ | | |
| task_service.py | | | | ✓ | ✓ | | | | ✓ | |
| export_service.py | | | | | | | | | ✓ | |
| config_service.py | | | | | | | ✓ | | | ✓ |
| animations.py | | | | ✓ | | | | | | |
| notifications.py | | | | | | ✓ | | | | |
| dark_theme.qss | | | | | | | ✓ | | | |
| light_theme.qss | | | | | | | ✓ | | | |

---

## Notas de Implementación

### Modo Demo vs Producción

Todas las Historias de Usuario funcionan en **modo demo** (datos en memoria):

```python
# Detectar modo
if os.getenv("DB_URL"):
    # Modo producción con SQLAlchemy
else:
    # Modo demo con datos en memoria
```

### Animaciones

Todas las vistas implementan el método `animate_in()` para HU004:

```python
def animate_in(self):
    AnimationHelper.fade_in(self, duration=300)
```

### Señales Qt

La comunicación entre componentes usa el sistema de señales de Qt:

```python
# Emisión
self.login_success.emit(user_data)

# Conexión
self.login_view.login_success.connect(self._on_login_success)
```
