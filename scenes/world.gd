extends Node2D

var survival_time = 0
var paused = false
var nightmare_mode = false
var baby_mode = false
var normal_mode = true

signal HUD_restart

func _ready():
	$HUD/GameOver.hide()
	$HUD/Restart.hide()
	$HUD/QUIT.hide()
	$HUD/Resume.hide()
	$HUD/Modes.hide()
	
	
func _process(_delta):
	if $Player.is_alive:
		if nightmare_mode:
			if Input.is_action_just_pressed("jump"):
				nightmareMode()
				
		$Background.position = $Player.position
		if Input.is_action_just_pressed("pause"):
			if not paused:
				pause()
			else:
				unpause()
	else:
		return


func _on_survival_time_timeout():
	if not paused:
		if $Player.is_alive:
			survival_time += 0.1
			$SurvivalTimer.start()
			$HUD/Label.set_text("Time: %.1f" % survival_time)
		else:
			$HUD/GameOver.show()
			$HUD/Restart.show()
			$HUD/QUIT.show()
			$HUD/Modes.show()


func pause():
	$HUD/Restart.show()
	$HUD/Modes.show()
	$HUD/QUIT.show()
	$HUD/Resume.show()
	$Player.velocity.x = 0
	$Player.velocity.y = 0
	paused = true
	
	
func unpause():
	$HUD/Restart.hide()
	$HUD/QUIT.hide()
	$HUD/Resume.hide()
	$HUD/Modes.hide()
	paused = false


func _on_hud_restart():
	emit_signal("HUD_restart")


func nightmareMode():
	$Player.game_normal_mode = false
	$Player.game_nightmare_mode = true
	$Player.game_baby_mode = false
	
	var colors = [
		Color(1, 0.972549, 0.862745, 1),
		Color(0, 1, 1, 1),
		Color(0, 0, 0.545098, 1),
		Color(0, 0.545098, 0.545098, 1),
		Color(0.721569, 0.52549, 0.0431373, 1),
		Color(0.333333, 0.419608, 0.184314, 1),
		Color(0.560784, 0.737255, 0.560784, 1),
		Color(0.282353, 0.239216, 0.545098, 1),
		Color(0, 0.807843, 0.819608, 1),
		Color(0, 0.74902, 1, 1),
		Color(0.411765, 0.411765, 0.411765, 1),
		Color(1, 0.980392, 0.941176, 1),
		Color(0.972549, 0.972549, 1, 1),
		Color(1, 0.843137, 0, 1),
		Color(0.752941, 0.752941, 0.752941, 1),
		Color(0.0, 0.32, 1.0, 1.0)]
	randomize()
	$Background.modulate = colors[randi() % colors.size()]
	
	$Player.scale.x = 0.5
	$Player.scale.y = $Player.scale.x
	
	$Player/Camera2D.zoom.x = randf_range(0.5, 1.5)
	$Player/Camera2D.zoom.y = $Player/Camera2D.zoom.x
	


func _on_hud_nightmare_mode():
	nightmareMode()
	$HUD.markMode("Nightmare")
	nightmare_mode = true
	baby_mode = false
	normal_mode = false


func _on_hud_normal_mode():
	normalMode()
	$HUD.markMode("Normal")
	nightmare_mode = false
	baby_mode = false
	normal_mode = true


func normalMode():
	$Player.game_normal_mode = true
	$Player.game_nightmare_mode = false
	$Player.game_baby_mode = false
	
	$Player.scale.x = 1
	$Player.scale.y = $Player.scale.x
	
	$Player/Camera2D.zoom.x = 1
	$Player/Camera2D.zoom.y = $Player/Camera2D.zoom.x
	$Background.modulate = Color(0.0, 0.32, 1.0, 1.0)


func _on_hud_baby_mode():
	babyMode()
	$HUD.markMode("Baby")
	nightmare_mode = false
	baby_mode = true
	normal_mode = false



func babyMode():
	$Player.game_normal_mode = false
	$Player.game_nightmare_mode = false
	$Player.game_baby_mode = true
	
	$Player.scale.x = 1.5
	$Player.scale.y = $Player.scale.x
	
	$Player/Camera2D.zoom.x = 0.75
	$Player/Camera2D.zoom.y = $Player/Camera2D.zoom.x
	$Background.modulate = Color(0.0, 0.32, 1.0, 1.0)
