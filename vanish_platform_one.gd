extends CSGBox3D

@onready var animation_tree: AnimationTree = %AnimationTree

var platform_alive = true

func _physics_process(delta: float) -> void:
	if %Platform_Come_Back_Timer.time_left == 0 and !platform_alive:
		use_collision = true
		#transparency = 1.0
		visible = true
		platform_alive = true
	#print(str(%Platform_Vanish_Timer.time_left)) #remove l8r
	
func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("player"):
		%Platform_Vanish_Timer.start()
		warn()
		#print("Collision of group player")
		#print(str(%Platform_Vanish_Timer.time_left))
	#print("Collission :3" + str(area))


func _on_platform_vanish_timer_timeout() -> void:
	use_collision = false
	visible = false
	platform_alive = false
	
	%Platform_Vanish_Timer.stop()
	%Platform_Come_Back_Timer.start()

func warn():
	animation_tree.set("parameters/OneShot/request", true)
	
