extends KinematicBody2D
signal hit()

export var speed = 400
var screen_size
var screen_position
onready var camera_rig:Node2D = get_node("../../Camera")
onready var state_machine = $AnimationTree.get("parameters/playback")

func _ready():
	screen_size = get_viewport_rect().size


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
	move_and_slide(velocity)
	
	screen_position = camera_rig.position - screen_size/2
	position.x = clamp(position.x, screen_position.x, 
		screen_position.x + screen_size.x)
	position.y = clamp(position.y, screen_position.y, 
		screen_position.y + screen_size.y)
	
	if velocity.x != 0:
		state_machine.travel("side_walk")
		$side_body.scale.x = -1 if velocity.x < 0 else 1
	elif velocity.y < 0:
		state_machine.travel("back_walk")
	elif velocity.y > 0:
		state_machine.travel("front_walk")
	elif velocity.y == 0:
		state_machine.travel("front_idle")


func _on_Player_body_exited(_body):
	emit_signal("hit")


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false



