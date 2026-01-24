extends Node2D


var music_has_started = false

func start_music():
	music_has_started = true
	
func stop_music():
	music_has_started = false	
	
	$AudioStreamPlayer.stop()
	
func _process(delta):
	if music_has_started:
		if !$AudioStreamPlayer.playing:
			$AudioStreamPlayer.play()	
