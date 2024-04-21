extends Marker2D

var is_spawned: bool = false 

const ROBOT = preload("res://scenes/robots/base_robot.tscn")

func _on_player_detector_body_entered(body):
	if not is_spawned: 
		is_spawned = true
		var robot = ROBOT.instantiate()
		add_child(robot)
		var juice = ["apple", "apple", "apple"]
		robot.override_juice(juice)
		
