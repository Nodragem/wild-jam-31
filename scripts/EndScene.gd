extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.show()
	$Label.text = "Congratulations!!"
	yield(get_tree().create_timer(2), "timeout")
	$Label.text = "John defeated the giant robot weevil!"
	yield(get_tree().create_timer(4), "timeout")
	$Label.text = "John can have his hazelnut spread and trees back!"
	yield(get_tree().create_timer(4), "timeout")
	$Label.text = "Thanks to the mighty OREGANO gun!"
	yield(get_tree().create_timer(5), "timeout")
	$Label.text = "Thank you for playing our game! \n :)"
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
