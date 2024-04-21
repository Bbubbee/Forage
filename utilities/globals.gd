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
