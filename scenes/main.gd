extends Node2D

var world = preload("res://scenes/world.tscn")

func _ready():
	pass

func _on_world_hud_restart():
	var old_world = get_node("World")
	var old_nightmare = old_world.nightmare_mode
	var old_baby = old_world.baby_mode
	var old_normal = old_world.normal_mode
	
	remove_child(old_world)
	var worldInstance = world.instantiate()
	add_child(worldInstance)
	
	if old_nightmare:
		worldInstance._on_hud_nightmare_mode()
		
	elif old_baby:
		worldInstance._on_hud_baby_mode()
		
	elif old_normal:
		worldInstance._on_hud_normal_mode()
		
	worldInstance.HUD_restart.connect(_on_world_hud_restart)
