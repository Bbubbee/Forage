extends State

var time_to_adult: float = 5.0
var growth_timer: float = 0.0

func enter(_enter_params = null):
	actor.is_wet = false 
	actor.sprite.frame = 1
	growth_timer = 0
	actor.dry_up_timer = 0 
	

func physics_process(delta: float) -> void:
	if actor.is_getting_rained_on: 
		actor.dry_up_timer = actor.time_to_dry_up
		
	# Time to dry up.  
	actor.dry_up_timer -= delta
	
	# I'm dry. 
	if actor.dry_up_timer < 0: 
		actor.is_wet = false
		
	# I'm wet!
	else: 
		actor.is_wet = true
		growth_timer += delta
		if growth_timer >= time_to_adult:
			transition.emit(self, "adult")

