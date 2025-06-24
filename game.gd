extends Node3D

@onready var label: Label = %Label
@onready var time_label: Label = $Time_Label
@onready var time_survived: Timer = $Time_Survived

@onready var total_seconds: int = 0

var score

func _ready() -> void:
	time_survived.start()

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


func _on_time_survived_timeout() -> void:
	total_seconds += 1
	var minutes = floor(total_seconds / 60)
	var seconds = total_seconds - (minutes*60)
	
	time_label.text = '%02d:%02d' % [minutes, seconds]
	

func _on_player_reset_seconds() -> void:
	total_seconds = 0
