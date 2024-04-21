extends Fruit

class_name Seed

# The type of tree this seed will spawn. 
@export var tree_type: PackedScene


func _on_despawn_timer_timeout():
	queue_free()
	
func pick_up(): 
	$Pop.play()
	state_machine.force_transition("held")
