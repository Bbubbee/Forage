extends State 

var direction: Vector2

@onready var wander_timer: Timer = $WanderTimer
var wander_time_max: float = 6
var wander_time_min: float = 4


func enter(_enter_params = null):
	actor.animator.play("walk")
	
	# Wander either left or right. 
	var r = randi_range(0 , 1)
	if r == 0: direction = Vector2.LEFT
	else: direction = Vector2.RIGHT
	
	actor.face_toward(direction)
	
	# Wander for some time. 
	wander_timer.start(randf_range(wander_time_min, wander_time_max))
	

func physics_process(delta: float) -> void:
	# Wander forward. 
	actor.velocity.x = move_toward(direction.x*actor.SPEED, actor.velocity.x, delta*actor.ACCELERATION)
	
	# Turn around if a drop is ahead. 
	if not actor.floor_detector_ray.is_colliding(): turn_around()
			
	# Turn around if a wall is ahead.
	if actor.is_on_wall(): turn_around()
	
	actor.move_and_slide()
	

func turn_around(): 
	if direction == Vector2.LEFT: 
		direction = Vector2.RIGHT
		actor.face_toward(direction)
	else: 
		direction = Vector2.LEFT
		actor.face_toward(direction)


func _on_wander_timer_timeout() -> void:
	transition.emit(self, 'idle')
