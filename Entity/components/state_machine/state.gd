class_name State
extends Node

var state_machine : StateMachine
var entity : Entity


func _ready() -> void:
	await ready
	
	entity = owner as Entity
	assert(entity != null)


func input(_event: InputEvent) -> void:
	pass


func process(_delta: float) -> void:
	pass


func physics_process(_delta: float) -> void:
	pass


func enter(_msg : Dictionary = {}) -> void:
	pass


func exit() -> void:
	pass
