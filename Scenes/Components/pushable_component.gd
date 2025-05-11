class_name PushableComponent extends Node


func try_push(dir : Vector2i) -> bool:
	if owner.rotating:
		if dir.x < 0: owner.sprite.scale.x = 1
		elif dir.x > 0: owner.sprite.scale.x = -1
	
	var target_cell : Vector2i = owner.grid_position + dir
	
	if not owner.tile_map.cellv_exists(target_cell) or\
	owner.tile_map.astar_grid.is_point_solid(target_cell):
		animate_push_fail(dir)
		return false
		
	var object : GridObject = owner.tile_map.get_cellv(target_cell)
	if object == null:
		owner.grid_position = target_cell
		return true
	
	if object.intangible:
		owner.grid_position = target_cell
		return true
	
	if object.has_node(^"InteractableComponent"):
		object.get_node(^"InteractableComponent").interact(owner)
		return false
		
	if not object.has_node(^"PushableComponent"):
		animate_push_fail(dir)
		return false
		
	var pc : Node = object.get_node(^"PushableComponent")
	if pc.try_push(dir):
		owner.grid_position = target_cell
		return true
	
	animate_push_fail(dir)
	return false

func animate_push_fail(dir: Vector2i):	
	# Play the animation
	create_tween()\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)\
		.tween_property(
			owner, ^"position", Vector2((owner.grid_position + dir) * owner.GRID_SIZE + owner.GRID_SIZE / 2), 
			0.4)
		
	create_tween()\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)\
		.tween_property(
			owner, ^"position", Vector2(owner.grid_position * owner.GRID_SIZE + owner.GRID_SIZE / 2), 
			0.4)
