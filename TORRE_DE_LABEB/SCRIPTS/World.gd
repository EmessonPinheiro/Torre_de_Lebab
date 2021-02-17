extends Node2D

var screen_size 

var preHuman = preload("res://SCENES/Humans.tscn")
var preMiner = preload("res://SCENES/Miners.tscn")
var preWoodCutter = preload("res://SCENES/WoodCutters.tscn")
#INSTANCIANDO HUMANO NO ESCOPO GLOBAL
var human 
var armazemDeHuman = []

var costPdHuman = 20

#VARIAVEL PARA DELETAR HUMANOS
var convertHumans = 0

export var pd = 0
export var humans = 0
export var miners = 0
export var woodCuttersH = 0
export var rockCurrent = 0
export var woodCurrent = 0


#VARIAVEL PARA CAPACIDADE DE HUMANOS POR NIVEL DE TORRE
var MaxHuman = 3

#VARIAVEL PARA NIVEL DA TORRE
var LevelTower = 0
var addMaxHuman =2
var woodToUp = 20
var rockToUp = 20


#VARIAVEL PARA CAPACIDADE DE MINERS POR NIVEL DE QUARRY
var MaxWoodcutters = 3

#VARIAVEL PARA NIVEL DA MADEIREIRA
var LevelLogging = 0
var addMaxWoodCutters =2
var woodToUpLogging = 25
var rockToUpLogging = 15



#VARIAVEL PARA CAPACIDADE DE MINERS POR NIVEL DE QUARRY
var MaxMiner = 3

#VARIAVEL PARA NIVEL DA PEDREIRA
var LevelQuarry = 0
var addMaxMiners =2
var woodToUpQuarry = 15
var rockToUpQuarry = 25

#VARIÁVEIS PARA OS EVENTOS DO NELIPE F.
var meteoro
var quarryCrash
var loggingCrash
var towerCrash


# VARIAVEIS PARA CONTROLE DE UPGRADE/DOWNGRADE
var add_up1 = 5
var add_up2 = 10
var add_up3 = 15
var add_up4 = 20
var add_up5 = 30

var add_cap1 = 3
var add_cap2 = 3
var add_cap3 = 5
var add_cap4 = 5
var add_cap5 = 5




func _ready() -> void:
	randomize()
	screen_size = get_viewport_rect().size
	$Fundo.play()
	pass


func _process(delta):
	ui()
	lv_das_construcoes()



#ESSA FUNC É PARA ADICIONAR PONTOS DIVINOS
func _on_AddPD_pressed() -> void:
	
	pd +=10
	pass # Replace with function body.


#FUNÇÃO PARA REPRODUZIR HUMANOS
func _on_Reproduct_pressed() -> void:
	
	
	
	#VARIAVEL PARA LOCALIZAÃO DOS HUMANOS
	var spawHumanX = rand_range(50,1000)
	var spawHumanY = rand_range(420,570)
	
	if pd >= costPdHuman && MaxHuman > humans:
		
#		ESSA PARTE ABAIXO É SOBRE GERAÇAO DOS OBJETOS HUMANOS

		human = preHuman.instance()
		armazemDeHuman.append(human) 
		add_child(armazemDeHuman[armazemDeHuman.size()-1])
		human.position.x = spawHumanX
		human.position.y = spawHumanY
		
#ESSA PARTE ABAIXO É SOBRE AS VARIAVEIS DE CONTROLE

		humans +=1
		convertHumans +=1
		pd -= costPdHuman
#		costPdHuman += humans*1.25
		
	pass # Replace with function body.


#ESSA FUNÇÃO AQUI É PARA CATAR PEDRA
#QUANDO HOUVER PICARETA, É PARA MINERAR
func _on_Rock_pressed() -> void:
	
	if humans > 0 && miners < MaxMiner:
		humans -= 1
		miners += 1
		
		
		var miner = preMiner.instance()
		add_child(miner)
		
	pass # Replace with function body.

