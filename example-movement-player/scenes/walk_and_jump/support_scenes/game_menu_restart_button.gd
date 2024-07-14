extends Button


func _ready() -> void:
	return

func _pressed() -> void:
	get_tree().current_scene.get_parent().get_tree().reload_current_scene()
	return
