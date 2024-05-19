extends Sprite2D

var is_dragging = false
var mouse_offset
var delay = 5

func _physics_process(delta):
	if is_dragging:
		var new_position = get_global_mouse_position()
		
		# Get viewport boundaries
		var viewport = get_viewport_rect()
		print(viewport.size)
		var half_size = get_rect().size / 2

		# Clamp the position to keep the sprite within the screen bounds
		# clamp(value,min,max)
		new_position.x = clamp(new_position.x, half_size.x, viewport.size.x - half_size.x)
		new_position.y = clamp(new_position.y, half_size.y, viewport.size.y - half_size.y)
		
		# Move the sprite smoothly to the clamped position
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", new_position, delay * delta)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if get_rect().has_point(to_local(event.position)):
				print("clicked on sprite")
				is_dragging = true
		else:
			print("released button")
			is_dragging = false
