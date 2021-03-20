extends KinematicBody2D

signal no_bullets
signal fired(value)
signal hit(damage)
signal dead()

export var speed = 400
export var bullets = 100
export var max_life = 6
var current_life = 0

const BulletScn = preload("res://scenes/Bubble.tscn")
var screen_size
var screen_position

onready var muzzle = $FirePositionUP
onready var camera_rig:Node2D = get_node("../../Camera")
onready var state_machine = $AnimationTree.get("parameters/playback")


func _ready():
	screen_size = get_viewport_rect().size
	emit_signal("fired", bullets)
	current_life = max_life

func _input(event):
	if event.is_action_pressed("fire") and bullets > 0:
		bullets -= 1
		emit_signal("fired", bullets)
		AudioManager.play("res://art/sound/shoot3.wav")
		var bullet = BulletScn.instance()
		owner.add_child(bullet)
		bullet.set_owner(owner)
		bullet.transform = muzzle.global_transform
#		var tween = $Tween
#		tween.interpolate_property(self, "position", position,
#		position - muzzle.global_transform.x*20, 0.15,Tween.TRANS_BOUNCE,Tween.EASE_IN,0)
#		tween.start()
		if bullets <= 0:
			emit_signal("no_bullets")
		
		
		
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


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func damage(ennemy):
	current_life -= ennemy.damage
	emit_signal("hit", ennemy.damage)
	if current_life <= 0:
		emit_signal("dead")


func game_over():
	pass # Replace with function body.
