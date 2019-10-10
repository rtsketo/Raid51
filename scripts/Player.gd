extends KinematicBody2D
var collected = []
var sprites = []
var items = []

var ending = false
var start = false
var ended = false
var press = false
var mach = false
var hit = false

var endingTime = 0
#var startTime = 180

var maxSpeed = 200
var speed = 50
var speedX = 0
var speedY = 0
var endingCount
var diff = 0
var pos = 0
var dir = 1

onready var hitMeBaby = [
preload("res://assets/sounds/Area 51 SF part 2/kraygh1.wav"),
preload("res://assets/sounds/Area 51 SF part 2/kraygh2.wav"),
preload("res://assets/sounds/Area 51 SF part 2/kraugh3.wav"),
preload("res://assets/sounds/Area 51 SF part 2/kraugh4.wav")]

onready var yeahBaby = [
preload("res://assets/sounds/Area 51 SF part 3/yeah1.wav"),
preload("res://assets/sounds/Area 51 SF part 3/yeah2.wav"),
preload("res://assets/sounds/Area 51 SF part 3/yooho1.wav"),
preload("res://assets/sounds/Area 51 SF part 3/yooho2.wav"),
preload("res://assets/sounds/Area 51 SF part 3/yooho3.wav")]

func _ready():
	sprites = [
	get_node("Ending/Control/Sprite1"),
	$Ending/Control/Sprite2,
	$Ending/Control/Sprite3,
	$Ending/Control/Sprite4,
	$Ending/Control/Sprite5,
	$Ending/Control/Sprite6,
	$Ending/Control/Sprite7,
	$Ending/Control/Sprite8]

	items = [
	$Ending/Control/Item1,
	$Ending/Control/Item2,
	$Ending/Control/Item3,
	$Ending/Control/Item4,
	$Ending/Control/Item5,
	$Ending/Control/Item6,
	$Ending/Control/Item7,
	$Ending/Control/Item8]

func _process(delta):
	var calibra = 7
	var preDir = dir
	speedX += speed
	
	if ended and Input.is_action_pressed("ui_accept"):
		var root = get_tree().get_root() 
		Input.action_release("ui_accept")
		root.get_child(root.get_child_count()-1).queue_free()
		var ui = load("res://scenes/Interface.tscn").instance()
		root.add_child(ui)
	
	if diff != 0:
		speedY = abs(diff) * calibra
		dir = -sign(diff)
	elif Input.is_action_pressed("ui_up"):
		speedY += speed
		dir = -1
	elif Input.is_action_pressed("ui_down"):
		speedY += speed
		dir = 1
	else: speedY = 0
	
	if hit:
		speedX = 0
		hit = false
		if maxSpeed > 200:
			maxSpeed -= 100
		if maxSpeed > 600:
			maxSpeed = 600
	
	if speedX > maxSpeed: speedX = maxSpeed
	if speedY > maxSpeed: speedY = maxSpeed
	if preDir * dir != 1: speedY = 10
	
	if position.y < -15 and dir == -1: speedY = 0
	if position.y > 210 and dir == 1: speedY = 0
	
#	if speedX != 0 or speedY != 0:
#		$Anime.playback_speed = 7 * max(speedX, speedY) / 500
#		$Anime.play("Walk")
#	else: $Anime.stop(false)
	
	if position.y < -5: z_index = 1
	elif position.y > 205: z_index = 9
	elif position.y > 135: z_index = 7
	elif position.y > 65: z_index = 5
	elif position.y > -5: z_index = 3
	
	if ending:
		speedY = 200
		maxSpeed = 400
		if speedX > 400: speedX -= 20
		if position.y > 65: dir = -1
		elif position.y < 55: dir = 1
		else: speedY = 0
	
	if !start: speedX = 0
	if $Graphics/Anime.animation != "Run":
		speedY = 0
	
	#move_and_collide(Vector2(speedX, dir*speedY)*delta)
	move_local_x(speedX*delta)
	move_local_y(speedY*delta*dir)

func slow_down():
	hit = true
	$Graphics/Anime.play("Hit")
	$Hit.stream = hitMeBaby[randi()%4]
	$Graphics/Shadow.play("Shadow")
	$Hit.play()

func speed_up(collectable):
	maxSpeed = 1300
	collected.append(collectable)
	$Yeah.stream = yeahBaby[randi()%5]
	$Yeah.play()

func _on_Timer_timeout():
	if maxSpeed < 1200: maxSpeed += 20
	
	if speedX > 800 and !mach:
		$Particles.visible = true
		$Nitro.play()
		mach = true
	elif speedX < 800 and mach:
		$Particles.visible = false
		mach = false

func _on_StartTimer_timeout():
	$Ending/TimeIndicator/Timer.start()
	$Ending/TimeIndicator.visible = true
	$Hype.play()
	start = true

func _on_Anime_animation_finished():
	$Graphics/Anime.play("Run")

func go_to_portal():
	$Cam.smoothing_speed = .4
	$Portacles.visible = true
	$Ending/TimeIndicator.visible = false
	endingTime = $Ending/TimeIndicator.posit
	ending = true

func end_this():
	start = false
	$AnimeEnding.play("End")
	$Ending/CRT.visible = true
	endingCount = collected.size() + 5
	for x in range(collected.size()):
		sprites[x].texture = collected[x].get_node("Sprite").texture
		sprites[x].scale = collected[x].get_node("Sprite").scale
		items[x].text = collected[x].get_node("Label").text
	if collected.size() == 0:
		$Ending/Control/Items.text = "You didn't uncover any secrets...\nWas it all in vain?"
	$Ending/EndingTimer.start()

func _on_EndingTimer_timeout():
	if endingCount == collected.size() + 1:
		$Ending/Control/Items.visible = true
	if endingCount < collected.size() and endingCount > -1:
		sprites[collected.size() - endingCount - 1].visible = true
		items[collected.size() - endingCount - 1].visible = true
		$Ending/Effect.play()
	if endingCount == -1:
		$Ending/Control/Time.text = "Your time: " + String(endingTime) + " sec"
		$Ending/Control/Time.visible = true
		$Ending/Effect.play()
		ended = true
		$End.play()
	endingCount -= 1
	
func _on_MusicFader_timeout():
#	if music:
#		increaseDB($Music, 5)
#		decreaseDB($Hype, 5)
#	elif hype:
#		decreaseDB($Music, 5)
#		increaseDB($Hype, 5)
#	else:
#	decreaseDB($Music, 1)
	decreaseDB($Hype, 1)

func decreaseDB(node, x):
	if node.volume_db > -70:
		node.volume_db -= x

#func increaseDB(node, x):
#	if node.volume_db < -x:
#		node.volume_db += x

func _input(event):
	if event is InputEventScreenDrag and press:
		var posy = event.position.y
		diff = pos - posy
	
	if event is InputEventScreenTouch:
		if event.is_pressed():
			pos = event.position.y
			press = true
		else: 
			press = false
			diff = 0


