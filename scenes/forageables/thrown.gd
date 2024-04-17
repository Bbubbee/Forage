extends State

@onready var collision_reset_timer: Timer = $CollisionResetTimer


func enter(enter_params = null):
	var dir = enter_params["direction"]
	var force = enter_params["force"]
	
	actor.velocity = dir * force
	
	collision_reset_timer.start()
	

func physics_process(delta: float):
	# Return velocity.x to zero. 
	actor.velocity_component.stop(delta) 
	actor.velocity_component.handle_gravity(delta)
	
	actor.move_and_slide()
	
	actor.handle_rotation(delta)


# Let the player collide with the fruit now.
func _on_collision_reset_timer_timeout() -> void:
	actor.collision_layer = 8
