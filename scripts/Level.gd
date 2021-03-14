extends Node

export (PackedScene) var Trees
export var y_limit = 1080
export var nb_trees = 10
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var rand = RandomNumberGenerator.new()
	
	for i in range(0,nb_trees):
		var trees = Trees.instance()
		rand.randomize()
		var x = rand.randf_range(0,1920)
		rand.randomize()
		var y = rand.randf_range(0,y_limit)
		trees.position.y = y
		trees.position.x = x
		add_child(trees)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
