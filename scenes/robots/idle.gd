extends State

@export var enemy: CharacterBody2D
@export var move_speed: float = 10.0
var acceleration 

var move_direction: int 
var wander_time: float

@onready var idle_timer: Timer = $IdleTimer
var idle_time_max: float = 8
var idle_time_min: float = 5


func enter(_enter_params = null):
	# Stay in place for some time. 
	actor.animator.play("idle")
	idle_timer.start(randf_range(idle_time_min, idle_time_max))
	
	

func physics_process(delta):
	actor.velocity_component.stop(delta)
	if not actor.is_on_floor():
		actor.velocity.y += actor.gravity * delta
	
	actor.move_and_slide()
	

func _on_idle_timer_timeout() -> void:
	transition.emit(self, "wander")
