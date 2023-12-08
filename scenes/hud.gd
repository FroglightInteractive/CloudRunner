extends CanvasLayer

signal restart
signal nightmare_mode
signal normal_mode
signal baby_mode


func _on_restart_button_down():
	emit_signal("restart")


func _on_quit_button_down():
	get_parent().get_parent().get_tree().quit()


func _on_resume_button_down():
	get_parent().unpause()


func _on_nightmare_button_down():
	emit_signal("nightmare_mode")
	
	
	
func markMode(m):
	$CurrentMode.set_text("Current Mode: " + m)


func _on_normal_button_down():
	emit_signal("normal_mode")


func _on_baby_button_down():
	emit_signal("baby_mode")
