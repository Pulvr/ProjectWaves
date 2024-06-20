extends Node2D
#die Ressource stage1 Pfad mit dem Gegner wird geladen
@onready var path = preload("res://Scenes/stage1.tscn")

@onready var spawnTimer = $SpawnTimer
@onready var startButton = $StartWaveButton
@onready var waveLabel = $"../UI/Panel/Wave"

var tempPath

var enemyCounter = 0		#aktuelle Gegner die gespawned wurden, wird nach welle auf 0 gesetzt
var maxEnemies				#maximale Gegner die pro welle gespawned werden sollen

var timerStopped = true
var waveCounter = 0

#Wenn der verknüpfter Timer abläuft, wird der tempPath "instanced"
#Und dann als child zum Scene_tree hinzugefügt
func _on_timer_timeout():
	tempPath = path.instantiate()
	add_child(tempPath)
	enemyCounter+=1
	print(enemyCounter)
	
func _process(delta):
	#wenn genug gegner gespawned sind und auf dem "Path" nur noch 2 Childs sind (Spawntimer und startbutton)
	if enemyCounter == maxEnemies and self.get_child_count()==2:
		enemyCounter = 0		#gegner count zurücksetzen
		timerStopped = true		#Der timer ist gestopped!
		
	#Sind genug gegner gespawned und der Timer läuft nicht mehr, spawntimer stop
	if enemyCounter == maxEnemies and timerStopped==false:
		spawnTimer.stop()		
	
	#Sind gerade keine Gegner auf dem Path und der Timer ist stopped, kann die nächste wave gestartet werden.
	if enemyCounter == 0 and timerStopped == true:
		startButton.show()
	
	# wenn welle 10 erreicht und alle gegner besiegt gewonnen, bisher noch broken, man gewinnt sofort auf welle 10
	if enemyCounter == 0 and self.get_child_count()==2 and waveCounter==10:
		print("won")

func _on_start_wave_button_pressed():
	spawnTimer.start()		#Gegner Spawn starten
	timerStopped = false	
	waveCounter+=1			#Welle erhöhen und Label updaten
	wave_logic(waveCounter)
	waveLabel.set_text(str(waveCounter) + " / 10")
	startButton.hide()		#WellenStart Button verstecken

func wave_logic(currentwave):
	match currentwave:
		1: maxEnemies = 12
		2: maxEnemies = 14		#ab hier speed und hp erhöhen
		3: maxEnemies = 15		#ab hier speed erhöhen
		4: maxEnemies = 20		#eigtl immer speed und alle 2 schritte hp, die towers sind zu stark
		5: maxEnemies = 25
		6: maxEnemies = 30
		7: maxEnemies = 35
		8: maxEnemies = 40
		9: maxEnemies = 45
		10: maxEnemies = 50
		_: print("something went wrong")
