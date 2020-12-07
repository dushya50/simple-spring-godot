extends Sprite


onready var spring = $spring
onready var ball = $ball 
var ball_velocity = 0 
var ball_acceleration = 0 
var spring_length_initial = 1
var spring_length = 1
var spring_constant = 10
var mass = 1
var dragging = false

func _ready():
	spring_length_initial = ball.position.length()
	spring_length = spring_length_initial


func _physics_process(delta):
	if dragging and Input.is_action_pressed("mouse_left"):
		look_at(get_global_mouse_position())
		ball.position = get_local_mouse_position()
		spring.scale.x = (ball.position.length()+0.000001)*spring.scale.x/(spring_length+0.000001)
		spring_length = ball.position.length()
		ball_acceleration = 0
		ball_velocity = 0 
	else:
		ball.position.x += ball_velocity*delta
		ball_acceleration = -spring_constant*(ball.position.length() - spring_length_initial)/mass
		ball_velocity += ball_acceleration*delta
		spring.scale.x = (ball.position.length()+0.000001)*spring.scale.x/(spring_length+0.000001)
		spring_length = ball.position.length()
		if ball.position.x < 0.1 and ball_velocity<0:
			ball.position.x = 0.1
			ball_velocity = - ball_velocity
		


func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("mouse_left"):
		dragging = true
	else:
		dragging = false
