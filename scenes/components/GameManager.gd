extends Node

signal endless_loaded(level_instance: Node)

@onready var level_root: Node2D = null

func _ready() -> void:
	# Cache LevelRoot after the scene tree is ready
	level_root = get_tree().current_scene.get_node_or_null("World/Node2D/LevelRoot")
	if level_root == null:
		push_error("LevelRoot not found! Check the path: World/Node2D/LevelRoot")


func clear_level_root() -> void:
	if not level_root:
		print("LevelRoot not found!")
		return

	for child in level_root.get_children():
		child.queue_free()


func load_endless() -> void:
	if not level_root:
		print("Cannot load endless, LevelRoot not found!")
		return

	# Open Subsetmaps folder
	var dir := DirAccess.open("res://Subsetmaps/")
	if dir == null:
		print("Failed to open Subsetmaps folder")
		return

	# Collect all .tscn files
	var map_files: Array[String] = []
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if not dir.current_is_dir() and file_name.ends_with(".tscn"):
			map_files.append("res://Subsetmaps/" + file_name)
		file_name = dir.get_next()
	dir.list_dir_end()

	if map_files.size() == 0:
		print("No map files found in Subsetmaps")
		return

	# Layout parameters
	var tile_size := 16
	var map_width := 15 * tile_size
	var map_height := 15 * tile_size
	var maps_per_row := 5
	var rows := 3

	# Pick 15 random maps (duplicates allowed)
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var chosen_maps: Array[String] = []
	for i in range(rows * maps_per_row):  # 15 maps total
		var pick_index = rng.randi_range(0, map_files.size() - 1)
		chosen_maps.append(map_files[pick_index])

	print("Chosen maps:", chosen_maps)

	# Load and position maps in 3 rows
	for row_index in range(rows):
		for col_index in range(maps_per_row):
			var map_index = row_index * maps_per_row + col_index
			var path := chosen_maps[map_index]
			var scene: PackedScene = load(path)
			if scene:
				var instance: Node = scene.instantiate()
				level_root.add_child(instance)

				if instance is Node2D:
					instance.position = Vector2(col_index * map_width, row_index * map_height)

				print("Placed map:", path, "at row:", row_index, "col:", col_index)
			else:
				print("Failed to load:", path)

	# Emit signal
	endless_loaded.emit(level_root)
