extends Control



func define_cosmetic(id):
	var cosmetic = GlobalShopInventory.costmetics_dict
	
	$ItemBox/Title.text = cosmetic[id]["name"]
	$ItemBox/ItemTexture.texture = load(cosmetic[id]["texture"])
	$ItemBox/Amount.text = "x" + str(cosmetic[id]["cost"])
