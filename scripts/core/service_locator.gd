# ============================================================================
# SERVICE LOCATOR
# ============================================================================
# Implements IoC using the Service Locator pattern
#
# DESIGN PATTERNS APPLIED:
# ------------------------
# [Service Locator] Architectural pattern
#       Provides a global registry for application services
#
# [Dependency Injection] Design principle
#       Inverts control: services are injected, not created directly
#
# SOLID PRINCIPLES:
# -----------------
# [DIP] Dependency Inversion - Depend on abstractions, not concretions
# [SRP] Single Responsibility - Only manages service registry
#
# Benefits:
# - Decoupling between components
# - Easier testing with mock services
# - Centralized dependency configuration
# ============================================================================

class_name ServiceLocator
extends Node

## Registry for services (singleton)
static var _services: Dictionary = {}

## Register a service
## @param service_name: Identifier name for the service
## @param service_instance: Instance of the service
static func register_service(service_name: String, service_instance) -> void:
    if _services.has(service_name):
        push_warning("Service already registered, will replace: " + service_name)
    
    _services[service_name] = service_instance
    print("? Service registered: " + service_name)

## Get a service from the registry
## @param service_name: Name of the service to get
## @returns: Service instance or null if not found
static func get_service(service_name: String):
    if not _services.has(service_name):
        push_error("Service not found: " + service_name)
        return null
    
    return _services[service_name]

## Unregister a service
static func unregister_service(service_name: String) -> void:
    if _services.has(service_name):
        _services.erase(service_name)
        print(" Service unregistered: " + service_name)

## Clear all services
static func clear_all() -> void:
    _services.clear()
    print(" All services cleared")

## Check if a service is registered
static func has_service(service_name: String) -> bool:
    return _services.has(service_name)