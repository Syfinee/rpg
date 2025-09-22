extends Area2D

# Reference to LevelRoot dynamically
@onready var level_root: Node2D = get_tree().current_scene.get_node("World/Node2D/LevelRoot")

signal endless_loaded(level_instance: Node)

# Cooldown in "uses remaining" style
var cooldown: int = 0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(_body: Node2D) -> void:
	if _body.name == "Player" and cooldown <= 0:
		print("detect")

		# Trigger GameManager actions
		GameManager.clear_level_root()
		GameManager.load_endless()

		# Set cooldown
		cooldown = 2

		# Disable only collisions and monitoring
		_disable_area()

# Disable Area2D monitoring (keeps CollisionShape2D scripts intact)
func _disable_area() -> void:
	monitoring = false   # stop detecting bodies
	visible = false      # optional: hide portal visually
	print("Portal disabled (collisions off)")

# Call this whenever GameManager.load_endless() runs
func reduce_cooldown() -> void:
	if cooldown > 0:
		cooldown -= 1
		print("Cooldown reduced, current:", cooldown)

		# Re-enable the Area2D when cooldown reaches 0
		if cooldown == 0:
			_enable_area()

# Re-enable Area2D monitoring
func _enable_area() -> void:
	monitoring = true    # detect bodies again
	visible = true       # optional: show portal
	print("Portal re-enabled (collisions on)")
