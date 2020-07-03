extends Tank


func _physics_process(delta):
	
	# Get the input vectors 
	var input_velocity = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_velocity = Vector2(0, MAX_SPEED * input_velocity)
	input_velocity = input_velocity.rotated(rotation)
	var input_angular_velocity = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_angular_velocity *= MAX_ANGULAR_VELOCITY
	
	# Get mouse direction to set gun rotation and shoot.
	var dir = get_global_mouse_position() - global_position
	point(dir)
	if Input.is_action_just_pressed("left_mouse"):
		shoot()

	
	#Move
	move(input_velocity, input_angular_velocity, delta)

	



