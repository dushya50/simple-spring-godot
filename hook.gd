extends Sprite

onready var spring = $spring
#onready var hook = $hook
onready var ball = $ball
var ball_position = Vector2()
var ball_velocity = 0
var ball_acceleration = 0 
var spring_length_initial = 1
var spring_length = 1
var spring_constant = 100
var mass = 1
var dragging = false
var auxiliary_vec = Vector2()


func _ready():
	ball_position = ball.position
	spring_length_initial = ball_position.length()
	spring_length = spring_length_initial


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#print(dragging)
	if dragging and Input.is_action_pressed("left_mouse"):
		look_at(get_global_mouse_position())
		ball.position = get_local_mouse_position()
		spring.scale.x = (ball.position.length()+0.000001)*spring.scale.x/spring_length
		spring_length = ball.position.length()+0.000001
		ball_acceleration = 0
		ball_velocity = 0
		
	elif not dragging:
		ball.position.x += ball_velocity*delta
		ball_acceleration = -spring_constant*(ball.position.x - spring_length_initial)/mass
		ball_velocity += ball_acceleration*delta
		spring.scale.x = (ball.position.length()+0.000001)*abs(spring.scale.x)/spring_length
		spring_length = ball.position.length()+0.000001 
		if ball.position.x<0 and ball_velocity < 0:
			ball.position.x = 0.1 
			ball_velocity = - abs(ball_velocity)


func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("left_mouse"):
		dragging = true 
	else:
		dragging = false
