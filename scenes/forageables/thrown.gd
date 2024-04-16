extends State


func enter(_enter_params = null):
	var dir = _enter_params
	
	if dir.x > 0: 	
		actor.velocity.x = 125
		actor.velocity.y = -100
	else: 
		actor.velocity.x = -125
		actor.velocity.y = -100

func physics_process(delta: float):
	# Return velocity.x to zero. 
	actor.velocity_component.stop(delta) 
	actor.velocity_component.handle_gravity(delta)
	actor.move_and_slide()
	
	actor.handle_rotation(delta)
