extends Node2D


@onready var path : Path2D = get_node(^"Path2D")
@export var position_curve : Curve

var travel_time  : float = 6.0
var sample_point : float = 0.0
var dir : int = 1

var list_sheet : Array[Sprite2D]

func _physics_process(delta: float) -> void:
	if sample_point > 1.0 or sample_point < 0.0:
		dir = -dir
		
	var path_direction = path.curve.get_point_position(1) - path.curve.get_point_position(0)
	sample_point += (delta / travel_time) * dir
	
	$Camera2D.position = path.curve.get_point_position(0) + path_direction * position_curve.sample(sample_point)
	
	for sheet in list_sheet:
		sheet.position += Vector2.DOWN * 4

func _on_timer_timeout() -> void:
	%Eye.visible = true
	await get_tree().create_timer(0.2).timeout
	%Eye.visible = false


func _on_button_exit_pressed() -> void:
	get_tree().quit()


func _on_button_start_pressed() -> void:
	$AnimationPlayer.play("start game")


func _on_button_options_pressed() -> void:
	var sprite : Sprite2D = Sprite2D.new()
	sprite.texture = preload("res://Assets/Bg menu/sheet.png")
	sprite.global_position = Vector2(228, 92)
	add_child(sprite)
	list_sheet.append(sprite)

func _on_button_pressed() -> void:
	%Eye.visible = true
	await get_tree().create_timer(0.2).timeout
	%Eye.visible = false
	
func start_game() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game/game.tscn")
