extends KinematicBody2D

export(int) var walk_speed = 450

const FLOOR_NORMAL = Vector2()
const SLOPE_SLIDE_STOP = 5.0
const MIN_ONAIR_TIME = 0.1
const ATTACK_TIME_SHOW_WEAPON = 0.2
const BULLET_VELOCITY = 1000

var linear_velocity = Vector2()
var facing_direction = Vector2()
var sprite_scale = Vector2(1,1)
var last_attack_time = 1
var on_floor = false
var animation=''

onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite

func _physics_process(delta):
	last_attack_time += delta
	apply_movement(delta)
	set_direction()
	update_animations()

func apply_movement(delta):
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	if input_direction != Vector2.ZERO:
		facing_direction = input_direction
	
	linear_velocity = input_direction.normalized() * walk_speed
	linear_velocity = move_and_slide(linear_velocity, FLOOR_NORMAL, SLOPE_SLIDE_STOP)
	on_floor = is_on_floor()

func update_animations():
	var new_animation = 'Idle'
	
	if on_floor && abs(linear_velocity.x) > 0:
		new_animation = 'Run'

	if new_animation != animation:
		animation = new_animation
		# animation_player.play(animation)

func set_direction():
	var new_scale = Vector2(1,1)
	if facing_direction.x < 0:
		new_scale.x = -1
	if facing_direction.y < 0:
		new_scale.y = -1
	sprite.set_scale(Vector2(new_scale.x, new_scale.y))

func _input(event):
	if event.is_action_pressed('attack'):
		if $AttackCooldown.is_stopped():
			$AttackCooldown.start()
			var sword = preload("res://Weapons/Sword.tscn").instance()
			#sword.position = $Sprite/SwordPosition.global_position
			#print($Sprite/SwordPosition.global_position)
			if facing_direction.y != 0:
				$Sprite/SwordPosition2.add_child(sword)
			else:
				$Sprite/SwordPosition.add_child(sword)
			#sword.attack()
			#$sound_sword.play()
