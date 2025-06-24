extends Node3D

@export var mob_to_spawn: PackedScene = null

@onready var pipe_spawn_timer: Timer = %PipeSpawnTimer
@onready var pipe_marker: Marker3D = %PipeMarker

signal mob_spawn(mob)

func _on_pipe_spawn_timer_timeout() -> void:
	
	if AmountOfEnemies.MAX_BATS <= AmountOfEnemies.current_bats:
		pass
	else:
		var new_mob = mob_to_spawn.instantiate()
		add_child(new_mob)
		new_mob.global_position = pipe_marker.global_position
		AmountOfEnemies.current_bats += 1
		
		mob_spawn.emit(new_mob)
	
	#print("Chat is this even executing?") yes
