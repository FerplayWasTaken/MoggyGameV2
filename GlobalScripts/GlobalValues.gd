extends Node


var golden_bananas_amount = 999

var last_checkpoint_position_cross = "Origin"

var game_has_started = false

var bananas_dictionary_save = {}
var checkpoint_dictionary_save = {}

var sound_manager_config = {
	"SFX": .5,
	"Music" : .5,
	"Master" : .5
}

func reset_sound_default():
	sound_manager_config = {
		"SFX": .5,
		"Music" : .5,
		"Master" : .5
	}
