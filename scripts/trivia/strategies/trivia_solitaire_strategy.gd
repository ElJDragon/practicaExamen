# ============================================================================
# TRIVIA SOLITAIRE STRATEGY
# ============================================================================
# Implementation of the strategy for single-player mode
#
# DESIGN PATTERNS: Strategy Pattern (Concrete implementation)
# SOLID: [SRP] Single Responsibility: Handle single-player trivia logic
# ============================================================================

class_name TriviaSolitaireStrategy
extends TriviaStrategy

var _game_manager: TriviaGameManager
var _question_bank
var _current_score: int = 0

func initialize(question_bank) -> void:
    _question_bank = question_bank
    _game_manager = TriviaGameManager.new()
    
    # Connect game manager signals to our signals
    _game_manager.game_started.connect(func(cat): game_started.emit(cat))
    _game_manager.question_changed.connect(func(q, n, t): question_changed.emit(q, n, t))
    _game_manager.answer_submitted.connect(func(c, a): answer_submitted.emit(c, a))
    _game_manager.game_ended.connect(func(s, t): 
        var results = {
            "score": s,
            "total": t,
            "percentage": float(s) / float(t) * 100.0
        }
        game_ended.emit(results)
    )

func start_game(category: String, question_count: int) -> void:
    var questions = _question_bank.get_random_questions(category, question_count)
    _game_manager.start_game(questions)

func handle_answer(answer_index: int) -> void:
    _game_manager.submit_answer(answer_index)

func show_next_question() -> void:
    _game_manager.show_next_question()

func end_game() -> Dictionary:
    return {
        "score": _game_manager.get_score(),
        "total": _game_manager.get_total_questions(),
        "percentage": float(_game_manager.get_score()) / float(_game_manager.get_total_questions()) * 100.0
    }

func get_current_score() -> int:
    return _game_manager.get_score()