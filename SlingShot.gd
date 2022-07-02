extends Node2D

onready var left_line:Line2D = $LeftLine
onready var right_line:Line2D = $RightLine
onready var center_of_slingshot:Position2D = $CenterOfSlinghot

var throwable_body:RigidBody2D
var can_grab: bool = false
var can_launch: bool = false
var is_equiped: bool = false

func _ready():
	reset_slingshot()

func reset_slingshot():
	left_line.points[1] = right_line.points[0]
	right_line.points[1] = left_line.points[0]

func _input(event):
	if event is InputEventScreenTouch:
		var evt = event as InputEventScreenTouch
		if !evt.is_pressed():
			can_grab = false

func _process(delta):	
	if can_grab:
		can_launch = true
		var mouse_position: Vector2 = get_local_mouse_position()	
		left_line.points[1] = mouse_position
		
		left_line.points[1].x = clamp(left_line.points[1].x, -100, 75)
		left_line.points[1].y = clamp(left_line.points[1].y, -75, 75)
		
		right_line.points[1] = left_line.points[1]

		if is_instance_valid(throwable_body):		
			throwable_body.global_position = left_line.global_position - Vector2(-20, 10) + (left_line.points[1])
	else:
		if can_launch:
			throw_body()			

func throw_body():
	throwable_body.mode = RigidBody2D.MODE_RIGID
	throwable_body.apply_central_impulse(-left_line.points[1] * 5)
	can_launch = false
	can_grab = false
	is_equiped = false
	reset_slingshot()
	
	
func equip(body:RigidBody2D):
	body.mode = RigidBody2D.MODE_KINEMATIC
	throwable_body = body	
	is_equiped = true
	throwable_body.global_position = center_of_slingshot.global_position
	throwable_body.global_position = center_of_slingshot.global_position
	
	
func _on_GrabArea_input_event(viewport, event, shape_idx):
	if is_equiped:
		if event is InputEventScreenTouch:
			var evt = event as InputEventScreenTouch
			can_grab = evt.is_pressed()

