extends KinematicBody2D

export(int) var damage = 1
var speed = 120
var dead = false


func _process(delta):
	position.x -= speed*delta 


func _on_Area2D_area_entered(area):
	$AnimationPlayer.play("LarvaDead")
	speed = 0
	dead = true


func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("player") and not dead:
		body.damage(self)


