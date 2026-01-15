extends RigidBody2D

var motion = Vector2()
var speed = 50


var JUMP_HEIGHT = -300
const gravity = 10

var is_holding_vector = false

func _ready():
	$AnimationPlayer.play("IDLE")

func _process(delta):
	if is_holding_vector:
		
		if $RayCast2D.is_colliding():
			$AnimationPlayer.play("IDLE")
			
			rotate_to_zero($AnimatedSprite)
			
#	$AnimatedSprite.rotation_degrees = -rotation_degrees
	$RayCast2D.rotation_degrees = -rotation_degrees

func launch(force):
	apply_impulse(Vector2.ZERO, force)


func jump_funciton(direction):
	motion.y = JUMP_HEIGHT
		
	motion.x = speed * direction
	
	if direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true	
		
	

func _on_VectorArea_vector_created(vector):
	if $RayCast2D.is_colliding():
	
		launch(vector * 7.5)
		
		is_holding_vector = false
		
		$AnimationPlayer.play("JUMP")
		
		yield(get_tree().create_timer(.2),"timeout")
		
		is_holding_vector = true



func _on_VectorArea_is_holding_vector():
	is_holding_vector = true
	
#	$AnimationPlayer.play("HOLD_JUMP")


func _on_Area2D_body_entered(body):
	if body.name == "TileMap":
		pass
		
		
func rotate_to_zero(node_target):
	var tween = $Tween

	tween.interpolate_property(node_target, "rotation_degrees", -rotation_degrees, 0 , .5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	
	
