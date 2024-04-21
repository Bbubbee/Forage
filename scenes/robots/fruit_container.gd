extends HBoxContainer

const FRUIT_PANEL = preload("res://scenes/ui/fruit_panel.tscn")
@onready var display_timer: Timer = $DisplayTimer
@onready var animator: AnimationPlayer = $Animator
@onready var interact_area: Area2D = $InteractArea

#func _ready() -> void:
	#set_modulate(Color(1, 1, 1, 0))
	#print(get_modulate())

func init(juice): 		
	for fruit in juice: 
		var panel = FRUIT_PANEL.instantiate()
		add_child(panel) 
		panel.init(fruit)

# Show juice container. 
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and interact_area.has_overlapping_bodies():
		display_timer.start()
		animator.play("appear")


func _on_display_timer_timeout() -> void:
	animator.play_backwards("appear")
	
func add_fruit_to_panel(fruit: String): 
	
	# Add fruit to panel slot. 
	for panel in get_children(): 
		
		if not panel is FruitPanel: continue
		
		# TODO: Iterate from end of list. 
		
		if not panel.occupied:  
			print("add new fruit to frame")
			panel.add_fruit_to_frame(fruit)
			break
	

