extends Node2D

func _ready():
	$AnimationPlayer.play("idle")

func _on_Area2D_body_entered(body):
	if body.name == "Moggy":
		queue_free()
