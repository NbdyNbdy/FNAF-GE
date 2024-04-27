extends Node3D

var fodifficulty = 0
var foinstate1 = true
var foinstate2 = false
var foinstate3 = false
var foinstate4 = false

func fo():
	if foinstate1:
		foinstate1 = false
		foinstate2 = true
		$foap.play("state2")
	elif foinstate2:
		foinstate2 = false
		foinstate3 = true
		$foap.play("state3")
	elif foinstate3:
		foinstate3 = false
		foinstate4 = true
		$foap.play("state4")

func _on_foap_animation_finished(anim):
	if anim == "state4":
		if $"../../interactable/leftredofficebutton".on:
			foinstate4 = false
			foinstate1 = true
			$"../../player/doorhit".play()
			$"../../player/doorhit".play()
			$foap.play("state1")
		elif $"../../interactable/leftredofficebutton".on == false:
			$"../../player".camcanrotate = false
			if $"../../player".camopen:
				$"../../player/cameratabap".play("cameratabclose2")
			$"../../player/player".look_at($body/head/lowerhead.global_transform.origin)
			$"../../player".look_at($body/head/lowerhead.global_transform.origin)
			$foap.play("jumpscare")

func _on_fotimer_timeout():
	var rng = randf_range(1, 20)
	if rng <= fodifficulty:
		fo()

func fodisable():
	$fotimer.stop()
	foinstate1 = true
	foinstate2 = false
	foinstate3 = false
	foinstate4 = false
	$foap.play("RESET")

func four():
	if $"../../player".currentcam == 4:
		$"../../player".camstatic()

func four_six():
	if $"../../player".currentcam == 4 or $"../../player".currentcam == 6:
		$"../../player".camstatic()
