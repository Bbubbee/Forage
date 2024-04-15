extends State

var body: RigidBody2D 

func enter(_enter_params = null):
	body = _enter_params  
	body.freeze = true
	body.collision_layer = 16

	

func physics_process(delta):
	if not body: return
	body.global_transform.origin = actor.pickup_marker.global_position
	actor.move_and_slide()

func on_input(_event: InputEvent): 
	if _event.is_action_pressed("pickup"):
		# WARNING: Might need to set this to deferred. 
		body.freeze = false
		body.apply_central_impulse(Vector2(-10, -10))
		body.collision_layer = 8
		body = null
		transition.emit(self, "move")
