extends Area2D


signal vector_created(vector)

signal is_holding_vector

export var max_length = 25

var touch_down = false
var position_start = Vector2.ZERO
var position_end = Vector2.ZERO

var vector = Vector2.ZERO

func _ready():
	connect("input_event", self, "_on_input_event")


#apenas para visualizar o vetor
func _draw():
	draw_line(position_start - global_position, (position_end - global_position), Color.blue, 8)		
		
	draw_line(position_start - global_position, position_start - global_position + vector, Color.red, 8)			


func _reset():
	position_start = Vector2.ZERO
	position_end = Vector2.ZERO
	vector = Vector2.ZERO
	
	update()

func _input(event):
	if not touch_down:
		return
		
	if event.is_action_released("ui_touch"):
		touch_down = false
		emit_signal("vector_created", vector)	
		_reset()
		
		
	if event is InputEventMouseMotion:
		position_end = event.position
		
		vector = -(position_end - position_start).clamped(max_length)	
	
		emit_signal("is_holding_vector")
	
		update()
	
func _on_input_event(_viewport, event, _shape_idx):
	
	if Input.is_action_pressed("ui_touch"):
		touch_down = true
		
		position_start = event.position
		
		
