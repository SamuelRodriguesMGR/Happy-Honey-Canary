class_name GridObject extends Node2D


const GRID_SIZE : Vector2i = Vector2i(16, 16)

@onready var tile_map : Node2D = get_parent().get_node(^"TileMap")
@onready var sprite : AnimatedSprite2D = get_node(^"AnimatedSprite2D")

@export var rotating : bool = false
@export var is_enable : bool = false
@export var intangible : bool = false

var grid_position : Vector2i: set = set_grid_pos

# Стек ходов
var can_turn : bool = false
var next : GridObject 
var prev : GridObject 

var actived : bool = false

func _ready() -> void:
	grid_position = tile_map.local_to_map(global_position)
	
func set_grid_pos(p: Vector2i):
	grid_position = p
	create_tween()\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)\
		.tween_property(self, ^"position", Vector2(grid_position * GRID_SIZE + GRID_SIZE / 2), 0.3)
	
