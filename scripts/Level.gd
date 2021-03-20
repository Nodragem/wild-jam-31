extends Node

export (PackedScene) var Trees
export var y_limit = 1080
export var nb_trees = 10
var max_prog
var start_pos

func _ready():
	max_prog = ($StartPosition.position - $EndPosition.position).y
	start_pos = $StartPosition.position.y
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

func _process(delta):
	var cur_prog = $YSort/Farmer.position.y - start_pos
	cur_prog = (cur_prog / max_prog)*100
	$CanvasLayer/LevelProgress.value = cur_prog

func _on_Farmer_dead() -> void:
	$CanvasLayer/GameOverPanel.show()


func _on_TryAgainButton_pressed() -> void:
	get_tree().reload_current_scene()


func _on_Farmer_no_bullets() -> void:
	$CanvasLayer/GameOverPanel.show()
