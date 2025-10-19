extends CharacterBody2D

var player_in_range = false
var player_reference = null
var speech_bubble = null

func _ready():
	print("=== INICIANDO MAGO ===")
	setup_interaction_area()
	create_speech_bubble()

func setup_interaction_area():
	# Crear Area2D para detección de proximidad
	var area = Area2D.new()
	area.name = "InteractionArea"
	add_child(area)
	
	# Crear CollisionShape2D para el área de interacción
	var collision = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 50  # Radio de detección
	collision.shape = shape
	area.add_child(collision)
	
	# Conectar señales
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	print("✅ Área de interacción del mago configurada")

func create_speech_bubble():
	# Crear el contenedor del globo de texto como Node2D
	speech_bubble = Node2D.new()
	speech_bubble.name = "SpeechBubble"
	add_child(speech_bubble)
	
	# Posicionar el globo arriba del mago
	speech_bubble.position = Vector2(0, -60)  # Directamente arriba
	speech_bubble.visible = false
	speech_bubble.z_index = 100
	
	# Crear el texto del globo usando Label con configuración correcta
	var label = Label.new()
	label.name = "Text"
	label.text = "Presiona E para\niniciar la trivia"
	# Usar offsets para posicionar en el mundo 2D
	label.offset_left = -65
	label.offset_top = -25
	label.offset_right = 65
	label.offset_bottom = 25
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	# Estilo del label (tema mágico - púrpura/azul)
	label.add_theme_color_override("font_color", Color(0.9, 0.9, 1.0))
	label.add_theme_font_size_override("font_size", 12)
	
	# Agregar fondo al label con tema mágico
	var style_box = StyleBoxFlat.new()
	style_box.bg_color = Color(0.3, 0.2, 0.5, 0.95)  # Púrpura oscuro
	style_box.border_color = Color(0.6, 0.4, 0.9, 0.9)  # Púrpura brillante
	style_box.border_width_left = 2
	style_box.border_width_right = 2
	style_box.border_width_top = 2
	style_box.border_width_bottom = 2
	style_box.corner_radius_top_left = 8
	style_box.corner_radius_top_right = 8
	style_box.corner_radius_bottom_left = 8
	style_box.corner_radius_bottom_right = 8
	label.add_theme_stylebox_override("normal", style_box)
	
	speech_bubble.add_child(label)

func _on_body_entered(body):
	if body.name == "Mono" or body.name == "PJ_Principal":
		print("✅ Jugador cerca del mago")
		player_in_range = true
		player_reference = body
		speech_bubble.visible = true

func _on_body_exited(body):
	if body.name == "Mono" or body.name == "PJ_Principal":
		print("❌ Jugador se alejó del mago")
		player_in_range = false
		player_reference = null
		speech_bubble.visible = false

func _process(delta):
	if player_in_range and (Input.is_action_just_pressed("ui_accept") or Input.is_key_pressed(KEY_E)):
		# Ocultar el globo al iniciar la trivia
		speech_bubble.visible = false
		
		# Usar la referencia del jugador que ya tenemos guardada
		if player_reference:
			Global.posicion_mono = player_reference.global_position
			print("✅ Posición del jugador guardada (mago):", Global.posicion_mono)
		else:
			print("⚠️ No hay referencia del jugador disponible")
		
		# Ir a la trivia
		get_tree().change_scene_to_file("res://trivia.tscn")
