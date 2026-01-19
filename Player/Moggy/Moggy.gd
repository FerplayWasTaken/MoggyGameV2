extends RigidBody2D

var motion = Vector2()
var speed = 50


var JUMP_HEIGHT = -300
const gravity = 10

var is_holding_vector = false

var respawn_position = Vector2()
var check_can_respawn = true

export var bounce_force = 50



func _ready():
	$AnimationPlayer.play("IDLE")

func _process(delta):
	if is_holding_vector:
		
		if $RayCast2D.is_colliding():
			$AnimationPlayer.play("IDLE")
			
			rotate_to_zero($AnimatedSprite)
			
			
			
#	$AnimatedSprite.rotation_degrees = -rotation_degrees
	$RayCast2D.rotation_degrees = -rotation_degrees
	$CheckgroundRaycasts.rotation_degrees = -rotation_degrees


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
		change_player_sprite(vector)
		
		is_holding_vector = false
		
		$AnimationPlayer.play("JUMP")
		
		yield(get_tree().create_timer(.2),"timeout")
		
		is_holding_vector = true

func change_player_sprite(vector):
	var vector_direction = vector.x
	
	if vector_direction > 0:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true	

func _on_VectorArea_is_holding_vector():
	is_holding_vector = true
	

func _on_Area2D_body_entered(body):
	if body.name == "WaterTile":
		print("water!")
		
		respawn_last_position()

		

func respawn_last_position():
	z_index = -1
	set_mode(1) 
	yield(get_tree().create_timer(.25),"timeout")
	global_position = respawn_position
	
	angular_velocity = 0
	rotation_degrees = 0
	set_mode(0) 
	z_index = 1
	
func set_respawn(checkpoint_pos):
	respawn_position = checkpoint_pos	
		
		
func rotate_to_zero(node_target):
	var tween = $Tween

	tween.interpolate_property(node_target, "rotation_degrees", -rotation_degrees, 0 , .5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	

func bounce_effect(area, direction):
	var impact_speed = abs(linear_velocity.y)
	var bounce = clamp(impact_speed * 1.2, 150, 500)

	linear_velocity.y = 0
	apply_impulse(Vector2.ZERO, Vector2(direction * impact_speed , -bounce))

