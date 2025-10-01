extends Control

# Variables para las animaciones
var tween_btn_iniciar
var posicion_inicial_btn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Dar foco al botón iniciar
	$Iniciar.grab_focus()
	
	# Configurar la escala base del botón (mantener fija)
	$BtnIniciar.scale = Vector2(0.3, 0.3)
	
	# Guardar la posición inicial del botón
	posicion_inicial_btn = $BtnIniciar.position
	
	# Crear la animación de movimiento para BtnIniciar
	animar_boton_iniciar()

# Función para animar el botón iniciar (movimiento arriba-abajo)
func animar_boton_iniciar() -> void:
	# Crear un nuevo Tween con bucle infinito
	tween_btn_iniciar = create_tween()
	tween_btn_iniciar.set_loops() # Hacer que se repita infinitamente
	tween_btn_iniciar.set_trans(Tween.TRANS_SINE) # Transición suave tipo seno
	tween_btn_iniciar.set_ease(Tween.EASE_IN_OUT) # Suavizado al inicio y final
	
	# Calcular posición superior e inferior para el movimiento
	var posicion_arriba = Vector2(posicion_inicial_btn.x, posicion_inicial_btn.y - 6)
	var posicion_abajo = Vector2(posicion_inicial_btn.x, posicion_inicial_btn.y + 6)
	
	# Animar la posición arriba y abajo (efecto de "flotación")
	tween_btn_iniciar.tween_property($BtnIniciar, "position", posicion_arriba, 1.0)
	tween_btn_iniciar.tween_property($BtnIniciar, "position", posicion_abajo, 1.0)
	tween_btn_iniciar.tween_property($BtnIniciar, "position", posicion_inicial_btn, 1.0)

# Funciones para los botones
func _on_btn_iniciar_pressed() -> void:
	# Detener la animación existente
	if tween_btn_iniciar:
		tween_btn_iniciar.kill()
		print('click')
	
	# Efecto de clic (pequeño movimiento hacia abajo)
	var tween_click = create_tween()
	var posicion_presionado = Vector2(posicion_inicial_btn.x, posicion_inicial_btn.y + 5)
	
	tween_click.tween_property($BtnIniciar, "position", posicion_presionado, 0.1)
	tween_click.tween_property($BtnIniciar, "position", posicion_inicial_btn, 0.2)
	
	# Detener la música del menú
	$AudioStreamPlayer2D.stop()
	# Retraso antes de cambiar de escena
	await get_tree().create_timer(0.5).timeout
	
	# Cambiar a la escena del mundo
	get_tree().change_scene_to_file("res://mundo.tscn")

func _on_btn_salir_pressed() -> void:
	get_tree().quit()

# Mantengo las funciones originales por si acaso las necesitas
func _on_iniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://mundo.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()
