extends Node3D
@onready var label: Label = %Label

func adjust_label():
	label.text = "Score: " + str(AmountOfEnemies.bats_died)

func _on_node_3d_mob_spawn(mob) -> void:
	mob.mob_died.connect(adjust_label)

func _on_node_3d_2_mob_spawn(mob) -> void:
	mob.mob_died.connect(adjust_label)


func _on_node_3d_3_mob_spawn(mob) -> void:
	mob.mob_died.connect(adjust_label)


func _on_node_3d_4_mob_spawn(mob) -> void:
	mob.mob_died.connect(adjust_label)
