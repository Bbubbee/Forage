extends State

@onready var collision_reset_timer: Timer = $CollisionResetTimer

@onready var robot_can_interact: bool = false

func enter(enter_params = null):
	robot_can_interact = true
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
	
	# Check if in contact with robot.


# Let the player collide with the fruit now.
func _on_collision_reset_timer_timeout() -> void:
	actor.collision_layer = 8


func _on_robot_detector_body_entered(body):
	if robot_can_interact:
		body.received_juice(actor.juice)
		actor.queue_free()
