extends Area2D

#Limit Area Node
onready var limit_area_node = get_parent()
var limit_area_default_setting = 0

#Camera Limits
export var right_limit = 0
export var left_limit = 0
export var up_limit = 0
export var down_limit = 0

var delta_is_in_area = false

func _ready():
	$CollisionPolygon2D.disabled = true
	yield(get_tree().create_timer(.2),"timeout")
	$CollisionPolygon2D.disabled = false


func check_if_limit_has_been_changed():
	if right_limit == 0:
		right_limit = limit_area_node.default_camera_settings[2]
	if left_limit == 0:
		left_limit = limit_area_node.default_camera_settings[0]
	if up_limit == 0:
		up_limit = limit_area_node.default_camera_settings[1]
	if down_limit == 0:
		down_limit = limit_area_node.default_camera_settings[3]
		
func fix_interpolating_area_limit_detection(command):
	for area in get_parent().get_children():
		if area != self:
			if command == "has_entered":
				area.get_node("CollisionPolygon2D").call_deferred("disabled", true)
				area.visible = false	
			if command == "has_exited":
				area.get_node("CollisionPolygon2D").call_deferred("disabled", false)
				area.visible = true
				
func check_if_delt_is_in_area():
	for area in get_parent().get_children():
		if area.delta_is_in_area and area != self:
			return true
	return false		


func _on_LimitArea_body_entered(body):
	if body.name == "Moggy":
		check_if_limit_has_been_changed()		
		limit_area_default_setting = limit_area_node.default_camera_settings
		limit_area_node.set_new_limit_settings([left_limit, up_limit, right_limit, down_limit])
		
		fix_interpolating_area_limit_detection("has_entered")
		
		delta_is_in_area = true


func _on_LimitArea_body_exited(body):
	if body.name == "Moggy":
		fix_interpolating_area_limit_detection("has_exited")
		
		delta_is_in_area = false
		
#		yield(get_tree().create_timer(.2), "timeout")
		if !check_if_delt_is_in_area():
			limit_area_node.set_new_limit_settings(limit_area_default_setting)

