extends CharacterBody3D


const ACCELERATION = 25.0
const SPEED = 5.0
const JUMP_VELOCITY = 4.5


@export var camera: Camera3D


func _physics_process(delta: float) -> void:
	
	%TestLabel.hide()
	if %InteractCast.is_colliding():
		var target = %InteractCast.get_collider()
		if target.has_method("interact"):
			%TestLabel.show()
			if Input.is_action_just_pressed("interact"):
				target.interact()
	
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("left", "right", "foward", "back")
	var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()
	
	
	
	direction = direction.rotated(Vector3.UP, camera.global_rotation.y)
	
	
	if direction:
		direction *= SPEED
		velocity.x = move_toward(velocity.x, direction.x, delta * ACCELERATION)
		velocity.z = move_toward(velocity.z, direction.z, delta * ACCELERATION)
		
		if velocity.length_squared() >= 0.1:
			var look_position := global_position + Vector3(velocity.x, 0, velocity.z)
			$son.look_at(look_position, Vector3.UP, true)
		
		
	else:
		velocity.x = move_toward(velocity.x, 0, delta * ACCELERATION)
		velocity.z = move_toward(velocity.z, 0, delta * ACCELERATION)

	move_and_slide()
