extends CharacterBody2D
class_name gunMob

@export var stats : EnemyStats

@onready var main = get_tree().get_root().get_node("StartingMap") #TODO will eventually need to change 
@onready var projectile = load("res://scenes/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
	if velocity.length() > 0:
		if velocity.x > 0:
			$AnimationPlayer.play("moveRight")
		else:
			$AnimationPlayer.play("moveLeft")

func shoot():
	var instance = projectile.instantiate()
	var player : CharacterBody2D = get_tree().get_first_node_in_group("Player")
	instance.direction = player.global_position - global_position
	instance.spawnPos = global_position
	instance.spawnRotation = global_position.angle_to_point(player.global_position)+1.5708
	main.add_child.call_deferred(instance)


func _on_follow_ready_to_shoot() -> void:
	shoot()
