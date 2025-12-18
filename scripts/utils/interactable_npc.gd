# ============================================================================
# INTERACTABLE NPC (BASE CLASS)
# ============================================================================
# Clase base para todos los NPCs con los que el jugador puede interactuar
#
# SOLID PRINCIPLES APPLIED:
# -------------------------
# [SRP] Single Responsibility Principle (Principio de Responsabilidad Única)
#       Responsabilidad: Gestionar la interacción básica jugador-NPC
#       (detección de proximidad, mostrar UI de interacción).
#       No maneja lógica específica de cada NPC (eso va en clases hijas).
#
# [OCP] Open/Closed Principle (Principio Abierto/Cerrado)
#       ABIERTO para extensión: Las clases hijas pueden extender comportamiento
#       mediante métodos virtuales (on_interaction, on_player_entered, etc.)
#       CERRADO para modificación: No es necesario modificar esta clase para
#       agregar nuevos tipos de NPCs.
#
# [LSP] Liskov Substitution Principle (Principio de Sustitución de Liskov)
#       Cualquier clase que herede de InteractableNPC puede usarse en lugar
#       de esta clase sin romper la funcionalidad. Todas las clases hijas
#       mantienen el contrato definido por la clase base.
#
# [DIP] Dependency Inversion Principle (Principio de Inversión de Dependencias)
#       Usa señales (signals) en lugar de referencias directas, permitiendo
#       que otros sistemas se suscriban sin crear dependencias fuertes.
#
# Benefits:
# - Código reutilizable: Todos los NPCs comparten la misma lógica de interacción
# - Fácil de extender: Crear un nuevo NPC solo requiere heredar y override
# - Mantenible: Correcciones en interacción base benefician a todos los NPCs
# - Testeable: Lógica de interacción aislada y verificable
#
# Usage Example:
# ```gdscript
# extends InteractableNPC
# 
# func on_interaction() -> void:
#     super.on_interaction()  # Llamar comportamiento base
#     # Agregar comportamiento específico aquí
#     get_tree().change_scene_to_file("res://scenes/minigame.tscn")
# ```
# ============================================================================

class_name InteractableNPC
extends CharacterBody2D

# ============================================================================
# SIGNALS (DIP - Dependency Inversion)
# ============================================================================
# Las señales permiten comunicación desacoplada. Otros nodos pueden
# escuchar estos eventos sin que el NPC sepa quiénes son.

## Emitida cuando el jugador interactúa con este NPC
signal interaction_triggered(npc_name: String)

# ============================================================================
# EXPORTED VARIABLES (Configurables desde el editor)
# ============================================================================

## Nombre identificador del NPC
@export var npc_name: String = "NPC"

## Radio de detección de interacción en píxeles
@export var interaction_radius: float = 50.0

## Desplazamiento del bocadillo de diálogo respecto al NPC
@export var bubble_offset: Vector2 = Vector2(0, -60)

## Texto mostrado en el bocadillo de interacción
@export var interaction_text: String = "Presiona E para interactuar"

# ============================================================================
# PRIVATE VARIABLES (Estado interno encapsulado)
# ============================================================================

var _player_in_range: bool = false
var _player_reference: Node2D = null
var _speech_bubble: Node2D = null
var _interaction_area: Area2D = null

# ============================================================================
# LIFECYCLE METHODS
# ============================================================================

func _ready():
    setup_interaction_area()
    create_speech_bubble()

func _process(_delta: float) -> void:
    if _player_in_range and is_interact_pressed():
        _speech_bubble.visible = false
        save_player_position()
        on_interaction()

# ============================================================================
# SETUP METHODS (Inicialización de componentes)
# ============================================================================

