extends Node2D
class_name PlayerAttack

@onready var player : CharacterBody2D = get_owner()
signal attackingSignal

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		attackingSignal.emit(true)
