extends KinematicBody2D

# Declare member variables here. Examples:
export (int) var speed = 200
var move = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if (Input.is_action_pressed("ui_left")):
		move.x -= speed
		$AnimationPlayer.play("left")
	elif (Input.is_action_pressed("ui_right")):
		move.x += speed
		$AnimationPlayer.play("right")
		
	elif (Input.is_action_pressed("ui_up")):
		move.y -= speed
		$AnimationPlayer.play("back")
		
	elif (Input.is_action_pressed("ui_down")):
		move.y += speed
		$AnimationPlayer.play("front")
	else:
		move.x = 0
		move.y = 0
		$AnimationPlayer.stop()
		
	move = move.normalized() * speed
	
	move_and_slide(move)