#PRODUÇAO DE RECURSOS
func _on_Prodution_timeout() -> void:
	
	woodCurrent += woodCuttersH
	rockCurrent += miners
	pd += humans/2
	
	
	
	pass # Replace with function body.


func _on_Wood_pressed() -> void:
	
	
	if humans > 0 && MaxWoodcutters > woodCuttersH:
		humans -= 1
		woodCuttersH += 1
		var Woodcutter = preWoodCutter.instance()
		add_child(Woodcutter)
		
	pass # Replace with function body.

#FUNÇÃO QUE FAZ AS LABEL MOSTRAR O QUE TEM QUE
#SER MOSTRADO
func ui():
	#ISSO É PARA MOSTRA QUANTOS PONTOS DIVINOS NÓS TEMOS
	$BotaoPai/AddPD/pontosDivinos.text = str(pd)
	#ISSO MOSTRA QUNTOS HUMANOS
	$BotaoPai/Reproduct/Label.text = str(humans)
#	ISSO MOSTRA QUANTAS PEDRAS TEMOS
	$BotaoPai/Rock/rockCounter/rockCurrency.text = str(rockCurrent)
#	ISSO MOSTRA QUANTOS MINEIROS
	$BotaoPai/Rock/miners.text = str(miners)
#	ISSO MOSTRA QUANTOS LENHADORES
	$BotaoPai/Wood/WoodCutters.text = str(woodCuttersH)
#	ISSO MOSTRA QUANTAS MADEIRAS
	$BotaoPai/Wood/woodcr/WoodCurrency.text = str(woodCurrent)
#	ISSO VAI SER A IU DA TORRE
	$Tower/LvTower.text = "Lv" + str(LevelTower)
	$Tower/MaxHumanInTower.text = "Capacity" + str(humans) +"/" +str(MaxHuman)
# QUANTOS RECURSOS PARA UPAR A TORRE
	$BotaoPai/Upgrade/rock.text = str(rockToUp)
	$BotaoPai/Upgrade/wood.text = str(woodToUp)
	
	
	#	ISSO VAI SER A IU DA Logging
	$Logging/LvLogging.text = "Lv" + str(LevelLogging)
	$Logging/MaxWoodcutters.text = "Capacity" + str(woodCuttersH) +"/" +str(MaxWoodcutters)
	
#ISSO VAI SER A IU DA QUARRY
	$Quarry/LvQuarry.text = "Lv" + str(LevelQuarry)
	$Quarry/MaxMiners.text = "Capacity" + str(miners) +"/" +str(MaxMiner)
	
	# QUANTOS RECURSOS PARA UPAR A LOGGING
	$BotaoPai/UpgradeL/rock.text = str(rockToUpLogging)
	$BotaoPai/UpgradeL/wood.text = str(woodToUpLogging)
	
	# QUANTOS RECURSOS PARA UPAR A QUARRY
	$BotaoPai/UpgradeQ/rock.text = str(rockToUpQuarry)
	$BotaoPai/UpgradeQ/wood.text = str(woodToUpQuarry)
	
	pass


#FUNÇÃO QUE APAGA DESEMPREGADOS QUNADO ELE ARRUMA EMPREGO
func _on_AttMobs_timeout() -> void:
	
	if convertHumans > humans:
		convertHumans -=1
		remove_child(armazemDeHuman[0])
		armazemDeHuman.remove(0)
	
	pass # Replace with function body.

