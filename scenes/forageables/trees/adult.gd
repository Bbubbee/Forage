extends State

var fruit_timer: float
var time_to_grow_fruit: float = 5.0 

func enter(_enter_params = null):
	actor.sprite.frame = 2
	fruit_timer = 0

func physics_process(delta: float) -> void:
	if actor.is_getting_rained_on: 
		actor.dry_up_timer = actor.time_to_dry_up
		
	# Time to dry up.  
	actor.dry_up_timer -= delta
	
	# I'm dry. 
	if actor.dry_up_timer <= 0: 
		actor.is_wet = false
		return
		
	# I'm wet!
	else: 
		actor.is_wet = true
		
		fruit_timer -= delta
		if fruit_timer <= 0: 
			fruit_timer = time_to_grow_fruit 
				
			# Grow a fruit!!!
			
			# Randomly choose a marker to spawn in. 
			var fruit = actor.fruit_scene.instantiate()
			fruit.name = actor.fruit_name
			print(fruit.name)
			$"../../Pop".play()
			
			# TODO: Check if all spawns have been taken. 
			var r = randi_range(1, actor.fruit_spawns.get_child_count())	
			match r: 
				1: 
					actor.fruit_marker_1.add_child(fruit)
				2:
					actor.fruit_marker_2.add_child(fruit)
				3: 
					actor.fruit_marker_3.add_child(fruit)
	
