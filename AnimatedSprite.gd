extends AnimatedSprite

func _ready():
	pass


func _on_Area2D_body_entered(body):
	$Gun.play()
	play()
