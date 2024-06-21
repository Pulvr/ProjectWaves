extends Node2D
#die Ressource stage1 Pfad mit dem Gegner wird geladen
@onready var path = preload("res://Scenes/stage1.tscn")

@onready var spawnTimer = $SpawnTimer
@onready var startButton = $StartWaveButton
@onready var waveLabel = $"../UI/Panel/Wave"

signal gameWon

var mobScene
var mobs = []
var tempPath

var mobCounter = 0		#aktuelle Gegner die gespawned wurden, wird nach welle auf 0 gesetzt
var maxEnemies				#maximale Gegner die pro welle gespawned werden sollen

var timerStopped = true
var waveCounter = 0

#Wenn der verknüpfter Timer abläuft, wird der tempPath "instanced"
#Und dann als child zum Scene_tree hinzugefügt
func _on_timer_timeout():
	tempPath = path.instantiate()
	add_child(tempPath)
	mobCounter+=1
	
	mobScene = tempPath.get_child(0).get_child(0) 
	
	if waveCounter == 2 :
		mobScene.set_speed(150)
		mobScene.set_health(15)
	elif waveCounter == 3 :
		mobScene.set_speed(180)
		mobScene.set_health(15)
	elif waveCounter == 4:
		mobScene.set_speed(200)
		mobScene.set_health(20)
	elif waveCounter == 5:
		mobScene.set_speed(220)
		mobScene.set_health(25)
	elif waveCounter == 6:
		mobScene.set_speed(250)
		mobScene.set_health(30)
	elif waveCounter == 7:
		mobScene.set_speed(270)
		mobScene.set_health(35)
	elif waveCounter == 8:
		mobScene.set_speed(300)
		mobScene.set_health(40)
	elif waveCounter == 9:
		mobScene.set_speed(350)
		mobScene.set_health(50)
	elif waveCounter == 10:
		mobScene.set_speed(400)
		mobScene.set_health(60)
	
func _process(delta):
	#wenn genug gegner gespawned sind und auf dem "Path" nur noch 2 Childs sind (Spawntimer und startbutton)
	if mobCounter == 1 and self.get_child_count()==2:
		mobCounter = 0		#gegner count zurücksetzen
		timerStopped = true		#Der timer ist gestopped!
		mobs.clear()
		
	#Sind genug gegner gespawned und der Timer läuft nicht mehr, spawntimer stop
	if mobCounter == 1 and timerStopped==false:
		spawnTimer.stop()		
	
	#Sind gerade keine Gegner auf dem Path und der Timer ist stopped, kann die nächste wave gestartet werden.
	if mobCounter == 0 and timerStopped == true:
		startButton.show()
	
	# wenn welle 10 erreicht und alle gegner besiegt gewonnen, bisher noch broken, man gewinnt sofort auf welle 10
	if mobCounter == 0 and self.get_child_count()==2 and waveCounter==10 and timerStopped == true:
		gameWon.emit()
		
func _on_start_wave_button_pressed():
	spawnTimer.start()		#Gegner Spawn starten
	timerStopped = false	
	
	waveCounter+=1			#Welle erhöhen und Label updaten
	change_maxEnemyAndTimer(waveCounter)
	
	waveLabel.set_text(str(waveCounter) + " / 10")
	startButton.hide()		#WellenStart Button verstecken

func change_maxEnemyAndTimer(currentwave):
	match currentwave:
		1: maxEnemies = 12
		2: maxEnemies = 14		#ab hier speed und hp erhöhen
		3: maxEnemies = 15		#ab hier speed erhöhen
		4: 
			maxEnemies = 20		#eigtl immer speed und alle 2 schritte hp, die towers sind zu stark
			spawnTimer.wait_time = 0.8
		5: maxEnemies = 25
		6: maxEnemies = 30
		7: 
			maxEnemies = 35
			spawnTimer.wait_time = 0.7
		8: maxEnemies = 40
		9: 
			maxEnemies = 45
			spawnTimer.wait_time = 0.6
		10: 
			maxEnemies = 50
			spawnTimer.wait_time = 0.5
		_: print("something went wrong")
