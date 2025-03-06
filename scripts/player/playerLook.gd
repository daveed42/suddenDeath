extends Node2D
class_name PlayerLook

var lastLookDirection : Vector2 = Vector2()

@onready var player : CharacterBody2D = get_owner()

func _physics_process(_delta: float) -> void:
	var lookDirection = Input.get_vector("look_left", "look_right", "look_up", "look_down")
	if lookDirection:
		lastLookDirection = lookDirection
