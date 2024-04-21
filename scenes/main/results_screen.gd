extends Control

@onready var money_label = $VBoxContainer/MoneyStat/MoneyLabel
@onready var robot_label = $VBoxContainer/RobotStat/RobotLabel

func _ready():
	money_label.text = "= " + str(Stats.money)
	robot_label.text = "= " + str(Stats.robots)
	
