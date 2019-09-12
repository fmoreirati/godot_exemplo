extends Sprite

func _on_corpo_body_entered(body):
	print (body.get_groups())

	if body.get_groups().has("player"):
		print("morre")
		body.dano()

	if body.get_groups().has("tiro"):
		print("morre")
		body.queue_free()
		queue_free()

	pass # Replace with function body.


func _on_cabeca_body_entered(body):
	print (body.get_groups())
	if body.get_groups().has("player"):
		print("morreu")
		queue_free()
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	print (body.get_groups())
	if body.get_groups().has("player"):
		body.dano()

	if body.get_groups().has("tiro"):
		$AnimationPlayer.stop()
		$Area2D/CollisionShape2D.queue_free()
		body.queue_free()

	pass # Replace with function body.
