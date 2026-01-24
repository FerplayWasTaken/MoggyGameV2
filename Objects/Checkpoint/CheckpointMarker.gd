extends Node2D



func get_checkpoint_index():
	var index = 0
	
	for cross in get_parent().get_children():
		
		if cross == self:
			return index
		
		index += 1

func _on_Area2D_body_entered(body):
	if body.name == "Moggy":
		body.set_respawn(global_position)
		
		if GlobalValues.last_checkpoint_position_cross != get_checkpoint_index():
			$AnimationPlayer.play("checkpoint")
			
			GlobalSoundEffectGenerator.play_sound("checkpoint_sound")
		
		GlobalValues.last_checkpoint_position_cross = get_checkpoint_index()
	
		

		
		
