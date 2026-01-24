extends Node2D


func _ready():
	respawn_at_checkpoint()
	
	if !GlobalValues.game_has_started:
		$GameStartUI.start_game()
		
		GlobalValues.game_has_started = true
	
	else:
		$AnimationPlayer.play("start_game")
		$AnimationPlayer.seek(1)
		
		$VectorAreaView/VectorArea.can_touch_screen = true

		$MuiscManager.start_music()

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


func _on_GameStartUI_start_game():
	$AnimationPlayer.play("start_game")
	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "start_game":
		$VectorAreaView/VectorArea.can_touch_screen = true

		$MuiscManager.start_music()
