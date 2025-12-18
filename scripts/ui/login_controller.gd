# ============================================================================
# LOGIN CONTROLLER
# ============================================================================
# Presentation layer controller for login UI
#
# DESIGN PATTERNS:
# [MVP - Presenter] Mediates between View (UI) and Model (AuthService)
# [Observer] Listens to AuthService signals
#
# SOLID PRINCIPLES:
# [SRP] Single Responsibility: Handle login UI logic only
# [DIP] Dependency Inversion: Depends on AuthService abstraction
#
# CLEAN ARCHITECTURE: Presentation Layer (Controller/Presenter)
# ============================================================================

extends Control

@onready var username_input: LineEdit = $Panel/VBoxContainer/UsernameContainer/UsernameInput
@onready var password_input: LineEdit = $Panel/VBoxContainer/PasswordContainer/PasswordInput
@onready var login_button: Button = $Panel/VBoxContainer/LoginButton
@onready var admin_button: Button = $Panel/VBoxContainer/AdminButton
@onready var message_label: Label = $Panel/VBoxContainer/MessageLabel

const MAIN_MENU_SCENE = "res://scenes/ui/menu.tscn"
const ADMIN_PANEL_SCENE = "res://scenes/ui/admin_panel.tscn"

func _ready() -> void:
	# Setup UI
	password_input.secret = true
	message_label.text = ""
	message_label.modulate = Color.WHITE
	
	# Connect UI signals
	login_button.pressed.connect(_on_login_button_pressed)
	admin_button.pressed.connect(_on_admin_button_pressed)
	username_input.text_submitted.connect(func(_text): password_input.grab_focus())
	password_input.text_submitted.connect(func(_text): _attempt_login())
	
	# Connect to AuthService signals
	AuthService.login_succeeded.connect(_on_login_succeeded)
	AuthService.login_failed.connect(_on_login_failed)
	AuthService.user_locked.connect(_on_user_locked)
	
	# Focus on username field
	username_input.grab_focus()
	
	print("Login screen ready")

func _on_login_button_pressed() -> void:
	_attempt_login()

func _on_admin_button_pressed() -> void:
	_show_message("Opening admin panel...", Color.CYAN)
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file(ADMIN_PANEL_SCENE)

func _attempt_login() -> void:
	var username = username_input.text.strip_edges()
	var password = password_input.text
	
	if username.is_empty() or password.is_empty():
		_show_message("Please enter username and password", Color.YELLOW)
		return
	
	# Disable button during login attempt
	login_button.disabled = true
	admin_button.disabled = true
	_show_message("Authenticating...", Color.CYAN)
	
	# Attempt login
	AuthService.login(username, password)

func _on_login_succeeded(username: String, is_admin: bool) -> void:
	_show_message("Welcome, %s!" % username, Color.GREEN)
	password_input.text = ""
	
	# Brief delay before transitioning
	await get_tree().create_timer(0.5).timeout
	
	# Navigate to main menu
	if FileAccess.file_exists(MAIN_MENU_SCENE):
		get_tree().change_scene_to_file(MAIN_MENU_SCENE)
	else:
		_show_message("Error: Main menu scene not found", Color.RED)
		login_button.disabled = false
		admin_button.disabled = false

func _on_login_failed(username: String, reason: String) -> void:
	_show_message(reason, Color.RED)
	password_input.text = ""
	password_input.grab_focus()
	login_button.disabled = false
	admin_button.disabled = false

func _on_user_locked(username: String) -> void:
	_show_message("Account LOCKED! Contact administrator", Color.DARK_RED)

func _show_message(text: String, color: Color) -> void:
	message_label.text = text
	message_label.modulate = color
	print("[Login] " + text)
