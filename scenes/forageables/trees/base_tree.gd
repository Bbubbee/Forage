extends Node2D

@export var fruit_scene: PackedScene
@onready var sprite: Sprite2D = $Sprite

var is_wet: bool = false
var is_getting_rained_on: bool = false


# Timers to grow up. 
# Must be rained on to grow! TODO: Change this. 

# Timers to grow fruit. 
var time_to_grow_fruit: float = 5.0
@onready var fruit_timer: float = time_to_grow_fruit
	# When fruit timer reaches 0, grow a fruit! 
	
# Dry up timers. 
var time_to_dry_up: float = 9.0
var dry_up_timer: float = 0

# Places to spawn fruits. 
@onready var fruit_spawns = $FruitSpawns
@onready var fruit_marker_1 = $FruitSpawns/FruitMarker1
@onready var fruit_marker_2 = $FruitSpawns/FruitMarker2
@onready var fruit_marker_3 = $FruitSpawns/FruitMarker3

@onready var animator = $Animator
@onready var state_machine: Node = $StateMachine

func _ready():
	state_machine.init(self) 
	
	
func _physics_process(_delta: float) -> void:
	if is_wet: 
		animator.play("RESET")
	else: 
		animator.play("dry")



# Stop getting rained on. 

func _on_water_area_area_entered(area: Area2D) -> void:
	if area.collision_layer == 32:
		is_getting_rained_on = true


func _on_water_area_area_exited(area: Area2D) -> void:
	if area.collision_layer == 32:
		is_getting_rained_on = false
