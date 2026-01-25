extends Node2D

onready var custom_item_label = preload("res://UI/CustomItemLabel.tscn")

func _ready():
	add_cosmetics_shop()

func add_cosmetics_shop():
	for cosmetic in GlobalShopInventory.costmetics_dict.keys():
		if !(GlobalShopInventory.current_cosmetics.has(cosmetic)):
			print("cosmetic name: ", cosmetic)
			
			instance_cosmetic_label(cosmetic)

func instance_cosmetic_label(id):
	var cosmetic_instance = custom_item_label.instance()
	$CosmeticsShop/Options/ScrollContainer/PowerUps.add_child(cosmetic_instance)

	cosmetic_instance.define_cosmetic(id)	
	

func _on_TouchScreenButton_pressed():
	get_parent().get_node("AnimationPlayer").play_backwards("SWITCH_SHOP")
