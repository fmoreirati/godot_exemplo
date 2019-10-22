extends Sprite

func _on_corpo_body_entered(body):
	#print (body.get_groups())
	#O inimigo para o player
	if body.get_groups().has("player"):
		print("você morreu")
		body.dano()
		
	#O itro para o inimigo
	if body.get_groups().has("tiro"):
		print("morri")
		$AudioStreamPlayer2D.play()
		body.queue_free()
		queue_free()


#Pisa na cabeça e mata o inimigo
func _on_cabeca_body_entered(body):
	#print (body.get_groups())
	if body.get_groups().has("player"):
		print("morreu")
		queue_free()


#O serra para o player
func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		body.dano()

	if body.get_groups().has("tiro"):
		body.queue_free()
		$AnimationPlayer.stop()
		$Area2D/CollisionShape2D.queue_free()

