extends Node2D

onready var custom_item_label = preload("res://UI/CustomItemLabel.tscn")

var current_selected_item = ""


func _ready():
	add_items_shop()
	
	define_inventory_current_bananas()
	
func add_items_shop():
	for item in GlobalShopInventory.items_dict.keys():
		instance_item_label(item)	


func instance_item_label(id):
	var item_instance = custom_item_label.instance()
	$ItemShop/Options/ScrollContainer/Items.add_child(item_instance)

	item_instance.define_item(id)	
	item_instance.connect("has_been_clicked", self, "define_item_confirm_box", [item_instance])
	

func define_inventory_current_bananas():
	$Inventory/CurrentBananaAmount/Label.text = "x" + str(GlobalValues.golden_bananas_amount)	
	
	var index = 0
	for powerup in GlobalShopInventory.current_power_list:
		$Inventory/CurrentPowerUp/PowerUpList.get_child(index).texture = load(GlobalShopInventory.items_dict[powerup]["texture"])			
	
		index += 1
	
func define_item_confirm_box(item_instance):
	var item_id = item_instance.item_id
	
	$Description/ConfirmBox.visible = true
	$Description/ConfirmBox/BananaAmount.text = str(GlobalShopInventory.items_dict[item_id]["cost"])
	
	$Description/Options/Text.text = GlobalShopInventory.items_dict[item_id]["description"]
	
	if GlobalShopInventory.items_dict[item_id]["type"] == "cosmetic":
		$Inventory/Moggy/AnimatedSprite.frames = load(GlobalShopInventory.items_dict[item_id]["skin_file"])
		
	if GlobalShopInventory.items_dict[item_id]["sold"]:
		if GlobalShopInventory.current_animation_skin != item_id:		
			$Description/ConfirmBox/Options/Buy.text = "Use"	
		else:
			$Description/ConfirmBox/Options/Buy.text = "Remove"
	else:
		$Description/ConfirmBox/Options/Buy.text = "Buy"

	current_selected_item = item_id
	
	$GlobalSoundEffectGenerator.play_sound("select_sound_effect")
	

func check_item_buyable(item_id):
	var item_cost = GlobalShopInventory.items_dict[item_id]["cost"]

	if GlobalShopInventory.items_dict[item_id]["type"] == "cosmetic":
		if !GlobalShopInventory.items_dict[item_id]["sold"]:
			if GlobalValues.golden_bananas_amount >= item_cost:
				
				GlobalValues.golden_bananas_amount -= item_cost
#				GlobalShopInventory.current_animation_skin = item_id
				GlobalShopInventory.items_dict[item_id]["sold"] = true
			
				$Description/ConfirmBox/Options/AnimationPlayer.play("CLICKED")
				$Description/ConfirmBox/Options/Buy.text = "Use"
			
				$GlobalSoundEffectGenerator.play_sound("buy_item_sound_effect")
			else:
				$Description/ConfirmBox/Options/AnimationPlayer.play("DENIED")
				
				$GlobalSoundEffectGenerator.play_sound("error_sound_effect")	
			
		else:
			if GlobalShopInventory.current_animation_skin != item_id:
				GlobalShopInventory.current_animation_skin = item_id	
				$Description/ConfirmBox/Options/Buy.text = "Remove"
				
				$Inventory/Moggy/AnimatedSprite.frames = load(GlobalShopInventory.items_dict[item_id]["skin_file"])
			else:
				GlobalShopInventory.current_animation_skin = "default_moggy"
				$Description/ConfirmBox/Options/Buy.text = "Use"
			
				$Inventory/Moggy/AnimatedSprite.frames = load(GlobalShopInventory.items_dict["default_moggy"]["skin_file"])
			
			$Description/ConfirmBox/Options/AnimationPlayer.play("CLICKED")
			$GlobalSoundEffectGenerator.play_sound("select_sound_effect")
			
		define_inventory_current_bananas()	

#	if GlobalValues.golden_bananas_amount >= item_cost:
#
#		if GlobalShopInventory.items_dict[item_id]["type"] == "powerup":
#			if GlobalShopInventory.current_power_list.size() < 3:
#				GlobalValues.golden_bananas_amount -= item_cost
#
#				GlobalShopInventory.current_power_list.append(item_id)
#
#				$Description/ConfirmBox/Options/AnimationPlayer.play("CLICKED")
#			else:
#				$Description/ConfirmBox/Options/AnimationPlayer.play("DENIED")
			

func _on_TouchScreenButton_pressed():
	get_parent().get_node("AnimationPlayer").play_backwards("SWITCH_SHOP")


func _on_cosmetic_TouchScreenButton_pressed():
	check_item_buyable(current_selected_item)

