extends Node2D


var rng = RandomNumberGenerator.new()

var sound_effects_stream_list = {
	"game_over_smack" : "res://Audio/SoundEffects/UISoundEffects/punch_sound_effect.wav",
	"moggy_jump": ["res://Audio/SoundEffects/MoggySoundEffects/Macaco3 (online-audio-converter.com).wav","res://Audio/SoundEffects/MoggySoundEffects/Macaco4 (online-audio-converter.com).wav"],
	"bounce_sound_effect": "res://Audio/SoundEffects/CartoonSoundEffects/cartoon sound effects pack (HD) - the sounds your mom makes (youtube)-3.wav",
	"select_sound_effect" : "res://Audio/SoundEffects/CartoonSoundEffects/cartoon sound effects pack (HD) - the sounds your mom makes (youtube)-4.wav",
	"lost_aura_sound_effect" : "res://Audio/SoundEffects/CartoonSoundEffects/cartoon sound effects pack (HD) - the sounds your mom makes (youtube).wav",
	"checkpoint_sound" : "res://Audio/SoundEffects/CartoonSoundEffects/cartoon sound effects pack (HD) - the sounds your mom makes (youtube)-5.wav"
}
	

func play_sound(audio_name):
	if sound_effects_stream_list.has(audio_name):
		var audio = AudioStreamPlayer.new()
		add_child(audio)
		audio.stream = load(sound_effects_stream_list[audio_name])
		audio.play()
		
		print("TOCOU ÁUDIO")		
	else:
		print("esse efeito sonoro n existe!")	


func play_random_sound_effect_audio_random_pitch(audio_name, volume_db):
	rng.randomize()
	
	var audio = AudioStreamPlayer.new()
	add_child(audio)
	audio.stream = load(sound_effects_stream_list[audio_name][rng.randf_range(0, (sound_effects_stream_list[audio_name]).size())])
	audio.volume_db = volume_db
	
	var random_pitch = rng.randf_range(.8, 1.2)
	
	audio.set_pitch_scale(random_pitch) 
	
	audio.play()
