class_name PathComponent extends Node


# Система AStarGrid2D
var astar_grid : AStarGrid2D

func direction_move(trg_pos : Vector2) -> void: 
	if !astar_grid:   
		astar_grid = owner.tile_map.astar_grid
	var start_position : Vector2i = owner.tile_map.local_to_map(owner.global_position)
	var   end_position : Vector2i = owner.tile_map.local_to_map(trg_pos)
	
	var is_path = astar_grid.get_id_path(start_position, end_position).slice(1) # список точек передвижения 
	if not is_path.is_empty(): # если путь не пустой и он прошёл точку
		owner.pushable_component.try_push(is_path.front() - owner.grid_position)
