extends Control

@onready var money_count = $MoneyCount

func _ready():
	Stats.money_changed.connect(show_new_money) 


func show_new_money(new_money): 
	money_count.text = str(new_money)
