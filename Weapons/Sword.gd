extends Area2D

export(int) var damage = 1

onready var animation_player = $AnimationPlayer

func _ready():
	$TimeToLive.connect('timeout', self, '_on_TimeToLive_timeout')
	#animation_player.play("attack")
	#animation_player.connect('animation_finished', self, "_on_animation_finished")
	#idle()

func _on_TimeToLive_timeout():
	queue_free()

#func idle():
	#animation_player.play("idle")

#func attack():
	#animation_player.play("attack_straight")

#func _on_animation_finished(name):
	#idle()
