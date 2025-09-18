extends CharacterBody2D

var can_move = true

func _ready() -> void: 
	name = "Mono"
	print("=== MONO INICIALIZADO ===")
	print("Nombre del nodo: ", name)
	$animaciones.play("XD")
	print("Posicion Mono:", Global.posicion_mono)
	if Global.posicion_mono != Vector2.ZERO:
		print("Posicion Mono actualizada:", Global.posicion_mono)
		global_position = Global.posicion_mono
		
func _physics_process(delta):
	if not can_move:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	var direccion = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direccion * 200
	move_and_slide()

# Debug de input - esto nos dirá si las teclas funcionan
func _input(event):
	if event is InputEventKey and event.pressed:
		print("MONO - Tecla presionada: ", event.keycode, " (", char(event.keycode), ")")
		if event.keycode == KEY_E:
			print("MONO - ¡Tecla E detectada!")
		elif event.keycode == KEY_ENTER:
			print("MONO - ¡Tecla ENTER detectada!")

func disable_movement():
	can_move = false
	print("MONO - Movimiento desactivado")

func enable_movement():
	can_move = true
	print("MONO - Movimiento activado")
