extends Node2D

func _ready():
	$Portal/CRT_Shader_Control.set("z_index", 15)

func _on_PortalSound_body_entered(body):
	body.get_node("MusicFader").start()
	$PortalSound/Sound.play()
	print("sound")

func _on_Finishing_body_entered(body):
	body.go_to_portal()


func _on_Credits_body_entered(body):
	body.end_this()
