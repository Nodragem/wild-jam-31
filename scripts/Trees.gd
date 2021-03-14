extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var tree_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = tree_types[randi() % tree_types.size()]

