extends CharacterBody2D

@export var speed := 80

var directions := [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var anims := ["walk_right", "walk_down", "walk_left", "walk_up"]
var current_index := 0

func _ready():
	set_direction(current_index)

func _physics_process(delta):
	velocity = directions[current_index] * speed
	var prev_position = position
	move_and_slide()
	if position == prev_position:
		current_index = (current_index + 1) % directions.size()
		set_direction(current_index)

func set_direction(idx):
	$Animacion_Pinguino.animation = anims[idx]
	$Animacion_Pinguino.play()
