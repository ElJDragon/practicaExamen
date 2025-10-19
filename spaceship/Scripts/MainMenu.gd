extends Node2D

@onready var title_label: Label = $Title_Label
@onready var start_button: Button = $StartButton
@onready var instructions_label: Label = $InstructionsLabel

func _ready():
	# Configurar interfaz del menú
	title_label.text = "SPACE INVADERS"
	title_label.position = Vector2(400, 200)
	
	start_button.text = "START GAME"
	start_button.position = Vector2(450, 300)
	
	instructions_label.text = "Use A/D or Arrow Keys to move\nSpace to shoot\nR to restart"
	instructions_label.position = Vector2(400, 400)

func _on_start_button_pressed():
	print("Starting game from menu...")
	get_tree().change_scene_to_file("res://spaceship/scenes/Main.tscn")

func _input(event):
	if event.is_action_pressed("shoot") or event.is_action_pressed("ui_accept"):
		_on_start_button_pressed()
