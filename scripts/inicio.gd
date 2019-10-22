extends Node2D

var t = 1

func _ready():
	$Control/Timer.start(t)

func _process(delta):
	pass
	
func _on_Timer_timeout():
	$Control/AnimationPlayer.play("raio")
	yield($Control/Timer, "timeout")
	t = randi() % 10
	print(t)
	$Control/Timer.start(t)
	