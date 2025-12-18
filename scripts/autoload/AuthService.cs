// ============================================================================
// AUTHENTICATION SERVICE (C#)
// ============================================================================
// Centralized authentication logic with user management
//
// DESIGN PATTERNS:
// [Singleton] Through Godot autoload system
// [Service Locator] Provides authentication services globally
// [Observer] Emits signals for authentication events
//
// SOLID PRINCIPLES:
// [SRP] Single Responsibility: Authentication and user session management
// [OCP] Open/Closed: Extensible for new authentication methods
// [DIP] Dependency Inversion: Depends on User and UserRepository abstractions
//
// CLEAN ARCHITECTURE: Application Layer (Use Cases)
// ============================================================================

using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
using JuegoTest.Core.Auth;

namespace JuegoTest.Autoload;

public partial class AuthService : Node
{
	// Signals for authentication events
	[Signal] public delegate void LoginSucceededEventHandler(string username, bool isAdmin);
	[Signal] public delegate void LoginFailedEventHandler(string username, string reason);
	[Signal] public delegate void UserLockedEventHandler(string username, bool isPermanent);
	[Signal] public delegate void UserUnlockedEventHandler(string username);

	private User _currentUser;

	// User database with lock tracking
	private Dictionary<string, User> _users = new Dictionary<string, User>
	{
		{ "user123", new User("user123", "123", UserRole.User) },
		{ "admin", new User("admin", "admin123", UserRole.Admin) }
	};

	public override void _Ready()
	{
		GD.Print("=== AUTH SERVICE INITIALIZED (Lock Tracking Mode) ===");
	}

	/// <summary>
	/// Login with 3-attempt lockout system
	/// - Regular users: locked after 3 fails, can be unlocked by admin once
	/// - After unlock, 3 more fails = permanent lock
	/// - Admin never gets locked
	/// </summary>
	public bool Login(string username, string password)
	{
		if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
		{
			EmitSignal(SignalName.LoginFailed, username, "Usuario y contraseña no pueden estar vacíos");
			return false;
		}

		// Admin bypass - never locked
		if (username == "admin" && password == "admin123")
		{
			_currentUser = _users["admin"];
			EmitSignal(SignalName.LoginSucceeded, username, true);
			GD.Print($"Admin logged in successfully");
			return true;
		}

		// Check if user exists
		if (!_users.ContainsKey(username))
		{
			EmitSignal(SignalName.LoginFailed, username, "Usuario no existe");
			return false;
		}

		User user = _users[username];

		// Check permanent lock
		if (user.IsPermanentlyLocked)
		{
			EmitSignal(SignalName.LoginFailed, username, "Cuenta bloqueada PERMANENTEMENTE");
			EmitSignal(SignalName.UserLocked, username, true);
			return false;
		}

		// Check temporary lock
		if (user.IsLocked)
		{
			EmitSignal(SignalName.LoginFailed, username, "Cuenta bloqueada. Contacta al admin");
			EmitSignal(SignalName.UserLocked, username, false);
			return false;
		}

		// Validate password
		if (user.PasswordHash == password)
		{
			// Success - reset attempts
			user.FailedAttempts = 0;
			_currentUser = user;
			EmitSignal(SignalName.LoginSucceeded, username, user.IsAdmin());
			GD.Print($"User {username} logged in successfully");
			return true;
		}
		else
		{
			// Failed attempt
			user.FailedAttempts++;
			GD.Print($"Failed attempt {user.FailedAttempts}/3 for user {username}");

			if (user.FailedAttempts >= 3)
			{
				// Check if already unlocked before
				if (user.UnlockCount >= 1)
				{
					// Second lock = PERMANENT
					user.IsPermanentlyLocked = true;
					user.IsLocked = true;
					EmitSignal(SignalName.LoginFailed, username, "Cuenta BLOQUEADA PERMANENTEMENTE");
					EmitSignal(SignalName.UserLocked, username, true);
					GD.Print($"User {username} PERMANENTLY locked (unlock count: {user.UnlockCount})");
				}
				else
				{
					// First lock = temporary
					user.IsLocked = true;
					EmitSignal(SignalName.LoginFailed, username, "Cuenta bloqueada tras 3 intentos");
					EmitSignal(SignalName.UserLocked, username, false);
					GD.Print($"User {username} locked after 3 failed attempts");
				}
			}
			else
			{
				int remaining = 3 - user.FailedAttempts;
				EmitSignal(SignalName.LoginFailed, username, $"Contraseña incorrecta. {remaining} intentos restantes");
			}
			return false;
		}
	}

	/// <summary>
	/// Log out the current user
	/// </summary>
	public void Logout()
	{
		if (_currentUser != null)
		{
			GD.Print($"User logged out: {_currentUser.Username}");
			_currentUser = null;
		}
	}

	/// <summary>
	/// Check if a user is currently logged in
	/// </summary>
	public bool IsLoggedIn() => _currentUser != null;

	/// <summary>
	/// Get the current logged-in user
	/// </summary>
	public User GetCurrentUser() => _currentUser;

	/// <summary>
	/// Check if current user is admin
	/// </summary>
	public bool IsCurrentUserAdmin() => _currentUser?.IsAdmin() ?? false;

	/// <summary>
	/// Admin function: Unlock a user account
	/// Cannot unlock permanently locked users
	/// </summary>
	public bool UnlockUser(string username)
	{
		if (!IsCurrentUserAdmin())
		{
			GD.PushWarning("Only administrators can unlock users");
			return false;
		}

		if (!_users.ContainsKey(username))
		{
			GD.PrintErr($"User {username} not found");
			return false;
		}

		User user = _users[username];

		// Cannot unlock permanently locked users
		if (user.IsPermanentlyLocked)
		{
			GD.Print($"Cannot unlock permanently locked user {username}");
			EmitSignal(SignalName.UserUnlocked, username);
			return false;
		}

		// Unlock and reset
		user.IsLocked = false;
		user.FailedAttempts = 0;
		user.UnlockCount++;
		
		GD.Print($"User {username} unlocked (unlock count: {user.UnlockCount})");
		EmitSignal(SignalName.UserUnlocked, username);
		return true;
	}

	/// <summary>
	/// Admin function: Get all users with their lock status
	/// </summary>
	public List<User> GetAllUsers()
	{
		if (!IsCurrentUserAdmin())
		{
			GD.PushWarning("Only administrators can view all users");
			return new List<User>();
		}

		return _users.Values.ToList();
	}

	/// <summary>
	/// Admin function: Get all users as Godot dictionaries
	/// </summary>
	public Godot.Collections.Array<Godot.Collections.Dictionary> GetAllUsersDict()
	{
		var users = new Godot.Collections.Array<Godot.Collections.Dictionary>();
		
		foreach (var kvp in _users)
		{
			var user = kvp.Value;
			var userDict = new Godot.Collections.Dictionary
			{
				{ "username", user.Username },
				{ "role", user.Role.ToString() },
				{ "is_locked", user.IsLocked },
				{ "is_permanently_locked", user.IsPermanentlyLocked },
				{ "failed_attempts", user.FailedAttempts },
				{ "unlock_count", user.UnlockCount }
			};
			users.Add(userDict);
		}
		
		return users;
	}
}
