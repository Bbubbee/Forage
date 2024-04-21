extends Control
#
#const TUTORIAL_LEVEL = preload("res://scenes/levels/tutorial_level.tscn")

@onready var v_box_container = $VBoxContainer
@onready var next_page_info = $NextPageInfo

func _on_start_button_pressed():
	$Select.play()
	#SceneTransition.change_scene("res://scenes/levels/tutorial_level.tscn")
	v_box_container.hide()
	next_page_info.show()


func _on_yes_button_pressed():
	SceneTransition.change_scene("res://scenes/levels/tutorial_level.tscn")


func _on_no_button_pressed():
	SceneTransition.change_scene("res://scenes/levels/level_1.tscn")
