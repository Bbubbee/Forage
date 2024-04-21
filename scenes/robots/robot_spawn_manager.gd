extends Node2D

@onready var spawn_areas = $SpawnAreas
@onready var spawn_timer = $SpawnTimer

@export var max_robots: int = 5
var num_robots: int = 0

@export var spawn_time_min: float = 12
@export var spawn_time_max: float = 15

func _ready():
	Events.robot_left.connect(on_robot_left)

func on_robot_left(): 
	num_robots -= 1 
	
func _on_spawn_timer_timeout():
	spawn_timer.start(get_random_spawn_time())
	
	if num_robots >= max_robots: return
	
	num_robots += 1 
	# Randomly select a spawn area. 
	var rand_index = randi() % spawn_areas.get_child_count()
	var spawn_area = spawn_areas.get_child(rand_index) 
	spawn_area.spawn_robot()

func get_random_spawn_time(): 
	return randf_range(spawn_time_min, spawn_time_max)
	


func _on_initial_timer_timeout():
	spawn_timer.start(get_random_spawn_time())
