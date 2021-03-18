extends KinematicBody2D
signal hit()

export var speed = 400
const BulletScn = preload("res://scenes/Bubble.tscn")
var screen_size
var screen_position
onready var muzzle = $FirePositionUP
onready var camera_rig:Node2D = get_node("../../Camera")
onready var state_machine = $AnimationTree.get("parameters/playback")


func _ready():
	screen_size = get_viewport_rect().size


func _input(event):
	if event.is_action_pressed("fire"):
		AudioManager.play("res://art/sound/shoot3.wav")
		var bullet = BulletScn.instance()
		owner.add_child(bullet)
		bullet.set_owner(owner)
		bullet.transform = muzzle.global_transform
		var tween = $Tween
		tween.interpolate_property(self, "position", position,
		position-muzzle.global_transform.x*20, 0.15,Tween.TRANS_BOUNCE,Tween.EASE_IN,0)
		tween.start()
		
		
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
	
	var current = state_machine.get_current_node()
	
	if velocity.x != 0:
		state_machine.travel("side_walk")
		if velocity.x < 0:
			$side_body.scale.x = -1
			muzzle = $FirePositionLEFT
		else:
			$side_body.scale.x = 1
			muzzle = $FirePositionRIGHT	
	elif velocity.y < 0:
		state_machine.travel("back_walk")
		muzzle = $FirePositionUP
	elif velocity.y > 0:
		state_machine.travel("front_walk")
		muzzle = $FirePositionDOWN
	elif velocity.y == 0:
		if current == 'front_walk':
			state_machine.travel("front_idle")
		elif current == 'back_walk':
			state_machine.travel("back_idle")
		elif current == 'side_walk':
			state_machine.travel("side_idle")

func _on_Player_body_exited(_body):
	emit_signal("hit")

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false



