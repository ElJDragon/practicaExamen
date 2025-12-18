// ============================================================================
// USER REPOSITORY (C#)
// ============================================================================
// Handles persistence and retrieval of user data
//
// DESIGN PATTERNS:
// [Repository Pattern] Abstracts data access layer
// [Singleton] Single instance through Godot autoload (via AuthService)
//
// SOLID PRINCIPLES:
// [SRP] Single Responsibility: User data persistence only
// [DIP] Dependency Inversion: Depends on User abstraction
//
// CLEAN ARCHITECTURE: Infrastructure Layer (Data Access)
// ============================================================================

using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace JuegoTest.Core.Auth;

public partial class UserRepository : RefCounted
{
    private const string SavePath = "user://users.save";

    /// <summary>
    /// Save all users to disk
    /// </summary>
    public bool SaveUsers(Dictionary<string, User> users)
    {
        using var file = FileAccess.Open(SavePath, FileAccess.ModeFlags.Write);
        if (file == null)
        {
            GD.PushError($"Failed to open file for writing: {SavePath}");
            return false;
        }

        var usersData = new Godot.Collections.Array();
        foreach (var user in users.Values)
        {
            usersData.Add(user.ToDict());
        }

        file.StoreVar(usersData);
        return true;
    }

    /// <summary>
    /// Load all users from disk
    /// </summary>
    public Dictionary<string, User> LoadUsers()
    {
        if (!FileAccess.FileExists(SavePath))
        {
            return CreateDefaultUsers();
        }

        using var file = FileAccess.Open(SavePath, FileAccess.ModeFlags.Read);
        if (file == null)
        {
            GD.PushError($"Failed to open file for reading: {SavePath}");
            return CreateDefaultUsers();
        }

        var usersData = file.GetVar();
        if (usersData.Obj == null || usersData.Obj is not Godot.Collections.Array array)
        {
            return CreateDefaultUsers();
        }

        var users = new Dictionary<string, User>();
        foreach (var item in array)
        {
            if (item.Obj is Godot.Collections.Dictionary dict)
            {
                var user = User.FromDict(dict);
                users[user.Username] = user;
            }
        }

        return users;
    }

    /// <summary>
    /// Create default users (admin and test user)
    /// </summary>
    private Dictionary<string, User> CreateDefaultUsers()
    {
        var users = new Dictionary<string, User>();

        // Admin user (username: admin, password: admin123)
        var admin = new User("admin", HashPassword("admin123"), UserRole.Admin);
        users["admin"] = admin;

        // Regular test user (username: player, password: player123)
        var player = new User("player", HashPassword("player123"), UserRole.User);
        users["player"] = player;

        SaveUsers(users);
        return users;
    }

    /// <summary>
    /// Hash password using SHA256 (for demo - use proper crypto in production)
    /// </summary>
    public static string HashPassword(string password)
    {
        using var sha256 = SHA256.Create();
        var bytes = Encoding.UTF8.GetBytes(password);
        var hash = sha256.ComputeHash(bytes);
        return BitConverter.ToString(hash).Replace("-", "").ToLowerInvariant();
    }
}
