extends CharacterBody2D
@export var speed : int = 400 #Player speed in pixels/sec
var dashMult : int = 5 #Player dash speed in pixels/sec
var isAlive : bool #Character is either alive or dead, no HP
var screen_size #Size of game window
var look : Vector2 = Vector2()
var lastLookDirection : Vector2 = Vector2()
var dashVector : Vector2 = Vector2()
var canDash : bool = true
var canAttack : bool = true

enum playerStates {move, attack}
var currentState


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	isAlive = true
	$AnimationPlayer.play("idleDown")
	currentState = playerStates.move

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	#read_move_input()
	#read_look_input()
	
	match currentState:
		playerStates.move:
			read_move_input()
		playerStates.attack:
			attack()
	
func read_move_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if lastLookDirection.x > 0:
			$AnimationPlayer.play("moveLookRight")
		else:
			$AnimationPlayer.play("moveLookRight")
	else:
		pass
	
	if Input.is_action_pressed("dash") and canDash == true:
		dash()
	elif Input.is_action_pressed("attack") and canAttack == true:
		currentState = playerStates.attack
	else:
		move_and_slide()
		
	read_look_input()
	
func read_look_input():
	look = Vector2.ZERO
	if Input.is_action_pressed("look_up"):
		look.y -= 1
		#$Anims.play("lookUp")
		#$AnimatedSprite2D.animation = "walkUp"
		#$AnimatedSprite2D.flip_v = false
	if Input.is_action_pressed("look_down"):
		look.y += 1
		#$Anims.play("lookDown")
		#$AnimatedSprite2D.animation = "walkUp"
		#$AnimatedSprite2D.flip_v = true
	if Input.is_action_pressed("look_right"):
		look.x += 1
		#$Anims.play("lookRight")
		#$AnimatedSprite2D.animation = "walkRight"
		#$AnimatedSprite2D.flip_h = false
	if Input.is_action_pressed("look_left"):
		look.x -= 1
		#$Anims.play("lookLeft")
		#$AnimatedSprite2D.animation = "walkRight"
		#$AnimatedSprite2D.flip_h = true
		
	if look.length() > 0:
		look = look.normalized()
		lastLookDirection = look
	
	#lookAnim()
	
func lookAnim():
	pass
	#if lastLookDirection.y < 0: # and (lastLookDirection.x <= .5 or lastLookDirection.x >= -.5):
	#	$AnimationPlayer.play("")
		#print("sword up")
		
	#elif lastLookDirection.y > 0: # and (lastLookDirection.x <= .5 or lastLookDirection.x >= -.5):
	#	$Anims.play("lookDown")
	#	#print("sword down")
#
	#if lastLookDirection.x < 0: # and (lastLookDirection.y <= .5 or lastLookDirection.y >= -.5):
	#	$Anims.play("lookLeft")
		#print("sword left")

	#elif lastLookDirection.x > 0: # and (lastLookDirection.y <= .5 or lastLookDirection.y >= -.5):
	#	$Anims.play("lookRight")
		#print("sword right")

func dash():
	if velocity != Vector2.ZERO:
		dashVector = velocity
	elif velocity == Vector2.ZERO:
		noMoveDash()
	velocity = dashMult * dashVector
	
	move_and_slide()
	
	await get_tree().create_timer(.25).timeout
	
	canDash = false
	
	await get_tree().create_timer(.25).timeout
	canDash = true
	
func noMoveDash():
	dashVector = Vector2.ZERO
	dashVector = lastLookDirection * speed
	
func attack():
	print(lastLookDirection)
	if lastLookDirection.y < 0: # and (lastLookDirection.x <= .5 or lastLookDirection.x >= -.5):
		$AnimationPlayer.play("swordUp")
		print("sword up")
		
	elif lastLookDirection.y > 0: # and (lastLookDirection.x <= .5 or lastLookDirection.x >= -.5):
		$AnimationPlayer.play("swordDown")
		print("sword down")

	elif lastLookDirection.x < 0: # and (lastLookDirection.y <= .5 or lastLookDirection.y >= -.5):
		$AnimationPlayer.play("swordLeft")
		print("sword left")

	elif lastLookDirection.x > 0: # and (lastLookDirection.y <= .5 or lastLookDirection.y >= -.5):
		$AnimationPlayer.play("swordRight")
		print("sword right")
	
	canAttack = false
	#await get_tree().create_timer(.34).timeout
	
func attackRecovery():
	currentState = playerStates.move
	await get_tree().create_timer(.15).timeout
	canAttack = true
