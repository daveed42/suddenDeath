extends Node2D
class_name PlayerMove

@export var speed : int = 400 #Player speed in pixels/sec
@export var accelerationTime := 0.1

@onready var player : CharacterBody2D = get_owner()

func _physics_process(delta: float) -> void:
	var velocity = player.velocity
	
	var inputDirection = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = velocity.move_toward(inputDirection * speed, 10 * delta * speed)
	
	player.velocity = velocity
	player.move_and_slide()
