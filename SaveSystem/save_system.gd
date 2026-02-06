extends Node

const SAVE_PATH = "user://save.dat"

func save_game():
	var save_data = {
		"checkpoint_id": GlobalValues.last_checkpoint_position_cross,
		"banana_amount": GlobalValues.golden_bananas_amount,
		"item_stats": GlobalShopInventory.items_dict,
		"current_skin" : GlobalShopInventory.current_animation_skin,
		"sound_settings" : GlobalValues.sound_manager_config
	}
	
	var file = File.new()
	var err = file.open(SAVE_PATH, File.WRITE)
	if err != OK:
		print("Erro ao salvar")
		return
	
	file.store_string(JSON.print(save_data))
	file.close()

	
func load_game():
	# estado inicial SEMPRE válido
	GlobalValues.last_checkpoint_position_cross = "Origin"
	GlobalValues.golden_bananas_amount = 0
	GlobalShopInventory.reset_to_default()
	GlobalShopInventory.current_animation_skin = "default_moggy"
	GlobalValues.reset_sound_default()
	
	var file = File.new()
	if not file.file_exists(SAVE_PATH):
		print("Nenhum save encontrado, usando defaults")
		return
	
	var err = file.open(SAVE_PATH, File.READ)
	if err != OK:
		print("Erro ao abrir save")
		return
	
	var content = file.get_as_text()
	file.close()
	
	var result = JSON.parse(content)
	if result.error != OK:
		print("Save corrompido, usando defaults")
		return
	
	var data = result.result
	
	GlobalValues.last_checkpoint_position_cross = data.get(
		"checkpoint_id",
		GlobalValues.last_checkpoint_position_cross
	)
	
	GlobalValues.golden_bananas_amount = data.get(
		"banana_amount",
		GlobalValues.golden_bananas_amount
	)
	
	if data.has("item_stats"):
#		print("items data: ", data["item_stats"])
		
		GlobalShopInventory.items_dict = data["item_stats"]

	GlobalShopInventory.current_animation_skin = data.get(
		"current_skin",
		GlobalShopInventory.current_animation_skin
	)
	
	GlobalValues.sound_manager_config = data.get(
		"sound_settings",
		GlobalValues.sound_manager_config
	)
