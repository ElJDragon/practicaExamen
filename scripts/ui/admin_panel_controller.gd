# ============================================================================
# ADMIN PANEL CONTROLLER
# ============================================================================
# UI controller for administrative functions
#
# DESIGN PATTERNS:
# [MVP - Presenter] Mediates between View and AuthService
#
# SOLID PRINCIPLES:
# [SRP] Single Responsibility: Handle admin UI logic only
#
# CLEAN ARCHITECTURE: Presentation Layer
# ============================================================================

extends Control

@onready var back_button: Button = $Panel/VBoxContainer/BackButton
@onready var user_list: ItemList = $Panel/VBoxContainer/UserListContainer/UserList
@onready var unlock_button: Button = $Panel/VBoxContainer/ActionButtons/UnlockButton
@onready var refresh_button: Button = $Panel/VBoxContainer/ActionButtons/RefreshButton
@onready var message_label: Label = $Panel/VBoxContainer/MessageLabel

const LOGIN_SCENE = "res://scenes/ui/login.tscn"

func _ready() -> void:
	# Setup UI
	message_label.text = ""
	unlock_button.disabled = true
	
	# Connect signals
	back_button.pressed.connect(_on_back_button_pressed)
	unlock_button.pressed.connect(_on_unlock_button_pressed)
	refresh_button.pressed.connect(_on_refresh_button_pressed)
	user_list.item_selected.connect(_on_user_selected)
	
	# Connect to AuthService signals
	AuthService.user_unlocked.connect(_on_user_unlocked)
	
	# Load users
	_refresh_user_list()

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(LOGIN_SCENE)

func _on_unlock_button_pressed() -> void:
	var selected_items = user_list.get_selected_items()
	if selected_items.is_empty():
		_show_message("Please select a user", Color.YELLOW)
		return
	
	var selected_index = selected_items[0]
	var username = user_list.get_item_text(selected_index).split(" ")[0]
	
	# Attempt unlock (requires admin privileges)
	if AuthService.unlock_user(username):
		_show_message("User unlocked successfully!", Color.GREEN)
		_refresh_user_list()
	else:
		_show_message("Failed to unlock user", Color.RED)

func _on_refresh_button_pressed() -> void:
	_refresh_user_list()
	_show_message("User list refreshed", Color.CYAN)

func _on_user_selected(index: int) -> void:
	unlock_button.disabled = false

func _on_user_unlocked(username: String) -> void:
	_show_message("User '%s' has been unlocked" % username, Color.GREEN)

func _refresh_user_list() -> void:
	user_list.clear()
	
	var users = AuthService.get_all_users()
	if users.is_empty():
		_show_message("No access to user data. Admin login required.", Color.RED)
		unlock_button.disabled = true
		return
	
	for user in users:
		var status = ""
		if user.is_admin():
			status = " [ADMIN]"
		elif user.is_locked:
			status = " [LOCKED]"
		elif user.failed_attempts > 0:
			status = " (Failed: %d)" % user.failed_attempts
		
		var item_text = "%s%s" % [user.username, status]
		user_list.add_item(item_text)
		
		# Color locked users in red
		if user.is_locked:
			var item_index = user_list.item_count - 1
			user_list.set_item_custom_fg_color(item_index, Color.RED)
		elif user.is_admin():
			var item_index = user_list.item_count - 1
			user_list.set_item_custom_fg_color(item_index, Color.GOLD)

func _show_message(text: String, color: Color) -> void:
	message_label.text = text
	message_label.modulate = color
	print("[AdminPanel] " + text)
