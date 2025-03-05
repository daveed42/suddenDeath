extends CharacterBody2D
class_name Player
@export var speed : int = 400 #Player speed in pixels/sec
@export var projectile : Projectile

var dashMult : int = 5 #Player dash speed in pixels/sec
var isAlive : bool #Character is either alive or dead, no HP
var screen_size #Size of game window
var look : Vector2 = Vector2()
var lastLookDirection : Vector2 = Vector2()
var dashVector : Vector2 = Vector2()
var canDash : bool = true
var canAttack : bool = true
var attacking : bool = false
var shining : bool = false
var canShine : bool = true

enum playerStates {move, attack}
var currentState

func _ready() -> void:
	screen_size = get_viewport_rect().size
	isAlive = true
		
@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	pass
	
#Called at end of animation
func attackRecovery():
	attacking = false
	await get_tree().create_timer(.15).timeout
	canAttack = true

#Used to activate animation
func _on_player_attack_attacking_signal(attackingBool) -> void:
	attacking = attackingBool


func shineRecovery():
	shining = false
	await get_tree().create_timer(.5).timeout
	canShine = true

#Used to activate animation
func _on_player_shine_shine_signal(shiningBool) -> void:
	shining = shiningBool
