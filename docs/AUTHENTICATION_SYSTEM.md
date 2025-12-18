# Sistema de Autenticación - JuegoGodot

## Descripción General

Sistema completo de autenticación con login, gestión de usuarios, bloqueo automático y panel de administración implementado con Clean Architecture y patrones de diseño.

## Características Principales

### 🔐 Autenticación Segura
- Login con usuario y contraseña
- Hash SHA-256 para almacenamiento seguro de contraseñas
- Validación de credenciales
- Sesión de usuario persistente

### 🚫 Protección contra Fuerza Bruta
- Bloqueo automático tras 3 intentos fallidos
- Contador de intentos fallidos por usuario
- Mensajes informativos de intentos restantes

### 👨‍💼 Panel de Administración
- Acceso exclusivo para administradores
- Visualización de todos los usuarios registrados
- Desbloqueo de cuentas bloqueadas
- Indicadores visuales de estado (bloqueado, admin, intentos fallidos)

### 💾 Persistencia de Datos
- Almacenamiento local en `user://users.save`
- Carga y guardado automático de usuarios
- Usuarios por defecto pre-configurados

## Arquitectura

### Clean Architecture

```
┌─────────────────────────────────────────┐
│     Presentation Layer (UI)             │
│  - login_controller.gd                  │
│  - admin_panel_controller.gd            │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│     Application Layer (Use Cases)       │
│  - auth_service.gd (Singleton)          │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│     Domain Layer (Entities)             │
│  - user.gd                              │
└─────────────────────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│  Infrastructure Layer (Data Access)     │
│  - user_repository.gd                   │
└─────────────────────────────────────────┘
```

### Patrones de Diseño Implementados

1. **Singleton Pattern**
   - `AuthService` como autoload de Godot
   - Única instancia global accesible desde cualquier escena

2. **Repository Pattern**
   - `UserRepository` abstrae la lógica de persistencia
   - Separación clara entre dominio y acceso a datos

3. **MVP (Model-View-Presenter)**
   - Controllers actúan como Presenters
   - Vista (UI) separada de la lógica de negocio

4. **Observer Pattern**
   - Signals de Godot para eventos de autenticación
   - Desacoplamiento entre componentes

### Principios SOLID Aplicados

- **[SRP]** Cada clase tiene una única responsabilidad
- **[OCP]** Abierto a extensión, cerrado a modificación
- **[DIP]** Dependencia de abstracciones, no concreciones

## Estructura de Archivos

```
scripts/
├── autoload/
│   └── auth_service.gd          # Singleton de autenticación
├── core/
│   └── auth/
│       ├── user.gd              # Entidad de dominio
│       └── user_repository.gd   # Capa de persistencia
└── ui/
    ├── login_controller.gd      # Controlador de login
    └── admin_panel_controller.gd # Controlador de admin

scenes/
└── ui/
    ├── login.tscn               # Escena de login
    └── admin_panel.tscn         # Escena de administración
```

## Usuarios por Defecto

### Usuario Admin
- **Username:** `admin`
- **Password:** `admin123`
- **Role:** Administrator
- **Privilegios:** Puede desbloquear usuarios

### Usuario Regular
- **Username:** `player`
- **Password:** `player123`
- **Role:** User
- **Privilegios:** Acceso básico al juego

## Flujo de Uso

### Login Normal
1. Usuario ingresa credenciales
2. Sistema valida contra la base de datos
3. Si es correcto: redirige al menú principal
4. Si es incorrecto: muestra error y cuenta intento

### Bloqueo de Usuario
1. Usuario falla 3 intentos consecutivos
2. Cuenta se bloquea automáticamente
3. Se muestra mensaje de contactar administrador
4. Usuario no puede iniciar sesión hasta ser desbloqueado

### Desbloqueo por Admin
1. Admin ingresa con sus credenciales
2. Accede al panel de administración
3. Selecciona usuario bloqueado en la lista
4. Presiona "Unlock User"
5. Usuario puede volver a intentar login

## API del AuthService

### Métodos Públicos

```gdscript
# Intenta iniciar sesión
func login(username: String, password: String) -> bool

# Cierra sesión del usuario actual
func logout() -> void

# Verifica si hay un usuario logueado
func is_logged_in() -> bool

# Obtiene el usuario actual
func get_current_user() -> User

# Verifica si el usuario actual es admin
func is_current_user_admin() -> bool

# [Admin] Desbloquea un usuario
func unlock_user(username: String) -> bool

# [Admin] Obtiene lista de todos los usuarios
func get_all_users() -> Array

# [Admin] Crea un nuevo usuario
func create_user(username: String, password: String, is_admin: bool) -> bool
```

### Signals

```gdscript
signal login_succeeded(username: String, is_admin: bool)
signal login_failed(username: String, reason: String)
signal user_locked(username: String)
signal user_unlocked(username: String)
```

## Ejemplo de Uso

### Login desde cualquier script:

```gdscript
# Intentar login
if AuthService.login("player", "player123"):
    print("Login exitoso!")
else:
    print("Login fallido")

# Verificar si está logueado
if AuthService.is_logged_in():
    var user = AuthService.get_current_user()
    print("Usuario actual: ", user.username)
```

### Escuchar eventos de autenticación:

```gdscript
func _ready():
    AuthService.login_succeeded.connect(_on_login_success)
    AuthService.login_failed.connect(_on_login_failed)

func _on_login_success(username: String, is_admin: bool):
    print("%s logged in (Admin: %s)" % [username, is_admin])

func _on_login_failed(username: String, reason: String):
    print("Login failed for %s: %s" % [username, reason])
```

## Seguridad

### Implementaciones Actuales
- Hashing SHA-256 de contraseñas
- No se almacenan contraseñas en texto plano
- Bloqueo automático tras intentos fallidos

### Mejoras Futuras Recomendadas
- Salt aleatorio para cada contraseña
- Bcrypt o Argon2 en lugar de SHA-256
- Timeout de sesión automático
- Logs de auditoría de accesos
- Captcha tras primer intento fallido
- Recuperación de contraseña por email

## Extensibilidad

### Agregar nuevos roles:

```gdscript
# En user.gd
enum Role {
    USER,
    ADMIN,
    MODERATOR,  # Nuevo rol
    DEVELOPER   # Nuevo rol
}
```

### Agregar nuevos métodos de autenticación:

```gdscript
# En auth_service.gd
func login_with_token(token: String) -> bool:
    # Implementar autenticación por token
    pass

func login_with_oauth(provider: String) -> bool:
    # Implementar OAuth
    pass
```

## Troubleshooting

### El archivo de usuarios no se guarda
- Verificar permisos de escritura en `user://`
- Revisar consola para errores de FileAccess

### Usuario no se desbloquea
- Asegurarse de estar logueado como admin
- Verificar que el usuario esté efectivamente bloqueado
- Revisar consola para mensajes de error

### La escena de login no aparece
- Verificar que `run/main_scene` en `project.godot` apunte a `res://scenes/ui/login.tscn`
- Confirmar que el autoload `AuthService` está configurado

## Licencia

Este código forma parte del proyecto JuegoGodot y está disponible para uso educativo.
