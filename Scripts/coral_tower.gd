extends StaticBody2D

# lade bullet scene
var Bullet = preload("res://Scenes/Bullet_Coral_Tower.tscn")
var bulletDamage = 5
var pathName
var currTargets = [] 	# array mit allen currentTargets
var curr 				# aktuelles Ziel


func _on_tower_body_entered(body):
	if "Mob" in body.name:
		var tempArray = []
		currTargets = get_node("Tower").get_overlapping_bodies()
		
		print(currTargets)

func _on_tower_body_exited(body):
	pass # Replace with function body.
