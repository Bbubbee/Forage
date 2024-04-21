extends Node2D


@onready var level_timer = $LevelTimer
@onready var time_label = $UI/TimeLabel

signal game_over

var has_level_started: bool = false

func _ready():
	time_label.set_deferred("visible", false)

func _process(_delta):
	# Show time. 
	var time = roundi(level_timer.get_time_left())
	var minute = int(time/60)
	var seconds = int(time%60)
	
	time_label.text = str(minute)+":"+str(seconds)
	

#get_wait_time()
@onready var pause_menu = $UI/PauseMenu

var is_paused: bool = false
func pause():
	is_paused = true
	get_tree().paused = true
	pause_menu.show()


func resume():
	is_paused = false
	get_tree().paused = false	
	pause_menu.hide()
	

func _input(event):
	if event.is_action_pressed("pause"):
		$"../Select".play()
		if is_paused:
			resume()
		else: 
			pause()
	

func _on_animator_animation_finished(_anim_name):
	level_timer.start()
	time_label.set_deferred("visible", true)
	
	

@onready var finish_screen = $UI/FinishScreen

func _on_level_timer_timeout():
	game_over.emit()
	get_tree().paused = true	
	
	finish_screen.show()
	finish_screen.end_game()
