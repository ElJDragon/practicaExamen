extends CharacterBody2D

@export var speed := 80
@export var check_interval := 0.2 # tiempo entre verificaciones
@export var min_movement := 2.0  # distancia mínima para considerar que se movió

var directions := [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var anims := ["walk_right", "walk_down", "walk_left", "walk_up"]
var current_index := 0

var stuck_check_timer := 0.0
var last_checked_position := Vector2.ZERO

func _ready():
	last_checked_position = position
	set_direction(current_index)

func _physics_process(delta):
	velocity = directions[current_index] * speed
	move_and_slide()

	# Temporizador para verificar si está atrapado
	stuck_check_timer += delta
	if stuck_check_timer >= check_interval:
		check_if_stuck()
		stuck_check_timer = 0.0

func check_if_stuck():
	if position.distance_to(last_checked_position) < min_movement:
		change_direction_random()
	last_checked_position = position

func change_direction_random():
	var old_index = current_index
	while current_index == old_index and directions.size() > 1:
		current_index = randi() % directions.size()
	set_direction(current_index)

func set_direction(idx):
	$Animacion_Pinguino.animation = anims[idx]
	$Animacion_Pinguino.play()
