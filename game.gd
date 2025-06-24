extends Node3D
@onready var label: Label = %Label
var score

func adjust_label():
	if(AmountOfEnemies.bats_died < 0):
		score = 0
	else:
		score = AmountOfEnemies.bats_died
	label.text = "Score: " + str(score)

func _on_node_3d_mob_spawn(mob) -> void:
	mob.mob_died.connect(adjust_label)

func _on_node_3d_2_mob_spawn(mob) -> void:
	mob.mob_died.connect(adjust_label)


func _on_node_3d_3_mob_spawn(mob) -> void:
	mob.mob_died.connect(adjust_label)


func _on_node_3d_4_mob_spawn(mob) -> void:
	mob.mob_died.connect(adjust_label)


func _on_player_update_score() -> void:
	adjust_label()
