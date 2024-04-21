extends CharacterBody2D


const SPEED = 30.0
const ACCELERATION = 10.0

@onready var floor_detector_ray: RayCast2D = $General/FloorDetectorRay
@onready var sprite: Sprite2D = $General/Sprite

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var state_machine: Node = $StateMachine
@onready var velocity_component: VelocityComponent = $Components/VelocityComponent
@onready var animator: AnimationPlayer = $General/Animator

@onready var fruit_panel_container_new = $FruitPanelContainerNew

# The juice this robot is ordering. 
var juice

func _ready() -> void:
	state_machine.init(self) 
	juice = Globals.generate_juice(3)
	fruit_panel_container_new.init(juice)

func override_juice(new_juice):
	juice = []
	juice = new_juice 
	fruit_panel_container_new.replace_fruit_recipe(juice)


func face_toward(direction: Vector2):
	if direction == Vector2.LEFT: 
		sprite.flip_h = true
		floor_detector_ray.position.x = -12
	else: 
		sprite.flip_h = false		
		floor_detector_ray.position.x = 15


func received_juice(new_juice):	
	# Determine if this is the right juice. 
	if compare_juice(new_juice): 
		state_machine.force_transition("despawn", true)
	else: 
		timer.patience_time -= 30
		
@onready var timer = $General/Timer

func compare_juice(new_juice): 
	if juice.size() != new_juice.size(): return false
	
	# Create copies of the arrays to avoid modifying the originals
	var copy_arr1 = juice.duplicate()
	var copy_arr2 = new_juice.duplicate()
	
	# Sort both arrays
	copy_arr1.sort()
	copy_arr2.sort()
	
	# Compare sorted arrays element by element
	for i in range(copy_arr1.size()):
		if copy_arr1[i].to_lower() != copy_arr2[i].to_lower():
			return false
	
	return true
	


func _on_timer_im_out_of_patience():
	state_machine.force_transition("despawn", false)
