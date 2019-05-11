extends KinematicBody2D

const BULLET_VELOCITY := 1000

var sprite_scale := Vector2(1,1)
var look_direction = Vector2(1, 0) setget set_direction

onready var animation_player := $AnimationPlayer
onready var sprite := $Sprite
onready var health := $Health

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

func _input(event: InputEvent) -> void:
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

func damage(amount: int) -> void:
	health.take_damage(amount)

func _on_Health_health_depleted() -> void:
	self.queue_free()
