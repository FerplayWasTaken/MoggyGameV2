extends CanvasLayer

var has_started_game = false

signal start_game


func start_game():
	$AnimationPlayer.play("START")

func _on_Button_pressed():
	if !has_started_game:
		$AnimationPlayer.play("start_game")	
			
		has_started_game = true
		
		emit_signal("start_game")

func _on_Button2_pressed():
	pass

