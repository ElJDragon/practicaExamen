# ============================================================================
# TRIVIA QUESTION BANK
# ============================================================================
# Central repository for trivia questions
#
# SOLID PRINCIPLES APPLIED:
# -------------------------
# [SRP] Single Responsibility Principle
#       This class has a single responsibility: manage and provide
#       questions. It does not handle game logic, UI, or scoring.
#
# [OCP] Open/Closed Principle
#       Open for extension: new categories can be added without
#       modifying existing code. Closed for modification.
#
# Benefits:
# - Easy to add/modify questions without affecting game logic
# - Can load questions from external files (JSON, CSV)
# - Testable independently from other components
# - Reusable across different game modes
# ============================================================================

class_name TriviaQuestionBank
extends Node

# Constants for categories
const CULTURA_GENERAL = "cultura_general"
const INGENIERIA = "ingenieria"

# Internal storage for questions by category
var _questions_cultura: Array = []
var _questions_ingenieria: Array = []

func _ready():
    _load_cultura_questions()
    _load_ingenieria_questions()

## Returns a random set of questions for a given category
## @param category: Use constants CULTURA_GENERAL, INGENIERIA
## @param count: Number of questions to return
## @returns: Array of question dictionaries
func get_random_questions(category: String, count: int) -> Array:
    var source: Array = []
    
    match category:
        CULTURA_GENERAL:
            source = _questions_cultura.duplicate()
        INGENIERIA:
            source = _questions_ingenieria.duplicate()
        _:
            push_error("Unknown category: " + category)
            return []
    
    source.shuffle()
    return source.slice(0, min(count, source.size()))

## Load cultura general questions
func _load_cultura_questions() -> void:
    _questions_cultura = [
        # Existing questions go here
    ]

## Load ingenieria questions
func _load_ingenieria_questions() -> void:
    _questions_ingenieria = [
        # Existing questions go here
    ]

## Returns available categories
func get_available_categories() -> Array:
    return [CULTURA_GENERAL, INGENIERIA]

## Returns number of questions in a category
func get_question_count(category: String) -> int:
    match category:
        CULTURA_GENERAL:
            return _questions_cultura.size()
        INGENIERIA:
            return _questions_ingenieria.size()
        _:
            return 0