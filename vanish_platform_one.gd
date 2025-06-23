extends CSGBox3D

@onready var animation_tree: AnimationTree = %AnimationTree


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("player"):
		warn()
		%Platform_Vanish_Timer.start()
		print("Collision of group player")
	print("Collission :3" + str(area))


func _on_platform_vanish_timer_timeout() -> void:
	use_collision = false
	transparency = 1.0

func warn():
	animation_tree.set("parameters/OneShot/request", true)
	
