extends KinematicBody2D

enum states {WAITING, SHOOTING, SPAWNING, DEAD}
var current_state = states.WAITING

func _ready() -> void:
	pass # Replace with function body.



func _on_CameraAnimation_animation_finished(anim_name: String) -> void:
	current_state = states.SHOOTING
	current_state = states.SHOOTING
	current_state = states.SHOOTING
