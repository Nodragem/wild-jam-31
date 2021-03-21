extends Area2D

var speed = 1200
var damage = 1
const BubbleRedPcl = preload("res://scenes/BubbleParticlesRed.tscn")
const BubbleGreenPcl = preload("res://scenes/BubbleParticlesGreen.tscn")

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_Bubble_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		var particles =  BubbleRedPcl.instance()
		owner.add_child(particles)
		particles.transform = global_transform
		particles.emitting = true
		particles.get_node("AudioStreamPlayer").play()
		queue_free()
		body.damage(self)
	else:
		var particles =  BubbleGreenPcl.instance()
		owner.add_child(particles)
		particles.transform = global_transform
		particles.emitting = true
		particles.get_node("AudioStreamPlayer").play()
		queue_free()


