extends CanvasLayer

signal start_game

func _ready():
	
	$Message.show()



func _on_StartButton_pressed():
	$StartButton.hide()
	$Message.hide()
	get_tree().change_scene("res://scenes/GameScreen.tscn")
