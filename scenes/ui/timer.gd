extends TextureProgressBar


@export var patience_time: float = 100

signal im_out_of_patience


# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = patience_time
	value = patience_time

var call_once: bool = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	patience_time -= delta
	value = patience_time
	
	
	if patience_time <= 0 and call_once:
		call_once = false 
		im_out_of_patience.emit()
