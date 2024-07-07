extends Node2D

var screen_size # Size of the game window.
const PLAYER_STARTING_POS: Vector2 = Vector2(150, 500)

func start(pos: Vector2) -> void:
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
