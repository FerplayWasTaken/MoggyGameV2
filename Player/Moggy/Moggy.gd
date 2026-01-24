extends RigidBody2D

var motion = Vector2()
var speed = 50


var JUMP_HEIGHT = -300
const gravity = 10

var is_holding_vector = false

var respawn_position = Vector2()
var check_can_respawn = true

export var bounce_force = 50

var is_dead = false
signal has_died

var is_holding_moggy = false

#camera acess
onready var camera_node = get_node("Camera2D")

func _ready():
	$AnimationPlayer.play("IDLE")

func _process(delta):
	
	if !is_dead:
		if is_holding_vector:
			
			if $RayCast2D.is_colliding():
				if !is_holding_moggy:
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
		camera_node.zoom_in_camera()
		
		GlobalSoundEffectGenerator.play_random_sound_effect_audio_random_pitch("moggy_jump", 0)
		
		$AnimationPlayer.play("JUMP")
		
		yield(get_tree().create_timer(.2),"timeout")
		
		is_holding_vector = true
		is_holding_moggy = false

func change_player_sprite(vector):
	var vector_direction = vector.x
	
	if vector_direction > 0:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true	

func _on_VectorArea_is_holding_vector():
	if $RayCast2D.is_colliding():
		is_holding_vector = true
		
		if !is_holding_moggy:
	#		shake_chamera()
			camera_node.zoom_out_camera()
			
			$AnimationPlayer.stop()
		
			$AnimationPlayer.play("HOLD_JUMP")
			
			is_holding_moggy = true
	

func _on_Area2D_body_entered(body):
	if body.name == "WaterTile":
		death_function()

func death_function():
	GlobalSoundEffectGenerator.play_sound("lost_aura_sound_effect")
	
	is_dead = true
	
	z_index = -1
	$AnimationPlayer.play("DEATH")
	
	sleeping = true
	shake_chamera()
	yield(get_tree().create_timer(.2),"timeout")
	
	sleeping = false
	apply_impulse(Vector2.ZERO, Vector2(0 , -100))
#	$CollisionPolygon2D.set_deferred("disabled", true)
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	
	lock_to_screen()
	yield(get_tree().create_timer(.5),"timeout")
	emit_signal("has_died")
	
	
func lock_to_screen():
	camera_node.set_smoothing_camera(false)
	var current_camera_position = global_position
	
	remove_child(camera_node)	
	
	get_tree().current_scene.add_child(camera_node)
	camera_node.global_position = current_camera_position

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
	
func shake_chamera():
	$Camera2D.shake(25, 0.2, 100)	
	

func bounce_effect_mush(area, direction):
	var impact_speed = abs(linear_velocity.y)
	

	var bounce = clamp(impact_speed * 1.5, 150, 500)

	linear_velocity.y = 0
	apply_impulse(Vector2.ZERO, Vector2(direction * impact_speed , -bounce))

func bounce_effect_duck(area, direction):
	var impact_speed = abs(linear_velocity.y)
	

	var bounce = clamp(impact_speed * .75, 75, 200)

	linear_velocity.y = 0
	apply_impulse(Vector2.ZERO, Vector2(direction * impact_speed , -bounce))

func fan_effect(area, direction):
	var impact_speed = abs(linear_velocity.y)
	

	var bounce = clamp(impact_speed * 1.2, 150, 200)

	linear_velocity.y = 0
	apply_impulse(Vector2.ZERO, Vector2(direction * impact_speed , -bounce))
