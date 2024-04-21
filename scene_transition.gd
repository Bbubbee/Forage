extends CanvasLayer

@onready var animator = $Animator

func change_scene(target: String) -> void:
	animator.play("dissolve")
	await animator.animation_finished
	
	get_tree().change_scene_to_file(target) 
	animator.play_backwards("dissolve")

var cloud_transition_target 

func cloud_transition(target: String):
	cloud_transition_target = target
	animator.play("cloud_in")


func cloud_transition_change_scene(): 
	get_tree().change_scene_to_file(cloud_transition_target) 
