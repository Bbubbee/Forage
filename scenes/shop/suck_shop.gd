extends Node2D

@onready var consumption_area: Area2D = $ConsumptionArea
@onready var animator: AnimationPlayer = $Animator

var juice = []
@onready var fruit_panel_container: HBoxContainer = $FruitPanelContainer


func _ready() -> void:
	juice = ['empty', 'empty', 'empty']
	fruit_panel_container.init(juice)
	
	# WARNING: Temp solution. 
	juice = []

func _on_consumption_area_body_entered(body: Node2D) -> void:
	if body is Seed: return
	
	# Add fruit to juice. 
	animator.play("suck")
	var fruit_name = body.name.rstrip("1234567890")  # Remove numbers from name. 
	juice.append(fruit_name)
	body.queue_free()
	
	# Add fruit to panel. 
	fruit_panel_container.add_fruit_to_panel(fruit_name)
	
	if juice.size() >= 3: 
		animator.play("blend")
		return

			
	
	
	
