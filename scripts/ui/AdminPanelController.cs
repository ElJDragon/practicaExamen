// ============================================================================
// ADMIN PANEL CONTROLLER (C#)
// ============================================================================
// UI controller for administrative functions
//
// DESIGN PATTERNS:
// [MVP - Presenter] Mediates between View and AuthService
//
// SOLID PRINCIPLES:
// [SRP] Single Responsibility: Handle admin UI logic only
//
// CLEAN ARCHITECTURE: Presentation Layer
// ============================================================================

using Godot;
using System;
using JuegoTest.Autoload;
using JuegoTest.Core.Auth;

namespace JuegoTest.UI;

public partial class AdminPanelController : Control
{
    private Button _backButton;
    private ItemList _userList;
    private Button _unlockButton;
    private Button _refreshButton;
    private Label _messageLabel;

    private const string LoginScene = "res://scenes/ui/login.tscn";

    private AuthService _authService;

    public override void _Ready()
    {
        // Get node references
        _backButton = GetNode<Button>("Panel/VBoxContainer/BackButton");
        _userList = GetNode<ItemList>("Panel/VBoxContainer/UserListContainer/UserList");
        _unlockButton = GetNode<Button>("Panel/VBoxContainer/ActionButtons/UnlockButton");
        _refreshButton = GetNode<Button>("Panel/VBoxContainer/ActionButtons/RefreshButton");
        _messageLabel = GetNode<Label>("Panel/VBoxContainer/MessageLabel");

        // Get AuthService singleton
        _authService = GetNode<AuthService>("/root/AuthService");

        // Setup UI
        _messageLabel.Text = "";
        _unlockButton.Disabled = true;

        // Connect signals
        _backButton.Pressed += OnBackButtonPressed;
        _unlockButton.Pressed += OnUnlockButtonPressed;
        _refreshButton.Pressed += OnRefreshButtonPressed;
        _userList.ItemSelected += OnUserSelected;

        // Connect to AuthService signals
        _authService.UserUnlocked += OnUserUnlocked;

        // Load users
        RefreshUserList();
    }

    private void OnBackButtonPressed()
    {
        GetTree().ChangeSceneToFile(LoginScene);
    }

    private void OnUnlockButtonPressed()
    {
        var selectedItems = _userList.GetSelectedItems();
        if (selectedItems.Length == 0)
        {
            ShowMessage("Por favor selecciona un usuario", Colors.Yellow);
            return;
        }

        var selectedIndex = selectedItems[0];
        var itemText = _userList.GetItemText(selectedIndex);
        var username = itemText.Split(' ')[0];

        // Get user to check status
        var users = _authService.GetAllUsers();
        var user = users.Find(u => u.Username == username);

        if (user == null)
        {
            ShowMessage("Usuario no encontrado", Colors.Red);
            return;
        }

        if (user.IsPermanentlyLocked)
        {
            ShowMessage($"No se puede desbloquear: {username} está bloqueado PERMANENTEMENTE", Colors.DarkRed);
            return;
        }

        if (!user.IsLocked)
        {
            ShowMessage($"{username} no está bloqueado", Colors.Yellow);
            return;
        }

        // Attempt unlock
        if (_authService.UnlockUser(username))
        {
            ShowMessage($"¡Usuario {username} desbloqueado exitosamente!", Colors.Green);
            RefreshUserList();
        }
        else
        {
            ShowMessage($"Error al desbloquear {username}", Colors.Red);
        }
    }

    private void OnRefreshButtonPressed()
    {
        RefreshUserList();
        ShowMessage("Lista de usuarios actualizada", Colors.Cyan);
    }

    private void OnUserSelected(long index)
    {
        // Enable unlock button only for locked users
        var itemText = _userList.GetItemText((int)index);
        var username = itemText.Split(' ')[0];
        
        var users = _authService.GetAllUsers();
        var user = users.Find(u => u.Username == username);
        
        if (user != null)
        {
            // Enable unlock only if temporarily locked (not permanent)
            _unlockButton.Disabled = !user.IsLocked || user.IsPermanentlyLocked;
            
            // Show info
            if (user.IsPermanentlyLocked)
            {
                ShowMessage($"{username}: Bloqueado permanentemente - NO desbloqueable", Colors.DarkRed);
            }
            else if (user.IsLocked)
            {
                ShowMessage($"{username}: Bloqueado (Desbloqueos: {user.UnlockCount}) - Click para desbloquear", Colors.Orange);
            }
            else
            {
                ShowMessage($"{username}: Activo (Intentos fallidos: {user.FailedAttempts}/3)", Colors.Cyan);
            }
        }
    }

    private void OnUserUnlocked(string username)
    {
        ShowMessage($"Usuario '{username}' ha sido desbloqueado", Colors.Green);
        RefreshUserList();
    }

    private void RefreshUserList()
    {
        _userList.Clear();

        var users = _authService.GetAllUsers();
        if (users.Count == 0)
        {
            ShowMessage("No access to user data. Admin login required.", Colors.Red);
            _unlockButton.Disabled = true;
            return;
        }

        foreach (var user in users)
        {
            string status = "";
            Color color = Colors.White;

            if (user.IsAdmin())
            {
                status = " [ADMIN]";
                color = Colors.Gold;
            }
            else if (user.IsPermanentlyLocked)
            {
                status = " [BLOQUEADO PERMANENTE]";
                color = new Color(0.8f, 0.2f, 0.2f);
            }
            else if (user.IsLocked)
            {
                status = " [BLOQUEADO - Desbloqueable]";
                color = new Color(1.0f, 0.6f, 0.2f);
            }
            else if (user.FailedAttempts > 0)
            {
                status = $" (Intentos: {user.FailedAttempts}/3)";
                color = Colors.Yellow;
            }
            else
            {
                status = " [Activo]";
                color = new Color(0.3f, 1.0f, 0.3f);
            }

            var itemText = $"{user.Username}{status}";
            int itemIndex = _userList.AddItem(itemText);
            _userList.SetItemCustomFgColor(itemIndex, color);
        }

        ShowMessage($"Usuarios cargados: {users.Count}", Colors.Cyan);
    }

    private void ShowMessage(string text, Color color)
    {
        _messageLabel.Text = text;
        _messageLabel.Modulate = color;
        GD.Print($"[AdminPanel] {text}");
    }

    public override void _ExitTree()
    {
        // Disconnect signals to prevent memory leaks
        if (_authService != null)
        {
            _authService.UserUnlocked -= OnUserUnlocked;
        }
    }
}
