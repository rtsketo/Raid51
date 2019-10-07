extends Node2D

func _ready():
	pass 


func _on_LFench_body_entered(body):
	body.slow_down()
	$Graphics/LUp.visible = false
	$Graphics/LFall.visible = true
	$Graphics/LFallUp.visible = true

func _on_RFench_body_entered(body):
	body.slow_down()
	$Graphics/RUp.visible = false
	$Graphics/RFall.visible = true
	$Graphics/RFallUp.visible = true

func _on_RRFench_body_entered(body):
	body.slow_down()
	$Graphics/RRUp.visible = false
	$Graphics/RRFall.visible = true
	$Graphics/RRFallUp.visible = true
