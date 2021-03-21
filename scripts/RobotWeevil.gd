extends KinematicBody2D


var current_state
const ProjectileScn = preload("res://scenes/BossProjectile.tscn")
var waiting_for_player = true

onready var state_machine = $AnimationTree.get("parameters/playback")
onready var muzzle = $Muzzle

func _ready() -> void:
	state_machine.travel("idle")
	waiting_for_player = true


func _on_CameraAnimation_animation_finished(anim_name: String) -> void:
	state_machine.travel("attacking")
	$AttackTimer.start()
	waiting_for_player = false


func _on_Button_pressed() -> void:
	state_machine.travel("attacking")
	$AttackTimer.start()
	waiting_for_player = false


func _process(delta: float) -> void:
	var current_state = state_machine.get_current_node()
	
	if(current_state == 'attacking'):
		if $AttackTimer.time_left <= 0:
			AudioManager.play("res://art/sound/shoot3.wav")
			var bullet = ProjectileScn.instance()
			owner.add_child(bullet)
			bullet.set_owner(owner)
			bullet.transform = muzzle.global_transform
			$AttackTimer.start()
			
	if(current_state == 'idle'):
		if $IdleTimer.time_left <=0 and not waiting_for_player:
			state_machine.travel("attacking")


func _on_attack_end() -> void:
	$IdleTimer.start()
