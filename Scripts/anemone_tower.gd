extends StaticBody2D

# lade bullet scene
var Bullet = preload("res://Scenes/BulletAnemoneTower.tscn")
@export var bulletDamage = 2.7
var pathName
var currTargets = [] 	# array mit allen currentTargets
var curr 				# aktuelles Ziel
var justShot = true

@onready var bubble = $shootSound

func _physics_process(delta):
	#Kugeln die nicht mehr gebraucht werden löschen, wenn bspw. gegner 
	#von anderem Turm erledigt wird. 
	if !is_instance_valid(curr):
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(i).queue_free()
	
	#Target Array und aktuells Ziel aktualisieren
	currTargets = clean(currTargets)
	update_current_target()
	
	# Wenn ziel existiert, bullet erstellen
	if is_instance_valid(curr) and justShot == false:
		var tempBullet  = Bullet.instantiate()
		bubble.pitch_scale = randf_range(0.8,1.3)
		bubble.play()
		tempBullet.pathName = pathName
		tempBullet.bulletDamage = bulletDamage
		get_node("BulletContainer").call_deferred("add_child", tempBullet)
		tempBullet.set_deferred("global_position", $Aim.global_position)
		justShot=true

# Logik zum füllen des Ziel-Arrays beim entern und exiten von bodys
func _on_tower_body_entered(body):
	update_targets_array(body)

func _on_tower_body_exited(body):
	update_targets_array(body)

#wird ausgeführt wenn ein body die area entered und exited
func update_targets_array(body):
	if "Mob" in body.name:
		var tempArray = []
		currTargets = get_node("Tower").get_overlapping_bodies()
		#print(currTargets)
		
		for i in currTargets:
			if "Mob" in i.name:
				tempArray.append(i)
		currTargets = tempArray

func update_current_target():
	var currTarget = null
	if !currTargets.is_empty():
		for i in currTargets:
			if (currTarget == null ):
				currTarget = i.get_node("../")
				#print(currTarget)
			#elif i.get_parent().get_progress() > currTarget.get_progress():
			#	currTarget = i.get_node("../")
			if is_instance_valid(currTarget):
				curr = currTarget
				pathName = currTarget.get_parent().name

#Hilfsunktion um null aus dem Zielarray zu entfernen.
#sehr unperformant, da es jeden Frame ausgeführt wird aber hey ¯\_(ツ)_/¯
func clean(dirty_array: Array) -> Array:
	var clean_array := []
	for item in dirty_array:
		if item!=null or is_instance_valid(item):
			clean_array.append(item)
	return clean_array

#timer von 1 sekunde im tower, damit er nicht ununterbrochen schießt
func _on_cooldown_timer_timeout():
	justShot = false
