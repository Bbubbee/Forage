extends Node2D

const FRUIT_PANEL = preload("res://scenes/ui/fruit_panel.tscn")
@onready var display_timer: Timer = $DisplayTimer
@onready var animator: AnimationPlayer = $Animator
@onready var interact_area: Area2D = $InteractArea
@onready var fruit_panel_container = $FruitPanelContainer

func init(juice): 		
	for fruit in juice: 
		var panel = FRUIT_PANEL.instantiate()
		fruit_panel_container.add_child(panel) 
		panel.init(fruit)

# Show juice container. 
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and interact_area.has_overlapping_bodies():
		display_fruit_panels()

func display_fruit_panels(): 
	display_timer.start()
	animator.play("appear")


func _on_display_timer_timeout() -> void:
	animator.play_backwards("appear")
	
func add_fruit_to_panel(fruit: String): 
	# Add fruit to panel slot. 
	for panel in fruit_panel_container.get_children(): 
		
		if not panel is FruitPanel: continue
		
		# TODO: Iterate from end of list. 
		
		if not panel.occupied:  
			panel.add_fruit_to_frame(fruit)
			break

func replace_fruit_recipe(juice): 
	for panel in fruit_panel_container.get_children(): 
		panel.queue_free()
		
	for fruit in juice: 
		var panel = FRUIT_PANEL.instantiate()
		fruit_panel_container.add_child(panel) 
		panel.init(fruit)
	

