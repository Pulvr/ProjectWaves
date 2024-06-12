extends Panel


@onready var tower = preload("res://Scenes/coral_tower.tscn")
var currTile


func _on_gui_input(event):
	var tempTower = tower.instantiate()
	if event is InputEventMouseButton and event.button_mask == 1:
		#Left Click Down
		add_child(tempTower)
		
		tempTower.process_mode = Node.PROCESS_MODE_DISABLED
	elif event is InputEventMouseMotion and event.button_mask == 1:
		#Left Click Drag
		#nachdem tempTower als child gaddet wurde, ist es nicht mehr direkt 
		#addressierbar, also get the first child of array
		if get_child_count() > 1:
			get_child(1).global_position = event.global_position
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
			var path = get_tree().get_root().get_node("Main/Towers")
			
			#den temptower dann als "child" vom Node Towers in der main adden
			path.add_child(tempTower)
			
			#die position ist da, wo die maus gerade ist und die Tower Range wird ausgeblendet
			tempTower.global_position = event.global_position
			tempTower.get_node("Area").hide()
	#falls irgend ein anderer Button Input dazwischen kommt, aktuelle Queue löschen
	else:
		if get_child_count() > 1:
			get_child(1).queue_free()
