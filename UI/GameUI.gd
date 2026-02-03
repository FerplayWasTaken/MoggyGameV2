extends CanvasLayer

onready var player_powerup_manager = get_tree().get_current_scene().get_node("Moggy/PowerUpManager")

var power_up_selection_index = 0

var in_pause_mode = false
var can_pause_game = false

func _ready():
	if GlobalShopInventory.current_power_list.size() > 0:
		define_power_up_level()	

func _process(delta):
	$BananaAmountDisplay/Label.text = str(GlobalValues.golden_bananas_amount) + "x"

func define_power_up_level():
	if GlobalShopInventory.current_power_list.size() > 0:

		var selected_power_up = GlobalShopInventory.current_power_list[power_up_selection_index]
		
		$PoweUpSelection/PowerUp.texture = load(GlobalShopInventory.items_dict[selected_power_up]["texture"])
		
		if GlobalShopInventory.current_power_list.size() > 1:
			$PoweUpSelection/Selection.visible = true
	
	else:
		$PoweUpSelection/PowerUp.texture = null	
		$PoweUpSelection/Selection.visible = false

func define_current_powerup():
	if GlobalShopInventory.current_power_list.size() > 0:
		var selected_power_up = GlobalShopInventory.current_power_list[power_up_selection_index]
		$PowerUps/Label.text = "Power Up: " + GlobalShopInventory.items_dict[selected_power_up]["name"]
	else:
		$PowerUps/Label.text = "Power Up: " 


func _on_TouchScreenButton_pressed():
	if GlobalShopInventory.current_power_list.size() > 0:
		var current_power_up = GlobalShopInventory.current_power_list[power_up_selection_index]
		
		if current_power_up != "":
			GlobalShopInventory.current_power_up = current_power_up
			GlobalShopInventory.available_power_up = ""
			
			define_current_powerup()
			
			player_powerup_manager.define_current_powerup()
		
			GlobalShopInventory.current_power_list.erase(current_power_up)
	
			define_power_up_level()
			

func _on_Selection_TouchScreenButton_pressed():
	if GlobalShopInventory.current_power_list.size() > 0:
		if power_up_selection_index < GlobalShopInventory.current_power_list.size() - 1:
			power_up_selection_index += 1
		else:
			power_up_selection_index = 0
			
		define_power_up_level()		



func _on_RetryTouch_pressed():
	get_tree().change_scene("res://World/ForestWorld/ForestWorld.tscn")


func _on_BackTouch_pressed():
	$PauseUI/AnimationPlayer.play_backwards("pause_game")

	in_pause_mode = false

func _on_PauseTouch_pressed():
	if can_pause_game:
		if !in_pause_mode:
			$PauseUI/AnimationPlayer.play("pause_game")

			in_pause_mode = true


func _on_MenuTouch_pressed():
	GlobalValues.game_has_started = false	
	
	get_tree().change_scene("res://World/ForestWorld/ForestWorld.tscn")

