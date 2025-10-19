extends Area2D

# Variables
var speed: float = 200.0

# Referencias a nodos
var sprite_node: Sprite2D
var collision_node: CollisionShape2D

func _ready():
	# Obtener referencias a los nodos
	sprite_node = get_node("Sprite2D")
	collision_node = get_node("CollisionShape2D")
	
	if not sprite_node or not collision_node:
		print("ERROR: EnemyBullet nodes not found!")
		return
	
	# Crear sprite de la bala enemiga
	create_enemy_bullet_sprite()
	
	# Configurar colisión adaptativa
	setup_enemy_bullet_collision()
	
	# Agregar al grupo de balas enemigas
	add_to_group("enemy_bullets")
	
	print("Enemy bullet created at ", position)

func setup_enemy_bullet_collision():
	"""Configurar colisión basada en el sprite de la escena"""
	var shape = RectangleShape2D.new()
	
	if sprite_node.texture:
		# Usar el tamaño de la textura de la escena para calcular colisión
		var texture_size = sprite_node.texture.get_size()
		var scaled_size = texture_size * sprite_node.scale
		
		# Ajustar para que sea apropiado para una bala muy pequeña
		var collision_width = min(scaled_size.x, 2)  # Muy pequeña
		var collision_height = min(scaled_size.y, 6)
		shape.size = Vector2(collision_width, collision_height)
		
		print("Enemy bullet using scene texture collision: ", shape.size)
	else:
		# Colisión estándar para fallback
		shape.size = Vector2(4, 10)
		print("Enemy bullet using fallback collision: ", shape.size)
	
	collision_node.shape = shape

func create_enemy_bullet_sprite():
	# Verificar si ya tiene textura asignada desde la escena
	if sprite_node.texture != null:
		print("Enemy bullet using texture from scene: ", sprite_node.texture)
		# La escena ya tiene la textura configurada (invertida respecto al jugador)
		# Escalar apropiadamente para balas muy pequeñas
		sprite_node.scale = Vector2(0.04, 0.08)  # Ligeramente más pequeñas que las del jugador
		sprite_node.visible = true
	else:
		# Fallback: crear imagen roja pequeña solo si no hay textura en la escena
		print("No texture found in scene, creating fallback sprite")
		var image = Image.create(4, 10, false, Image.FORMAT_RGBA8)
		image.fill(Color.RED)
		
		var texture = ImageTexture.new()
		texture.set_image(image)
		sprite_node.texture = texture
		sprite_node.scale = Vector2(1.0, 1.0)

func _process(delta):
	position.y += speed * delta
	
	# Destruir si sale de la pantalla
	if position.y > 780:
		queue_free()
