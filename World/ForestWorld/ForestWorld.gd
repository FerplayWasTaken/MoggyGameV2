extends Node2D


func _ready():
	respawn_at_checkpoint()
	
	if !GlobalValues.game_has_started:
		$GameStartUI.start_game()
		
		GlobalValues.game_has_started = true
		$GameUI.can_pause_game = false
	
	
	else:
		$AnimationPlayer.play("start_game")
		$AnimationPlayer.seek(1)
		
		$GameStartUI.retry_game()
		
		$VectorAreaView/VectorArea.can_touch_screen = true

		$MuiscManager.start_music()

		$GameUI.can_pause_game = true

func _process(delta):
	if Input.is_action_just_pressed("back"):
		get_tree().change_scene("res://World/ForestWorld/ForestWorld.tscn")
			

func _on_Moggy_has_died():
	$MuiscManager.stop_music()
	
	$GameOverUI.start_game_over_menu()

func respawn_moggy():
	$Moggy.respawn_last_position()
	
func respawn_at_checkpoint():
	var checkpoint_cross = $Checkpoints.get_child(GlobalValues.last_checkpoint_position_cross)	

	$Moggy.global_position = checkpoint_cross.global_position

func cancel_all_sound_effects():
	$GlobalSoundEffectGenerator.cancel_current_sound_effect()

func _on_GameStartUI_start_game():
	$AnimationPlayer.play("start_game")
	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "start_game":
		$VectorAreaView/VectorArea.can_touch_screen = true

		$MuiscManager.start_music()
		
		$GameUI.can_pause_game = true


func _on_ToiletArea_body_entered(body):
	if body.name == "Moggy":
		get_tree().change_scene("res://UI/GameFinale.tscn")
