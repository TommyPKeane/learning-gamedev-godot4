extends CharacterBody2D

var is_falling: bool = false
var on_wall

const FALL_TILT_SPEED: float = 25.0
const WALK_SPEED: float = 250.0
const FRICTION: float = 20.0
const JUMPFORCE: float = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var DEFAULT_GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
var GRAVITY

func _ready() -> void:
	#$PlayerAnimation.autoplay = "PlayerColorAnimation"
	#GRAVITY = DEFAULT_GRAVITY
	GRAVITY = 980
	is_falling = not is_on_floor()
	return


func _physics_process(delta) -> void:
	is_falling = not is_on_floor()
	velocity.y += delta * GRAVITY
	
	if is_on_floor():
		if Input.is_action_pressed("move_left"):
			velocity.x = -WALK_SPEED
		elif Input.is_action_pressed("move_right"):
			velocity.x =  WALK_SPEED
		else:
			velocity.x = 0
			
		if Input.is_action_pressed("jump"):
			velocity.y += JUMPFORCE
			
			if Input.is_action_pressed("move_up"):
				velocity.y *= 1.5  # Super Jump
			elif Input.is_action_pressed("move_down"):
				velocity.y *= 0.5  # Crouch Jump
			else:
				pass
		else:
			pass
	else:
		if Input.is_action_pressed("move_left"):
			velocity.x = -FALL_TILT_SPEED
		elif Input.is_action_pressed("move_right"):
			velocity.x =  FALL_TILT_SPEED
		else:
			velocity.x = 0

	# "move_and_slide" already takes delta time into account.
	move_and_slide()
	return

func _process(_delta) -> void:
	if is_falling:
		if Input.is_action_pressed("move_left"):
			rotate(-PI/128)
		elif Input.is_action_pressed("move_right"):
			rotate(PI/128)
		else:
			rotation = 0.0
	else:
		if Input.is_action_pressed("move_down"):
			scale.x = 1.0
			scale.y = 0.65
		elif Input.is_action_pressed("move_up"):
			scale.x = 0.65
			scale.y = 1.25
		else:
			scale.x = 1.0
			scale.y = 1.0
	return
