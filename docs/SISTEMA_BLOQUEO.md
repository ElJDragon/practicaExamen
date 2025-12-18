# Sistema de Bloqueo de Cuentas - Documentación

## 📋 Resumen del Sistema

Sistema de autenticación con bloqueo progresivo de cuentas tras intentos fallidos de login.

## 🔐 Características Principales

### 1. **Sistema de 3 Intentos**
- Los usuarios tienen 3 intentos para ingresar la contraseña correcta
- Cada fallo se cuenta y se muestra cuántos intentos quedan
- Al fallar 3 veces: la cuenta se **bloquea temporalmente**

### 2. **Bloqueo Temporal**
- Después de 3 intentos fallidos, la cuenta queda bloqueada
- El usuario no puede iniciar sesión
- **Solo el administrador puede desbloquear la cuenta**
- Estado: `IsLocked = true`, `IsPermanentlyLocked = false`

### 3. **Bloqueo Permanente**
- Si el admin desbloquea una cuenta y el usuario vuelve a fallar 3 veces más
- La cuenta se **bloquea permanentemente**
- **El admin NO puede desbloquear cuentas con bloqueo permanente**
- Estado: `IsLocked = true`, `IsPermanentlyLocked = true`

### 4. **Excepción del Admin**
- El usuario `admin` **nunca** se bloquea
- Puede fallar el login todas las veces necesarias
- Siempre tiene acceso al panel de administración

## 📊 Estados de Usuario

| Estado | `IsLocked` | `IsPermanentlyLocked` | `UnlockCount` | Descripción |
|--------|------------|----------------------|---------------|-------------|
| **Activo** | `false` | `false` | 0+ | Usuario puede iniciar sesión |
| **Bloqueado Temporal** | `true` | `false` | 0 | Primera vez bloqueado, admin puede desbloquear |
| **Desbloqueado** | `false` | `false` | 1 | Ya fue desbloqueado una vez |
| **Bloqueado Permanente** | `true` | `true` | 1+ | No se puede desbloquear |

## 🔄 Flujo de Bloqueo

```
Usuario normal (user123/123)
    ↓
Fallo 1 → Mensaje: "Contraseña incorrecta. 2 intentos restantes"
    ↓
Fallo 2 → Mensaje: "Contraseña incorrecta. 1 intento restante"
    ↓
Fallo 3 → Mensaje: "Cuenta bloqueada tras 3 intentos"
    ↓
Estado: IsLocked = true, UnlockCount = 0
    ↓
Admin desbloquea → UnlockCount = 1, IsLocked = false, FailedAttempts = 0
    ↓
Fallo 1 (después de desbloqueo) → 2 intentos restantes
    ↓
Fallo 2 → 1 intento restante
    ↓
Fallo 3 → "Cuenta BLOQUEADA PERMANENTEMENTE"
    ↓
Estado: IsPermanentlyLocked = true
    ↓
Admin NO puede desbloquear (botón deshabilitado)
```

## 👤 Usuarios del Sistema

### Usuario Normal
```csharp
Username: "user123"
Password: "123"
Role: User
```

### Usuario Administrador
```csharp
Username: "admin"
Password: "admin123"
Role: Admin
```

## 🛠️ Implementación Técnica

### Modelo de Usuario (`User.cs`)

```csharp
public partial class User : RefCounted
{
    public string Username { get; set; }
    public string PasswordHash { get; set; }
    public UserRole Role { get; set; }
    public bool IsLocked { get; set; }                    // Bloqueo temporal o permanente
    public bool IsPermanentlyLocked { get; set; }         // Solo bloqueo permanente
    public int FailedAttempts { get; set; }               // Contador 0-3
    public int UnlockCount { get; set; }                  // Veces que admin ha desbloqueado
}
```

### Servicio de Autenticación (`AuthService.cs`)

