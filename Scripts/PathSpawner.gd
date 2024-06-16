extends Node2D
#die Ressource stage1 Pfad mit dem Gegner wird geladen
@onready var path = preload("res://Scenes/stage1.tscn")

@onready var timer = $Timer

#Wenn der verknüpfter Timer abläuft, wird der tempPath "instanced"
#Und dann als child zum Scene_tree hinzugefügt
func _on_timer_timeout():
	var tempPath = path.instantiate()
	add_child(tempPath)


func _on_start_wave_button_pressed():
	timer.start()
