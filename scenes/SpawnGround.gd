extends Node2D

const GROUNDSPAWNER = preload("res://scenes/ground.tscn")
const GROUNDWIDTH = 282
var spawn_position = global_position
@onready var player = get_parent().get_node("Player")
var platform_number = 0

func _ready():
	pass
	
	
func _process(_delta):
	if spawn_position.distance_to(player.position) < 1500:
		spawn_ground()

func max_rise_for_x(x):
	if x < 0:
		x = 0
	var g = player.gravity		# positive
	var vx = player.speed
	var vy0 = player.JUMP_VELOCITY		# negative
	var tfar = x / vx
	var ttop = -vy0 / g
	
	var t
	if tfar > ttop:
		t = tfar
	else:
		t = ttop
	var y = vy0 * t + 0.5 * g * t * t	
	return y

		
func spawn_ground():
	var spawn_ground_instance = GROUNDSPAWNER.instantiate()
	add_child(spawn_ground_instance)
	spawn_ground_instance.global_position.x = spawn_position.x
	spawn_ground_instance.global_position.y = spawn_position.y
	
	randomize()
	
	if platform_number < 1:
		spawn_position.x = spawn_position.x + GROUNDWIDTH
	else:
	
		var dx = randi_range(0, 300)
		var dy = randi_range(0, 75)
		var yimpossible = max_rise_for_x(dx - player.playerWidth())
		
		spawn_position.x = spawn_position.x + GROUNDWIDTH + dx
		spawn_position.y = spawn_position.y + dy + yimpossible + 20
	platform_number += 1


