extends CharacterBody2D

@export var speed := 150
@onready var animated_sprite = $Animacion_PJ_Principal

var last_direction := "down"  # Para recordar la última dirección
var can_move := true  # Control de movimiento

func _ready():
	# Restaurar posición guardada si existe
	if Global.posicion_mono != Vector2.ZERO:
		print("Restaurando posición del jugador:", Global.posicion_mono)
		global_position = Global.posicion_mono

	if animated_sprite:
		print("AnimatedSprite2D encontrado!")
		for anim in animated_sprite.sprite_frames.get_animation_names():
			print("Animación: ", anim)

		# 🔥 SELECCIÓN SEGURA DE ANIMACIÓN INICIAL
		var anim_default = ""

		if animated_sprite.sprite_frames.has_animation("idle_down"):
			anim_default = "idle_down"
		elif animated_sprite.sprite_frames.has_animation("idle"):
			anim_default = "idle"
		else:
			# Si no tienes idle, usa la primera animación existente
			anim_default = animated_sprite.sprite_frames.get_animation_names()[0]

		animated_sprite.animation = anim_default
		animated_sprite.play()
	else:
		print("AnimatedSprite2D NO encontrado!")

func _physics_process(delta):
	# Verificar si el jugador puede moverse
	if not can_move:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_dir.length() > 0:
		velocity = input_dir * speed
		
		# Determinar dirección y actualizar last_direction
		var direction = ""
		if abs(input_dir.x) > abs(input_dir.y):
			direction = "right" if input_dir.x > 0 else "left"
		else:
			direction = "down" if input_dir.y > 0 else "up"
		
		last_direction = direction
		var anim_name = "walk_" + direction
		
		# Reproducir animación de caminar
		play_animation(anim_name)
		
	else:
		velocity = Vector2.ZERO
		# Reproducir animación idle en la última dirección
		var idle_anim = "idle_" + last_direction
		
		# Si no tienes animaciones idle, usar el primer frame de walk
		if animated_sprite.sprite_frames.has_animation(idle_anim):
			play_animation(idle_anim)
		else:
			# Usar el primer frame de la animación de caminar
			var walk_anim = "walk_" + last_direction
			if animated_sprite.sprite_frames.has_animation(walk_anim):
				animated_sprite.animation = walk_anim
				animated_sprite.stop()
				animated_sprite.frame = 0
	
	move_and_slide()

func play_animation(anim_name: String):
	if animated_sprite and animated_sprite.sprite_frames.has_animation(anim_name):
		if animated_sprite.animation != anim_name:
			animated_sprite.animation = anim_name
			animated_sprite.play()
		elif not animated_sprite.is_playing():
			animated_sprite.play()
	else:
		print("Animación no encontrada: ", anim_name)

# Funciones para controlar el movimiento (usadas por NPCs durante cinemáticas)
func disable_movement():
	can_move = false
	velocity = Vector2.ZERO
	print("Movimiento del jugador desactivado")

func enable_movement():
	can_move = true
	print("Movimiento del jugador activado")
