extends Node2D
class_name PlayerShoot

@onready var player : CharacterBody2D = get_owner()
signal shootSignal

var shooting : bool = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shootSignal.emit(true)
