extends Node2D
@onready var player : CharacterBody2D = get_owner()

var dashVector : Vector2 = Vector2()
var dashMult : int = 5

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("dash"):
		dash()

func dash():
	if player.velocity != Vector2.ZERO:
		dashVector = player.velocity
	elif player.velocity == Vector2.ZERO:
		noMoveDash()
	player.velocity = dashMult * dashVector
	
	player.move_and_slide()
	
	await get_tree().create_timer(.25).timeout
	
	
func noMoveDash():
	dashVector = Vector2.ZERO
	dashVector = player.lastLookDirection * player.speed
