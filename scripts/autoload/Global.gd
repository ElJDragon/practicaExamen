# ============================================================================
# GLOBAL AUTOLOAD
# ============================================================================
# Singleton global accesible desde cualquier parte del juego
#
# SOLID PRINCIPLES APPLIED:
# -------------------------
# [SRP] Single Responsibility Principle (Principio de Responsabilidad Unica)
#       Responsabilidad unica: Mantener estado global compartido entre escenas.
#       No maneja logica de juego compleja, solo almacena datos persistentes.
#
# Design Pattern: Singleton (mediante Autoload de Godot)
#       Garantiza una unica instancia accesible globalmente.
#
# Benefits:
# - Estado persistente entre cambios de escena
# - Punto de acceso global para datos compartidos
# - Facil de usar desde cualquier script
#
# Usage:
#   Global.posicion_mono = player.global_position
#   var saved_pos = Global.posicion_mono
# ============================================================================

extends Node

# ============================================================================
# GLOBAL STATE VARIABLES
# ============================================================================

## Posicion guardada del jugador principal (Mono o PJ_Principal)
## Usada para restaurar posicion al regresar del mundo principal
var posicion_mono = Vector2.ZERO
