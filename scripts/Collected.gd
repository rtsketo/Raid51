extends Node2D
var pos = Vector2()
var started = false
var speed = 600
var order

func _ready():
	pass

func _process(delta):
	if started:
		var yCalc = 50
		var xCalc = 50 + 50 * order
		if position.y != yCalc: position.y -= speed*delta
		if position.x < xCalc: position.x += speed * delta
		elif position.x > xCalc: position.x -= speed * delta	
		if abs(position.x - xCalc) <= speed * delta: position.x = xCalc
		if abs(position.y - yCalc) <= speed * delta: position.y = yCalc
		if position == Vector2(xCalc, yCalc): started = false

func start(posit, num):
	position = posit
	order = num - 1
	started = true