## Configura el área de detección de proximidad del jugador
func setup_interaction_area() -> void:
    _interaction_area = Area2D.new()
    _interaction_area.name = "InteractionArea"
    add_child(_interaction_area)
    
    var collision = CollisionShape2D.new()
    var shape = CircleShape2D.new()
    shape.radius = interaction_radius
    collision.shape = shape
    _interaction_area.add_child(collision)
    
    # Conectar señales para detectar entrada/salida del jugador
    _interaction_area.body_entered.connect(_on_body_entered)
    _interaction_area.body_exited.connect(_on_body_exited)

## Crea el bocadillo de diálogo visual
func create_speech_bubble() -> void:
    _speech_bubble = Node2D.new()
    _speech_bubble.name = "SpeechBubble"
    _speech_bubble.position = bubble_offset
    _speech_bubble.visible = false
    _speech_bubble.z_index = 100  # Renderizar por encima de otros elementos
    add_child(_speech_bubble)
    
    var label = Label.new()
    label.name = "Text"
    label.text = interaction_text
    label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
    label.offset_left = -60
    label.offset_top = -25
    label.offset_right = 60
    label.offset_bottom = 25
    
    setup_label_style(label)
    _speech_bubble.add_child(label)

## Configura el estilo visual del bocadillo
func setup_label_style(label: Label) -> void:
    var style = StyleBoxFlat.new()
    style.bg_color = Color(1, 1, 1, 0.95)
    style.border_color = Color(0, 0, 0, 0.8)
    style.border_width_left = 2
    style.border_width_right = 2
    style.border_width_top = 2
    style.border_width_bottom = 2
    style.corner_radius_top_left = 8
    style.corner_radius_top_right = 8
    style.corner_radius_bottom_left = 8
    style.corner_radius_bottom_right = 8
    
    label.add_theme_stylebox_override("normal", style)
    label.add_theme_color_override("font_color", Color.BLACK)
    label.add_theme_font_size_override("font_size", 12)

# ============================================================================
# EVENT HANDLERS (Manejadores de eventos internos)
# ============================================================================

func _on_body_entered(body: Node) -> void:
    if is_player(body):
        _player_in_range = true
        _player_reference = body as Node2D
        _speech_bubble.visible = true
        on_player_entered(body)  # Hook para clases hijas

func _on_body_exited(body: Node) -> void:
    if is_player(body):
        _player_in_range = false
        _player_reference = null
        _speech_bubble.visible = false
        on_player_exited(body)  # Hook para clases hijas

# ============================================================================
# UTILITY METHODS (Métodos auxiliares)
# ============================================================================

## Verifica si un nodo es el jugador
func is_player(body: Node) -> bool:
    return body.name == "Mono" or body.name == "PJ_Principal"

## Verifica si se presionó la tecla de interacción
func is_interact_pressed() -> bool:
    return Input.is_action_just_pressed("ui_accept") or Input.is_key_pressed(KEY_E)

## Guarda la posición actual del jugador en el sistema global
func save_player_position() -> void:
    if _player_reference:
        Global.posicion_mono = _player_reference.global_position
        print(" Posición guardada: ", Global.posicion_mono)

# ============================================================================
# VIRTUAL METHODS (OCP - Para override en clases hijas)
# ============================================================================
# Estos métodos están diseñados para ser sobrescritos por clases derivadas.
# Implementan el patrón Template Method, permitiendo extensión sin modificación.

## Método virtual: Llamado cuando el jugador interactúa con el NPC
## OVERRIDE este método en clases hijas para comportamiento personalizado
func on_interaction() -> void:
    interaction_triggered.emit(npc_name)
    # Las clases hijas pueden agregar comportamiento aquí

## Método virtual: Llamado cuando el jugador entra en rango
## @param _body: El nodo del jugador (prefijado con _ si no se usa)
func on_player_entered(_body: Node) -> void:
    pass  # Implementar en clases hijas si es necesario

## Método virtual: Llamado cuando el jugador sale del rango
## @param _body: El nodo del jugador
func on_player_exited(_body: Node) -> void:
    pass  # Implementar en clases hijas si es necesario