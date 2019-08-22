extends StaticBody2D

func _on_Area2D_body_entered(body):
	print(body.get_name())

	if body.get_name() == "KinematicBody2D":
		body.dano()
