extends State

var time_to_youth: float = 6.0
var growth_timer: float = 0.0 

func enter(_enter_params = null):
	actor.sprite.frame = 0


func physics_process(delta: float) -> void:
	if actor.is_getting_rained_on: 
		actor.dry_up_timer = actor.time_to_dry_up
		
	# Time to dry up.  
	actor.dry_up_timer -= delta
	
	# I'm dry. 
	if actor.dry_up_timer < 0: 
		actor.is_wet = false
		return
		
	# I'm wet!
	else: 
		actor.is_wet = true
		growth_timer += delta
		if growth_timer >= time_to_youth:
			$"../../Growth".play()
			transition.emit(self, "youth")



