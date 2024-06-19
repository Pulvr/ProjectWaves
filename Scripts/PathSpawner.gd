extends Node2D
#die Ressource stage1 Pfad mit dem Gegner wird geladen
@onready var path = preload("res://Scenes/stage1.tscn")

@onready var spawnTimer = $SpawnTimer
@onready var startButton = $StartWaveButton
@onready var waveLabel = $"../UI/Panel/Wave"

var enemyCounter = 0
var tempPath
var timerStopped = true
var waveCounter = 0


#Wenn der verknüpfter Timer abläuft, wird der tempPath "instanced"
#Und dann als child zum Scene_tree hinzugefügt
func _on_timer_timeout():
	
	tempPath = path.instantiate()
	add_child(tempPath)
	enemyCounter+=1
	#print(self.get_child_count())

	
func _process(delta):
	#wenn genug gegner gespawned sind und auf dem "Path" nur noch 2 Childs sind (Spawntimer und startbutton)
	if enemyCounter == 10 and self.get_child_count()==2:
		enemyCounter = 0		#gegner count zurücksetzen
		timerStopped = true		#Der timer ist gestopped!

	#Sind genug gegner gespawned und der Timer läuft nicht mehr, spawntimer stop
	if enemyCounter == 10 and timerStopped==false:
		spawnTimer.stop()		
	
	#Sind gerade keine Gegner auf dem Path und der Timer ist stopped, kann die nächste wave gestartet werden.
	if enemyCounter == 0 and timerStopped == true:
		startButton.show()



func _on_start_wave_button_pressed():
	spawnTimer.start()		#Gegner Spawn starten
	timerStopped = false	
	waveCounter+=1			#Welle erhöhen und Label updaten
	waveLabel.set_text(str(waveCounter) + " / 10")
	startButton.hide()		#WellenStart Button verstecken
