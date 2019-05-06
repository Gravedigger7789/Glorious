extends KinematicBody2D

export(int) var walk_speed = 450

const FLOOR_NORMAL = Vector2()
const SLOPE_SLIDE_STOP = 5.0
const MIN_ONAIR_TIME = 0.1
const ATTACK_TIME_SHOW_WEAPON = 0.2
const BULLET_VELOCITY = 1000

enum direction { RIGHT, DOWN, LEFT, UP }

var linear_velocity = Vector2()
var facing_direction = direction.RIGHT
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
	# Moving
	var target_speed = Vector2()
	if Input.is_action_pressed('move_up'):
		target_speed.y += -1
		facing_direction = direction.UP
	if Input.is_action_pressed('move_down'):
		target_speed.y +=  1
		facing_direction = direction.DOWN

	if target_speed.y == 0:
		if Input.is_action_pressed('move_left'):
			target_speed.x += -1
			facing_direction = direction.LEFT
		if Input.is_action_pressed('move_right'):
			target_speed.x +=  1
			facing_direction = direction.RIGHT

	target_speed *= walk_speed

	match facing_direction:
		direction.LEFT, direction.RIGHT:
			linear_velocity.x = lerp(linear_velocity.x, target_speed.x, 0.1)
			linear_velocity.y = 0
		direction.UP, direction.DOWN:
			linear_velocity.x = 0
			linear_velocity.y = lerp(linear_velocity.y, target_speed.y, 0.1)
	
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
	if facing_direction == direction.LEFT:
		new_scale.x = -1
	if facing_direction == direction.UP:
		new_scale.y = -1
	sprite.set_scale(Vector2(new_scale))

func _input(event):
	if event.is_action_pressed('attack'):
		if $AttackCooldown.is_stopped():
			$AttackCooldown.start()
			var sword = preload("res://Weapons/Sword.tscn").instance()
			#sword.position = $Sprite/SwordPosition.global_position
			#print($Sprite/SwordPosition.global_position)
			if facing_direction == direction.UP || facing_direction == direction.DOWN:
				$Sprite/SwordPosition2.add_child(sword)
			else:
				$Sprite/SwordPosition.add_child(sword)
			#sword.attack()
			#$sound_sword.play()
