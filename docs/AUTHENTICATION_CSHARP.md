# Sistema de Autenticación en C# - JuegoGodot

## ✅ Conversión Completa a C#

Todo el sistema de autenticación ha sido convertido a **C# (.NET 8.0)** manteniendo la arquitectura Clean y patrones de diseño.

## 📁 Archivos C# Creados

### Core / Domain Layer
```
scripts/core/auth/
├── User.cs              # Entidad de dominio (Entity)
└── UserRepository.cs    # Capa de persistencia (Repository Pattern)
```

### Application Layer
```
scripts/autoload/
└── AuthService.cs       # Singleton de autenticación (Autoload)
```

### Presentation Layer
```
scripts/ui/
├── LoginController.cs          # Controlador de pantalla de login
└── AdminPanelController.cs     # Controlador de panel de admin
```

## 🔧 Configuración

### project.godot
El autoload está configurado para usar C#:
```ini
[autoload]
AuthService="*res://scripts/autoload/AuthService.cs"
```

### Escenas actualizadas
- `scenes/ui/login.tscn` → Usa `LoginController.cs`
- `scenes/ui/admin_panel.tscn` → Usa `AdminPanelController.cs`

## 💻 Uso desde C#

### Login
```csharp
// Obtener el servicio desde cualquier nodo
var authService = GetNode<AuthService>("/root/AuthService");

// Intentar login
if (authService.Login("player", "player123"))
{
    GD.Print("Login exitoso!");
}
```

### Verificar usuario actual
```csharp
var authService = GetNode<AuthService>("/root/AuthService");

if (authService.IsLoggedIn())
{
    var user = authService.GetCurrentUser();
    GD.Print($"Usuario: {user.Username}");
    GD.Print($"Es admin: {user.IsAdmin()}");
}
```

### Escuchar eventos (Signals)
```csharp
public override void _Ready()
{
    var authService = GetNode<AuthService>("/root/AuthService");
    
    authService.LoginSucceeded += OnLoginSuccess;
    authService.LoginFailed += OnLoginFailed;
}

private void OnLoginSuccess(string username, bool isAdmin)
{
    GD.Print($"{username} logged in (Admin: {isAdmin})");
}

private void OnLoginFailed(string username, string reason)
{
    GD.Print($"Login failed: {reason}");
}

// IMPORTANTE: Desconectar en _ExitTree
public override void _ExitTree()
{
    authService.LoginSucceeded -= OnLoginSuccess;
    authService.LoginFailed -= OnLoginFailed;
}
```

### Funciones de Admin
```csharp
var authService = GetNode<AuthService>("/root/AuthService");

// Obtener todos los usuarios (solo admin)
var users = authService.GetAllUsers();
foreach (var user in users)
{
    GD.Print($"{user.Username} - Locked: {user.IsLocked}");
}

// Desbloquear usuario (solo admin)
authService.UnlockUser("player");

// Crear nuevo usuario (solo admin)
authService.CreateUser("newuser", "password123", isAdmin: false);
```

## 🔐 Características de Seguridad

### Hashing de Contraseñas
```csharp
// En UserRepository.cs
public static string HashPassword(string password)
{
    using var sha256 = SHA256.Create();
    var bytes = Encoding.UTF8.GetBytes(password);
    var hash = sha256.ComputeHash(bytes);
    return BitConverter.ToString(hash).Replace("-", "").ToLowerInvariant();
}
```

## 🏗️ Arquitectura C#

### Namespaces
```csharp
JuegoTest.Core.Auth         // Domain entities & repositories
JuegoTest.Autoload          // Singleton services (autoloads)
JuegoTest.UI                // UI controllers
```

### Herencia de Godot
```csharp
User : RefCounted           // No necesita herencia de Node
UserRepository : RefCounted // Clase utilitaria
AuthService : Node          // Singleton autoload
LoginController : Control   // UI controller
AdminPanelController : Control
```

## 🎯 Diferencias vs GDScript

