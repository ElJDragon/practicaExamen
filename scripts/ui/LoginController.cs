// ============================================================================
// LOGIN CONTROLLER (C#)
// ============================================================================
// Presentation layer controller for login UI
//
// DESIGN PATTERNS:
// [MVP - Presenter] Mediates between View (UI) and Model (AuthService)
// [Observer] Listens to AuthService signals
//
// SOLID PRINCIPLES:
// [SRP] Single Responsibility: Handle login UI logic only
// [DIP] Dependency Inversion: Depends on AuthService abstraction
//
// CLEAN ARCHITECTURE: Presentation Layer (Controller/Presenter)
// ============================================================================

using Godot;
using System;
using JuegoTest.Autoload;

namespace JuegoTest.UI;

public partial class LoginController : Control
{
	private LineEdit _usernameInput;
	private LineEdit _passwordInput;
	private Button _loginButton;
	private Label _messageLabel;

	private const string MainMenuScene = "res://scenes/ui/menu.tscn";

	private AuthService _authService;

	public override void _Ready()
	{
		// Get node references
		_usernameInput = GetNode<LineEdit>("Panel/VBoxContainer/UsernameContainer/UsernameInput");
		_passwordInput = GetNode<LineEdit>("Panel/VBoxContainer/PasswordContainer/PasswordInput");
		_loginButton = GetNode<Button>("Panel/VBoxContainer/LoginButton");
		_messageLabel = GetNode<Label>("Panel/VBoxContainer/MessageLabel");

		// Get AuthService singleton
		_authService = GetNode<AuthService>("/root/AuthService");

		// Setup UI
		_passwordInput.Secret = true;
		_messageLabel.Text = "";
		_messageLabel.Modulate = Colors.White;

		// Connect UI signals
		_loginButton.Pressed += OnLoginButtonPressed;
		_usernameInput.TextSubmitted += _ => _passwordInput.GrabFocus();
		_passwordInput.TextSubmitted += _ => AttemptLogin();

		// Connect to AuthService signals
		_authService.LoginSucceeded += OnLoginSucceeded;
		_authService.LoginFailed += OnLoginFailed;
		_authService.UserLocked += OnUserLocked;

		// Focus on username field
		_usernameInput.GrabFocus();

		GD.Print("Login screen ready");
	}

	private void OnLoginButtonPressed()
	{
		AttemptLogin();
	}

	private void AttemptLogin()
	{
		var username = _usernameInput.Text.Trim();
		var password = _passwordInput.Text;

		if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
		{
			ShowMessage("Por favor ingresa usuario y contraseña", Colors.Yellow);
			return;
		}

		// Disable button during login attempt
		_loginButton.Disabled = true;
		ShowMessage("Autenticando...", Colors.Cyan);

		// Attempt login
		_authService.Login(username, password);
	}

	private void OnLoginSucceeded(string username, bool isAdmin)
	{
		ShowMessage($"¡Bienvenido, {username}!", Colors.Green);
		_passwordInput.Text = "";

		// Brief delay before transitioning
		GetTree().CreateTimer(0.5).Timeout += () =>
		{
			// Navigate to main menu
			if (FileAccess.FileExists(MainMenuScene))
			{
				GetTree().ChangeSceneToFile(MainMenuScene);
			}
			else
			{
				ShowMessage("Error: Escena del menú no encontrada", Colors.Red);
				_loginButton.Disabled = false;
			}
		};
	}

	private void OnLoginFailed(string username, string reason)
	{
		ShowMessage(reason, Colors.Red);
		_passwordInput.Text = "";
		_usernameInput.GrabFocus();
		_loginButton.Disabled = false;
	}

	private void OnUserLocked(string username, bool isPermanent)
	{
		if (isPermanent)
		{
			ShowMessage("Cuenta BLOQUEADA PERMANENTEMENTE", Colors.DarkRed);
		}
		else
		{
			ShowMessage("Cuenta BLOQUEADA! Contacta al administrador", Colors.OrangeRed);
		}
	}

	private void ShowMessage(string text, Color color)
	{
		_messageLabel.Text = text;
		_messageLabel.Modulate = color;
		GD.Print($"[Login] {text}");
	}

	public override void _ExitTree()
	{
		// Disconnect signals to prevent memory leaks
		if (_authService != null)
		{
			_authService.LoginSucceeded -= OnLoginSucceeded;
			_authService.LoginFailed -= OnLoginFailed;
			_authService.UserLocked -= OnUserLocked;
		}
	}
}
