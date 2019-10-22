extends Node2D

func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		get_tree().change_scene("res://scenes/fase01.tscn")