#FUNÃO PARA MELHORAR A TORRE
func _on_Upgrade_pressed() -> void:

	if LevelTower < 1 && woodCurrent >= woodToUp && rockCurrent >= rockToUp :
		woodCurrent -= woodToUp
		rockCurrent -= rockToUp
		MaxHuman += addMaxHuman
		addMaxHuman += add_cap1
		LevelTower +=1
		woodToUp += add_up1
		rockToUp += add_up1
		
	elif LevelTower < 2 && woodCurrent >= woodToUp && rockCurrent >= rockToUp :
		woodCurrent -= woodToUp
		rockCurrent -= rockToUp
		MaxHuman += addMaxHuman
		addMaxHuman += add_cap2
		LevelTower +=1
		woodToUp += add_up2
		rockToUp += add_up2
		
	elif  LevelTower < 3 && woodCurrent >= woodToUp && rockCurrent >= rockToUp :
		woodCurrent -= woodToUp
		rockCurrent -= rockToUp
		MaxHuman += addMaxHuman
		addMaxHuman += add_cap3
		LevelTower +=1
		woodToUp += add_up3
		rockToUp += add_up3
		
	elif LevelTower < 4 && woodCurrent >= woodToUp && rockCurrent >= rockToUp :
		woodCurrent -= woodToUp
		rockCurrent -= rockToUp
		MaxHuman += addMaxHuman
		addMaxHuman += add_cap4
		LevelTower +=1
		woodToUp += add_up4
		rockToUp += add_up4
		
	elif  LevelTower < 5 && woodCurrent >= woodToUp && rockCurrent >= rockToUp :
		woodCurrent -= woodToUp
		rockCurrent -= rockToUp
		MaxHuman += addMaxHuman
		addMaxHuman += add_cap5
		LevelTower +=1
		woodToUp += add_up5
		rockToUp += add_up5

	
	
	pass # Replace with function body.


func lv_das_construcoes():
	
	if LevelTower == 0:
		$Tower.animation = "TowerLv0"
	elif LevelTower == 1:
		$Tower.animation = "TowerLv1"
	elif LevelTower == 2:
		$Tower.animation = "TowerLv2"
	elif LevelTower == 3:
		$Tower.animation = "TowerLv3"
	elif LevelTower == 4:
		$Tower.animation = "TowerLv4"
	elif LevelTower == 5:
		$Tower.animation = "TowerLv5"
		$BotaoPai/Upgrade/rock.text = "MAX"
		$BotaoPai/Upgrade/wood.text = "MAX"
		
	if LevelQuarry == 0:
		$Quarry.animation = "QuarryLv0"
	elif LevelQuarry == 1:
		$Quarry.animation = "QuarryLv1"
	elif LevelQuarry == 2:
		$Quarry.animation = "QuarryLv2"
	elif LevelQuarry == 3:
		$Quarry.animation = "QuarryLv3"
	elif LevelQuarry == 4:
		$Quarry.animation = "QuarryLv4"
	elif LevelQuarry == 5:
		$Quarry.animation = "QuarryLv5"
		$BotaoPai/UpgradeQ/rock.text = "Max"
		$BotaoPai/UpgradeQ/wood.text = "Max"
	
	
	if LevelLogging == 0:
		$Logging.animation = "LoggingLv0"
	elif LevelLogging == 1:
		$Logging.animation = "LoggingLv1"
	elif LevelLogging == 2:
		$Logging.animation = "LoggingLv2"
	elif LevelLogging == 3:
		$Logging.animation = "LoggingLv3"
	elif LevelLogging == 4:
		$Logging.animation = "LoggingLv4"
	elif LevelLogging == 5:
		$Logging.animation = "LoggingLv5"
		$BotaoPai/UpgradeL/rock.text = "Max"
		$BotaoPai/UpgradeL/wood.text = "Max"
	pass


