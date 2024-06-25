extends Node

signal gameOver

# Spieler Skript
var max_hp = 100
var current_hp = 100
var current_money = 200

@onready var hp_bar = $UI/HpBar
@onready var money = $UI/Money
@onready var deathSound = $enemyDeath

func _ready():
	update_hp_bar()
	update_money()
	
func take_damage(damage):
	current_hp -= damage
	if current_hp < 0:
		current_hp = 0
	update_hp_bar()
	
func earn_money(amount):
	current_money += amount
	deathSound.pitch_scale = randf_range(0.9,1.1)
	deathSound.play()
	if current_money > 9999:
		current_money = 9999
	update_money()

func spend_money(amount):
	current_money -= amount
	if current_money < 0:
		current_money = 0
	update_money()
	
func check_money(amount):
	if current_money >= amount:
		return true
	else:
		return false
	
func get_money():
	return current_money

func heal(amount):
	current_hp += amount
	if current_hp > max_hp:
		current_hp = max_hp
	update_hp_bar()

#zum visuellen Updaten des UIs
func update_hp_bar():
	hp_bar.value = current_hp
	
func update_money():
	money.text = str(current_money)

func _process(delta):
	if current_hp <=0:
		gameOver.emit()

func _on_game_over():
	get_tree().change_scene_to_file("res://Scenes/gameover_screen.tscn")

func _on_path_spawner_game_won():
	get_tree().change_scene_to_file("res://Scenes/gameWon_screen.tscn")
