extends Area2D


signal vector_created(vector)

signal is_holding_vector

export var max_length = 25

var touch_down = false
var position_start = Vector2.ZERO
var position_end = Vector2.ZERO

var vector = Vector2.ZERO

onready var moggy = get_tree().get_current_scene().get_node("Moggy")

var can_touch_screen = false

func _ready():
	connect("input_event", self, "_on_input_event")

func _process(_delta):
	manage_jump_arrow_direction()
#	global_position = moggy.global_position

#apenas para visualizar o vetor
func _draw():
	draw_line(position_start - global_position, (position_end - global_position), Color(1,1,1,0.3), 4)		
#	draw_line(position_end - global_position, (position_start - global_position), Color(1,1,1,0.3), 4)		
	draw_line(position_start - global_position, position_start - global_position + vector, Color(1,1,1,0.3), 4)			


func _reset():
	position_start = Vector2.ZERO
	position_end = Vector2.ZERO
	vector = Vector2.ZERO
	
	update()

func _input(event):
	if can_touch_screen:
	
		if not touch_down:
			return
			
		if event.is_action_released("ui_touch"):
			touch_down = false
			emit_signal("vector_created", vector)	
			_reset()
			
			
		if event is InputEventMouseMotion:
			position_end = event.position
			
			vector = -(position_end - position_start).clamped(max_length)	
		
			update()
			
			$JumpArrow.visible = true
	
func _on_input_event(_viewport, event, _shape_idx):
	if can_touch_screen:
	
		if Input.is_action_pressed("ui_touch"):
			touch_down = true
			
			position_start = event.position
			
			emit_signal("is_holding_vector")
			
		else:
			$JumpArrow.visible = false	
		
func manage_jump_arrow_direction():
	$JumpArrow.look_at(get_global_mouse_position())

	$JumpArrow.position = position_start - global_position + vector
#	$JumpArrow.scale.x = 0.05 * abs((position_start - position_end).x)
