extends State


func enter(_enter_params = null):
	actor.animator.play("spawn")





func _on_animator_animation_finished(anim_name: StringName) -> void:
	if anim_name == "spawn": 
		transition.emit(self, "idle")
