extends Sprite2D

@onready var tree_spawn_marker = $TreeSpawnMarker

@onready var seed_detector_shape = $SeedDetector/SeedDetectorShape



func _on_seed_detector_body_entered(body):
	# This body is not a seed. 
	if not body is Seed: return
	
	# TODO: Check if the dirtblock already has a tree. 
	
	
	call_deferred("spawn_tree_on_dirt_block", body)

func spawn_tree_on_dirt_block(fruit_seed: Seed):
	seed_detector_shape.disabled = true
	
	# Spawn a certain tree based on the seed. 
	var tree = fruit_seed.tree_type.instantiate()
	
	# Position tree. 
	var spawn_point = tree_spawn_marker.position
	add_child(tree)	
	spawn_point.y -= tree.sprite.texture.get_height()/2
	tree.position = spawn_point
	
	fruit_seed.queue_free()
