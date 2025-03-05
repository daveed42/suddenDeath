extends State
class_name EnemyFollow

@export var enemy : CharacterBody2D
@export var stats : EnemyStats
var player: CharacterBody2D
var isAlive : bool = true

func enter():
	player = get_tree().get_first_node_in_group("Player")

func physics_update(_delta: float):
	if isAlive:
		if enemy.is_queued_for_deletion() or player.is_queued_for_deletion():
			isAlive = false
		else:
			var direction = player.global_position - enemy.global_position
			
			if direction.length() > 25:
				enemy.velocity = direction.normalized() * stats.moveSpeed
			else:
				enemy.velocity = Vector2()
				
			if direction.length() > 400:
				transition.emit(self, "Wander")
		
