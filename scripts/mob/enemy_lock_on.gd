extends State
class_name EnemyLockOn

@export var enemy : CharacterBody2D
@export var stats : EnemyStats
var player: CharacterBody2D
var isAlive : bool = true
var ableToShoot : bool = true

signal readyToShoot
signal timerStart

func enter():
	player = get_tree().get_first_node_in_group("Player")

func physics_update(_delta: float):
	if isAlive:
		if enemy.is_queued_for_deletion() or player.is_queued_for_deletion():
			isAlive = false
		else:
			var direction = player.global_position - enemy.global_position
			
			if direction.length() > 250:
				enemy.velocity = direction.normalized() * stats.moveSpeed
			else:
				enemy.velocity = Vector2()
				
			if direction.length() > 800:
				transition.emit(self, "Wander")
			elif direction.length() < 800:
				if ableToShoot == true:
					readyToShoot.emit()
					ableToShoot = false
					timerStart.emit()
					
				
				
func _on_shoot_timer_timeout() -> void:
	ableToShoot = true
