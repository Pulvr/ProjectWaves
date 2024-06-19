extends StaticBody2D

# lade bullet scene
var Bullet = preload("res://Scenes/Bullet_Coral_Tower.tscn")
@export var bulletDamage = 5
var pathName
var currTargets = [] 	# array mit allen currentTargets
var curr 				# aktuelles Ziel
var justShot = true

func _physics_process(delta):
	#Kugeln die nicht mehr gebraucht werden löschen
	if !is_instance_valid(curr):
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(i).queue_free()
	
	currTargets = clean(currTargets)
	update_current_target()
	
	
	if is_instance_valid(curr) and justShot == false:
		#print(currTargets)
		var tempBullet  = Bullet.instantiate()
		tempBullet.pathName = pathName
		tempBullet.bulletDamage = bulletDamage
		get_node("BulletContainer").call_deferred("add_child", tempBullet)
		tempBullet.set_deferred("global_position", $Aim.global_position)
		justShot=true

# Logik zum füllen des Ziel-Arrays
func _on_tower_body_entered(body):
	update_current_targets(body)

func _on_tower_body_exited(body):
	update_current_targets(body)

func update_current_targets(body):
	
	if "Mob" in body.name:
		var tempArray = []
		currTargets = get_node("Tower").get_overlapping_bodies()
		print(currTargets)
		
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
				print(currTarget)
			#elif i.get_parent().get_progress() > currTarget.get_progress():
			#	currTarget = i.get_node("../")
			if is_instance_valid(currTarget):
				curr = currTarget
				pathName = currTarget.get_parent().name

func clean(dirty_array: Array) -> Array:
	var clean_array := []
	for item in dirty_array:
		if item!=null or is_instance_valid(item):
			clean_array.append(item)
	return clean_array

func _on_cooldown_timer_timeout():
	#timer von 1 sekunde im tower, damit der tower nicht auf alle mobs gleichzeitig schießt beim platzieren
	justShot = false
