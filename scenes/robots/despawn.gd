extends State 

@onready var fruit_panel_container_new = $"../../FruitPanelContainerNew"

func enter(_enter_params = null):
	actor.animator.play_backwards("spawn") 
	actor.velocity.x = 0 
	actor.timer.set_deferred("visible", false)
	fruit_panel_container_new.set_deferred("visible", false)
	
	Events.robot_left.emit()
	
	
	if _enter_params: 
		Stats.money += 25
		Stats.robots += 1 
		

func physics_process(_delta):
	#actor.velocity_component.stop() 
	actor.move_and_slide()
	
