extends Button


func _ready() -> void:
	return

func _pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	return
