extends RigidBody2D

onready var moggy = get_tree().get_current_scene().get_node("Moggy")

func _ready():
	yield(get_tree().create_timer(.5),"timeout")
	
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func tp_moggy():
	moggy.global_position = global_position

func launch(force):
	apply_impulse(Vector2.ZERO, force)


func _on_Area2D_body_entered(body):
	if body.name == "TileMap":
		tp_moggy()
		
		queue_free()
