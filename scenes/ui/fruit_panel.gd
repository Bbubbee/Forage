extends Panel
class_name FruitPanel

@onready var fruit_sprite: Sprite2D = $FruitSprite

var occupied: bool = false

func init(fruit: String):
	occupied = true
	match fruit.to_lower(): 
		"peach":
			fruit_sprite.texture = load("res://assets/fruits/peach-Sheet.png")
		"apple":
			fruit_sprite.texture = load("res://assets/fruits/apple-Sheet.png")
		"blueberry": 
			fruit_sprite.texture = load("res://assets/fruits/blueberry-Sheet.png")	
		"empty": 
			occupied = false

func add_fruit_to_frame(fruit: String): 
	occupied = true
	match fruit.to_lower(): 
		"peach":
			fruit_sprite.texture = load("res://assets/fruits/peach-Sheet.png")
		"apple":
			fruit_sprite.texture = load("res://assets/fruits/apple-Sheet.png")
		"blueberry": 
			fruit_sprite.texture = load("res://assets/fruits/blueberry-Sheet.png")	
		"empty": 
			occupied = false

