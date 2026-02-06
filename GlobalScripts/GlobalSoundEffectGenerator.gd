extends Node2D


var rng = RandomNumberGenerator.new()

var sound_effects_stream_list = {
	"game_over_smack" : "res://Audio/SoundEffects/UISoundEffects/punch_sound_effect.wav",
	"moggy_jump": ["res://Audio/SoundEffects/MoggySoundEffects/Macaco3 (online-audio-converter.com).wav","res://Audio/SoundEffects/MoggySoundEffects/Macaco4 (online-audio-converter.com).wav"],
	"bounce_sound_effect": "res://Audio/SoundEffects/CartoonSoundEffects/cartoon sound effects pack (HD) - the sounds your mom makes (youtube)-3.wav",
	"select_sound_effect" : "res://Audio/SoundEffects/CartoonSoundEffects/selection_sound_effect.wav",
	"lost_aura_sound_effect" : "res://Audio/SoundEffects/CartoonSoundEffects/cartoon sound effects pack (HD) - the sounds your mom makes (youtube).wav",
	"checkpoint_sound" : "res://Audio/SoundEffects/CartoonSoundEffects/cartoon sound effects pack (HD) - the sounds your mom makes (youtube)-6.wav",
	"toilet_flush" : "res://Audio/SoundEffects/CartoonSoundEffects/skibidi toilet flush sound effect #skibiditoilet - king bob (youtube).wav",
	"buy_item_sound_effect" : "res://Audio/SoundEffects/CartoonSoundEffects/cartoon sound effects pack (HD) - the sounds your mom makes (youtube)-4.wav",
	"banana_collected_sound_effect" : "res://Audio/SoundEffects/CartoonSoundEffects/banana_sound_effect.wav",
	"error_sound_effect" : "res://Audio/SoundEffects/CartoonSoundEffects/error_sound_effect.wav",
	"squeeky_duck" : "res://Audio/SoundEffects/CartoonSoundEffects/squaky_duck.wav"
}
	

func play_sound(audio_name):
	if sound_effects_stream_list.has(audio_name):
		var audio = AudioStreamPlayer.new()
		add_child(audio)
		
#		audio.volume_db = -80 #mutar a porra desse jogo
		
		audio.stream = load(sound_effects_stream_list[audio_name])
		
		audio.add_to_group("sfx")
		audio.bus = "SFX"
		audio.play()
		
#		print("TOCOU ÁUDIO")		
	else:
		print("esse efeito sonoro n existe!")	


func play_random_sound_effect_audio_random_pitch(audio_name, volume_db):
	rng.randomize()
	
	var audio = AudioStreamPlayer.new()
	add_child(audio)
	audio.stream = load(sound_effects_stream_list[audio_name][rng.randf_range(0, (sound_effects_stream_list[audio_name]).size())])
	audio.volume_db = volume_db
	audio.add_to_group("sfx")
	audio.bus = "SFX"
	
#	audio.volume_db = -80 #mutar a porra desse jogo
	
	var random_pitch = rng.randf_range(.8, 1.2)
	
	audio.set_pitch_scale(random_pitch) 
	
	audio.play()
	
func cancel_current_sound_effect():
	get_tree().call_group("sfx", "queue_free")
