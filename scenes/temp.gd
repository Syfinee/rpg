extends Node
signal pointreached
func _ready() -> void:
	# Wait one frame so all nodes in the scene are ready
	await get_tree().process_frame

	# Make sure LevelRoot exists in GameManager
	if GameManager.level_root == null:
		GameManager.level_root = get_tree().current_scene.get_node_or_null("World/Node2D/LevelRoot")
		if GameManager.level_root == null:
			push_error("LevelRoot not found! Check the path: World/Node2D/LevelRoot")
			return

	# Now safely load endless
	GameManager.clear_level_root()
	GameManager.load_endless()
	
