extends Area2D

func _ready():
	pass

func _on_Obstacle_body_entered(body):
	body.slow_down()
	pass

