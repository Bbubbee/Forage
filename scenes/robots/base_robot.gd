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

@onready var fruit_panel_container: HBoxContainer = $FruitPanelContainer

# The juice this robot is ordering. 
var juice

func _ready() -> void:
	state_machine.init(self) 
	juice = Globals.generate_juice(3)
	fruit_panel_container.init(juice)


func face_toward(direction: Vector2):
	if direction == Vector2.LEFT: 
		sprite.flip_h = true
		floor_detector_ray.position.x = -12
	else: 
		sprite.flip_h = false		
		floor_detector_ray.position.x = 15







