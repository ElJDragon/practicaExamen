extends Area2D

# Señales
signal bullet_hit(bullet)

# Variables
var speed: float = 400.0

# Referencias a nodos
var sprite_node: Sprite2D
var collision_node: CollisionShape2D

func _ready():
	# Obtener referencias a los nodos
	sprite_node = get_node("Sprite2D")
	collision_node = get_node("CollisionShape2D")
	
	if not sprite_node or not collision_node:
		print("ERROR: Bullet nodes not found!")
		return
	
	# Crear sprite de la bala
	create_bullet_sprite()
	
	# Configurar colisión adaptativa
	setup_bullet_collision()
	
	# Agregar al grupo de balas del jugador
	add_to_group("player_bullets")
	
	# Conectar señal de colisión
	connect("area_entered", _on_area_entered)
	
	print("Player bullet created at ", position)

func setup_bullet_collision():
	"""Configurar colisión basada en el sprite (de escena o cargado)"""
	var shape = RectangleShape2D.new()
	
	if sprite_node.texture:
		# Usar el tamaño de la textura para calcular colisión
		var texture_size = sprite_node.texture.get_size()
		var scaled_size = texture_size * sprite_node.scale
		
		# Ajustar para que sea apropiado para una bala muy pequeña
		var collision_width = min(scaled_size.x, 3)  # Mucho más pequeña
		var collision_height = min(scaled_size.y, 8)
		shape.size = Vector2(collision_width, collision_height)
		
		print("Player bullet collision based on texture: ", shape.size)
	else:
		# Colisión estándar para fallback
		shape.size = Vector2(4, 10)
		print("Player bullet using standard collision: ", shape.size)
	
	collision_node.shape = shape

func create_bullet_sprite():
	# Verificar si ya tiene textura asignada desde la escena
	if sprite_node.texture != null:
		print("Player bullet using texture from scene: ", sprite_node.texture)
		# La escena ya tiene la textura configurada, pero necesita escala pequeña
		sprite_node.scale = Vector2(0.05, 0.1)  # Forzar escala pequeña
		sprite_node.visible = true
	else:
		# Intentar cargar sprite de bala desde recursos
		var bullet_texture = load_bullet_sprite()
		
		if bullet_texture:
			sprite_node.texture = bullet_texture
			# Escala mucho más pequeña para balas apropiadas
			sprite_node.scale = Vector2(0.05, 0.1)  # Muy pequeña en ancho, un poco más en alto
			print("Player bullet using loaded sprite")
		else:
			# Fallback: crear imagen blanca pequeña
			var image = Image.create(4, 10, false, Image.FORMAT_RGBA8)
			image.fill(Color.WHITE)
			
			var texture = ImageTexture.new()
			texture.set_image(image)
			sprite_node.texture = texture
			sprite_node.scale = Vector2(1.0, 1.0)
			print("Player bullet using fallback sprite")

func load_bullet_sprite():
	"""Cargar sprite de bala del jugador desde recursos"""
	var bullet_paths = [
		"res://assets/Spaceshipassets/99396.png",  # Podría ser una bala
		"res://assets/Spaceshipassets/spaceship-png-icon-8.png",  # O parte de este sprite
		"res://icon.svg"  # Como último recurso
	]
	
	for path in bullet_paths:
		if FileAccess.file_exists(path):
			var texture = load(path)
			if texture:
				print("Found player bullet texture at: ", path)
				return texture
	
	print("No player bullet texture found, using fallback")
	return null

func _process(delta):
	position.y -= speed * delta
	
	# Destruir si sale de la pantalla
	if position.y < -10:
		queue_free()

func _on_area_entered(_area):
	emit_signal("bullet_hit", self)
	print("Player bullet hit something!")
