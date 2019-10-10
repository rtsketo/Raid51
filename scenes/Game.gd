extends Control

func _ready():
	var ui = load("res://scenes/Interface.tscn").instance()
	Input.action_release("ui_accept")
	add_child(ui)

func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed(): Input.action_press("ui_accept")
		else: Input.action_release("ui_accept")
