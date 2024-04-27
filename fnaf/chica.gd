extends Node3D

var cdifficulty = 0
var cineasthall = false
var cinmainstage = true
var cinkitchen = false
var cindiningarea = false
var cinrestrooms = false
var cinoffice = false
var ccanjumpscare = false

func c():
	if cinmainstage:
		$cap.play("mainstagetodiningarea")
	elif cindiningarea:
		var random = randf_range( 1, 6)
		if random <= 2:
			$cap.play("diningareatorestrooms")
		elif random <= 4:
			$cap.play("diningareatokitchen")
		elif random <= 6:
			$cap.play("diningareatoeasthall")
	elif cineasthall:
		$cap.play("easthalltooffice")
	elif cinkitchen:
		$cap.play("kitchentodiningarea")
	elif cinrestrooms:
		$cap.play("restroomstodiningarea")
	elif cinoffice:
		$cap.play("readyjumpscare")
	elif ccanjumpscare and $"../../interactable/rightredofficebutton".on == false:
		$"../../player".camcanrotate = false
		if $"../../player".camopen:
			$"../../player/cameratabap".play("cameratabclose2")
		$"../../player/effects/camtransitionap".play("camtransition2")
		$cap.play("jumpscare")
	elif ccanjumpscare and $"../../interactable/rightredofficebutton".on:
		$cap.play("officetomainstage")

func _on_cap_animation_started(anim):
	if anim == "mainstagetodiningarea":
		cinmainstage = false
		cindiningarea = true
	elif anim == "diningareatokitchen":
		cindiningarea = false
		cinkitchen = true
	elif anim == "kitchentodiningarea":
		cinkitchen = false
		cindiningarea = true
	elif anim == "diningareatorestrooms":
		cindiningarea = false
		cinrestrooms = true
	elif anim == "restroomstodiningarea":
		cinrestrooms = false
		cindiningarea = true
	elif anim == "diningareatoeasthall":
		cindiningarea = false
		cineasthall = true
	elif anim == "easthalltooffice":
		cineasthall = false
		cinoffice = true
	elif anim == "officetodiningarea":
		cinoffice = false
		cindiningarea = true
	elif anim == "readyjumpscare":
		cinoffice = false
		ccanjumpscare = true
	elif anim == "officetomainstage":
		ccanjumpscare = false
		cinoffice = false
		cinmainstage = true

func _on_ctimer_timeout():
	var rng = randf_range(1, 20)
	if rng <= cdifficulty:
		c()

func cdisable():
	$ctimer.stop()
	ccanjumpscare = false
	cindiningarea = false
	cineasthall = false
	cinkitchen = false
	cinoffice = false
	cinrestrooms = false
	cinmainstage = true
	$cap.play("RESET")



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

func ten_two():
	if $"../../player".currentcam == 10 or $"../../player".currentcam == 2:
		$"../../player".camstatic()

func eight():
	if $"../../player".currentcam == 8:
		$"../../player".camstatic()
