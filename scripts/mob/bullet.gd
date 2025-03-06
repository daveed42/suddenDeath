extends CharacterBody2D
class_name Projectile

@export var speed =300

var direction : Vector2
var spawnPos : Vector2
var spawnRotation : float
var reflected : bool = false

@onready var player = get_tree().get_first_node_in_group("Player")

func _ready() -> void:
	global_position = spawnPos
	global_rotation = spawnRotation 
	print("Bullet parent: ", get_parent())
	
func _physics_process(_delta: float) -> void:
	if reflected == true:
		velocity = direction.normalized() * speed * 1.5
	else:
		velocity = direction.normalized() * speed
	move_and_slide()

func _on_projectile_hitbox_area_entered(area: Area2D) -> void:
	if area == player.get_node("ShineReflect"):
		var projectileDirection = velocity
		projectileDirection.x = -(projectileDirection.x)
		projectileDirection.y = -(projectileDirection.y)
		direction = projectileDirection 
		
		var projectileRotation = global_rotation + 3.14159
		rotation = projectileRotation
		
		reflected = true
		$ProjectileHitbox.set_collision_layer_value(9, true)
		$ProjectileHitbox.set_collision_mask_value(3, true)
	
	if area.get("name") == "HitboxComponent":
		queue_free()

func _on_projectile_lifetime_timeout() -> void:
	queue_free()
