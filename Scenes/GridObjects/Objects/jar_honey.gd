extends GridObject


func _on_interactable_component_just_interacted(interacted_by: GridObject) -> void:
	sprite.scale = Vector2(2.0, 0.5)
	sprite.rotation_degrees = 7.0
	
	# Animate scale and rotation back to normal
	var t: Tween = create_tween()\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_OUT)\
		.set_parallel()
	t.tween_property(sprite, ^"scale", Vector2.ONE, 0.2)
	t.tween_property(sprite, ^"rotation", 0.0, 0.2)
	
	if interacted_by.is_in_group("BearGroup"):
		interacted_by.grid_position = grid_position
		
		if not interacted_by.getting_honey:
			tile_map.temp_open_trees()
