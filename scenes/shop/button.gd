extends Sprite2D

signal pressed 

@onready var press_area = $PressArea
@onready var press_timer = $PressTimer

var is_pressed: bool = false 

func _input(event):
	if event.is_action_pressed("interact") and press_area.has_overlapping_bodies() and press_timer.is_stopped(): 
		pressed.emit()
		press_timer.start()
		frame = 1


func _on_press_timer_timeout():
	frame = 0
