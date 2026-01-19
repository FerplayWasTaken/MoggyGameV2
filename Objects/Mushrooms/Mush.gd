extends Node2D

export var direction = 1

func _on_Area2D_body_entered(body):
	if body.name == "Moggy":
		$AnimationPlayer.play("bounce")
		
		body.bounce_effect($Area2D, direction)
