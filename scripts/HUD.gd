extends CanvasLayer




	
	
	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Message.text = "Meet John!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(2), "timeout")
	$Message.text = "John is a hezelnut farmer."
	yield(get_tree().create_timer(3), "timeout")
	$Message.text = "As every morning, John woke up and got ready to eat breakfast"
	yield(get_tree().create_timer(4), "timeout")
	$Message.text = "But that morning, something's MISSING on the breakfast table..."
	yield(get_tree().create_timer(4), "timeout")
	$Message.text = "His jar of hazelnut and cacao spread is NOWHERE TO BE FOUND!"
	yield(get_tree().create_timer(5), "timeout")
	$Message.text = "John realises that his hazelnut farm got infested by \nhazelnut weevil over night, they stole his jar of hazelnut spread, \nand they stole his stock of (eco-friendly) pesticide!"
	yield(get_tree().create_timer(9), "timeout")
	$Message.text = "Damned hazelnut weevil! \n'Le balanin des noisettes' John remembers the voice of his French great grand mother..."
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
