extends Node3D

@onready var menuscene = load("res://fnaf/menu.tscn")

func _on_ap_animation_finished(anim):
	if anim == "win":
		get_tree().change_scene_to_packed(menuscene)
