extends KinematicBody2D

const GRAVITY_VEC = Vector2(0, 900)
const FLOOR_NORMAL = Vector2(0, -1)

const WALK_SPEED = 70
const STATE_WALKING = 0
const STATE_KILLED = 1

var linear_velocity = Vector2()
var direction = -1
var anim=""

var state = STATE_WALKING

func _ready():
	$espera.start(3)
	randomize()
	
func _physics_process(delta):
	var new_anim = "idle"
	if state == STATE_WALKING:
		linear_velocity += GRAVITY_VEC * delta
		linear_velocity.x = direction * WALK_SPEED
		linear_velocity = move_and_slide(linear_velocity, FLOOR_NORMAL)

		if ($detect_floor_right.is_colliding() and not $detect_floor_left.is_colliding()):
			direction = 1.0
		
		if ($detect_floor_left.is_colliding() and not $detect_floor_right.is_colliding()):
			direction = -1.0
		
		if is_on_wall():
			direction = direction * -1
			
		if direction > 0:
			new_anim = "right"
		else:
			new_anim = "left"
			
	else:
		new_anim = "idle"

	if anim != new_anim:
		anim = new_anim
		$AnimationPlayer.play(anim)


func _on_dano_body_entered(body):
	if body.get_groups().has("player"):
		body.dano()


func _on_espera_timeout():
	state = STATE_KILLED
	yield($espera, "timeout")
	var t = randi() % 3
	#print(t)
	$espera.start(t)
	state = STATE_WALKING
