extends CanvasLayer

var has_started_game = false

signal start_game


func start_game():
	$AnimationPlayer.play("START")
	
func retry_game():
	$AnimationPlayer.play("start_game")
	$AnimationPlayer.seek(1)	

func _on_Button_pressed():
	if !has_started_game:
		$AnimationPlayer.play("start_game")	
			
		has_started_game = true
		
		emit_signal("start_game")

func _on_Button2_pressed():
	if !has_started_game:
		$AnimationPlayer.play("SETTINGS")
	
		$SettingsUI.load_volume_settings()

func _on_TouchScreenButton3_pressed():
	if !has_started_game:
		$AnimationPlayer.play("CREDITS")
	

func back_to_menu(from_scene):
	if !has_started_game:
		match from_scene:
			"settings":
				$AnimationPlayer.play_backwards("SETTINGS")	
			"credits":
				$AnimationPlayer.play_backwards("CREDITS")

func title_smack_sound():
	$GlobalSoundEffectGenerator.play_sound("game_over_smack")




func _on_TouchScreenButton4_pressed():
	if !has_started_game:
		GlobalValues.last_checkpoint_position_cross = "Origin"
		
		SaveSystem.save_game()
		
		get_tree().change_scene("res://World/ForestWorld/ForestWorld.tscn")

	
