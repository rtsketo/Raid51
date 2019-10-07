extends Node2D

var last = 5100
var lane = [-5, 65, 135, 205]

func _ready():
	var obst = [
	preload("res://entities/Obstacles/Tentacle.tscn"),
	preload("res://entities/obstacles/MIBlack.tscn"),
	preload("res://entities/obstacles/Mobkun.tscn"),
	preload("res://entities/obstacles/Alienud.tscn"),
	preload("res://entities/Obstacles/Alienuda.tscn"),
	preload("res://entities/Obstacles/SoulEater.tscn"),
	preload("res://entities/Obstacles/Mobkunaki.tscn"),
	preload("res://entities/Obstacles/Soldier.tscn")]
	
	var coll = [
	preload("res://entities/Collectables/ToothPaste.tscn"),
	preload("res://entities/Collectables/HalfLife3.tscn"),
	preload("res://entities/Collectables/PauseButton.tscn"),
	preload("res://entities/Collectables/Shrek5.tscn"),
	preload("res://entities/Collectables/ChainMail.tscn"),
	preload("res://entities/Collectables/Windows9.tscn"),
	preload("res://entities/Collectables/Apple.tscn"),
	preload("res://entities/Collectables/ChuckNorris.tscn"),
	preload("res://entities/Collectables/KrabbyPatty.tscn"),
	preload("res://entities/Collectables/GoThrones.tscn"),
	preload("res://entities/Collectables/BoChips.tscn")]

	var put = 0
	randomize()
	for pos in range(72000):
		if pos > last + randf()*1500+750:
			
			var something
			var level = randi()%4
			if randi()%100 < 8 and put < 8:
				if coll.size() != 0:
					var item = randi()%coll.size()
					something = coll[item].instance()
					coll.remove(item)
					put += 1
			else: something = obst[randi()%obst.size()].instance()
			
			if something != null:
				something.position.y = lane[level]
				something.z_index = (level + 1) * 2
				something.position.x = pos
				add_child(something)
			last = pos
