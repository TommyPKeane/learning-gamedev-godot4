extends CharacterBody2D

const FALL_TILT_SPEED: float = 250.0
const WALK_SPEED: float = 250.0
const FRICTION: float = 20.0
const JUMPFORCE: float = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var DEFAULT_GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
var GRAVITY

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_INHERIT
	$PlayerAnimation.play("PlayerColorAnimation")
	#GRAVITY = DEFAULT_GRAVITY
	GRAVITY = 980
	self.safe_margin = 2.0
	self.slide_on_ceiling = true
	

func _player_debug_text() -> void:
	var collision_info = ""
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		collision_info = "Collided with: %s" % collision.get_collider().name
	
	$PlayerCamera/PlayerPositionLabel.text = (
		"""Position: (%0.2f, %0.2f)
Velocity: (%0.2f, %0.2f)
%s""" % [
			position.x,
			position.y,
			velocity.x,
			velocity.y,
			collision_info,
		]
	)
	return

	
func _player_ground_movements(delta, jump_multiply: float) -> void:
	velocity.y += delta * GRAVITY
	$PlayerCamera/PlayerPositionLabel.position.y = -85
		
	if Input.is_action_pressed("move_down"):
		$PlayerCollisionShape.scale.x = 1.0
		$PlayerCollisionShape.scale.y = 0.65
		jump_multiply = 0.5
	elif Input.is_action_pressed("move_up"):
		$PlayerCollisionShape.scale.x = 0.65
		$PlayerCollisionShape.scale.y = 1.25
		jump_multiply = 1.5
	else:
		$PlayerCollisionShape.scale.x = 1.0
		$PlayerCollisionShape.scale.y = 1.0
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("move_right"):
		velocity.x = WALK_SPEED
	else:
		velocity.x = 0
		
	if Input.is_action_pressed("jump"):
		velocity.y = (velocity.y + JUMPFORCE) * jump_multiply
	else:
		pass
	return

func _player_wall_movements(delta, jump_multiply) -> void:
	velocity.y += delta * GRAVITY
	var wall_normal = self.get_wall_normal()
	
	if Input.is_action_pressed("jump"):
		velocity.y = (velocity.y + JUMPFORCE) * jump_multiply
		velocity.x = -wall_normal.x * (velocity.x + JUMPFORCE/2) * jump_multiply
	else:
		pass
	return

func _player_air_movements(delta) -> void:
	velocity.y += delta * GRAVITY
	$PlayerCamera/PlayerPositionLabel.position.y = 0.0
	if Input.is_action_pressed("move_left"):
		velocity.x -= FALL_TILT_SPEED * delta
		#rotate(-PI/128)
	elif Input.is_action_pressed("move_right"):
		velocity.x += FALL_TILT_SPEED * delta
		#rotate(PI/128)
	else:
		velocity.x = 0
	return


func _physics_process(delta) -> void:
	if get_tree().paused:
		pass
	else:
		_player_debug_text()
		var jump_multiply: float = 1.0
		
		if is_on_floor():
			_player_ground_movements(delta, jump_multiply)
		elif is_on_wall_only():
			_player_wall_movements(delta, jump_multiply)
		else:
			_player_air_movements(delta)
		
		# "move_and_slide" already takes delta time into account.
		move_and_slide()
	
	return

func _process(_delta) -> void:
	return
