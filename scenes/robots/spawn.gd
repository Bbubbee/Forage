extends State

@onready var fruit_panel_container_new = $"../../FruitPanelContainerNew"

func enter(_enter_params = null):
	actor.animator.play("spawn")
	fruit_panel_container_new.display_fruit_panels()


func _on_animator_animation_finished(anim_name: StringName) -> void:
	if anim_name == "spawn": 
		transition.emit(self, "idle")
