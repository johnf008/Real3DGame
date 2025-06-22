extends CharacterBody3D

var max_jumps = 2

#Basically runs when the scene is run
func _ready(): 
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x / 2
		%Camera3D.rotation_degrees.x -= event.relative.y / 2
		%Camera3D.rotation_degrees.x = clamp(
			%Camera3D.rotation_degrees.x, -80, 80
		)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 

func _physics_process(delta):
	const SPEED = 5.5
	
	var input_direction_2D = Input.get_vector(
		"move_left", "move_right", "move_forward", "move_back"
	)
	var input_direction_3D = Vector3(
		input_direction_2D.x, 0.0, input_direction_2D.y
	)
	var direction = transform.basis * input_direction_3D
	
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	velocity.y -= 20.0 * delta
	if Input.is_action_just_pressed("jump") && max_jumps > 0:
		velocity.y = 10.0
		max_jumps -= 1
	elif Input.is_action_just_released("jump") and velocity.y > 0.0 and max_jumps > 0:
		velocity.y = 0.0
		max_jumps -= 1
	else:
		pass
	
	if is_on_floor():
		max_jumps = 2
	
		
	move_and_slide()
