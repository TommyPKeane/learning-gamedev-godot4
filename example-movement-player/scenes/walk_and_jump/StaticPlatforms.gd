extends CanvasGroup


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"FloorMainArea".freeze = true
	$"PlatformFloatingA-Area".freeze = true
	$"PlatformFloatingB-Area".freeze = true
	return


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	return