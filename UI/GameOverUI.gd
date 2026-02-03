extends CanvasLayer

var is_in_game_over_menu = false


func start_game_over_menu():
	$AnimationPlayer.play("START")	
	
	is_in_game_over_menu = true
	
	yield(get_tree().create_timer(.1),"timeout")
	GlobalSoundEffectGenerator.play_sound("game_over_smack")

func _on_Button_pressed():
	if is_in_game_over_menu:
		get_parent().cancel_all_sound_effects()
		
		get_tree().change_scene("res://World/ForestWorld/ForestWorld.tscn")


func _on_Button2_pressed():
	if is_in_game_over_menu:
		$AnimationPlayer.play("SWITCH_SHOP")


func _on_TouchScreenButton3_pressed():
	if is_in_game_over_menu:	
		GlobalValues.game_has_started = false
		get_tree().change_scene("res://World/ForestWorld/ForestWorld.tscn")
		
