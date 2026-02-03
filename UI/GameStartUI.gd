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

func back_to_menu():
	if !has_started_game:
		$AnimationPlayer.play_backwards("SETTINGS")	

func title_smack_sound():
	$GlobalSoundEffectGenerator.play_sound("game_over_smack")
