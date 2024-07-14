extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	self.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	print("GameMenu | Processing...")
	var player_camera = get_parent().get_node("WalkAndJump/Player/PlayerCamera")
	$PauseMenuPopUp.position = player_camera.get_target_position()
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = false
		get_parent().get_node("WalkAndJump").show()
		print("UNPAUSED")
	else:
		pass
	return

func _enter_tree():
	return

func _exit_tree():
	return
