extends State
class_name EnemyWander

@export var enemy : CharacterBody2D
@export var moveSpeed := 50.0
@export var stats : EnemyStats
 
var isAlive : bool = true
var moveDirection : Vector2
var wanderTime : float

var player : CharacterBody2D

func randomize_wander():
	moveDirection = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	wanderTime = randf_range(1, 3)

func enter():
	player = get_tree().get_first_node_in_group("Player")
	randomize_wander()

func update(delta: float):
	if wanderTime > 0:
		wanderTime -= delta
	else:
		randomize_wander()

func physics_update(_delta: float):
	if enemy:
		enemy.velocity = moveDirection * (stats.moveSpeed * 0.5)
	
	if isAlive:
		if enemy.is_queued_for_deletion() or player.is_queued_for_deletion():
			isAlive = false
		else:
			var direction = player.global_position - enemy.global_position
	
			if direction.length() < 800:
				transition.emit(self, "Follow")
