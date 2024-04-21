extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var state_machine = $StateMachine
@onready var velocity_component = $Components/VelocityComponent

@onready var juice_sprite = $JuiceSprite

var juice

func init(juice): 
	self.juice = juice
	# Determine the color of the juice based on the fruits.
	print(juice)
	var juice_color: Color
	for fruit in juice: 
		if not str(fruit) in Globals.list_of_fruits:
			fruit = Globals.list_of_fruits.pick_random()
			
		var fruit_color = Globals.fruit_colours[fruit.to_lower()]
		juice_color = juice_color.blend(fruit_color)
	
	juice_sprite.modulate = juice_color

	
func _ready():
	state_machine.init(self) 

func pick_up(): 
	state_machine.force_transition("held")

func throw(data: Dictionary): 
	state_machine.force_transition("thrown", data)
	
func handle_rotation(_delta): 
	pass


	
