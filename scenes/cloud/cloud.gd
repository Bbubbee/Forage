extends Area2D

var is_mouse_holding: bool = false

var shake_counter: int = 0
var shake_amount_to_cry: int = 6
var last_shake: String = "right"
var shake_strength: float = 8.0

@onready var animator = $Animator
@onready var cry_timer = $CryTimer

@onready var rain_collider = $RainArea/RainCollider
@onready var rain_particles = $RainParticles
@onready var rain_contact_timer = $RainContactTimer

enum MyState {
	IDLE,
	DRAGGED,
	CRYING
}
var current_state: MyState = MyState.IDLE:
	set(new_state):
		if new_state == current_state: return
		current_state = new_state

# How to see if shaking. 

func _physics_process(delta):
	# State machine. 
	match current_state:
		MyState.IDLE:
			idle_state(delta)
		MyState.DRAGGED:
			dragged_state(delta)
		MyState.CRYING:
			crying_state(delta)
			
	

func _input(event):
	if event.is_action_pressed("pickup") and is_mouse_hovering:
		is_mouse_holding = true
	
	if event.is_action_released("pickup") and is_mouse_holding:
		is_mouse_holding = false

func idle_state(_delta: float):
	if is_mouse_holding: 	
		animator.play("angy")
		current_state = MyState.DRAGGED
	
func dragged_state(_delta: float):
	# The cloud is let go so go back to idle state. 
	if not is_mouse_holding: 
		animator.play("idle")
		shake_counter = 0 
		current_state = MyState.IDLE
	
	# Check if cloud is shook too much. 
	# If it is, it will start crying. 
	if shake_counter >= shake_amount_to_cry: 
		# Enter: crying state. 
		$Rain.play()
		rain_contact_timer.start()
		animator.play("crying")
		cry_timer.start()
		rain_particles.emitting = true
		current_state = MyState.CRYING
		
	
	handle_drag_cloud()
	

func crying_state(_delta: float):
	handle_drag_cloud()



func handle_drag_cloud(): 
	if is_mouse_holding: 	
		# Track the last position of the cloud. 
		var last_pos = self.global_position
		
		# Move the cloud to the mouse's position. 
		self.global_position.x = get_global_mouse_position().x
		
		# See if shaking.
		var displacement = last_pos.x - global_position.x
		
		# Shook left. 
		if displacement > shake_strength and last_shake == "right":
			shake_counter += 1
			last_shake = "left"
		# Shook right. 
		elif displacement < shake_strength and last_shake == "left":
			shake_counter += 1
			last_shake = "right"
	



var is_mouse_hovering: bool = false  # Checks is mouse is hovering cloud.

func _on_mouse_entered():
	is_mouse_hovering = true

func _on_mouse_exited():
	is_mouse_hovering = false


func _on_cry_timer_timeout():
	# Enter: idle state.
	$Rain.stop()
	rain_collider.set_deferred("disabled", true)
	rain_particles.emitting = false
	shake_counter = 0  # Reset shake_counter because the cloud can still be shook in crying state. 	
	animator.play("idle")
	current_state = MyState.IDLE


# Enough time has passed for the rain to contact any seeds. 
func _on_rain_contact_timer_timeout():
	rain_collider.set_deferred("disabled", false)
