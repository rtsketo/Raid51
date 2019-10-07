extends Area2D

func _ready():
	pass

func _on_Collectable_body_entered(body):
	body.speed_up(self)
	visible = false
