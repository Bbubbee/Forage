extends Control
@onready var level_manager = $"../.."

var is_game_over: bool = false 

func _input(event):
	if is_game_over: return 
	
	if event.is_action_pressed("pause"):
		get_tree().paused = false 


func _on_restart_button_pressed():
	if is_game_over: return 
	
	get_tree().paused = false 
	SceneTransition.change_scene("res://scenes/levels/level_1.tscn")


func _on_level_manager_game_over():
	is_game_over = true
