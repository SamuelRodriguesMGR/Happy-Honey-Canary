extends CanvasLayer


@onready var timer_death  : Timer = $TimerDeath
@onready var label_dozens : Label = %LabelDozens
@onready var label_units  : Label = %LabelUnits

@onready var texture_rect : TextureRect = %TextureRect
@onready var label : Label = %Label

@onready var menu : VBoxContainer = $Menu

var current_time : float = 60.0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_cancel"):
		$ColorRect.hide()
		menu.visible = !menu.visible
	
func _on_timer_death_timeout() -> void:
	if current_time <= 0:
		new_life()
		await get_tree().create_timer(2).timeout
		
	current_time -= 1
	
	label_dozens.text = str(int(current_time / 10))
	label_units.text = str(int(current_time) % 10)

func new_life() -> void:
	current_time = 60.0
	get_parent().new_life()
	
	
func get_cherry() -> void:
	label.text = str(int(label.text) + 1)
	texture_rect.scale = Vector2(2.0, 0.5)
	texture_rect.rotation_degrees = 7.0

	var t: Tween = create_tween()\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_OUT)\
		.set_parallel()
	t.tween_property(texture_rect, ^"scale", Vector2.ONE, 0.2)
	t.tween_property(texture_rect, ^"rotation", 0.0, 0.2)


func _on_button_reset_pressed() -> void:
	label.text = "0"
	get_parent().current_level.reset_level()
	menu.visible = !menu.visible


func _on_button_resume_pressed() -> void:
	menu.visible = !menu.visible
