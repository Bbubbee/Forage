extends Control

@onready var money_label = $VBoxContainer/MoneyStat/MoneyLabel
@onready var robot_label = $VBoxContainer/RobotStat/RobotLabel

var money 
var robots

func _ready():
	
	money_label.text = "= " + str(Stats.money)
	robot_label.text = "= " + str(Stats.robots)
	


func _on_button_pressed():
	SceneTransition.change_scene("res://scenes/levels/level_1.tscn")



	
