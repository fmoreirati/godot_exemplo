extends KinematicBody2D

const UP = Vector2(0, -1)
var inicio = Vector2(200,300)
var motion = Vector2()

export (int) var speed = 150
export (int) var gravity = 1000
export (int) var jump_height = 400

#importa compomente do tiro e dados do tiro
var tiro = preload("res://scenes/areaTiro.tscn")
var speed_fire = 250
var lado = -1 #esquerda: -1 e direta: 1
var free_fire = true
var doubleJump = false
var invencivel = false

func _process(delta):
	mover(delta)
	animar()

func mover(delta):
	motion.y += gravity * delta
	if Input.is_action_pressed("ui_right"):
		motion.x = speed
		lado = 1
	elif Input.is_action_pressed("ui_left"):
		motion.x = -speed
		lado = -1
	else:
		lado = 0
		motion.x = 0
		
	if Input.is_action_just_pressed("ui_accept"):
		fire()

	if is_on_floor():
		doubleJump = false
		if Input.is_action_pressed("ui_up"):
			motion.y = -jump_height
			doubleJump = true

	if is_on_wall():
		if doubleJump:
			motion.y = -jump_height
			recuar()
			doubleJump = false

	if global_position.y > 1450:
		morte()
		
	motion = move_and_slide(motion,UP)

func animar():	
	var anime
	if lado == 1:
		anime = "right_invencivel"
		$Position2D.set_position(Vector2(35,20))
	if lado == -1:
		anime = "left_invencivel"
		$Position2D.set_position(Vector2(-5,20))
	if lado == 0:
		$AnimationPlayer.stop()
	else:
		$AnimationPlayer.play(anime)

func dano():
	if not invencivel: 
		game.life -= 1
		recuar()
		$dano.start(2)
		invencivel = true
		$CanvasLayer/Control.coracoes()
		print("vidas: ", game.life)
		if (game.life < 0):
			morte()

func recuar():
	if lado == 1:
		move_and_collide(Vector2(-30, 0))
	else:
		move_and_collide(Vector2(30, 0))

func fire():
	var clone = tiro.instance()
	clone.get_node("Sprite").flip_h = false
	if (lado == 1):
 		clone.linear_velocity = (Vector2(speed_fire,0))
	else:
		clone.get_node("Sprite").flip_h = true
		clone.linear_velocity = (Vector2(-speed_fire,0))
	clone.position = $Position2D.global_position
	get_parent().add_child(clone)

func morte():
	get_tree().change_scene("res://scenes/gameOver.tscn")
	salvarDadosPost()
	queue_free()	


# Enviar dados para o servidor local via Post ou Get ----------------------
func salvarDadosPost():
	var query = "id=" + str(game.id) +"&game=1"+"&points=" + str(game.point) 
	var url = "http://localhost/_.halley/3o.Ano/Prog.OO/siteModelo/pages/add-rank.php"
	var headers = ["Content-Type: application/x-www-form-urlencoded; charset=UTF-8", "Content-Length:"+str(query.length())]
	var use_ssl = false
	print($HTTPRequest.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query))

func salvarDadosGet():
	var query = "id=" + str(game.id) +"&points=" + str(game.points) 
	var url = "http://localhost/_.halley/3o.Ano/Prog.OO/siteModelo/pages/add-rank.php?"+query
	var headers = ["Content-Type: application/x-www-form-urlencoded; charset=UTF-8"]
	var use_ssl = false
	print($HTTPRequest.request(url, headers, use_ssl, HTTPClient.METHOD_GET))

# Resultado do Request ------------------------------------------------------
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	#var json = JSON.parse(body.get_string_from_utf8())
	#print(json.result)
	if result == $HTTPRequest.RESULT_SUCCESS:
		print(body.get_string_from_utf8())
	else:
		print("Erro: ", response_code)

# end
