extends CharacterBody2D

var can_move = true

func _ready() -> void:
	name = "Mono"
	print("=== MONO INICIALIZADO ===")
	print("Nombre del nodo: ", name)
	
	# Crear un Node2D padre para controlar el pivot
	var pivot_parent = Node2D.new()
	pivot_parent.name = "PivotParent"
	
	# Mover este nodo a la posición deseada antes de agregar hijos
	if Global.posicion_mono != Vector2.ZERO:
		print("Posicion Mono actualizada:", Global.posicion_mono)
		global_position = Global.posicion_mono
	
	# Configurar el offset del pivot (ejemplo: pivot en los pies)
	var pivot_offset = Vector2(0, -40)  # Ajusta estos valores
	
	# Agregar el pivot parent como hijo de este nodo
	add_child(pivot_parent)
	pivot_parent.position = pivot_offset
	
	# Mover las animaciones y sprites al pivot parent
	var animaciones_node = $animaciones
	remove_child(animaciones_node)
	pivot_parent.add_child(animaciones_node)
	animaciones_node.owner = pivot_parent
	
	# Reproducir animación
	animaciones_node.play("XD")
		
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
