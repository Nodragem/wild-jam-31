extends StaticBody2D

const LarvaScn = preload("res://scenes/Larva.tscn")
const WeevilScn = preload("res://scenes/Weevil.tscn")
onready var nest_weevil = $Weevil_nest
onready var nest = $Nest
export var max_larva = 100
export var max_weevil = 100

var nb_larva = 0
var nb_weevil = 0

func _ready():
	$LarvaTimer.start()
	$WeevilTimer.start()
	var tree_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = tree_types[randi() % tree_types.size()]

func _on_LarvaTimer_timeout():
	if position.y > -2000:
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


func _on_WeevilTimer_timeout():
	nb_weevil += 1
	if position.y <= -2000:
		var weevil = WeevilScn.instance()
		add_child(weevil)
		weevil.global_transform = nest_weevil.global_transform
		$WeevilTimer.wait_time = rand_range(6,10)
		$WeevilTimer.start()
		if nb_weevil < max_weevil:
			$WeevilTimer.start()
		else: 
			$WeevilTimer.stop()
