extends CharacterBody2D


const SPEED = 225.0
const JUMP_VELOCITY = -200
const acceleration: float = 1000.0
const friction: float = 1500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var state_machine = $StateMachine
@onready var pickup_zone = $General/PickupZone
@onready var pickup_marker = $General/PickupMarker
@onready var sprite = $General/Sprite
@onready var pickup_collider = $General/PickupZone/PickupCollider


# TODO: Double Jump.


func _ready():
	state_machine.init(self) 
	
@onready var footsteps = $Audio/Footsteps

func _physics_process(_delta):
	flip_player()
	
	if not footsteps.is_playing() and abs(velocity.x) > 0 and is_on_floor() :
		footsteps.play()


func handle_movement(delta):
	# Handle player movement. 
	var direction := Input.get_axis("left", "right")
	# Move in the given direction when move is pressed. 
	if direction: velocity.x = move_toward(velocity.x, direction * SPEED, delta * acceleration)
	# Not moving. Graudally lower velocity to 0.
	else: velocity.x = move_toward(velocity.x, 0, delta * friction)
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY# Handle jump.
		$Audio/Jump.play()


func handle_gravity(delta: float): 
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

#func _draw():
	#draw_line(Vector2.ZERO, Vector2(50, -50), Color.RED, 2)

var facing_right: bool
func flip_player(): 
	if velocity.x > 0: 
		facing_right = true
		sprite.flip_h = true
		# Flip Pickup Zone. 
		pickup_collider.position.x = 10
	elif velocity.x < 0: 
		facing_right = false
		sprite.flip_h = false
		pickup_collider.position.x = -10



var is_mouse_in_throw_area: bool = false

func _on_throw_area_mouse_entered():
	is_mouse_in_throw_area = true

func _on_throw_area_mouse_exited():
	is_mouse_in_throw_area = false

