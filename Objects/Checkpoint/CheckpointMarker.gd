extends Node2D


var checkpoint_id = ""
var already_respawned = false

func _ready():
	checkpoint_id = self.name
	

func save_checkpoint():
	GlobalValues.last_checkpoint_position_cross = checkpoint_id

	SaveSystem.save_game()

func _on_Area2D_body_entered(body):
	if body.name == "Moggy":
		print("checkpoint in: ", checkpoint_id)
		
		GlobalValues.last_checkpoint_position_cross = checkpoint_id
		SaveSystem.save_game()
		
		body.set_respawn(global_position)
		
		if !already_respawned:
			$AnimationPlayer.play("checkpoint")
			
			GlobalSoundEffectGenerator.play_sound("checkpoint_sound")

		
