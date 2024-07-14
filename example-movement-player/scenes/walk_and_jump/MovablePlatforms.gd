extends CanvasGroup


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_INHERIT
	$"PlatformMovingArea/PlatformMovingAnimation".play("position_loop")
	return


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	return
