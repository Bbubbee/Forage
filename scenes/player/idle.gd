extends State


func on_input(_event: InputEvent): 
	if _event.is_action_pressed("pickup"):
		# Get areas touching pickup zone. 
		var bodies = actor.pickup_zone.get_overlapping_bodies()
		
		if not bodies: return 
		
		var body: RigidBody2D = bodies[0]
		
		transition.emit(self, "carrying", body)
		
		
