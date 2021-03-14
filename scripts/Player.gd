extends Area2D
signal hit()

export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.
var screen_position
onready var camera_rig:Node2D = get_node("../Camera")

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	#DebugStats.add_property(self, "position", "round")
	#hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	
	screen_position = camera_rig.position - screen_size/2
	position.x = clamp(position.x, screen_position.x, 
		screen_position.x + screen_size.x)
	position.y = clamp(position.y, screen_position.y, 
		screen_position.y + screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y < 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = false
	elif velocity.y > 0:
		$AnimatedSprite.animation = "down"
		$AnimatedSprite.flip_v = false
	elif velocity.y == 0:
		$AnimatedSprite.animation = "idle_down"
		$AnimatedSprite.flip_v = false


func _on_Player_body_exited(_body):
	hide()  # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false



