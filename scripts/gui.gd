extends Control

onready var coracao = preload("res://scenes/coracao.tscn")

func _ready():
	coracoes()
	placar(0)

func placar(pontos):
	game.point += pontos
	$VBoxContainer/HBoxContainer_Point/Label_Point.text = str("%012d" % game.point)
	
func coracoes():
	var x = 5
	var cloneCoracao
	var localCor = $VBoxContainer/HBoxContainer_Life
	
	for n in localCor.get_children():
		localCor.remove_child(n)
			
	for i in range(game.life):
		cloneCoracao = coracao.instance()
		cloneCoracao.position.x = x
		localCor.add_child(cloneCoracao)
		x += 40

func coins():
	game.coins+=1