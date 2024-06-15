extends Node


# Spieler Skript
var max_hp = 100
var current_hp = 100

@onready var hp_bar = $HP/HpBar

func _ready():
	update_hp_bar()
	
func take_damage(damage):
	current_hp -= damage
	if current_hp < 0:
		current_hp = 0
	update_hp_bar()

func heal(amount):
	current_hp += amount
	if current_hp > max_hp:
		current_hp = max_hp
	update_hp_bar()
	
func update_hp_bar():
	hp_bar.value = current_hp
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		take_damage(10)
	elif event.is_action_pressed("ui_cancel"):
			heal(10)