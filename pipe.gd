extends Node3D

@export var mob_to_spawn: PackedScene = null

@onready var pipe_spawn_timer: Timer = %PipeSpawnTimer
@onready var pipe_marker: Marker3D = %PipeMarker


func _on_pipe_spawn_timer_timeout() -> void:
	var new_mob = mob_to_spawn.instantiate()
	add_child(new_mob)
	new_mob.global_position = pipe_marker.global_position
	print("Chat is this even executing?")
