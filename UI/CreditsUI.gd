extends Node2D

func _ready():
	$AnimationPlayer.play("RESET")

func _on_TouchScreenButton_pressed():
	get_parent().back_to_menu("credits")



func _on_LinkButton_pressed():
	OS.shell_open("https://linktr.ee/ZeeskiGames")
