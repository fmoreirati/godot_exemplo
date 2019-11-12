extends KinematicBody2D

var flip = true
var posicao_inicial = Vector2()
var posicao_final
var velocidade = 0.5

func _ready():
	$AnimatedSprite.play("Walking")
	posicao_inicial = position.x
	posicao_final = posicao_inicial + 200

func _process(delta):
	#print(position.x)
	if(posicao_inicial <= posicao_final and flip):
		position.x += velocidade
		$AnimatedSprite.flip_h = false
	if(position.x >= posicao_final):
		flip = false

	if(position.x >= posicao_inicial and !flip):
		position.x -= velocidade
		$AnimatedSprite.flip_h = true
	if(position.x <= posicao_inicial):
		flip = true