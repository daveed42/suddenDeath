extends CharacterBody2D
class_name mob

@export var stats : EnemyStats

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
	if velocity.length() > 0:
		if velocity.x > 0:
			$AnimationPlayer.play("moveRight")
		else:
			$AnimationPlayer.play("moveLeft")
