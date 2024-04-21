extends Control
#
#const TUTORIAL_LEVEL = preload("res://scenes/levels/tutorial_level.tscn")
func _on_start_button_pressed():
	SceneTransition.change_scene("res://scenes/levels/tutorial_level.tscn")
