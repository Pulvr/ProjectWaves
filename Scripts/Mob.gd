extends CharacterBody2D

# Gescwindigkeit des Mob, kann dank export ausserhalb des Skripts veränder werden
@export var speed = 200
@export var health = 10

#Jeden Frame wird der ParentNodeProgress geprüft und der 
#aktuelle Progress auf den jetzigen + speed*delta gesetzt. 
#Wenn komplett fertig, dann wird das child gelöscht
func _process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	if get_parent().get_progress_ratio() == 1:
		queue_free()
	if health <= 0:
		get_parent().get_parent().queue_free()
