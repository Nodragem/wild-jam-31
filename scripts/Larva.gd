extends KinematicBody2D



func _process(delta):
	position.x -= 120*delta 




func _on_Area2D_area_entered(area):
	queue_free()
