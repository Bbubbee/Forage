extends State

var body: CharacterBody2D 

var is_aiming: bool = false

func enter(_enter_params = null):
	body = _enter_params  
	is_aiming = false
	

func physics_process(delta):
	actor.handle_movement(delta)
	actor.handle_gravity(delta)
	actor.move_and_slide()
	
	if not body: return
	body.global_transform.origin = actor.pickup_marker.global_position
	
	


func on_input(event: InputEvent): 
	# Aim the fruit in the direction and strength you desire. 
	if event.is_action_pressed("pickup"):
		if not actor.is_mouse_in_throw_area: return
		
		is_aiming = true 
		aim_fruit()
	
	# Throw the fruit! 
	if event.is_action_released("pickup"):
		
		if is_aiming: 
			is_aiming = false 
			throw_fruit()

var start_pos: Vector2

func aim_fruit():
	start_pos = actor.get_local_mouse_position()
	

func throw_fruit(): 
	# Get the force to throw the fruit. 
	# Depends on the distance dragged. 
	var release_pos = actor.get_local_mouse_position()
	var distance = Globals.get_distance_between_two_targets(start_pos, release_pos)
	var force = clamp(distance*3, 0, 225)  # *3 = it reaches max distant faster.
	
	# The direction to throw the fruit. 	
	var direction = Globals.get_direction_to_target(start_pos, release_pos)
	
	# Throw the fruit!
	var throw_data: Dictionary
	throw_data = {"direction": -direction, "force": force}
	body.throw(throw_data)
	
	transition.emit(self, "move")
	
	
	
	
	
	
	
	
	
	
