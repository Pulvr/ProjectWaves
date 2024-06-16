extends StaticBody2D

# lade bullet scene
var Bullet = preload("res://Scenes/Bullet_Coral_Tower.tscn")
@export var bulletDamage = 5
var pathName
var currTargets = [] 	# array mit allen currentTargets
var curr 				# aktuelles Ziel
var justShot = false

func _process(delta):
	#Kugeln die nicht mehr gebraucht werden löschen
	if !is_instance_valid(curr):
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(i).queue_free()

func _on_tower_body_entered(body):
	if "Mob" in body.name and justShot == false:
		var tempArray = []
		currTargets = get_node("Tower").get_overlapping_bodies()
		
		for i in currTargets:
			if "Mob" in i.name:
				tempArray.append(i)
		var currTarget = null
		
		for i in tempArray:
			if currTarget == null:
				currTarget = i.get_node("../")
			else:
				if i.get_parent().get_progress() > currTarget.get_progress():
					currTarget = i.get_node("../")
		
		curr = currTarget
		pathName = currTarget.get_parent().name
		
		var tempBullet  = Bullet.instantiate()
		tempBullet.pathName = pathName
		tempBullet.bulletDamage = bulletDamage
		get_node("BulletContainer").call_deferred("add_child", tempBullet)
		tempBullet.set_deferred("global_position", $Aim.global_position)
		justShot = true

func _on_tower_body_exited(body):
	currTargets = get_node("Tower").get_overlapping_bodies()


func _on_cooldown_timer_timeout():
	#timer von 1 sekunde im tower, damit der tower nicht auf alle mobs gleichzeitig schießt beim platzieren
	justShot = false
	
