extends KinematicBody2D

var velocity = Vector2(0, 0)
var velocity_increase = 1.15

func _ready():
	randomize()
	reset()

func _physics_process(delta):
	apply_movement(delta)
	if position.x < 0 || position.x > get_viewport_rect().size.x:
		reset()

func apply_movement(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		var motion = collision.remainder.bounce(collision.normal)
		velocity = velocity.bounce(collision.normal)
		move_and_collide(motion)
		if collision.collider is KinematicBody2D:
			velocity *= velocity_increase

func reset():
	position = get_viewport_rect().size / 2
	var direction = Vector2(-1 if randf() < 0.5 else 1, -1 if randf() > 0.5 else 1)
	velocity = Vector2(rand_range(200, 250) * direction.x, rand_range(50, 100) * direction.y)