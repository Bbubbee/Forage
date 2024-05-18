extends Node2D

@onready var consumption_area: Area2D = $ConsumptionArea
@onready var consumption_shape = $ConsumptionArea/ConsumptionShape

@onready var animator: AnimationPlayer = $Animator

var juice = []
var contents: int = 0 
@onready var fruit_panel_container_new = $FruitPanelContainerNew

func _ready() -> void:
	juice = ['empty', 'empty', 'empty']
	fruit_panel_container_new.init(juice)
	
	# WARNING: Temp solution. 
	juice = []

func _on_consumption_area_body_entered(body: Node2D) -> void:
	if body is Seed: return
	
	if not body is Fruit: return
	
	# Add fruit to juice. 
	animator.play("suck")
	print(body.name)
	
	var fruit_name = body.fruit_name  # body.name.rstrip("1234567890")  # Remove numbers from name. 
	
	juice.append(fruit_name)
	contents += 1 
	body.queue_free()
	
	if not fruit_name in Globals.list_of_fruits:
		fruit_name = Globals.list_of_fruits.pick_random() 
	
	# Add fruit to panel. 
	fruit_panel_container_new.add_fruit_to_panel(fruit_name)
	
	$Audio/Plunger.play()

	# WARNING: Maximum amount of fruits reached. 
	if contents >= 3: 
		contents = 0
		consumption_shape.set_deferred("disabled", true)
		can_blend = true
		return

var can_blend: bool = false 

func _on_juice_button_pressed():
	# Blend the juice only when the max number of fruits (3) is inside. 
	if can_blend:
		print(juice)
		$Audio/Blend.play()
		is_juicing = true 
		can_blend = false
		animator.play("blend")
		
		# Wait for some time.
		await get_tree().create_timer(randf_range(1, 3)).timeout
		animator.play("suck")
		
		await animator.animation_finished
		$Audio/Blend.stop()
		animator.play("open")
		$Audio/Ping.play()

const JUICE = preload("res://scenes/juice/base_juice.tscn")
@onready var juice_spawn = $JuiceSpawn

func give_juice(): 
	# Spawn the juice in the world!!!
	var juice_bottle = JUICE.instantiate()
	juice_bottle.global_position = juice_spawn.global_position
	get_tree().get_root().add_child(juice_bottle)
	juice_bottle.init(juice)
	
	# Renable the suck shop
	await get_tree().create_timer(1).timeout
	animator.play("RESET")
	contents = 0
	juice = []
	is_juicing = false
	
	var new_juice = ['empty', 'empty', 'empty']
	fruit_panel_container_new.replace_fruit_recipe(new_juice)
	consumption_shape.set_deferred("disabled", false)
	



func _on_animator_animation_finished(anim_name):
	if anim_name == "open": 
		give_juice()

var is_juicing: bool = false

func _on_spit_button_pressed():
	if is_juicing: return 
	
	var new_juice = ['empty', 'empty', 'empty']
	juice = []
	contents = 0
	consumption_shape.set_deferred("disabled", false)
	
	fruit_panel_container_new.replace_fruit_recipe(new_juice)
