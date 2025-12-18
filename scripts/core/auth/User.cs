// ============================================================================
// USER MODEL (C#)
// ============================================================================
// Domain entity representing a user in the authentication system
//
// SOLID PRINCIPLES:
// [SRP] Single Responsibility: Represents user data only
// [OCP] Open/Closed: Can be extended with additional properties
//
// CLEAN ARCHITECTURE: Domain Layer (Entity)
// ============================================================================

using Godot;
using System.Collections.Generic;

namespace JuegoTest.Core.Auth;

public enum UserRole
{
	User,
	Admin
}

public partial class User : RefCounted
{
	public string Username { get; set; } = string.Empty;
	public string PasswordHash { get; set; } = string.Empty;
	public UserRole Role { get; set; } = UserRole.User;
	public bool IsLocked { get; set; } = false;
	public bool IsPermanentlyLocked { get; set; } = false;
	public int FailedAttempts { get; set; } = 0;
	public int UnlockCount { get; set; } = 0;

	public User() { }

	public User(string username, string passwordHash, UserRole role = UserRole.User)
	{
		Username = username;
		PasswordHash = passwordHash;
		Role = role;
		IsLocked = false;
		IsPermanentlyLocked = false;
		FailedAttempts = 0;
		UnlockCount = 0;
	}

	/// <summary>
	/// Check if this user is an administrator
	/// </summary>
	public bool IsAdmin() => Role == UserRole.Admin;

	/// <summary>
	/// Serialize user to dictionary for persistence
	/// </summary>
	public Godot.Collections.Dictionary ToDict()
	{
		return new Godot.Collections.Dictionary
		{
			["username"] = Username,
			["password_hash"] = PasswordHash,
			["role"] = (int)Role,
			["is_locked"] = IsLocked,
			["is_permanently_locked"] = IsPermanentlyLocked,
			["failed_attempts"] = FailedAttempts,
			["unlock_count"] = UnlockCount
		};
	}

	/// <summary>
	/// Deserialize user from dictionary
	/// </summary>
	public static User FromDict(Godot.Collections.Dictionary data)
	{
		return new User
		{
			Username = data.GetValueOrDefault("username", string.Empty).AsString(),
			PasswordHash = data.GetValueOrDefault("password_hash", string.Empty).AsString(),
			Role = (UserRole)data.GetValueOrDefault("role", 0).AsInt32(),
			IsLocked = data.GetValueOrDefault("is_locked", false).AsBool(),
			IsPermanentlyLocked = data.GetValueOrDefault("is_permanently_locked", false).AsBool(),
			FailedAttempts = data.GetValueOrDefault("failed_attempts", 0).AsInt32(),
			UnlockCount = data.GetValueOrDefault("unlock_count", 0).AsInt32()
		};
	}
}
