extends CPUParticles2D

export var x_direction = .5

func _on_Area2D_body_entered(body):
	if body.name == "Moggy":
		body.fan_effect($Area2D, x_direction)