| Aspecto | GDScript | C# |
|---------|----------|-----|
| **Signals** | `signal login_succeeded(username, is_admin)` | `[Signal] public delegate void LoginSucceededEventHandler(string username, bool isAdmin);` |
| **Conectar** | `AuthService.login_succeeded.connect(_on_login)` | `authService.LoginSucceeded += OnLogin;` |
| **Desconectar** | No necesario (garbage collected) | `authService.LoginSucceeded -= OnLogin;` en `_ExitTree()` |
| **Diccionarios** | `Dictionary` | `Godot.Collections.Dictionary` o `Dictionary<K,V>` |
| **Arrays** | `Array` | `Godot.Collections.Array` o `List<T>` |
| **Hash** | `password.sha256_text()` | `SHA256.Create().ComputeHash(...)` |

## ⚠️ Notas Importantes

### 1. Build Requerido
Después de crear/modificar archivos C#, debes **compilar** el proyecto:
- En Godot: **Build → Build Project** (o Ctrl+Shift+B)
- Asegúrate de que no haya errores de compilación

### 2. Desconexión de Signals
En C#, es **crítico** desconectar los eventos en `_ExitTree()` para evitar memory leaks:
```csharp
public override void _ExitTree()
{
    authService.LoginSucceeded -= OnLoginSucceeded;
    authService.LoginFailed -= OnLoginFailed;
}
```

### 3. Nullable Reference Types
El código usa referencias nullables. Asegúrate de verificar:
```csharp
var user = authService.GetCurrentUser();
if (user != null)
{
    GD.Print(user.Username);
}
```

### 4. GetNode vs GetNodeOrNull
```csharp
// GetNode lanza excepción si no existe
var button = GetNode<Button>("MyButton");

// GetNodeOrNull retorna null si no existe
var button = GetNodeOrNull<Button>("MyButton");
```

## 🚀 Compilación y Ejecución

### Desde Godot Editor
1. Abre el proyecto en Godot
2. **Build → Build Project** (primera vez o tras cambios)
3. Presiona **F5** para ejecutar
4. Aparecerá la pantalla de login

### Desde línea de comandos
```bash
# Compilar
dotnet build JuegoTest.csproj

# Ejecutar en Godot
godot --path . --debug
```

## 🐛 Troubleshooting

### Error: "Cannot find type AuthService"
- Solución: Compila el proyecto (Build → Build Project)

### Error: "Object reference not set to an instance"
- Verifica que el nodo existe antes de usar `GetNode<T>()`
- Usa `GetNodeOrNull<T>()` y verifica null

### Error: "Signal handler not compatible"
- Verifica que la firma del delegate coincida con el método handler

### Los cambios en C# no se reflejan
- Re-compila el proyecto (Build → Build Project)
- Reinicia Godot si es necesario

## 📊 Estructura de Clases

```
RefCounted
    ├── User
    └── UserRepository

Node
    ├── AuthService (Singleton/Autoload)
    └── Control
        ├── LoginController
        └── AdminPanelController
```

## 🎓 Patrones en C#

### Singleton (Autoload)
```csharp
// AuthService.cs es un singleton mediante Godot autoload
var auth = GetNode<AuthService>("/root/AuthService");
```

### Repository Pattern
```csharp
// UserRepository abstrae la persistencia
private UserRepository _repository = new();
var users = _repository.LoadUsers();
```

### Observer (Events/Signals)
```csharp
// AuthService emite eventos
[Signal] public delegate void LoginSucceededEventHandler(...);

// Controladores se suscriben
authService.LoginSucceeded += OnLoginSuccess;
```

## ✨ Próximos Pasos Recomendados

1. **Unit Tests**: Crear pruebas unitarias con NUnit
2. **Async/Await**: Convertir operaciones de archivo a async
3. **Bcrypt**: Reemplazar SHA256 con Bcrypt para passwords
4. **Dependency Injection**: Usar DI container para mejor testabilidad
5. **Logging**: Implementar sistema de logging estructurado

## 📝 Usuarios por Defecto

```
Admin:
  Username: admin
  Password: admin123
  Role: Admin

Usuario Regular:
  Username: player
  Password: player123
  Role: User
```

---

**Todo el sistema está listo para usar en C#.** Compila el proyecto y ejecuta para probar el login.
