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

func _input(event):
	print(get_tree().current_scene)
	if event and not $Control/AnimationPlayer.is_playing():
		get_tree().change_scene("res://scenes/inicio.tscn")