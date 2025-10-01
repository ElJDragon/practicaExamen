extends CharacterBody2D

@onready var interaction_area = $Area2D/CollisionShape2D
@onready var interaction_prompt = $Label
var player_in_range = false
var player_reference = null
var cutscene_playing = false

func _ready():
	print("=== INICIANDO MAGO ===")
	print("Nodo mago: ", name)
	print("Posición del mago: ", global_position)
	
	# Verificar que los nodos existen ANTES de @onready
	print("Verificando nodos hijos...")
	for child in get_children():
		print("  - ", child.name, " (", child.get_class(), ")")
	
	# Verificar interaction_area específicamente
	var area_node = get_node_or_null("Area2D")
	if area_node == null:
		print("❌ ERROR: No se encontró Area2D")
		print("Nodos disponibles:")
		for child in get_children():
			print("  - ", child.name)
		return
	else:
		print("✅ Area2D encontrado: ", area_node.name)
		interaction_area = area_node
	
	# Verificar interaction_prompt
	var prompt_node = get_node_or_null("Label")
	if prompt_node == null:
		print("❌ ERROR: No se encontró Label")
		return
	else:
		print("✅ Label encontrado: ", prompt_node.name)
		interaction_prompt = prompt_node
	
	# Configurar Area2D
	setup_interaction_area()

func setup_interaction_area():
	print("=== CONFIGURANDO AREA2D ===")
	
	if interaction_area == null:
		print("❌ interaction_area es null")
		return
	
	print("Tipo de interaction_area: ", interaction_area.get_class())
	
	if not interaction_area is Area2D:
		print("❌ ERROR: Area2D no es un Area2D, es: ", interaction_area.get_class())
		return
	
	print("✅ Area2D es un Area2D válido")
	
	# Verificar que tenga CollisionShape2D
	var collision_found = false
	for child in interaction_area.get_children():
		print("  Area2D hijo: ", child.name, " (", child.get_class(), ")")
		if child is CollisionShape2D:
			collision_found = true
			if child.shape == null:
				print("❌ CollisionShape2D no tiene forma asignada")
			else:
				print("✅ CollisionShape2D tiene forma: ", child.shape.get_class())
	
	if not collision_found:
		print("❌ ERROR: Area2D no tiene CollisionShape2D")
		return
	
	# Conectar señales
	print("Conectando señales...")
	
	if interaction_area.body_entered.is_connected(_on_body_entered):
		print("⚠️ body_entered ya estaba conectado")
	else:
		var result = interaction_area.body_entered.connect(_on_body_entered)
		if result == OK:
			print("✅ body_entered conectado correctamente")
		else:
			print("❌ ERROR conectando body_entered: ", result)
	
	if interaction_area.body_exited.is_connected(_on_body_exited):
		print("⚠️ body_exited ya estaba conectado")
	else:
		var result = interaction_area.body_exited.connect(_on_body_exited)
		if result == OK:
			print("✅ body_exited conectado correctamente")
		else:
			print("❌ ERROR conectando body_exited: ", result)
	
	interaction_prompt.visible = false
	print("=== MAGO CONFIGURADO ===")

func _on_body_entered(body):
	print("🔵 SEÑAL body_entered recibida!")
	print("  Cuerpo: ", body.name)
	print("  Tipo: ", body.get_class())
	print("  Posición cuerpo: ", body.global_position)
	print("  Posición mago: ", global_position)
	
	if body.name == "Mono":
		print("✅ ¡Es el jugador Mono!")
		if not cutscene_playing:
			player_in_range = true
			player_reference = body
			interaction_prompt.visible = true
			print("✅ Interacción habilitada - Presiona E o ENTER")
		else:
			print("⚠️ Cinemática ya en progreso")
	else:
		print("❌ No es el jugador, es: ", body.name)

func _on_body_exited(body):
	print("🔴 SEÑAL body_exited recibida!")
	print("  Cuerpo: ", body.name)
	
	if body.name == "Mono":
		print("✅ El jugador salió del área")
		player_in_range = false
		player_reference = null
		interaction_prompt.visible = false

func _input(event):
	if not player_in_range or cutscene_playing:
		return
	
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_E or event.keycode == KEY_ENTER:
			print("🎬 ¡INICIANDO CINEMÁTICA desde mago!")
			start_cutscene()

# El resto de las funciones igual que antes...
func start_cutscene():
	cutscene_playing = true
	interaction_prompt.visible = false
	if player_reference:
		player_reference.disable_movement()
	play_video_cutscene()
	
func play_video_cutscene():
	var video_player = VideoStreamPlayer.new()
	video_player.name = "MagoCutscenePlayer"
	# AGREGAR AL ROOT para asegurar pantalla completa
	get_tree().root.add_child(video_player)

	# Ajustar anchors y offsets para pantalla completa
	video_player.anchor_left = 0.0
	video_player.anchor_top = 0.0
	video_player.anchor_right = 1.0
	video_player.anchor_bottom = 1.0
	video_player.offset_left = 0
	video_player.offset_top = 0
	video_player.offset_right = 0
	video_player.offset_bottom = 0
	video_player.expand = true
	video_player.visible = true

	var video_path = "res://cinematicas/mago_cinematics.ogv"
	var video_stream = load(video_path)
	if video_stream == null:
		print("❌ No se pudo cargar el video")
		end_cutscene()
		return
	video_player.stream = video_stream

	video_player.finished.connect(_on_video_finished)
	video_player.play()
	print("✅ Video iniciado a pantalla completa!")

func _on_video_finished():
	print("🎬 Video finalizado")
	end_cutscene()

func end_cutscene():
	cutscene_playing = false
	if player_reference:
		player_reference.enable_movement()
	var video_player = get_tree().root.get_node_or_null("MagoCutscenePlayer")
	if video_player:
		video_player.queue_free()
	if player_in_range:
		interaction_prompt.visible = true
