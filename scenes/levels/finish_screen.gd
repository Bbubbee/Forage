extends Control


func end_game():
	print('yo yo yooy oy ')
	get_tree().paused = false
	await get_tree().create_timer(2).timeout
	
	SceneTransition.change_scene("res://scenes/main/results_screen.tscn")
