extends Node3D

@onready var Player = $Player

func _physics_process(delta: float) -> void:
	const move_speed := 4.0
	%PathFollow3D.progress += move_speed * delta
	
	get_tree().call_group("enemies", "update_target_location", Player.global_transform.origin)
	
	
