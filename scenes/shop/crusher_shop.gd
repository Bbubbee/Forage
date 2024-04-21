extends Node2D

@onready var animator: AnimationPlayer = $Animator

var number_of_fruits: int = 0 


# Indicate to the player that it is about to crush. 
func crush_warning(): 
	pass


enum MyState {
	IDLE,
	CRUSHING, 
	SHOW_JUICE
}
var current_state: MyState = MyState.IDLE:
	set(new_state):
		if new_state == current_state: return
		current_state = new_state

# Push into the crush area. 
@onready var pusher_left: Area2D = $PusherLeft
@onready var pusher_right: Area2D = $PusherRight
@onready var squish_area: Area2D = $SquishArea

var is_crushing: bool = false
@onready var crushing_timer: Timer = $CrushingTimer

var juice_array = []

func _physics_process(delta: float) -> void:
	
	match current_state: 
		MyState.IDLE: 
			return
			
		MyState.CRUSHING:
			# Push fruits on the left to the middle to get crushed.
			var left_fruits = pusher_left.get_overlapping_bodies()
			for fruit in left_fruits:
				fruit.velocity.x = 200
			
			# Push fruits on the right to the middle to get crushed.
			var right_fruits = pusher_right.get_overlapping_bodies()
			for fruit in right_fruits:
				fruit.velocity.x = -200
			
			# Destroy all the fruits that got crushed in the middle. 
			var fruits = squish_area.get_overlapping_bodies()
			for fruit in fruits:
				
				# Get the names of all the fruit crushed. Exclude seeds. 
				if fruit is Fruit: 
					juice_array.append(fruit.get_name())
					
				fruit.queue_free()
			
			return
			
		MyState.SHOW_JUICE:
			
			return
	
func _on_crushing_timer_timeout() -> void:
	## ENTER: CRUSHING -> SHOW_JUICE
	current_state = MyState.SHOW_JUICE
	
	# Print what juice player made. 
	
	
	# Play the show juice animation after a bit to be dramatic. 
	await get_tree().create_timer(1).timeout
	animator.play("show_juice")
	
	
func _on_fruit_detector_body_entered(body: Node2D) -> void:
	if body is Seed: 
		print("this is a seed, not a fruit")
		return 
	if not body is Fruit: return
	
	number_of_fruits += 1 
	
	if number_of_fruits >= 3:
		## ENTER: IDLE -> CRUSHING
		current_state = MyState.CRUSHING
		crushing_timer.start() 
		number_of_fruits = 0
		animator.play('crush')
		


func _on_fruit_detector_body_exited(body: Node2D) -> void:
	number_of_fruits -= 1



