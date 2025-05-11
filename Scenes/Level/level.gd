extends Node2D


var dict_object : Dictionary[Node, Vector2i]



func _ready() -> void:
	for node in get_tree().get_nodes_in_group(&"GridObjects"):
		if node:
			dict_object[node] = node.grid_position
		

func reset_level() -> void:
	for node in dict_object:
		node.grid_position = dict_object[node]
		node.show()
		node.actived = false
		
func _physics_process(_delta: float) -> void:
	if bears_getting_honey():
		$Dialog.show()

func bears_getting_honey() -> bool:
	if !$Bear.getting_honey:
		return false
		
	if !$Bear2.getting_honey:
		return false
		
	return true
