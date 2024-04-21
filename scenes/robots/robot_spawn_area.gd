extends Area2D

@onready var robot_spawn_shape = $RobotSpawnShape

var spawn_width: float

const ROBOT = preload("res://scenes/robots/base_robot.tscn")

func _ready():
	spawn_width = robot_spawn_shape.shape.size.x


func spawn_robot():
	var robot = ROBOT.instantiate() 
	
	# Get random spawn point.
	var random_spawn = randf_range(robot_spawn_shape.global_position.x-(spawn_width/2), robot_spawn_shape.global_position.x+spawn_width/2)
	robot.global_position.y = robot_spawn_shape.global_position.y
	robot.global_position.x = random_spawn
	
	get_tree().get_root().add_child(robot)
	

