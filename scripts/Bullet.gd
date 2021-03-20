extends Area2D

var speed = 1200
const BubbleRedPcl = preload("res://scenes/BubbleParticlesRed.tscn")
const BubbleGreenPcl = preload("res://scenes/BubbleParticlesGreen.tscn")

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_Bubble_body_entered(body: Node) -> void:
	var particles =  BubbleGreenPcl.instance()
	owner.add_child(particles)
	particles.transform = global_transform
	particles.emitting = true
	particles.get_node("AudioStreamPlayer").play()
	queue_free()


func _on_Bubble_area_entered(area):
	if area.is_in_group("enemy"):
		var particles =  BubbleRedPcl.instance()
		owner.add_child(particles)
		particles.transform = global_transform
		particles.emitting = true
		particles.get_node("AudioStreamPlayer").play()
		queue_free()
