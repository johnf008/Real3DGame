extends RigidBody3D

var speed = randf_range(2.0, 4.0)

@onready var bat_model: Node3D = %bat_model

@onready var player = get_node("/root/Game/Player")

@onready var eye_location = Vector3(0, %Camera3D.global_position[1], 0)

func _physics_process(delta): 
	print("Camera location test" + str())
	var target = player.global_position + eye_location
	var direction = global_position.direction_to(player.global_position)
	
	#print("Should be player global pos y" + str(player.global_position[1]))
	
	if player.global_position[1] < bat_model.global_position[1]:
		direction.y -= -0.001
	else:
		direction.y = 0
		print("The direction of y is zero")
		
	linear_velocity = direction * speed
	bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + PI
	
func take_damage():
	bat_model.hurt()
