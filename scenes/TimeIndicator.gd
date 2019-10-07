extends Control
var time = 180
var posit = 0
func _ready():
	pass 

func _on_Timer_timeout():
	time -= 1
	posit += 1
	$Time.text = String(posit)