#### Método `Login()`
```csharp
public bool Login(string username, string password)
{
    // 1. Admin bypass - nunca se bloquea
    if (username == "admin" && password == "admin123")
        return true;

    // 2. Verificar si usuario existe
    if (!_users.ContainsKey(username))
        return false;

    User user = _users[username];

    // 3. Verificar bloqueo permanente
    if (user.IsPermanentlyLocked)
    {
        EmitSignal(SignalName.UserLocked, username, true);
        return false;
    }

    // 4. Verificar bloqueo temporal
    if (user.IsLocked)
    {
        EmitSignal(SignalName.UserLocked, username, false);
        return false;
    }

    // 5. Validar contraseña
    if (user.PasswordHash == password)
    {
        user.FailedAttempts = 0;  // Reset al login exitoso
        return true;
    }
    else
    {
        user.FailedAttempts++;
        
        if (user.FailedAttempts >= 3)
        {
            if (user.UnlockCount >= 1)
            {
                // Segunda vez = PERMANENTE
                user.IsPermanentlyLocked = true;
                user.IsLocked = true;
            }
            else
            {
                // Primera vez = TEMPORAL
                user.IsLocked = true;
            }
        }
        return false;
    }
}
```

#### Método `UnlockUser()`
```csharp
public bool UnlockUser(string username)
{
    if (!IsCurrentUserAdmin())
        return false;

    User user = _users[username];

    // NO desbloquear si es permanente
    if (user.IsPermanentlyLocked)
        return false;

    // Desbloquear y contar
    user.IsLocked = false;
    user.FailedAttempts = 0;
    user.UnlockCount++;
    
    return true;
}
```

## 🎨 Panel de Administrador

### Características
- Lista de todos los usuarios con su estado
- Colores visuales:
  - 🟢 Verde: Usuario activo
  - 🟡 Amarillo: Intentos fallidos pero no bloqueado
  - 🟠 Naranja: Bloqueado temporalmente (desbloqueable)
  - 🔴 Rojo: Bloqueado permanentemente (no desbloqueable)

### Información Mostrada
```
user123 [BLOQUEADO - Desbloqueable]
  Usuario: user123
  Rol: User
  Intentos fallidos: 3/3
  Veces desbloqueado: 0
  Estado: Bloqueado temporalmente (Puede ser desbloqueado)
  [Botón: Desbloquear Usuario]

user123 [BLOQUEADO PERMANENTE]
  Usuario: user123
  Rol: User
  Intentos fallidos: 3/3
  Veces desbloqueado: 1
  Estado: BLOQUEADO PERMANENTEMENTE (No se puede desbloquear)
  [Botón: Deshabilitado]
```

## 🎯 Casos de Uso

### Caso 1: Usuario se equivoca 2 veces
1. Usuario ingresa contraseña incorrecta → "2 intentos restantes"
2. Usuario ingresa contraseña incorrecta → "1 intento restante"
3. Usuario ingresa contraseña **correcta** → Login exitoso, `FailedAttempts = 0`

### Caso 2: Usuario se bloquea por primera vez
1. Usuario falla 3 veces → Cuenta bloqueada temporalmente
2. Admin entra al Panel Admin
3. Admin selecciona usuario y hace click en "Desbloquear Usuario"
4. Usuario puede volver a intentar (`FailedAttempts = 0`, `UnlockCount = 1`)

### Caso 3: Usuario se bloquea permanentemente
1. Usuario fue desbloqueado una vez (`UnlockCount = 1`)
2. Usuario vuelve a fallar 3 intentos
3. Sistema bloquea permanentemente (`IsPermanentlyLocked = true`)
4. Admin ve estado "BLOQUEADO PERMANENTE"
5. Botón de desbloqueo está deshabilitado

## 📁 Archivos Modificados

### Modelo y Lógica
- ✅ `scripts/core/auth/User.cs` - Agregados campos de bloqueo
- ✅ `scripts/autoload/AuthService.cs` - Lógica de bloqueo implementada

### Controladores UI
- ✅ `scripts/ui/LoginController.cs` - Mensajes de bloqueo
- ✅ `scripts/ui/AdminPanelController.cs` - Panel de gestión

### Escenas
- ✅ `scenes/ui/login.tscn` - UI simplificada
- ✅ `scenes/ui/admin_panel.tscn` - Panel de administrador
- ✅ `scenes/ui/menu.tscn` - Botón de acceso a admin panel

### Configuración
- ✅ `project.godot` - AuthService como autoload

## 🔧 Configuración de Proyecto

### Autoload (project.godot)
```ini
[autoload]
AuthService="*res://scripts/autoload/AuthService.cs"
```

