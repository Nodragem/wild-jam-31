extends HBoxContainer

export (int) var max_life = 3
export (PackedScene) var HeartScn
export (NodePath) var player_path
var player
var current_life = 0
var hearts = []

func _ready() -> void:
	player = get_node(player_path)
	if player:
		max_life = player.max_life	
	current_life = max_life
	for i in range(max_life):
		var new_heart:TextureRect = HeartScn.instance()
		new_heart.rect_scale = Vector2(0.5, 0.5)
		add_child(new_heart)
		hearts.append(new_heart)


func remove_heart(value):
	current_life -= value
	for i in range(value):
		if hearts.empty():
			return
		hearts[0].queue_free()
		hearts.pop_front()


func _on_Farmer_hit(damage: int) -> void:
	remove_heart(damage)
