extends State
@onready var footsteps = $"../../Audio/Footsteps"

func physics_process(delta):
	actor.handle_movement(delta)
	actor.handle_gravity(delta)
	actor.move_and_slide()
	
		

func on_input(_event: InputEvent): 
	if _event.is_action_pressed("pickup"):
		
		# Check if clicked on valid area (the orange circle around the player).
		if not actor.is_mouse_in_throw_area: return
		
		# Get areas touching pickup zone. 
		var bodies = actor.pickup_zone.get_overlapping_bodies()
		
		if not bodies: return 
		
		var body: CharacterBody2D = bodies[0]
		body.pick_up()
		
		transition.emit(self, "carrying", body)
		
		
