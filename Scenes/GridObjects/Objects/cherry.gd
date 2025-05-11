extends GridObject


@onready var player : GridObject = get_parent().get_node("Player")

func _physics_process(_delta: float) -> void:
	if player.grid_position == grid_position and not actived:
		get_tree().current_scene.ui.get_cherry()
		get_tree().current_scene.remove_node(self)
		hide()
		actived = true
