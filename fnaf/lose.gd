extends Node3D

var canclick = false
@onready var menuscene = load("res://fnaf/menu.tscn")

func _input(event):
	if Input.is_action_just_pressed("interact") and canclick:
		$AnimationPlayer.play("transition")

func _on_animation_player_animation_finished(anim):
	if anim == "lose":
		canclick = true
	elif anim == "transition":
		get_tree().change_scene_to_packed(menuscene)
