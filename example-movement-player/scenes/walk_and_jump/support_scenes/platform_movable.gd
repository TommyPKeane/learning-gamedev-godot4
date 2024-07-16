# Movable Platform
#
# References:
# - Example Tutorial: https://www.youtube.com/watch?v=iwNQ2sqH2cw
# - https://docs.godotengine.org/en/stable/classes/class_remotetransform2d.html
# - https://docs.godotengine.org/en/stable/classes/class_path2d.html

extends Node2D

@export var loop_animation: bool = false
@export var motion_path: Curve2D = null

func _ready() -> void:
	$PlatformAnimationPlayer.play(
		"move_loop" if loop_animation else "move_pingpong"
	)
	
	if motion_path:
		$PlatformMotionPath.curve = motion_path
	else:
		pass
	return


func _process(_delta) -> void:
	return
