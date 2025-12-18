# ============================================================================
# USER MODEL
# ============================================================================
# Domain entity representing a user in the authentication system
#
# SOLID PRINCIPLES:
# [SRP] Single Responsibility: Represents user data only
# [OCP] Open/Closed: Can be extended with additional properties
#
# CLEAN ARCHITECTURE: Domain Layer (Entity)
# ============================================================================

class_name User
extends RefCounted

enum Role {
	USER,
	ADMIN
}

var username: String
var password_hash: String
var role: Role
var is_locked: bool
var failed_attempts: int

func _init(p_username: String = "", p_password_hash: String = "", p_role: Role = Role.USER) -> void:
	username = p_username
	password_hash = p_password_hash
	role = p_role
	is_locked = false
	failed_attempts = 0

## Check if this user is an administrator
func is_admin() -> bool:
	return role == Role.ADMIN

## Serialize user to dictionary for persistence
func to_dict() -> Dictionary:
	return {
		"username": username,
		"password_hash": password_hash,
		"role": role,
		"is_locked": is_locked,
		"failed_attempts": failed_attempts
	}

## Deserialize user from dictionary
static func from_dict(data: Dictionary) -> User:
	var user = User.new()
	user.username = data.get("username", "")
	user.password_hash = data.get("password_hash", "")
	user.role = data.get("role", Role.USER)
	user.is_locked = data.get("is_locked", false)
	user.failed_attempts = data.get("failed_attempts", 0)
	return user
