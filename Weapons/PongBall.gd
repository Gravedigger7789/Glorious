extends KinematicBody2D

signal scored

var velocity = Vector2(0, 0)
var velocity_increase = 1.15

func _ready():
	randomize()
	reset()

func _physics_process(delta):
	apply_movement(delta)
	update()
	if position.x < 0:
		emit_signal("scored", "right") 
		reset() 
	
	if position.x > get_viewport_rect().size.x:
		emit_signal("scored", "left") 
		reset()

func _draw():
	draw_circle(Vector2.ZERO, 16, Color.white)

func apply_movement(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		var motion = collision.remainder.bounce(collision.normal)
		velocity = velocity.bounce(collision.normal)
		move_and_collide(motion)
		if collision.collider is KinematicBody2D and $CollisionTimer.is_stopped():
			$CollisionTimer.start()
			velocity *= velocity_increase

func reset():
	position = get_viewport_rect().size / 2
	var direction = Vector2(-1 if randf() < 0.5 else 1, -1 if randf() > 0.5 else 1)
	velocity = Vector2(rand_range(300, 350) * direction.x, rand_range(50, 100) * direction.y)
