extends Node2D


@onready var animator = $Animator

var shake_counter: int
var shake_required: int

func _ready():
	shake_required = randi_range(24, 40)


func _on_mouse_detector_mouse_entered():
	#if not is_mouse_down: return
	var direction = Globals.get_direction_to_target(get_global_mouse_position(), global_position)
	
	if direction.x > 0: 
		animator.play("shake_right")
		
	else: 
		animator.play("shake_left")
	
		
	shake_counter += 1
	if shake_counter >= shake_required:
		shake_counter = 0
		shake_required = randi_range(30, 50)
		spawn_seed()
		
@onready var sprite = $Sprite

func spawn_seed(): 
	var fruit_seed = Globals.spawn_random_seed().instantiate()
	fruit_seed.global_position = global_position
	var x = randf_range(global_position.x, global_position.x + 16)
	fruit_seed.global_position.x = x
	get_tree().get_root().add_child(fruit_seed)
		
	
var is_mouse_down: bool = false 

func _input(event):
	if event.is_action_pressed("pickup"):
		is_mouse_down = true
	
	if event.is_action_released("pickup"):
		is_mouse_down = false
	
		


func _on_animator_animation_finished(anim_name):
	if anim_name == "shake_left" or anim_name == "shake_right":
		animator.play("idle")
