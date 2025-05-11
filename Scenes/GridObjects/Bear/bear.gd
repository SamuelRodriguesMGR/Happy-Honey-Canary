extends GridObject


@onready var label : Label = %Label
@onready var dialog: Panel = $Dialog

var getting_honey : bool = false

func _physics_process(_delta: float) -> void:
	if on_honey():
		dialog.show()
		label.text = "Mmm,\nhhoney ;>"
		getting_honey = true
		
	elif getting_honey:
		dialog.show()
		label.text = "Heey..,\nhhoney :<"
			
func on_honey() -> bool:
	for node in get_parent().dict_object:
		if node and get_parent().dict_object[node] == grid_position and\
		(node.name == "jarHoney" or node.name == "jarHoney2"):
			return true
	return false
