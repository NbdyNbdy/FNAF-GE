extends Node3D

var exitpressed = false
@onready var fnafscene = preload("res://fnaf/fnaf.tscn")

func _process(delta):
	$camui/menu/continue/night.text = "Night " + str(Fnafdata.night)

func _on_exit_mouse_entered():
	$cammuneextra.play("exit")
func _on_exit_mouse_exited():
	if exitpressed != true:
		$cammuneextra.play_backwards("exit")
func _on_exit_pressed():
	exitpressed = true
	$cammenu.play("exit")
	$cammuneextra.play("exitpressed")
func exit():
	get_tree().quit()
	
func _on_newgame_pressed():
	$cammenu.play("play")
	$cammuneextra.play("newgamepressed")
func _on_newgame_mouse_entered():
	$cammuneextra.play("newgame")
func _on_newgame_mouse_exited():
	$cammuneextra.play_backwards("newgame")
func play():
	Fnafdata.night = 1
	get_tree().change_scene_to_packed(fnafscene)
	
func _on_continue_pressed():
	$cammenu.play("continueplay")
	$cammuneextra.play("continueplay")
func _on_continue_mouse_entered():
	$cammuneextra.play("continue")
func _on_continue_mouse_exited():
	$cammuneextra.play_backwards("continue")
func play2():
	get_tree().change_scene_to_packed(fnafscene)


