extends State


func physics_process(delta: float):
	actor.velocity_component.handle_gravity(delta)
	actor.move_and_slide()

