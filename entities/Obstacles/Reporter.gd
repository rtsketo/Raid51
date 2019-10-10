extends Node2D

var dia
var tal = 0
var talk = [
"We're broadcasting live from Area 51. The raid to uncover the well hidden secrets is about to begin!",
"We don't know what to expect, as we start literally with nothing.",
"One thing is certain though, they can't stop all of us!"]
var timer = false


func _ready():
	dia = dialog(talk[0])
	
func dialog(text):
	var diag = preload("res://scenes/SimpleDialogueBox.tscn").instance()
	get_parent().get_node("Graphics/AnimatedSprite").play()
	diag.get_node("RichTextLabel").dialogue_text = text
	add_child(diag)
	return diag

func stop_talking():
	if get_parent().get_node("Graphics/AnimatedSprite").frame != 0:
		get_parent().get_node("Graphics/AnimatedSprite").frame = 0
	get_parent().get_node("Graphics/AnimatedSprite").stop()
	
	if !timer:
		$Timer.start()
		timer = true
	
func _on_Timer_timeout():
	dia.get_node("RichTextLabel").text_advance()
	remove_child(dia)
	
	if tal == talk.size() - 1:
		tal = -1
	tal += 1
	dia = dialog(talk[tal])
	timer = false

func wth():
	if get_parent().get_node("Graphics/AnimatedSprite").frame != 0:
		get_parent().get_node("Graphics/AnimatedSprite").frame = 0
	get_parent().get_node("Graphics/AnimatedSprite").stop()

	dia.get_node("RichTextLabel").text_advance()
	remove_child(dia)
	$Timer.stop()
	timer = true
	
	dialog("Wait.. What is he doing?!\nWhere is this guy going alone?!")
	

