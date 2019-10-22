extends Sprite

func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		game.coins += 1
		$AudioStreamPlayer2D.play()
		print(game.coins)
		$Area2D/CollisionShape2D.disabled = true
		$AnimationPlayer.play("coin_up")
		yield($AnimationPlayer, "animation_finished")
		queue_free()
