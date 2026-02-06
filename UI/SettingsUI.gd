extends Node2D

var master_bus = AudioServer.get_bus_index("Master")
var sfx_bus = AudioServer.get_bus_index("SFX")
var music_bus = AudioServer.get_bus_index("Music")

func _ready():
	load_volume_settings()


func _on_TouchScreenButton_pressed():
	get_parent().back_to_menu("settings")


func load_volume_settings():
	$VolumeSliders/Master.value = GlobalValues.sound_manager_config["Master"]
	$VolumeSliders/Stx.value = GlobalValues.sound_manager_config["SFX"]
	$VolumeSliders/Music.value = GlobalValues.sound_manager_config["Music"]

func save_volume_settings():
	GlobalValues.sound_manager_config["Master"] = $VolumeSliders/Master.value
	GlobalValues.sound_manager_config["SFX"] = $VolumeSliders/Stx.value  
	GlobalValues.sound_manager_config["Music"] = $VolumeSliders/Music.value 

	SaveSystem.save_game()

func _on_Stx_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus, linear2db(value))
	AudioServer.set_bus_mute(sfx_bus, value < .05)
#	GlobalMenuInfo.current_game_settings["SFX"] = value

	save_volume_settings()

func _on_Music_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, linear2db(value))
	AudioServer.set_bus_mute(music_bus, value < .05)
#	GlobalMenuInfo.current_game_settings["Music"] = value

	save_volume_settings()
	
func _on_Master_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, linear2db(value))
	AudioServer.set_bus_mute(master_bus, value < .05)
#	GlobalMenuInfo.current_game_settings["Master"] = value
	
	save_volume_settings()
