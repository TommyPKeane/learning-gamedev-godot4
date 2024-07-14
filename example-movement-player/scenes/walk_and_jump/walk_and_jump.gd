extends Node2D

var screen_size # Size of the game window.
const PLAYER_STARTING_POS: Vector2 = Vector2(150, 500)

func start(pos: Vector2) -> void:
	# SDL Gamepads:
	# - https://github.com/mdqinc/SDL_GameControllerDB/blob/master/gamecontrollerdb.txt
	Input.add_joy_mapping(
		"03000000c82d00000160000001000000,8BitDo SN30 Pro,a:b1,b:b0,back:b10,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,leftshoulder:b6,leftstick:b13,lefttrigger:a4,leftx:a0,lefty:a1,rightshoulder:b7,rightstick:b14,righttrigger:a5,rightx:a2,righty:a3,start:b11,x:b4,y:b3,platform:Mac OS X",
		true,
	)
	Input.add_joy_mapping(
		"03000000c82d00000161000000010000,8BitDo SN30 Pro,a:b1,b:b0,back:b10,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b2,leftshoulder:b6,leftstick:b13,lefttrigger:b8,leftx:a0,lefty:a1,rightshoulder:b7,rightstick:b14,righttrigger:b9,rightx:a2,righty:a5,start:b11,x:b4,y:b3,platform:Mac OS X",
		true,
	)
	$Player.position = pos
	show()
	$Player/PlayerCollisionShape.disabled = false
	return

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	start(PLAYER_STARTING_POS)
	$Player/PlayerCamera.enabled = true
	$Player/PlayerCamera.make_current()
	return

func check_if_outofbounds_and_reset() -> void:
	if $Player.global_position.y > 0:
		get_tree().reload_current_scene()
	else:
		pass
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	check_if_outofbounds_and_reset()
	return
