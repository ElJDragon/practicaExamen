extends CharacterBody2D


func _process(delta):
	if Input.is_action_just_pressed("ui_accept") or Input.is_key_pressed(KEY_E):
		Global.posicion_mono = Vector2(600.0, -100)
		print("Posicion Mono fija:", Global.posicion_mono)
		get_tree().change_scene_to_file("res://trivia.tscn")
