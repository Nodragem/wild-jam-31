extends StaticBody2D

const LarvaScn = preload("res://scenes/Larva.tscn")
onready var nest = $Nest
export var max_larva = 100
var nb_larva = 0

func _ready():
	$LarvaTimer.start()
	var tree_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = tree_types[randi() % tree_types.size()]

func _on_LarvaTimer_timeout():
	nb_larva += 1
	var larva = LarvaScn.instance()
	add_child(larva)
	larva.global_transform = nest.global_transform
	$LarvaTimer.wait_time = rand_range(2,7)
	$LarvaTimer.start()
	if nb_larva < max_larva:
		$LarvaTimer.start()
	else: 
		$LarvaTimer.stop()
