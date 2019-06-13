extends KinematicBody2D

const UP = Vector2(0, -1)

export (int) var speed = 150
export (int) var gravity = 1000
export (int) var jump_height = -400

var motion = Vector2()

func _ready():
	pass

#func _process(delta):
#	pass

func _physics_process(delta):
	
	motion.y += gravity * delta
	
	if Input.is_action_pressed("ui_right"):
		motion.x = speed
		$AnimationPlayer.play("right")
		
	elif Input.is_action_pressed("ui_left"):
		motion.x = -speed
		$AnimationPlayer.play("left")
		
	else:
		motion.x = 0
		$AnimationPlayer.stop()

		
	if is_on_floor():
		if Input.is_action_pressed("ui_accept"):
			motion.y = jump_height
			
	motion = move_and_slide(motion,UP)

