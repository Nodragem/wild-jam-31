extends KinematicBody2D

export(int) var damage = 1

func _process(delta):
	position.x -= 120*delta 


func _on_Area2D_area_entered(area):
	queue_free()


func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.damage(self)
