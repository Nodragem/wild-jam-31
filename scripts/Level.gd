extends Node

export (PackedScene) var Trees
export var y_limit = 1080
export var nb_trees = 10


func _ready():
	$CanvasLayer/GameOverPanel.hide()
	var rand = RandomNumberGenerator.new()
	for i in range(0,nb_trees):
		var trees = Trees.instance()
		rand.randomize()
		var x = rand.randf_range(0,1920)
		rand.randomize()
		var y = rand.randf_range(0,y_limit)
		trees.position.y = y
		trees.position.x = x
		$YSort.add_child(trees)


func _on_Farmer_dead() -> void:
	$CanvasLayer/GameOverPanel.show()


func _on_TryAgainButton_pressed() -> void:
	get_tree().reload_current_scene()
