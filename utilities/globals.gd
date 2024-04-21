extends Node

func get_distance_between_two_targets(a: Vector2, b: Vector2) -> float: 
	return (a - b).length()

func get_direction_to_target(subject: Vector2, target: Vector2): 
	return (target - subject).normalized()


func generate_juice(num_of_fruit: int = 3):
	var juice = []
	
	for fruit in num_of_fruit:
		juice.append(list_of_fruits.pick_random())
	
	return juice

const list_of_fruits = [
	'apple', 
	'peach',
	'blueberry'
]

const fruit_colours = {
	'apple': Color(0.6, 0, 0),
	'peach': Color.HOT_PINK,
	'blueberry': Color.DEEP_SKY_BLUE
}

const seeds = [
	preload("res://scenes/forageables/apple_seed.tscn"),
	preload("res://scenes/forageables/peach_seed.tscn"),
	preload("res://scenes/forageables/blueberry_seed.tscn"),
]

func spawn_random_seed(): 
	return seeds.pick_random()
