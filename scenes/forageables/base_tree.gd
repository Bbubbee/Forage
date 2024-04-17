extends Sprite2D

@export var fruit_scene: PackedScene

enum MyState {
	SAPLING, 
	YOUTH,
	ADULT
}
var current_state: MyState = MyState.SAPLING:
	set(new_state):
		if new_state == current_state: return
		current_state = new_state 

# Timers to grow up. 
var time_spent_wet: float = 0.0
var time_to_youth: float = 3.0
var time_to_adult: float = 3.0
# Must be rained on to grow! TODO: Change this. 
var getting_rained_on: bool = false

# Timers to grow fruit. 
var time_to_grow_fruit: float = 5.0
@onready var fruit_timer: float = time_to_grow_fruit
	# When fruit timer reaches 0, grow a fruit! 
var time_to_dry_up: float = 11.0
@onready var dry_up_timer: float = time_to_dry_up

# Places to spawn fruits. 
@onready var fruit_spawns = $FruitSpawns
@onready var fruit_marker_1 = $FruitSpawns/FruitMarker1
@onready var fruit_marker_2 = $FruitSpawns/FruitMarker2
@onready var fruit_marker_3 = $FruitSpawns/FruitMarker3

@onready var animator = $Animator

func _ready():
	frame = 0 


func _physics_process(delta):
	
	match current_state:
		MyState.SAPLING:
			if getting_rained_on: 
				time_spent_wet += delta 
		
			if time_spent_wet >= time_to_youth:
				frame = 1
				current_state = MyState.YOUTH
			return
		MyState.YOUTH:
			if getting_rained_on: 
				time_spent_wet += delta 
				
			if time_spent_wet >= time_to_adult+time_to_youth:
				frame = 2
				current_state = MyState.ADULT
			return
		MyState.ADULT:
			if getting_rained_on: 
				# Reset the time to dry up. 
				dry_up_timer = time_to_dry_up
			
			dry_up_timer -= delta 
			
			# Adult has 2 states. Wet and dry. 
			
			# Dry State. 
			if dry_up_timer <= 0: 
				animator.play("dry")
				return
			
			# WARNING: Need to change animation system.
			
			# Wet State.
			animator.play("RESET") 
			fruit_timer -= delta
			if fruit_timer <= 0: 
				fruit_timer = time_to_grow_fruit 
					
				# Grow a fruit!!!
				
				# Randomly choose a marker to spawn in. 
				var fruit = fruit_scene.instantiate()
				
				# TODO: Check if all spawns have been taken. 
				var r = randi_range(1, fruit_spawns.get_child_count())	
				match r: 
					1: 
						fruit_marker_1.add_child(fruit)
					2:
						fruit_marker_2.add_child(fruit)
					3: 
						fruit_marker_3.add_child(fruit)
			
				
			return



# I am getting rained on. 
func _on_area_2d_area_entered(area: Area2D):
	if area.collision_layer == 32:
		getting_rained_on = true

# Stop getting rained on. 
func _on_area_2d_area_exited(area):
	if area.collision_layer == 32:
		getting_rained_on = false
