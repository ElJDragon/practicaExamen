# ============================================================================
# TRIVIA STRATEGY (Interface)
# ============================================================================
# Define la interfaz para diferentes estrategias de trivia
#
# DESIGN PATTERNS APPLIED:
# ------------------------
# [Strategy Pattern] Patrón de Comportamiento
#       Encapsula algoritmos intercambiables (solitario, multijugador, etc.)
#       Permite cambiar el comportamiento en tiempo de ejecución
#
# SOLID PRINCIPLES:
# -----------------
# [OCP] Open/Closed - Nuevas estrategias sin modificar código existente
# [SRP] Single Responsibility - Cada estrategia maneja un modo específico
# [DIP] Dependency Inversion - El cliente depende de la abstracción, no de implementaciones
# ============================================================================

class_name TriviaStrategy
extends RefCounted

## Señales para comunicación con la UI
signal game_started(category: String)
signal question_changed(question_data: Dictionary, question_number: int, total: int)
signal answer_submitted(is_correct: bool, correct_answer: int)
signal game_ended(results: Dictionary)

## Inicializa el modo de juego
## @param question_bank: Banco de preguntas a utilizar
func initialize(question_bank) -> void:
    pass

## Inicia el juego con la configuración específica
## @param category: Categoría de preguntas
## @param question_count: Número de preguntas
func start_game(category: String, question_count: int) -> void:
    pass

## Maneja la respuesta del jugador
## @param answer_index: Índice de la respuesta seleccionada
func handle_answer(answer_index: int) -> void:
    pass

## Finaliza el juego y retorna resultados
## @returns: Dictionary con resultados finales
func end_game() -> Dictionary:
    return {}

## Retorna el puntaje actual
func get_current_score() -> int:
    return 0

## Muestra la siguiente pregunta
func show_next_question() -> void:
    pass