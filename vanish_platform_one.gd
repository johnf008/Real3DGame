extends CSGBox3D


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("player"):
		use_collision = false
		transparency = 1.0
		print("Collision of group player")
	print("Collission :3" + str(area))
