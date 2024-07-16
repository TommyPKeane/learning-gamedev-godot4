extends Node2D

var screen_size # Size of the game window.
const PLAYER_STARTING_POS: Vector2 = Vector2(150, 500)
var PauseMenu = preload("res://scenes/walk_and_jump/support_scenes/game_menu.tscn")
var pause_menu: Object = PauseMenu.instantiate()

func start(pos: Vector2) -> void:
	SDLGameControllerUtils.parse_and_load_sdl_gamecontrolldb_txt(
		SDLGameControllerUtils.get_default_filename_by_os()
	)
	$Player.position = pos
	$Player/PlayerCollisionShape.disabled = false
	
	var found_controller_dev_indices: Array[int] = Input.get_connected_joypads()
	
	# Debug Printing
	for dev_index in found_controller_dev_indices:
		print(Input.get_joy_guid(dev_index))
		print(Input.get_joy_info(dev_index))
		print(Input.get_joy_name(dev_index))
	
	show()
	return

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_PAUSABLE
	#get_tree().root.add_child.call_deferred(pause_menu)
	screen_size = get_viewport_rect().size
	start($Player.position)
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
	#print("WalkAndRun | Processing...")
	#if Input.is_action_just_released("pause"):
		#get_tree().paused = true
		#print("PAUSED")
	check_if_outofbounds_and_reset()
	return
