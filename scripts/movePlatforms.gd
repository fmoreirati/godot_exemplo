extends StaticBody2D

var posinical;
var lado = 0;
var pos = Vector2()

func _ready():
	posinical = Vector2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(posinical , " - " , global_position.x)
	if lado == 0:
		pos.x -= 1
		if global_position.x == pos.x - 100:
			lado = 1
	else:
		position.x +=1
		if global_position.x == posinical:
			lado = 0
		
	
