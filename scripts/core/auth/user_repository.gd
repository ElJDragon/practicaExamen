# ============================================================================
# USER REPOSITORY
# ============================================================================
# Handles persistence and retrieval of user data
#
# DESIGN PATTERNS:
# [Repository Pattern] Abstracts data access layer
# [Singleton] Single instance through Godot autoload (via AuthService)
#
# SOLID PRINCIPLES:
# [SRP] Single Responsibility: User data persistence only
# [DIP] Dependency Inversion: Depends on User abstraction
#
# CLEAN ARCHITECTURE: Infrastructure Layer (Data Access)
# ============================================================================

class_name UserRepository
extends RefCounted

const SAVE_PATH = "user://users.save"

## Save all users to disk
func save_users(users: Dictionary) -> bool:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_error("Failed to open file for writing: " + SAVE_PATH)
		return false
	
	var users_data = []
	for username in users:
		users_data.append(users[username].to_dict())
	
	file.store_var(users_data)
	file.close()
	return true

## Load all users from disk
func load_users() -> Dictionary:
	if not FileAccess.file_exists(SAVE_PATH):
		return _create_default_users()
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		push_error("Failed to open file for reading: " + SAVE_PATH)
		return _create_default_users()
	
	var users_data = file.get_var()
	file.close()
	
	if users_data == null or not users_data is Array:
		return _create_default_users()
	
	var users = {}
	for user_dict in users_data:
		var user = User.from_dict(user_dict)
		users[user.username] = user
	
	return users

## Create default users (admin and test user)
func _create_default_users() -> Dictionary:
	var users = {}
	
	# Admin user (username: admin, password: admin123)
	var admin = User.new("admin", _hash_password("admin123"), User.Role.ADMIN)
	users["admin"] = admin
	
	# Regular test user (username: player, password: player123)
	var player = User.new("player", _hash_password("player123"), User.Role.USER)
	users["player"] = player
	
	save_users(users)
	return users

## Simple hash function (in production, use crypto)
func _hash_password(password: String) -> String:
	# For demo purposes - in production use proper cryptographic hashing
	return password.sha256_text()
