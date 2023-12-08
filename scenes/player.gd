extends CharacterBody2D


var speed = 400.0
const JUMP_VELOCITY = -750.0
const PLAYER_WIDTH = 100		# measured

var last_speed_up = 0
var is_alive = true
var gravity = 2500
var can_jump = true

var game_baby_mode = false
var game_normal_mode = true
var game_nightmare_mode = false

func _physics_process(delta):
	if get_parent().paused:
		return

		
	if not is_alive:
		velocity.x = 0
		velocity.y = 0
		return
	
	# Change speed based on game time
	if game_normal_mode:
		if get_parent().survival_time > last_speed_up + 10:
			speed *= 1.1
			gravity *= 1.1
			last_speed_up += 10

	elif game_baby_mode:
		if get_parent().survival_time > last_speed_up + 15:
			speed *= 1.1
			gravity *= 1.1
			last_speed_up += 15
			
	elif game_nightmare_mode:
		if get_parent().survival_time > last_speed_up + 2:
			speed *= 1.1
			gravity *= 1.1
			last_speed_up += 2
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if is_on_floor():
		$CoyoteTime.stop()
		can_jump = true
	else:
		if $CoyoteTime.is_stopped():
			$CoyoteTime.start()
	
	if Input.is_action_just_pressed("jump") and can_jump:
		velocity.y = JUMP_VELOCITY
			
	if is_on_wall():
		is_alive = false
		
	var ylowest = -100000000
	for c in get_parent().get_node("SpawnGround").get_children():
		var y = c.position.y
		if y > ylowest:
			ylowest = y
	if self.position.y > ylowest:
		is_alive = false

	velocity.x = speed

	move_and_slide()


func _on_coyote_time_timeout():
	can_jump = false


func playerWidth():
	return PLAYER_WIDTH * scale.x


func _on_hud_baby_mode():
	game_baby_mode = true


func _on_hud_nightmare_mode():
	game_nightmare_mode = true


func _on_hud_normal_mode():
	game_normal_mode = true
