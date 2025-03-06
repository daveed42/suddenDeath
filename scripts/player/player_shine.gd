extends Node2D
class_name PlayerShine

@onready var player : CharacterBody2D = get_owner()
signal shineSignal

var shining : bool = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("shine"):
		shineSignal.emit(true)
