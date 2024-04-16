extends State

var body: CharacterBody2D 

func enter(_enter_params = null):
	body = _enter_params  
	

func physics_process(delta):
	actor.handle_movement(delta)
	actor.handle_gravity(delta)
	actor.move_and_slide()
	
	if not body: return
	body.global_transform.origin = actor.pickup_marker.global_position
	
	


func on_input(_event: InputEvent): 
	if _event.is_action_pressed("pickup"):
		
		if actor.facing_right:
			body.throw(Vector2.RIGHT)
		else:
			body.throw(Vector2.LEFT)
		
		transition.emit(self, "move")
