extends KinematicBody2D

export(int) var damage = 1
var speed = 100
var dead = false
var players_in_range = []
onready var timer = $Timer


func _process(delta):
	position.x += speed*delta
	if not dead:
		for player in players_in_range:
			if timer.time_left <= 0:
				player.damage(self)
				timer.start()
			else:
				print(timer.time_left)

func _on_Area2D_area_entered(area):
	$AnimationPlayer.play("WeevilDead")
	speed = 0
	dead = true
	$CollisionShape2D.set_deferred("disabled", true)


func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("player") and not dead:
		body.damage(self)
		players_in_range.append(body)
		timer.start()




func _on_Area2D_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		players_in_range.erase(body)
		timer.stop()
