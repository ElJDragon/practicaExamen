extends Node2D

# Nodos
@onready var score_label: Label = $ScoreLabel
@onready var lives_label: Label = $LivesLabel
@onready var game_over_label: Label = $GameOverLabel

func _ready():
	# Configurar labels
	score_label.text = "SCORE: 0"
	lives_label.text = "LIVES: 3"
	game_over_label.text = ""
	game_over_label.visible = false
	
	# Posicionar elementos
	score_label.position = Vector2(20, 20)
	lives_label.position = Vector2(20, 50)
	game_over_label.position = Vector2(400, 350)

func _on_score_changed(score: int):
	score_label.text = "SCORE: " + str(score)

func _on_lives_changed(lives: int):
	lives_label.text = "LIVES: " + str(lives)

func _on_game_over():
	game_over_label.text = "GAME OVER\n\nPress R to restart\nPress ESC to exit"
	game_over_label.visible = true
	
	# Centrar mejor el mensaje
	game_over_label.position = Vector2(350, 300)
	
	print("Game Over message displayed on HUD")

func hide_game_over():
	"""Ocultar mensaje de Game Over (para reinicio)"""
	game_over_label.visible = false
	game_over_label.text = ""
	print("Game Over message hidden")
