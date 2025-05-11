extends GridObject


func _on_interactable_component_just_interacted(_interacted_by: GridObject) -> void:
	$Dialog.visible = !$Dialog.visible
	sprite.scale = Vector2(2.0, 0.5)
	sprite.rotation_degrees = 7.0
	
	# Animate scale and rotation back to normal
	var t: Tween = create_tween()\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_OUT)\
		.set_parallel()
	t.tween_property(sprite, ^"scale", Vector2.ONE, 0.2)
	t.tween_property(sprite, ^"rotation", 0.0, 0.2)
