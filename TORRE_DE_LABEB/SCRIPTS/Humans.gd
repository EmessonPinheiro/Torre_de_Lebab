extends StaticBody2D

var velocidade = 100
var gerarNumeroX = 0.0
var gerarNumeroY = 0.0



#CONSTANTES DE VARIAÇÃO DE BASE VETORIAL
#PARA SER MULTIPLICADO PELA velocidade
const MAX = 0.3
const MIN = -0.3

#CONSTANTE PARA DELIMITAR A ÁREA DE MOVIMENTO DOS HUMANOS




func _ready():
	
#	GERANDO NÚMEROS ALEATÓRIOS
	randomize()
	
	
	
	pass


func _process(delta):
	
	
	if self.position.x < 50 :
		gerarNumeroX = 0.3
	elif  self.position.x > 1000:
		gerarNumeroX = -0.3
	if self.position.y < 390 :
		gerarNumeroY = 0.3
	elif self.position.y > 570:
		gerarNumeroY = -0.3 
	
	
	var direcao_movimento = Vector2(0,0)
	direcao_movimento += Vector2(gerarNumeroX, gerarNumeroY)
#
#
#
#
#
	if Input.is_action_pressed("ui_up"):
		direcao_movimento.y = -1
		print("cima")

	if Input.is_action_pressed("ui_down"):

		direcao_movimento.y = 1

		print("baixo")

	if Input.is_action_pressed("ui_right"):

		direcao_movimento.x = 1
		print("direita")

	if Input.is_action_pressed("ui_left"):

		direcao_movimento.x = -1

		print("esquerda")
#
#	position.x += direcao_movimento.x *velocidade * delta
#	position.y += direcao_movimento.y *velocidade * delta

# PODE-SE PROGRAMAR O MOVIMENTO DA FORMAACIMA, OU
#DA FORMA ABAIXO
	translate(direcao_movimento *velocidade * delta)



#FUNÇÃO DO MOVIMENTO ALEATORI0
func _on_ChangeMoveDirection_timeout() -> void:
	
	
	gerarNumeroX = rand_range(MIN,MAX)
	gerarNumeroY = rand_range(MIN,MAX)

	
	
	
	pass # Replace with function body.


