extends CharacterBody2D
class_name Player
@export var speed : int = 400 #Player speed in pixels/sec
#@export var projectile : Projectile

@onready var main = get_tree().get_root().get_node("StartingMap") #TODO will eventually need to change 
@onready var projectile = load("res://scenes/bullet.tscn")

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
var shooting : bool = false
var canShoot : bool = true

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

#Called at end of animation
func shineRecovery():
	shining = false
	await get_tree().create_timer(.5).timeout
	canShine = true

#Used to activate animation
func _on_player_shine_shine_signal(shiningBool) -> void:
	if canShine:
		shining = shiningBool
		canShine = false

#Used to activate animation TODO and spawn bullet
func _on_player_shoot_shoot_signal(shootingBool) -> void:
	print("Can shoot?", canShoot)
	if canShoot:
		shooting = shootingBool
		canShoot = false
		shoot()
		await get_tree().create_timer(2).timeout
		shootRecovery()

func shootRecovery():
	shooting = false
	canShoot = true
	print("Reset canShoot: ", canShoot)

func shoot():
	var instance = projectile.instantiate()
	var lookDirection = Input.get_vector("look_left", "look_right", "look_up", "look_down")
	if lookDirection == Vector2.ZERO:
		instance.direction = $PlayerLook.lastLookDirection
		instance.spawnPos = global_position + ($PlayerLook.lastLookDirection.normalized() * 30)
		instance.spawnRotation = $PlayerLook.lastLookDirection.angle()+1.5708
	else:
		instance.direction = lookDirection
		instance.spawnPos = global_position + (lookDirection.normalized() * 30)
		instance.spawnRotation = lookDirection.angle()+1.5708
	
	instance.get_node("ProjectileHitbox").set_collision_layer_value(7, false)
	instance.get_node("ProjectileHitbox").set_collision_layer_value(9, true)
	
	instance.get_node("ProjectileHitbox").set_collision_mask_value(3, true)
	instance.get_node("ProjectileHitbox").set_collision_mask_value(6, false)
	#print("Player bullet collision layers: ", instance.get_child($ProjectileHitbox))
	#instance.get_node($ProjectileHitbox).set_collision_layer_value(9,true)
	
	main.add_child.call_deferred(instance)

	print("Shoot")
