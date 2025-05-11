extends Node2D

@onready var spawn_player: Sprite2D = $"../Nest"
@onready var layer_floor : TileMapLayer = get_node(^"LayerFloor")
@onready var layer_grass : TileMapLayer = get_node(^"LayerGrass")
@onready var layer_wall  : TileMapLayer = get_node(^"LayerWall")

var astar_grid : AStarGrid2D 

func _ready():
	astar_grid = AStarGrid2D.new() # создаём новую матрицу передвижения
	astar_grid.region = layer_floor.get_used_rect() # получаем минимальные и максимальные коородинаты тайлов
	astar_grid.cell_size = Vector2(16, 16)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	generate_chunk()

func generate_chunk() -> void:
	 # полные размеры карты и координаты начального тайла
	var region_size     : Vector2i = astar_grid.region.size
	var region_position : Vector2i = astar_grid.region.position
	
	for x in region_size.x:
		for y in region_size.y:
			# позиция тайла относительно начала
			var tile_position : Vector2i = Vector2i( 
				x + region_position.x,
				y + region_position.y,
			)
			# узнаём инфу об этом тайле
			var tile_data_floor : TileData = layer_floor.get_cell_tile_data(tile_position) 
			var tile_data_wall  : TileData = layer_wall.get_cell_tile_data(tile_position) 
				
			if tile_data_wall != null or tile_data_floor == null:
				astar_grid.set_point_solid(tile_position)

func temp_open_trees() -> void:
	layer_wall.erase_cell(Vector2i(8, 10))
	astar_grid.set_point_solid(Vector2i(8, 10), false)

func dead_player(player) -> void:
	layer_grass.set_cell(player.grid_position, 1, Vector2i(1, 2))
	player.grid_position = local_to_map(spawn_player.global_position)
	
func get_cellv(pos: Vector2i) -> GridObject:
	for node in get_tree().get_nodes_in_group(&"GridObjects"):
		if node.grid_position == pos:
			return node
	return null
	
func cellv_exists(pos: Vector2i) -> bool:
	return layer_floor.get_cell_tile_data(pos) != null

func map_to_local(pos : Vector2i) -> Vector2:
	return layer_floor.map_to_local(pos)

func local_to_map(pos : Vector2) -> Vector2i:
	return layer_floor.local_to_map(pos)
