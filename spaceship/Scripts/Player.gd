extends Area2D

# Señales
signal bullet_fired(bullet_scene, position)
signal player_hit

# Variables
var speed: float = 300.0
var bullet_scene = preload("res://spaceship/scenes/Bullet.tscn")
var can_shoot: bool = true
var shoot_cooldown: float = 0.3

# Referencias a nodos (almacenadas)
var sprite_node: Sprite2D
var collision_node: CollisionShape2D
var shoot_timer: Timer

func _ready():
	print("Player _ready() started")
	print("Player children count: ", get_child_count())
	print("Player node type: ", get_class())
	
	# Listar todos los hijos para debug
	for i in range(get_child_count()):
		var child = get_child(i)
		print("Child ", i, ": ", child.name, " (type: ", child.get_class(), ")")
	
	# Obtener y almacenar referencias a los nodos hijos
	sprite_node = find_child("Sprite2D")
	collision_node = find_child("CollisionShape2D") 
	shoot_timer = find_child("ShootTimer")
	
	# DEBUG: Verificar si hay múltiples Sprite2D
	var sprite_count = 0
	for child in get_children():
		if child is Sprite2D:
			sprite_count += 1
			print("Found Sprite2D: ", child.name, " at position: ", child.position)
	
	if sprite_count > 1:
		print("WARNING: Multiple Sprite2D nodes detected (", sprite_count, ")! This may cause overlap.")
	
	# Verificar que los nodos existan
	if not sprite_node:
		print("ERROR: Sprite2D node not found in Player!")
		print("Available children in Player.tscn:")
		for i in range(get_child_count()):
			var child = get_child(i)
			print("  - ", child.name, " (", child.get_class(), ")")
		
		# Solo crear si realmente no existe
		sprite_node = Sprite2D.new()
		sprite_node.name = "Sprite2D"
		add_child(sprite_node)
		print("Created Sprite2D node dynamically")
		
	if not collision_node:
		print("ERROR: CollisionShape2D node not found in Player!")
		collision_node = CollisionShape2D.new()
		collision_node.name = "CollisionShape2D"
		add_child(collision_node)
		print("Created CollisionShape2D node dynamically")
		
	if not shoot_timer:
		print("ERROR: ShootTimer node not found in Player!")
		shoot_timer = Timer.new()
		shoot_timer.name = "ShootTimer"
		add_child(shoot_timer)
		print("Created ShootTimer node dynamically")
	
	# CONFIGURAR DIMENSIONES CORRECTAS (REEMPLAZA create_player_sprite)
	setup_player_dimensions()
	
	# Configurar timer de disparo
	shoot_timer.wait_time = shoot_cooldown
	shoot_timer.one_shot = true
	shoot_timer.connect("timeout", _on_shoot_timer_timeout)
	
	# Conectar la señal area_entered del Area2D (self)
	if self is Area2D:
		self.connect("area_entered", _on_area_entered)
		print("Connected area_entered signal successfully")
	else:
		print("ERROR: self is not an Area2D! Type: ", self.get_class())
	
	print("Player initialized successfully at position: ", position)

func setup_player_dimensions():
	"""Configurar dimensiones correctas del jugador"""
	
	# 1. Configurar sprite
	setup_player_sprite()
	
	# 2. Configurar colisión basada en la textura real del sprite
	var shape = RectangleShape2D.new()
	
	if sprite_node.texture:
		# Calcular tamaño basado en la textura real y su escala
		var texture_size = sprite_node.texture.get_size()
		var scaled_size = texture_size * sprite_node.scale
		
		# Usar el tamaño real escalado de la textura
		shape.size = Vector2(scaled_size.x, scaled_size.y)
		print("Player collision calculated from texture: ", texture_size, " * ", sprite_node.scale, " = ", shape.size)
	else:
		# Fallback si no hay textura
		shape.size = Vector2(35, 25)
		print("Player collision using fallback size: ", shape.size)
	
	collision_node.shape = shape
	print("Player hitbox final size: ", shape.size)

func setup_player_sprite():
	if not sprite_node:
		print("ERROR: sprite_node is null!")
		return
	
	# SIMPLIFICADO: Solo usar la textura de la escena
	if sprite_node.texture != null:
		print("Using texture from Player.tscn scene")
		# Configurar escala apropiada
		sprite_node.scale = Vector2(0.3, 0.3)
		# Asegurar que esté visible y centrado
		sprite_node.visible = true
		sprite_node.position = Vector2.ZERO  # Centrar en el nodo padre
		print("Player sprite configured: scale=0.3, centered")
	else:
		# Solo crear fallback si no hay textura en la escena
		print("No texture in scene, creating simple fallback...")
		var image = Image.create(40, 30, false, Image.FORMAT_RGBA8)
		image.fill(Color.CYAN)  # Color diferente para identificar fallback
		
		var texture = ImageTexture.new()
		texture.set_image(image)
		sprite_node.texture = texture
		sprite_node.scale = Vector2(1.0, 1.0)
		sprite_node.position = Vector2.ZERO
		print("Fallback sprite created: 40x30px cyan")

# Función removida - ya no necesaria, usamos solo la textura de la escena

func _process(delta):
	handle_movement(delta)
	handle_shooting()

func handle_movement(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	
	velocity = velocity.normalized() * speed
	var new_position = position + velocity * delta
	
	# LÍMITES AJUSTADOS PARA LA ESCALA MÁS PEQUEÑA
	var screen_width = 1024.0
	var sprite_half_width = 17.5  # Ajustado para escala 0.3 (35/2)
	
	var left_limit = sprite_half_width
	var right_limit = screen_width - sprite_half_width
	
	new_position.x = clamp(new_position.x, left_limit, right_limit)
	
	# Debug para verificar el centrado
	if velocity.x != 0:
		var center_distance = abs(new_position.x - 512.0)  # Distancia al centro
		print("Position: ", new_position.x, " | Distance from center: ", center_distance)
	
	position = new_position

func handle_shooting():
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot()

func shoot():
	if not shoot_timer:
		print("ERROR: shoot_timer is null!")
		return
		
	can_shoot = false
	shoot_timer.start()
	emit_signal("bullet_fired", bullet_scene, position + Vector2(0, -15))
	print("Player shot fired!")

func _on_shoot_timer_timeout():
	can_shoot = true

func _on_area_entered(area):
	if area.is_in_group("enemy_bullets"):
		area.queue_free()
		emit_signal("player_hit")
		print("Player hit!")
