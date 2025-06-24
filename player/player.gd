extends CharacterBody3D

signal update_score

var max_jumps = 2
var og_camera
var og_rotation

var stamina = 15.00 
const STAMINA_CHANGE = 0.1

var sprint_check = false

#Basically runs when the scene is run
func _ready(): 
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	og_camera = %Camera3D.rotation_degrees
	og_rotation = rotation_degrees
	
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
	var SPEED = 5.5
	
	#print(str(global_transform.origin.y))
	var sprint_adjust = 2
	if (Input.is_action_pressed("sprint") and stamina > 0):
		SPEED *= sprint_adjust
		stamina -= STAMINA_CHANGE
		sprint_check = true
	else:
		sprint_check = false
		
	if stamina < 15 and !Input.is_action_pressed("sprint"):
		stamina += STAMINA_CHANGE
	#print("Stamina: " + str(stamina) + " Sprinting: " + str(sprint_check))
	
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
	
	if Input.is_action_pressed("shoot") and %Timer.is_stopped():
		shoot_bullet()
	
	#print(str(%Camera3D.rotation_degrees.x) + " " + str(%Camera3D.rotation_degrees.y) + " " + str(%Camera3D.rotation_degrees.z))
	if global_transform.origin.y < -20.0:
		global_transform.origin.x = 0.0
		global_transform.origin.y = -0.06333388388157
		global_transform.origin.z = 0.0
		
		rotation_degrees = og_rotation
		%Camera3D.rotation_degrees = og_camera
		
		AmountOfEnemies.bats_died -= 3 #Cheap way to update score once the player falls (ik it's bad to whoever is reading this ;-;
		update_score.emit()
	
		


func shoot_bullet():
	const BULLET_3D = preload("res://player/bullet_3d.tscn")
	var new_bullet = BULLET_3D.instantiate()
	%Marker3D.add_child(new_bullet)
	
	new_bullet.global_transform = %Marker3D.global_transform
	
	%Timer.start()


		
