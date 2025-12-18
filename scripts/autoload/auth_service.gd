# ============================================================================
# AUTHENTICATION SERVICE
# ============================================================================
# Centralized authentication logic with user management
#
# DESIGN PATTERNS:
# [Singleton] Through Godot autoload system
# [Service Locator] Provides authentication services globally
# [Observer] Emits signals for authentication events
#
# SOLID PRINCIPLES:
# [SRP] Single Responsibility: Authentication and user session management
# [OCP] Open/Closed: Extensible for new authentication methods
# [DIP] Dependency Inversion: Depends on User and UserRepository abstractions
#
# CLEAN ARCHITECTURE: Application Layer (Use Cases)
# ============================================================================

extends Node

# Signals for authentication events
signal login_succeeded(username: String, is_admin: bool)
signal login_failed(username: String, reason: String)
signal user_locked(username: String)
signal user_unlocked(username: String)

const MAX_FAILED_ATTEMPTS = 3

var _repository: UserRepository
var _users: Dictionary = {}
var _current_user: User = null

func _ready() -> void:
	_repository = UserRepository.new()
	_users = _repository.load_users()
	print("=== AUTH SERVICE INITIALIZED ===")
	print("Loaded %d users" % _users.size())

## Attempt to log in with username and password
## Returns true if successful, false otherwise
func login(username: String, password: String) -> bool:
	if username.is_empty() or password.is_empty():
		login_failed.emit(username, "Username and password cannot be empty")
		return false
	
	if not _users.has(username):
		login_failed.emit(username, "User not found")
		return false
	
	var user: User = _users[username]
	
	# Check if user is locked
	if user.is_locked:
		login_failed.emit(username, "Account is locked. Contact administrator")
		return false
	
	# Verify password
	var password_hash = _hash_password(password)
	if user.password_hash != password_hash:
		user.failed_attempts += 1
		
		# Lock user after max attempts
		if user.failed_attempts >= MAX_FAILED_ATTEMPTS:
			user.is_locked = true
			_repository.save_users(_users)
			user_locked.emit(username)
			login_failed.emit(username, "Account locked due to too many failed attempts")
			return false
		
		var remaining = MAX_FAILED_ATTEMPTS - user.failed_attempts
		_repository.save_users(_users)
		login_failed.emit(username, "Invalid password. %d attempts remaining" % remaining)
		return false
	
	# Successful login
	user.failed_attempts = 0
	_current_user = user
	_repository.save_users(_users)
	login_succeeded.emit(username, user.is_admin())
	print("User logged in: %s (Admin: %s)" % [username, user.is_admin()])
	return true

## Log out the current user
func logout() -> void:
	if _current_user != null:
		print("User logged out: %s" % _current_user.username)
		_current_user = null

## Check if a user is currently logged in
func is_logged_in() -> bool:
	return _current_user != null

## Get the current logged-in user
func get_current_user() -> User:
	return _current_user

## Check if current user is admin
func is_current_user_admin() -> bool:
	return _current_user != null and _current_user.is_admin()

## Admin function: Unlock a user account
func unlock_user(username: String) -> bool:
	if not is_current_user_admin():
		push_warning("Only administrators can unlock users")
		return false
	
	if not _users.has(username):
		push_warning("User not found: %s" % username)
		return false
	
	var user: User = _users[username]
	if not user.is_locked:
		push_warning("User is not locked: %s" % username)
		return false
	
	user.is_locked = false
	user.failed_attempts = 0
	_repository.save_users(_users)
	user_unlocked.emit(username)
	print("User unlocked by admin: %s" % username)
	return true

## Admin function: Get all users (for admin panel)
func get_all_users() -> Array:
	if not is_current_user_admin():
		push_warning("Only administrators can view all users")
		return []
	
	var users_list = []
	for username in _users:
		users_list.append(_users[username])
	return users_list

## Admin function: Create a new user
func create_user(username: String, password: String, is_admin: bool = false) -> bool:
	if not is_current_user_admin():
		push_warning("Only administrators can create users")
		return false
	
	if username.is_empty() or password.is_empty():
		push_warning("Username and password cannot be empty")
		return false
	
	if _users.has(username):
		push_warning("User already exists: %s" % username)
		return false
	
	var role = User.Role.ADMIN if is_admin else User.Role.USER
	var new_user = User.new(username, _hash_password(password), role)
	_users[username] = new_user
	_repository.save_users(_users)
	print("New user created: %s (Admin: %s)" % [username, is_admin])
	return true

## Hash password (same method as repository)
func _hash_password(password: String) -> String:
	return password.sha256_text()
