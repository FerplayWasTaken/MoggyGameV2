extends Node2D

export var direction = 0.5


func _on_Area2D_body_entered(body):
	if body.name == "Moggy":
		$AnimationPlayer.play("bounce")
		
		body.bounce_effect_duck($Area2D, direction)

		$GlobalSoundEffectGenerator.play_sound("squeeky_duck")
