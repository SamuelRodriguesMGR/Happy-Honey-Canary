extends GridObject


@onready var audio_stream_player : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var pushable_component : Node = get_node(^"PushableComponent") 
@onready var path_component : PathComponent = get_node(^"PathComponent")
@onready var delay_mouse : Timer = get_node(^"DelayMouse")
	
func _input(event: InputEvent) -> void:
	if get_tree().current_scene.ui.menu.visible:
		return
	
	if sprite.animation == "spawn":
		if not sprite.is_playing():
			sprite.play("idle")
		return
		
	if not can_turn:
		return
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and delay_mouse.is_stopped():
			delay_mouse.start()
			path_component.direction_move(get_global_mouse_position())
			audio_stream_player.play()
			can_turn = false
	
	var move_dir : Vector2i = Input.get_vector(&"ui_left", &"ui_right", &"ui_up", &"ui_down")
	if move_dir and delay_mouse.is_stopped():
		delay_mouse.start()
		pushable_component.try_push(move_dir)
		audio_stream_player.play()
		can_turn = false
