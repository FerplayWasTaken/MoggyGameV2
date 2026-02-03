extends Control

var item_id = ""

signal has_been_clicked

func define_item(id):
	var item = GlobalShopInventory.items_dict
	
	$ItemBox/Title.text = item[id]["name"]
	$ItemBox/ItemTexture.texture = load(item[id]["texture"])
	$ItemBox/Amount.text = "x" + str(item[id]["cost"])

	item_id = id

func has_been_clicked():
	$AnimationPlayer.play("CLICKED")

func _on_TouchScreenButton_pressed():
	has_been_clicked()
	
	emit_signal("has_been_clicked")
