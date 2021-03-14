extends Camera2D

func _ready() -> void:
	Globals.set("currentCamera", self)
