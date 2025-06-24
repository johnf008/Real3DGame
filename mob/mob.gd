extends RigidBody3D

signal mob_died()
var speed = randf_range(3.0, 9.0)
var health = 3
@onready var bat_model: Node3D = %bat_model
@onready var timer: Timer = %Timer

@onready var player = get_node("/root/Game/Player")

@onready var camera = get_node("/root/Game/Player/Camera3D")

@onready var label: Label = %Label

func _physics_process(delta):
	var eye_location = Vector3(0, camera.global_position.y, 0)
	 
	#print("Camera location test" + str(camera.global_position.y))
	
	var target = camera.global_position
	var direction = (target - global_position).normalized()
	
	#print("Should be player global pos y" + str(player.global_position[1]))
	
	"""
	if player.global_position[1] < bat_model.global_position[1]:
		direction.y -= -0.001
	else:
		direction.y = 0
		print("The direction of y is zero")
	"""
		
	linear_velocity = direction * speed
	bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + PI
	
	
func take_damage():
	if health == 0: 
		return
	bat_model.hurt()
	
	health -= 1
	
	if health == 0:
		set_physics_process(false)
		gravity_scale = 1.0
		var direction = -1.0 * global_position.direction_to(player.global_position)
		var random_upward_force = Vector3.UP * randf_range(1.0, 5.0)
		apply_central_impulse(direction * 10.0 + random_upward_force)
		timer.start()
		
		lock_rotation = false
		AmountOfEnemies.current_bats -= 1
		AmountOfEnemies.bats_died += 1
		
		print(str(AmountOfEnemies.bats_died))
		var text_thing = ":D"
		mob_died.emit()
		
		
		#label.text = ""


func _on_timer_timeout() -> void:
	queue_free()
