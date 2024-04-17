extends State

func enter(_enter_params = null):
	# Make the fruit not collidable with the player.
	actor.collision_layer = 128
	# We return collision some time after being thrown.
	