func _on_UpgradeQ_pressed() -> void:
	
	if LevelQuarry < 1 && woodCurrent >= woodToUpQuarry && rockCurrent >= rockToUpQuarry :
		woodCurrent -= woodToUpQuarry
		rockCurrent -= rockToUpQuarry
		MaxMiner += addMaxMiners
		addMaxMiners += add_cap1
		LevelQuarry +=1
		woodToUpQuarry += add_up1
		rockToUpQuarry += add_up1
		
	elif LevelQuarry < 2 && woodCurrent >= woodToUpQuarry && rockCurrent >= rockToUpQuarry :
		woodCurrent -= woodToUpQuarry
		rockCurrent -= rockToUpQuarry
		MaxMiner += addMaxMiners
		addMaxMiners += add_cap2
		LevelQuarry +=1
		woodToUpQuarry += add_up2
		rockToUpQuarry += add_up2
		
	elif LevelQuarry < 3 && woodCurrent >= woodToUpQuarry && rockCurrent >= rockToUpQuarry :
		woodCurrent -= woodToUpQuarry
		rockCurrent -= rockToUpQuarry
		MaxMiner += addMaxMiners
		addMaxMiners += add_cap3
		LevelQuarry +=1
		woodToUpQuarry += add_up3
		rockToUpQuarry += add_up3
		
	elif LevelQuarry < 4 && woodCurrent >= woodToUpQuarry && rockCurrent >= rockToUpQuarry :
		woodCurrent -= woodToUpQuarry
		rockCurrent -= rockToUpQuarry
		MaxMiner += addMaxMiners
		addMaxMiners += add_cap4
		LevelQuarry +=1
		woodToUpQuarry += add_up4
		rockToUpQuarry += add_up4
		
	elif LevelQuarry < 5 && woodCurrent >= woodToUpQuarry && rockCurrent >= rockToUpQuarry :
		woodCurrent -= woodToUpQuarry
		rockCurrent -= rockToUpQuarry
		MaxMiner += addMaxMiners
		addMaxMiners += add_cap5
		LevelQuarry +=1
		woodToUpQuarry += add_up5
		rockToUpQuarry += add_up5
		
	pass # Replace with function body.


func _on_UpgradeL_pressed() -> void:
	if LevelLogging < 1 && woodCurrent >= woodToUpLogging && rockCurrent >= rockToUpLogging :
		woodCurrent -= woodToUpLogging
		rockCurrent -= rockToUpLogging
		MaxWoodcutters += addMaxWoodCutters
		addMaxWoodCutters += add_cap1
		LevelLogging +=1
		woodToUpLogging += add_up1
		rockToUpLogging += add_up1
		
	elif LevelLogging < 2 && woodCurrent >= woodToUpLogging && rockCurrent >= rockToUpLogging :
		woodCurrent -= woodToUpLogging
		rockCurrent -= rockToUpLogging
		MaxWoodcutters += addMaxWoodCutters
		addMaxWoodCutters += add_cap2
		LevelLogging +=1
		woodToUpLogging += add_up2
		rockToUpLogging += add_up2
		
	elif LevelLogging < 3 && woodCurrent >= woodToUpLogging && rockCurrent >= rockToUpLogging :
		woodCurrent -= woodToUpLogging
		rockCurrent -= rockToUpLogging
		MaxWoodcutters += addMaxWoodCutters
		addMaxWoodCutters += add_cap3
		LevelLogging +=1
		woodToUpLogging += add_up3
		rockToUpLogging += add_up3
		
	elif LevelLogging < 4 && woodCurrent >= woodToUpLogging && rockCurrent >= rockToUpLogging :
		woodCurrent -= woodToUpLogging
		rockCurrent -= rockToUpLogging
		MaxWoodcutters += addMaxWoodCutters
		addMaxWoodCutters += add_cap4
		LevelLogging +=1
		woodToUpLogging += add_up4
		rockToUpLogging += add_up4
		
	elif LevelLogging < 5 && woodCurrent >= woodToUpLogging && rockCurrent >= rockToUpLogging :
		woodCurrent -= woodToUpLogging
		rockCurrent -= rockToUpLogging
		MaxWoodcutters += addMaxWoodCutters
		addMaxWoodCutters += add_cap5
		LevelLogging +=1
		woodToUpLogging += add_up5
		rockToUpLogging += add_up5
		
	
	pass # Replace with function body.


