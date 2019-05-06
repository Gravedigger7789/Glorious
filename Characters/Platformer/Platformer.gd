extends KinematicBody2D

export(int) var gravity = 980
export(int) var terminal_velocity = 750
export(int) var walk_speed = 450
export(int) var jump_speed = 450

const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_SLIDE_STOP = 25.0
const MIN_ONAIR_TIME = 0.1
const ATTACK_TIME_SHOW_WEAPON = 0.2
const BULLET_VELOCITY = 1000

var linear_velocity = Vector2()
var sprite_scale = Vector2(1,1)
var last_attack_time = 1
var on_floor = false
var animation=''

onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite
onready var health = $Health

func _physics_process(delta):
	last_attack_time += delta
	apply_movement(delta)
	set_direction()
	update_animations()

func apply_movement(delta):
	# Gravity
	linear_velocity.y += delta * gravity
	linear_velocity.y = min(linear_velocity.y, terminal_velocity)
	
	# Moving
	var target_speed = 0
	if Input.is_action_pressed('move_left'):
		target_speed += -1
	if Input.is_action_pressed('move_right'):
		target_speed +=  1

	target_speed *= walk_speed
	linear_velocity.x = lerp(linear_velocity.x, target_speed, 0.1)
	
	# Jumping
	if on_floor and Input.is_action_just_pressed('jump'):
		linear_velocity.y = -jump_speed
		# $sound_jump.play()
	if linear_velocity.y < -jump_speed / 4 && !Input.is_action_pressed('jump'):
		linear_velocity.y += delta * gravity
	
	linear_velocity = move_and_slide(linear_velocity, FLOOR_NORMAL, SLOPE_SLIDE_STOP)
	on_floor = is_on_floor()

func update_animations():
	var new_animation = 'Idle'
	
	if on_floor && abs(linear_velocity.x) > 0:
		new_animation = 'Run'
	# else:
		# if linear_velocity.y < 0:
			# new_animation = 'Jumping'
		# else:
			# new_animation = 'Falling'

	# if last_attack_time < ATTACK_TIME_SHOW_WEAPON:
		# weapon.show()
		# new_animation += '_weapon'
	# else:
		# weapon.hide()

	if new_animation != animation:
		animation = new_animation
		# animation_player.play(animation)

func set_direction():
	var new_scale = linear_velocity.x
	if new_scale == 0:
		new_scale = sprite_scale.x
	var new_scale_normalized = new_scale / abs(new_scale)
	sprite_scale = Vector2(new_scale_normalized, sprite_scale.y)
	sprite.set_scale(sprite_scale)

func _input(event):
	if event.is_action_pressed('attack'):
		damage(1)
		if $AttackCooldown.is_stopped():
			$AttackCooldown.start()
			var bullet = preload("res://Weapons/Bullet.tscn").instance()
			bullet.position = $Sprite/BulletPosition.global_position
			bullet.linear_velocity = Vector2(sprite.scale.x * BULLET_VELOCITY, 0)
			bullet.add_collision_exception_with(self)
			get_parent().add_child(bullet)
			#$sound_shoot.play()
			last_attack_time = 0

func damage(amount):
	health.take_damage(amount)

func _on_Health_health_depleted():
	self.queue_free()
