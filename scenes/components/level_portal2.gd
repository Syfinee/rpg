extends Area2D

# Reference to LevelRoot dynamically
@onready var level_root: Node2D = get_tree().current_scene.get_node("World/Node2D/LevelRoot")

# Optional Marker2D to teleport the player to
@export var target_marker: Marker2D

signal endless_loaded(level_instance: Node)

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("detect")

		# Teleport player if a marker is set
		if target_marker:
			body.global_position = target_marker.global_position
			print("Player teleported to marker at:", target_marker.global_position)

		# Clear current level and load endless
		GameManager.clear_level_root()
		GameManager.load_endless()
