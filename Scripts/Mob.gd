extends CharacterBody2D

# Gescwindigkeit des Mob, kann dank export ausserhalb des Skripts veränder werden
@export var speed = 200
@export var health = 10

#Main Node holen, wenn Mob durchkommt um 5hp verringern, wenn gekillt geld erhöhen
@onready var mainScene = get_tree().get_root().get_node("Main")

#Jeden Frame wird der ParentNodeProgress geprüft und der 
#aktuelle Progress auf den jetzigen + speed*delta gesetzt. 
#Wenn komplett fertig, dann wird das child gelöscht
func _process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	if get_parent().get_progress_ratio() == 1:
		mainScene.take_damage(5)
		get_parent().get_parent().queue_free() #delete entire node
	if health <= 0:
		mainScene.earn_money(20)
		get_parent().get_parent().queue_free()
