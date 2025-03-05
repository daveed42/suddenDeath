extends Node2D

@export var animationTree : AnimationTree
@onready var player : Player = get_owner()
@export var playerLook : PlayerLook

var lastFacingDirection := Vector2(0, 1)

func _ready():
	animationTree.active = true

func _physics_process(delta: float) -> void:
	var idle = !player.velocity
	
	lastFacingDirection = playerLook.lastLookDirection
		
	
	animationTree.set("parameters/PlayerStates/Run/blend_position", lastFacingDirection)
	animationTree.set("parameters/PlayerStates/Idle/blend_position", lastFacingDirection)
	animationTree.set("parameters/PlayerStates/Attack/blend_position", lastFacingDirection)

	animationTree.set("parameters/TimeScale/scale", 1.0)
