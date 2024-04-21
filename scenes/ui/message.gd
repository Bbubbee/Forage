extends Node2D


#@export_multiline var message: String = "sample sample sample"
@export var destroy_later: bool = false

@onready var animator = $Animator
@onready var rich_text_label = $RichTextLabel

func _ready():
	animator.play("invisible")



func _on_player_detector_body_entered(body):
	animator.play("appear")


func _on_player_detector_body_exited(body):
	animator.play("disappear")


func _on_animator_animation_finished(anim_name):
	if anim_name == "disappear" and destroy_later: 
		queue_free()
