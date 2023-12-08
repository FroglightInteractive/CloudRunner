extends StaticBody2D

@onready var player = get_parent().get_parent().get_node("Player")

func _ready():
	pass
	
	
func _process(_delta):
	if global_position.distance_to(player.position) > 1500 and player.position.x > global_position.x:
		queue_free()
