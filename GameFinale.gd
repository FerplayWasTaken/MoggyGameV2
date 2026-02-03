extends Node2D

func _ready():
	yield(get_tree().create_timer(1),"timeout")
	$GlobalSoundEffectGenerator.play_sound("toilet_flush")
	
	yield(get_tree().create_timer(5),"timeout")
	
	$Credits/AnimationPlayer.play("START_CREDITS")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "START_CREDITS":
		GlobalValues.game_has_started = false
		
		get_tree().change_scene("res://World/ForestWorld/ForestWorld.tscn")
