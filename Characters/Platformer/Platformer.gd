extends KinematicBody2D
class_name Platformer

const BULLET_VELOCITY := 1000

export (int) var walk_speed := 450
export (int) var jump_speed := 450
export (int) var air_speed := 450
export (int) var gravity := 16
export (int) var terminalVelocity := 750
export (Vector2) var floorNormal := Vector2(0, -1)
export (float) var slopeSlideStop := 25.0

var sprite_scale := Vector2(1,1)
var look_direction := Vector2(1, 0) setget set_direction
var velocity := Vector2()

onready var animation_player := $AnimationPlayer
onready var sprite := $Sprite
onready var health := $Health

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('attack'):
		get_tree().set_input_as_handled()
		damage(1)
		if $AttackCooldown.is_stopped():
			$AttackCooldown.start()
			var bullet = preload("res://Weapons/Bullet.tscn").instance()
			bullet.position = $Sprite/BulletPosition.global_position
			bullet.linear_velocity = Vector2(sprite.scale.x * BULLET_VELOCITY, 0)
			bullet.add_collision_exception_with(self)
			get_parent().add_child(bullet)
			#$sound_shoot.play()

func _physics_process(_delta: float) -> void:
	apply_gravity()
	move()

func apply_gravity() -> void:
	velocity.y += gravity
	velocity.y = min(terminalVelocity, velocity.y)

func move() -> void:
	velocity = move_and_slide(velocity, floorNormal, slopeSlideStop)

func set_direction(direction: Vector2) -> void:
	if look_direction == direction:
		return
	look_direction = direction
	var new_scale := direction.x
	if new_scale == 0:
		new_scale = sprite_scale.x
	var new_scale_normalized := new_scale / abs(new_scale)
	sprite_scale = Vector2(new_scale_normalized, sprite_scale.y)
	sprite.set_scale(sprite_scale)

func damage(amount: int) -> void:
	health.take_damage(amount)

func _on_Health_health_depleted() -> void:
	self.queue_free()
