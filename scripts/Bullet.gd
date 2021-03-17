extends Area2D

var speed = 1200
const BubblePcl = preload("res://scenes/BubbleParticles.tscn")

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_Bubble_body_entered(body: Node) -> void:
	var particles =  BubblePcl.instance()
	owner.add_child(particles)
	particles.transform = global_transform
	particles.emitting = true
	queue_free()
