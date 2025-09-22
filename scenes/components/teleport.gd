
extends Node2D  # Or Node3D if 3D

func _ready() -> void:
	# Find the player node
	var player: Node = get_tree().current_scene.get_node_or_null("Player")
	
	if player:
		# Move the player to this node's position
		if player is Node2D:
			player.global_position = global_position
		elif player is Node3D:
			player.global_transform.origin = global_transform.origin
		print("Player moved to", global_position)
	else:
		print("Player not found in the scene")
