extends Node2D

onready var camera:Camera2D = $Camera2D

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	position += Vector2.UP * 300 * delta
