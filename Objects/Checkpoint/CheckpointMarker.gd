extends Node2D



func _on_Area2D_body_entered(body):
	if body.name == "Moggy":
		body.set_respawn(global_position)
