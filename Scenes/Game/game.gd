extends Node2D

@onready var ui : CanvasLayer = get_node(^"UI")
@onready var current_level : Node2D = $Level1
@onready var player : Node2D = current_level.get_node(^"Player")

var head : GridObject
var tail : GridObject
var current_turn_object : GridObject

func _ready() -> void:
	update_stack()
	
	#output_stack()

func update_stack() -> void:
	for node in get_tree().get_nodes_in_group(&"GridObjects"): 
		if node.is_enable:
			add_node(node)
	current_turn_object = head
	
func _physics_process(_delta: float) -> void:
	if current_turn_object == null:
		return
	
	 # Текущий объект может ходить
	if not(current_turn_object.can_turn and current_turn_object.is_enable):
		# Переход к следующему объекту
		next_turn()

func next_turn() -> void:
	# Переходим к следующему объекту
	current_turn_object.can_turn = false
	current_turn_object = current_turn_object.next
	
	# Если дошли до конца, начинаем сначала
	if current_turn_object == null:
		current_turn_object = head
		
	# Даем возможность хода новому текущему объекту
	if current_turn_object != null:
		current_turn_object.can_turn = true

func new_life() -> void:
	get_tree().current_scene.current_level.get_node("TileMap").dead_player(player)
	player.sprite.play("spawn")

func add_node(node : GridObject) -> void:
	if tail == null:
		head = node
		tail = node
	else:
		tail.next = node
		node.prev = tail
		tail = node

func remove_node(node : GridObject) -> void:
	var prev_node : GridObject = node.prev
	var next_node : GridObject = node.next
	
	if node == head:
		head = next_node
	
	if node == tail:
		tail = prev_node
		
	if prev_node:
		prev_node.next = next_node
		
	if next_node:
		next_node.prev = prev_node

func output_stack() -> void:
	var current : GridObject = head
	while current != null:
		print(current)
		current = current.next
