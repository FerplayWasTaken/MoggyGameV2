extends Node2D


export var current_power_up = ""

onready var game_ui = get_tree().get_current_scene().get_node("GameUI")

func _ready():
	define_current_powerup()
	
func get_current_power():
	return current_power_up	
	
func used_current_power():
	current_power_up = ""
	
	GlobalShopInventory.current_power_up = current_power_up
	
	game_ui.define_current_powerup()
	
func define_current_powerup():
	current_power_up = GlobalShopInventory.current_power_up	
