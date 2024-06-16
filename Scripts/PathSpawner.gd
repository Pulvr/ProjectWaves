extends Node2D
#die Ressource stage1 Pfad mit dem Gegner wird geladen
@onready var path = preload("res://Scenes/stage1.tscn")

@onready var spawnTimer = $SpawnTimer
@onready var startButton = $StartWaveButton

var enemyCounter=0
var tempPath
var timerStopped =false

#Wenn der verknüpfter Timer abläuft, wird der tempPath "instanced"
#Und dann als child zum Scene_tree hinzugefügt
func _on_timer_timeout():
	
	tempPath = path.instantiate()
	add_child(tempPath)
	enemyCounter+=1
	print(self.get_child_count())

	
func _process(delta):
	if enemyCounter == 10 and timerStopped==false :
		spawnTimer.stop()
		enemyCounter = 0
		timerStopped = true
		startButton.show()
		#print("10 gegner gespawned")



func _on_start_wave_button_pressed():
	spawnTimer.start()
	timerStopped = false
	startButton.hide()
