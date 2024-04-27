extends Node3D

var frdifficulty = 0
var frinmainstage = true
var frindiningarea = false
var frinrestrooms = false
var frineasthall = false
var frinoffice = false

func f():
	var rng = randf_range( 1, 5)
	if rng >= 4:
		$"../../player/freddylaugh4".play()
	elif rng >= 3:
		$"../../player/freddylaugh3".play()
	elif rng >= 2:
		$"../../player/freddylaugh2".play()
	elif rng >= 1:
		$"../../player/freddylaugh1".play()
	if frinmainstage:
		$frap.play("mainstagetodiningarea")
	elif frindiningarea:
		var random = randf_range( 1, 3)
		if random <= 2:
			$frap.play("diningareatorestrooms")
		else:
			$frap.play("diningareatoeasthall")
	elif frineasthall:
		$frap.play("easthalltooffice")
	elif frinrestrooms:
		$frap.play("restroomstodiningarea")
	elif frinoffice and $"../../interactable/rightredofficebutton".on == false:
		$"../../player".camcanrotate = false
		if $"../../player".camopen:
			$"../../player/cameratabap".play("cameratabclose2")
		$"../../player/effects/camtransitionap".play("camtransition2")
		$frap.play("jumpscare")
	elif frinoffice and $"../../interactable/rightredofficebutton".on:
		$"../../player/doorhit".play()
		$frap.play("officetomainstage")

func _on_frap_animation_started(anim):
	if anim == "mainstagetodiningarea":
		frinmainstage = false
		frindiningarea = true
	elif anim == "diningareatorestrooms":
		frindiningarea = false
		frinrestrooms = true
	elif anim == "diningareatoeasthall":
		frindiningarea = false
		frineasthall = true
	elif anim == "easthalltooffice":
		frineasthall = false
		frinoffice = true
	elif anim == "restroomstodiningarea":
		frinrestrooms = false
		frindiningarea = true
	elif anim == "officetomainstage":
		frinoffice = false
		frinmainstage = true

func _on_frtimer_timeout():
	var rng = randf_range(1, 20)
	if rng <= frdifficulty:
		f()

func frdisable():
	$frtimer.stop()
	frindiningarea = false
	frineasthall = false
	frinoffice = false
	frinrestrooms = false
	frinmainstage = true
	$frap.play("RESET")

func one_two():
	if $"../../player".currentcam == 1 or $"../../player".currentcam == 2:
		$"../../player".camstatic()

func two_nine():
	if $"../../player".currentcam == 2 or $"../../player".currentcam == 9:
		$"../../player".camstatic()

func two_eleven():
	if $"../../player".currentcam == 2 or $"../../player".currentcam == 11:
		$"../../player".camstatic()

func eight_nine():
	if $"../../player".currentcam == 8 or $"../../player".currentcam == 9:
		$"../../player".camstatic()

func eight_one():
	if $"../../player".currentcam == 8 or $"../../player".currentcam == 1:
		$"../../player".camstatic()

func eleven_two():
	if $"../../player".currentcam == 11 or $"../../player".currentcam == 2:
		$"../../player".camstatic()
