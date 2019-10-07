extends Control

func _ready():
	var ui = load("res://scenes/Interface.tscn").instance()
	add_child(ui)
