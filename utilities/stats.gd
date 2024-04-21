extends Node


signal money_changed

var money = 0:
	set(amount): 
		money = amount
		money_changed.emit(amount)

var robots = 0: 
	set(amount): 
		robots = amount
