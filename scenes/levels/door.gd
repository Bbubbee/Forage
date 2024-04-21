extends Sprite2D
@onready var area_2d = $Area2D

func _input(event):
	if event.is_action_pressed("interact") and area_2d.has_overlapping_bodies():
		SceneTransition.change_scene("res://scenes/levels/level_1.tscn")
