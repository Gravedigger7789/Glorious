extends RigidBody2D

var sprite_scale = Vector2(1,1)

onready var sprite = $Sprite

func _physics_process(delta):
	var new_scale = linear_velocity.x
	if new_scale == 0:
		new_scale = sprite_scale.x
	var new_scale_normalized = new_scale / abs(new_scale)
	sprite_scale = Vector2(new_scale_normalized, sprite_scale.y)
	sprite.set_scale(sprite_scale)

func _on_Bullet_body_entered(body):
	queue_free()

func _on_TimeToLive_timeout():
	queue_free()