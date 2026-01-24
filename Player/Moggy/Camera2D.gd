extends Camera2D

onready var shakeTimer = $Timer
onready var tween = $Tween

var shake_bug = false
var shake_amount = 0
var default_offset = offset

func _ready():
	set_process(false)
	
	yield(get_tree().create_timer(1),"timeout")
	set_smoothing_camera(true)
	
	
	
func set_smoothing_camera(command):
	smoothing_enabled = command
	limit_smoothed = command
	
func _process(delta):
	offset = Vector2(rand_range(-shake_amount, shake_amount), rand_range(shake_amount, -shake_amount)) * delta + default_offset
	

func shake(new_shake, shake_time, shake_limit):
	shake_bug = true
	shake_amount += new_shake
	if shake_amount > shake_limit:
		shake_amount = shake_limit
		
	shakeTimer.wait_time = shake_time
	
	tween.stop_all()
	set_process(true)		
	shakeTimer.start()
	
func zoom_out_camera():
	tween.remove(self, "zoom")

	var current_zoom = zoom

	tween.interpolate_property(
		self,
		"zoom",
		current_zoom,
		Vector2(1.7, 1.7),
		1.0,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)
	tween.start()


	
	
func zoom_in_camera():
	tween.remove(self, "zoom")

	var current_zoom = zoom

	tween.interpolate_property(
		self,
		"zoom",
		current_zoom,
		Vector2(1.5, 1.5),
		0.5,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)
	tween.start()


func _on_Timer_timeout():
	if shake_bug:
		shake_amount = 0
		set_process(false)
		tween.interpolate_property(self, "offset", offset, default_offset, 0.1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		tween.start()
		shake_bug = false
