extends CharacterBody2D
class_name Fruit



# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var sprite = $General/Sprite

@onready var state_machine = $StateMachine
@onready var velocity_component = $Components/VelocityComponent

func _ready():
	state_machine.init(self) 

func pick_up(): 
	state_machine.force_transition("held")

func throw(data: Dictionary): 
	state_machine.force_transition("thrown", data)

func handle_rotation(_delta): 
	if velocity.x > 0: 
		sprite.rotation += 0.5
	elif velocity.x < 0: 
		sprite.rotation -= 0.5
	
	# TODO: Slow down as the velocity decreases.