func _on_NelipeEvents_timeout() -> void:
	
	meteoro = rand_range(0,20)
	if meteoro > 10:
		loggingCrash = rand_range(0,100)
		if loggingCrash < 20 && LevelLogging >0:
			if LevelLogging == 5:
				LevelLogging -=1
				woodToUpLogging -= add_up5
				rockToUpLogging -= add_up5
				MaxWoodcutters -=  addMaxWoodCutters - add_cap5
				addMaxWoodCutters -= add_cap5
				
				
			elif LevelLogging == 4:
				LevelLogging -=1
				woodToUpLogging -= add_up4
				rockToUpLogging -= add_up4
				MaxWoodcutters -=  addMaxWoodCutters - add_cap4
				addMaxWoodCutters -= add_cap4
				
			
			elif LevelLogging == 3:
				LevelLogging -=1
				woodToUpLogging -= add_up3
				rockToUpLogging -= add_up3
				MaxWoodcutters -=  addMaxWoodCutters - add_cap3
				addMaxWoodCutters -= add_cap3
				
				
			elif LevelLogging == 2:
				LevelLogging -=1
				woodToUpLogging -= add_up2
				rockToUpLogging -= add_up2
				MaxWoodcutters -=  addMaxWoodCutters - add_cap2
				addMaxWoodCutters -= add_cap2
				
				
			elif LevelLogging == 1:
				LevelLogging -=1
				woodToUpLogging -= add_up1
				rockToUpLogging -= add_up1
				MaxWoodcutters -=  addMaxWoodCutters - add_cap1
				addMaxWoodCutters -= add_cap1
				
		towerCrash = rand_range(0,100)
		if towerCrash < 20 && LevelTower >0:
				if LevelTower ==5:
					LevelTower -=1
					woodToUp -= add_up5
					rockToUp -= add_up5
					MaxHuman -=  addMaxHuman - add_cap5
					addMaxHuman -= add_cap5
					
				elif LevelTower == 4:
					LevelTower -=1
					woodToUp -= add_up4
					rockToUp -= add_up4
					MaxHuman -=  addMaxHuman - add_cap4
					addMaxHuman -= add_cap4
					
				
					
				elif LevelTower == 3:
					LevelTower -=1
					woodToUp -= add_up3
					rockToUp -= add_up3
					MaxHuman -=  addMaxHuman - add_cap3
					addMaxHuman -= add_cap3
					
				
					
				elif LevelTower == 2:
					LevelTower -=1
					woodToUp -= add_up2
					rockToUp -= add_up2
					MaxHuman -=  addMaxHuman - add_cap2
					addMaxHuman -= add_cap2
					
				

				elif LevelTower == 1:
					LevelTower -=1
					woodToUp -= add_up1
					rockToUp -= add_up1
					MaxHuman -=  addMaxHuman - add_cap1
					addMaxHuman -= add_cap1
					
				
		
		
		
		
		
		
		
		
		
		
		
		quarryCrash = rand_range(0,100)
		if quarryCrash < 20 && LevelQuarry >0:
			if LevelQuarry ==5:
				LevelQuarry -=1
				woodToUpQuarry -= add_up5
				rockToUpQuarry -= add_up5
				MaxMiner -=  addMaxMiners - add_cap5
				addMaxMiners -= add_cap5
				
			elif LevelQuarry == 4:
				LevelQuarry -=1
				woodToUpQuarry -= add_up4
				rockToUpQuarry -= add_up4
				MaxMiner -=  addMaxMiners - add_cap4
				addMaxMiners -= add_cap4
				
			elif LevelQuarry == 3:
				LevelQuarry -=1
				woodToUpQuarry -= add_up3
				rockToUpQuarry -= add_up3
				MaxMiner -=  addMaxMiners - add_cap3
				addMaxMiners -= add_cap3
				
			elif LevelQuarry == 2:
				LevelQuarry -=1
				woodToUpQuarry -= add_up2
				rockToUpQuarry -= add_up2
				MaxMiner -=  addMaxMiners - add_cap2
				addMaxMiners -= add_cap2

			elif LevelQuarry == 1:
				LevelQuarry -=1
				woodToUpQuarry -= add_up1
				rockToUpQuarry -= add_up1
				MaxMiner -=  addMaxMiners - add_cap1
				addMaxMiners -= add_cap1
				
			
			
	
	pass # Replace with function body.


func _on_Fundo_finished() -> void:
	$Fundo.play()
	pass # Replace with function body.