### Escena Inicial
```ini
[application]
run/main_scene="res://scenes/ui/login.tscn"
```

## 🧪 Pruebas Sugeridas

### Test 1: Bloqueo Temporal
1. Iniciar juego → Pantalla de login
2. Usuario: `user123`, Contraseña: `wrong1` → 2 intentos restantes
3. Contraseña: `wrong2` → 1 intento restante
4. Contraseña: `wrong3` → "Cuenta bloqueada tras 3 intentos"
5. Intentar login nuevamente → "Cuenta bloqueada. Contacta al admin"

### Test 2: Desbloqueo por Admin
1. Cerrar y abrir juego
2. Usuario: `admin`, Contraseña: `admin123` → Login exitoso
3. Click en "🔒 Panel Admin" (esquina superior derecha)
4. Seleccionar `user123 [BLOQUEADO - Desbloqueable]`
5. Click en "Unlock User"
6. Ver mensaje "¡Usuario user123 desbloqueado exitosamente!"
7. Volver al login → Usuario `user123` puede intentar de nuevo

### Test 3: Bloqueo Permanente
1. Usuario `user123` ya desbloqueado una vez
2. Fallar 3 intentos nuevamente
3. Ver mensaje "Cuenta BLOQUEADA PERMANENTEMENTE"
4. Admin entra al panel
5. Seleccionar `user123 [BLOQUEADO PERMANENTE]`
6. Botón "Unlock User" está deshabilitado
7. Mensaje: "No se puede desbloquear - bloqueo permanente"

### Test 4: Admin Nunca se Bloquea
1. Usuario: `admin`, Contraseña: `wrong` (100 veces)
2. Siempre muestra "Contraseña incorrecta"
3. Nunca se bloquea
4. Con contraseña correcta → Siempre puede entrar

## 📝 Notas Adicionales

### Persistencia
- Actualmente usa diccionario en memoria (`Dictionary<string, User>`)
- Los datos se pierden al cerrar el juego
- Para persistencia real, descomentar código de `UserRepository.cs`

### Seguridad
- Contraseñas hardcodeadas solo para demostración
- En producción: usar `UserRepository` con SHA256 hashing
- Implementar rate limiting para prevenir ataques de fuerza bruta

### Extensibilidad
- Se puede agregar tiempo de espera antes de desbloqueo automático
- Se puede implementar sistema de recuperación por email
- Se puede agregar logs de intentos fallidos con timestamps

## 🎨 Colores del Panel Admin

```csharp
// Usuario Admin
Colors.Gold → (1, 0.85, 0.4)

// Usuario Activo
new Color(0.3f, 1.0f, 0.3f) → Verde claro

// Intentos Fallidos (no bloqueado)
Colors.Yellow → (1, 1, 0)

// Bloqueado Temporal
new Color(1.0f, 0.6f, 0.2f) → Naranja

// Bloqueado Permanente
new Color(0.8f, 0.2f, 0.2f) → Rojo oscuro
```

## ✅ Checklist de Implementación

- [x] Modelo User con campos de bloqueo
- [x] Lógica de 3 intentos en AuthService.Login()
- [x] Bloqueo temporal tras 3 fallos
- [x] Bloqueo permanente tras segundo bloqueo
- [x] Admin puede desbloquear usuarios temporales
- [x] Admin NO puede desbloquear usuarios permanentes
- [x] Admin nunca se bloquea
- [x] Panel de administrador con lista de usuarios
- [x] Botón de desbloqueo con validación
- [x] Mensajes en español
- [x] Colores visuales por estado
- [x] Navegación desde menú principal
- [x] Botón admin visible solo para admins

## 🚀 Próximos Pasos (Opcionales)

1. **Persistencia**: Activar `UserRepository` para guardar datos
2. **Logs**: Registrar intentos fallidos con timestamps
3. **Email Recovery**: Sistema de recuperación de contraseña
4. **Auto-unlock**: Desbloqueo automático tras X tiempo
5. **Captcha**: Agregar después de 2 intentos fallidos
6. **Notificaciones**: Alertar admin cuando usuario se bloquea

---

**Autor**: Sistema de Autenticación Godot C#  
**Versión**: 1.0  
**Fecha**: Diciembre 2025
