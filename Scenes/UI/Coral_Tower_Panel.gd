extends Panel

@onready var tower = preload("res://Scenes/coral_tower.tscn")
var currTile
@onready var label = get_tree().get_root().get_node("Main/ErrorLabel")
@onready var money = get_tree().get_root().get_node("Main")
var tower_cost: int = 100

func _on_gui_input(event):
	var tempTower = tower.instantiate()
	if event is InputEventMouseButton and event.button_mask == 1:
		#Left Click Down
		if int(money.get_money()) >= tower_cost:
			add_child(tempTower)
			tempTower.process_mode = Node.PROCESS_MODE_DISABLED
			get_child(1).global_position = event.global_position
		#else:
		#	label.set_text("Du arme Sau")
		#	#Muss noch gefixt werden
		#	if get_child_count() > 1:
		#		get_child(1).queue_free()
			
		
	elif event is InputEventMouseMotion and event.button_mask == 1:
		#Left Click Drag
		#nachdem tempTower als child gaddet wurde, ist es nicht mehr direkt 
		#addressierbar, also get the first child of array
		if get_child_count() > 1:
			#Fehler Text resetten
			label.set_text("")

			get_child(1).global_position = event.global_position

			#lots of stupid code to the the tilemap and current tile
			var mapPath = get_tree().get_root().get_node("Main/TileMap")
			var tile = mapPath.local_to_map(get_global_mouse_position())
			currTile = mapPath.get_cell_atlas_coords(0,tile,false)
			#Check if current tile is 3,3 which is the path. If so set the color to RED
			#Else turn it gray
			#KOORDINATE 3,3 ist der Weg
			if(currTile == Vector2i(3,3)):
				get_child(1).get_node("Area").modulate = Color.RED
			else:
				get_child(1).get_node("Area").modulate = Color.GRAY

	elif event is InputEventMouseButton and event.button_mask == 0:
		#dieses child aus der "drag" queue dann löschen
		# nur ausführen wenn man auch wirklich ein child hat
		if event.global_position.y > 595 or event.global_position.y <=0  or event.global_position.x >=1280 or event.global_position.x <= 0:
			if get_child_count() > 1:
				get_child(1).queue_free()
		else:
			if get_child_count() > 1:
				get_child(1).queue_free()
			#den aktuellen Pfad aus der main scene mit dem Node "Towers" holen
			if currTile != Vector2i(3,3):
				var path = get_tree().get_root().get_node("Main/Towers")
				
				#den temptower dann als "child" vom Node Towers in der main adden
				path.add_child(tempTower)
				
				#die position ist da, wo die maus gerade ist und die Tower Range wird ausgeblendet
				tempTower.global_position = event.global_position
				tempTower.get_node("Area").hide()
				money.spend_money(tower_cost)
			else:
				#Fehler Text setzen
				label.set_text("Turm darf nicht auf dem Weg platziert werden")
				#label["theme_override_colors/font_color"] = Color.RED
				
	#falls irgend ein anderer Button Input dazwischen kommt, aktuelle Queue löschen
	else:
		if get_child_count() > 1:
			get_child(1).queue_free()

