extends Node2D

@export var child_nodes: Array[Node2D] = []  # Assign 4 child nodes in editor

var active_index: int = -1
var rng := RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	# Optionally deactivate all at start
	for child in child_nodes:
		if child:
			child.visible = false

# Call this when GameManager.load_endless is triggered
func activate_random_child() -> void:
	if child_nodes.size() != 4:
		push_warning("Please assign exactly 4 child nodes!")
		return

	# Disable current active node
	if active_index >= 0 and active_index < child_nodes.size():
		var current = child_nodes[active_index]
		if current:
			current.visible = false

	# Pick a random number between 1-4
	active_index = rng.randi_range(0, 3)
	var new_active = child_nodes[active_index]

	if new_active:
		new_active.visible = true

	print("Activated child number:", active_index + 1)
