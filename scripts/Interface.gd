extends Control
var gaming = true
var world = preload("res://scenes/World.tscn").instance()

func _ready():
	$Control/VSlider.set_value(0)
	$IntroMusic.play(1.5)

func _on_VSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

func _on_Volume_pressed():
	$Control/VSlider.set_visible(true)

func _on_VSlider_mouse_exited():
	$Control/VSlider.set_visible(false)

func _process(delta):
	if Input.is_action_pressed("ui_accept") and !gaming:
		$CRT_Shader_Control.visible = false
		$IntroMusic/Fader.start()
		$Obstacle/Reporter.wth()
		$Control.visible = false
		$BG/Anime.play("Fade")
		add_child(world)
		gaming = true

func _on_Fader_timeout():
	if $IntroMusic.volume_db > -50:
		$IntroMusic.volume_db -= 2
	else: 
		$IntroMusic.stop()
		$IntroMusic/Fader.stop()

func _on_Starter_timeout():
	gaming = false
