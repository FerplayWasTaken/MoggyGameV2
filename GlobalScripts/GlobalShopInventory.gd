extends Node


var current_power_list = []

var current_power_up = ""
var available_power_up = ""

var current_animation_skin = "default_moggy"


var items_dict = {
#	"respawn_power_up" : {
#		"name" : "Respawn",
#		"description" : "Respawn last position",
#		"texture" : "res://Items/Powerups/golden_apple.png",
#		"cost" : 5,
#		"type" : "powerup"
#	},
#	"force_power_up" : {
#		"name" : "Bomba",
#		"description" : "Te dá força",
#		"texture" : "res://Items/Powerups/mango.png",
#		"cost" : 10,
#		"type" : "powerup"
#	},
#	"double_air_jump_power_up" : {
#		"name" : "Dead Eye",
#		"description" : "Segundo pulo no ar!",
#		"texture" : "res://Items/Powerups/charons_coins.png",
#		"cost" : 15,
#		"type" : "powerup"	
#	},
	"banana_moggy": {
		"name": "Banana Hat",
		"description": "THE Banana Hat. Or… the Magic Man Hat?",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-13.png.png",
		"cost": 30,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyBanana.tres",
		"type": "cosmetic"
	},

	"barbie_moggy": {
		"name": "Pink Glasses",
		"description": "Pink glasses. *Moggy blushes*",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-7.png.png",
		"cost": 50,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyBarbie.tres",
		"type": "cosmetic"
	},

	"black_moggy": {
		"name": "Black Glasses",
		"description": "Cool glasses. Make Moggy look cool. Unlike this game.",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-12.png.png",
		"cost": 20,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyBlack.tres",
		"type": "cosmetic"
	},

	"cat_moggy": {
		"name": "Cat Hat",
		"description": "The Cat in the Hat knows a lot about that.",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-2.png.png",
		"cost": 50,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyCartola.tres",
		"type": "cosmetic"
	},

	"chrismas_moggy": {
		"name": "Christmas Hat",
		"description": "It’s Christmas!!!",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-3.png.png",
		"cost": 30,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyChrismas.tres",
		"type": "cosmetic"
	},

	"dream_moggy": {
		"name": "Dream Mask",
		"description": "Perfect for speedruns.",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-8.png.png",
		"cost": 100,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyDream.tres",
		"type": "cosmetic"
	},

	"gold_moggy": {
		"name": "Gold Glasses",
		"description": "Rare. Shiny. Questionably stylish.",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-9.png.png",
		"cost": 50,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyGold.tres",
		"type": "cosmetic"
	},

	"halloween_moggy": {
		"name": "Halloween Mask",
		"description": "Spooky skeletons everywhere!",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-4.png.png",
		"cost": 100,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyHalloween.tres",
		"type": "cosmetic"
	},

	"indiana_moggy": {
		"name": "Indiana Hat",
		"description": "It belongs in a museum!",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-5.png.png",
		"cost": 100,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyIndiana.tres",
		"type": "cosmetic"
	},

	"julliet_moggy": {
		"name": "Juliette Glasses",
		"description": "Only Brazilians will understand.",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-10.png.png",
		"cost": 20,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyJulliete.tres",
		"type": "cosmetic"
	},

	"sans_moggy": {
		"name": "Sans Mask",
		"description": "Wanna have a bad time?",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-6.png.png",
		"cost": 200,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggySans.tres",
		"type": "cosmetic"
	},

	"squid_moggy": {
		"name": "Squid Mask",
		"description": "We are NOT horses...",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-11.png.png",
		"cost": 200,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggySquid.tres",
		"type": "cosmetic"
	},

	"diamond_moggy": {
		"name": "Diamond Helmet",
		"description": "Creeper… aw man...",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-1.png.png",
		"cost": 200,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/moggy_diamond.tres",
		"type": "cosmetic"
	},

	"default_moggy": {
		"name": "Default",
		"description": "Nothing special. Absolutely default.",
		"texture": "res://Items/Cosmetics/cool_hat_inventory.png",
		"cost": 20,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyDefault.tres",
		"type": "cosmetic"
	}
}

func reset_to_default():
	items_dict = {
		"banana_moggy": {
		"name": "Banana Hat",
		"description": "THE Banana Hat. Or… the Magic Man Hat?",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-13.png.png",
		"cost": 30,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyBanana.tres",
		"type": "cosmetic"
		},

	"barbie_moggy": {
		"name": "Pink Glasses",
		"description": "Pink glasses. *Moggy blushes*",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-7.png.png",
		"cost": 50,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyBarbie.tres",
		"type": "cosmetic"
		},

	"black_moggy": {
		"name": "Black Glasses",
		"description": "Cool glasses. Make Moggy look cool. Unlike this game.",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-12.png.png",
		"cost": 20,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyBlack.tres",
		"type": "cosmetic"
		},

	"cat_moggy": {
		"name": "Cat Hat",
		"description": "The Cat in the Hat knows a lot about that.",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-2.png.png",
		"cost": 50,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyCartola.tres",
		"type": "cosmetic"
		},

	"chrismas_moggy": {
		"name": "Christmas Hat",
		"description": "It’s Christmas!!!",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-3.png.png",
		"cost": 30,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyChrismas.tres",
		"type": "cosmetic"
		},

	"dream_moggy": {
		"name": "Dream Mask",
		"description": "Perfect for speedruns.",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-8.png.png",
		"cost": 100,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyDream.tres",
		"type": "cosmetic"
		},

	"gold_moggy": {
		"name": "Gold Glasses",
		"description": "Rare. Shiny. Questionably stylish.",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-9.png.png",
		"cost": 50,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyGold.tres",
		"type": "cosmetic"
		},

	"halloween_moggy": {
		"name": "Halloween Mask",
		"description": "Spooky skeletons everywhere!",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-4.png.png",
		"cost": 100,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyHalloween.tres",
		"type": "cosmetic"
		},

	"indiana_moggy": {
		"name": "Indiana Hat",
		"description": "It belongs in a museum!",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-5.png.png",
		"cost": 100,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyIndiana.tres",
		"type": "cosmetic"
		},

	"julliet_moggy": {
		"name": "Juliette Glasses",
		"description": "Only Brazilians will understand.",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-10.png.png",
		"cost": 20,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyJulliete.tres",
		"type": "cosmetic"
		},

	"sans_moggy": {
		"name": "Sans Mask",
		"description": "Wanna have a bad time?",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-6.png.png",
		"cost": 200,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggySans.tres",
		"type": "cosmetic"
		},

	"squid_moggy": {
		"name": "Squid Mask",
		"description": "We are NOT horses...",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-11.png.png",
		"cost": 200,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggySquid.tres",
		"type": "cosmetic"
		},

	"diamond_moggy": {
		"name": "Diamond Helmet",
		"description": "Creeper… aw man...",
		"texture": "res://Player/Moggy/Assets/CosmeticIcons/MoggySkinsIcons-1.png.png",
		"cost": 200,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/moggy_diamond.tres",
		"type": "cosmetic"
		},

	"default_moggy": {
		"name": "Default",
		"description": "Nothing special. Absolutely default.",
		"texture": "res://Items/Cosmetics/cool_hat_inventory.png",
		"cost": 20,
		"sold": false,
		"skin_file": "res://Player/Moggy/Assets/Animations/MoggyDefault.tres",
		"type": "cosmetic"
		}	
	
	}		
	
	return items_dict
