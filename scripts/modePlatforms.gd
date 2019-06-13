extends StaticBody2D


var posinical;
var lado = 0;

func _ready():
	posinical = global_position.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(posinical , " - " , global_position.x)
	if lado == 0:
		position.x -= 1
		if global_position.x == posinical-100:
			lado = 1
	else:
		position.x +=1
		if global_position.x == posinical:
			lado = 0
	
