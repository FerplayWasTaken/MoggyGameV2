extends Node2D


onready var moggy_camera = get_parent().get_node("Moggy/Camera2D")

var default_camera_settings = null

func _ready():
	default_camera_settings = [moggy_camera.limit_left, moggy_camera.limit_top, moggy_camera.limit_right, moggy_camera.limit_bottom]
	
func set_new_limit_settings(new_limit):
	moggy_camera.limit_left = new_limit[0]
	moggy_camera.limit_top = new_limit[1]
	moggy_camera.limit_right = new_limit[2]
	moggy_camera.limit_bottom = new_limit[3]
	
