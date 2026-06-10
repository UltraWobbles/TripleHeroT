extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_vision_timer_timeout() -> void:
	var overlaps = $VisionArea.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.name == "Player":
				var playerPosition = overlap.global_position
				$VisionRayCast.look_at(playerPosition, Vector3.UP)
				$VisionRayCast.force_raycast_update()
			
				if $VisionRayCast.is_colliding():
					var collider = $VisionRayCast.get_collider()
					
					if collider.name == "Player":
						$VisionRayCast.debug_shape_custom_color = Color(1.0, 1.0, 0.0, 1.0)
						print("I found you")
						$VisionArea.look_at(playerPosition, Vector3.UP)
					else:
						$VisionRayCast.debug_shape_custom_color = Color(0.82, 0.0, 0.0, 1.0) 
						print("I dont see you")
