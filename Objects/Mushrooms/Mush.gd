extends Node2D

export var direction = 1


func _on_Area2D_body_entered(body):
	if body.name == "Moggy":
		GlobalSoundEffectGenerator.play_sound("bounce_sound_effect")
		
		$AnimationPlayer.play("bounce")
		
		body.bounce_effect_mush($Area2D, direction)
