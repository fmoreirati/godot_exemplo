extends KinematicBody2D

var inicio = Vector2(200,300)

const UP = Vector2(0, -1)

export (int) var speed = 150
export (int) var gravity = 1000
export (int) var jump_height = 400

var motion = Vector2()

#importa compomente do tiro e dados do tiro
var tiro = preload("res://scenes/areaTiro.tscn")
var speed_fire = 250
var lado = 0
var free_fire = true

func _ready():
	pass

#func _process(delta):
#	pass

func _physics_process(delta):
	motion.y += gravity * delta
	if Input.is_action_pressed("ui_right"):
		motion.x = speed
		$AnimationPlayer.play("right")
		$Position2D.set_position(Vector2(35,20))
		lado = 0
	elif Input.is_action_pressed("ui_left"):
		motion.x = -speed
		$AnimationPlayer.play("left")
		$Position2D.set_position(Vector2(-5,20))
		lado = 1
	else:
		motion.x = 0
		$AnimationPlayer.stop()

	if Input.is_action_just_pressed("ui_accept"):
		fire()

	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = -jump_height

	if global_position.y > 1450:
		dano()

	motion = move_and_slide(motion,UP)


func dano():
	game.life -= 1
	print("vidas: ", game.life)
	if (game.life < 0):
		queue_free()


func fire():
	#if free_fire:
		#$fire.play()
		free_fire = false;
		#$Timer.start();
		var clone = tiro.instance()
		clone.get_node("Sprite").flip_h = false
		if (lado == 0):
	 		clone.linear_velocity = (Vector2(speed_fire,0))
		else:
			clone.get_node("Sprite").flip_h = true
			clone.linear_velocity = (Vector2(-speed_fire,0))
		clone.position = $Position2D.global_position
		get_parent().add_child(clone)


func _on_Timer_timeout():
	$Timer.stop()
	free_fire = true

