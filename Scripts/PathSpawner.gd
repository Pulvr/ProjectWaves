extends Node2D
#die Ressource stage1 Pfad mit dem Gegner wird geladen
@onready var path = preload("res://Scenes/stage1.tscn")

#Wenn der verknüpfter Timer abläuft, wird der tempPath "instanced"
#Und dann als child zum Scene_tree hinzugefügt
func _on_timer_timeout():
	var tempPath = path.instantiate()
	add_child(tempPath)
