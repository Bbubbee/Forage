extends State

func enter(_enter_params = null):
	# Make fruit uninteractable with player. 
	actor.collision_layer = 16

func exit():
	# Make fruit interactable with player. 
	actor.collision_layer = 8

