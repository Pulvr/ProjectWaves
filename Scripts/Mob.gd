extends CharacterBody2D

# Gescwindigkeit des Mob, kann dank export ausserhalb des Skripts veränder werden
@export var speed = 200
@export var health = 10

var playerHp

#Jeden Frame wird der ParentNodeProgress geprüft und der 
#aktuelle Progress auf den jetzigen + speed*delta gesetzt. 
#Wenn komplett fertig, dann wird das child gelöscht
func _process(delta):
	#HP Bar vom Main Node holen, wenn Mob durchkommt um 5hp verringern
	playerHp = get_tree().get_root().get_node("Main")
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	if get_parent().get_progress_ratio() == 1:
		playerHp.take_damage(5)
		#reachedGoal.emit()
		queue_free()
	if health <= 0:
		get_parent().get_parent().queue_free()
