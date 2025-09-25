extends CharacterBody2D


func _process(delta):
	if Input.is_action_just_pressed("ui_accept") or Input.is_key_pressed(KEY_E):
		# Buscar al mono en la escena actual y guardar su posición
		var mono_node = get_node("../Mono")
		
		if mono_node:
			Global.posicion_mono = mono_node.global_position
			print("Posicion Mono guardada:", Global.posicion_mono)
		else:
			print("No se encontró el nodo Mono, usando posición por defecto")
			Global.posicion_mono = Vector2(653, 1280)  # Posición por defecto del mono
		
		get_tree().change_scene_to_file("res://trivia.tscn")
