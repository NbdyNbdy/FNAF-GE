extends Node3D

var bdifficulty = 0
var binmainstage = true
var bindiningarea = false
var binbackstage = false
var binsupplycloset = false
var binwesthall = false
var binoffice = false
var bcanjumpscare = false

func b():
	if binmainstage:
		var rng = randf_range( 1, 4)
		if rng >= 2:
			$bap.play("mainstagetodiningarea")
		else:
			$bap.play("mainstagetobackstage")
	elif bindiningarea:
		var rng = randf_range( 1, 4)
		if rng >= 2:
			$bap.play("diningareatowesthall")
		else:
			$bap.play("diningareatobackstage")
	elif binbackstage == true:
		$bap.play("backstagetodiningarea")
	elif binsupplycloset == true:
		var rng = randf_range( 1, 4)
		if rng >= 2:
			$bap.play("supplyclosettooffice")
		else:
			$bap.play("supplyclosettodiningarea")
	elif binwesthall == true:
		$bap.play("westhalltosupplycloset")
	elif binoffice == true:
		$bap.play("readyjumpscare")
	elif bcanjumpscare and $"../../interactable/leftredofficebutton".on == false:
		$"../../player".camcanrotate = false
		if $"../../player".camopen:
			$"../../player/cameratabap".play("cameratabclose2")
		$"../../player/effects/camtransitionap".play("camtransition2")
		$bap.play("jumpscare")
	elif bcanjumpscare and $"../../interactable/leftredofficebutton".on:
		$"../../player/doorhit".play()
		$bap.play("officetomainstage")

func _on_bap_animation_started(anim):
	if anim == "mainstagetodiningarea":
		binmainstage = false
		bindiningarea = true
	elif anim == "mainstagetobackstage":
		binmainstage = false
		binbackstage = true
	elif anim == "diningareatowesthall":
		bindiningarea = false
		binwesthall = true
	elif anim == "diningareatobackstage":
		bindiningarea = false
		binbackstage = true
	elif anim == "backstagetodiningarea":
		binbackstage = false
		bindiningarea = true
	elif anim == "supplyclosettodiningarea":
		binsupplycloset = false
		bindiningarea = true
	elif anim == "supplyclosettooffice":
		binsupplycloset = false
		binoffice = true
	elif anim == "westhalltosupplycloset":
		binwesthall = false
		binsupplycloset = true
	elif anim == "officetomainstage":
		bcanjumpscare = false
		binoffice = false
		binmainstage = true
	elif anim == "readyjumpscare":
		bcanjumpscare = true
		binoffice = false

func _on_btimer_timeout():
	var rng = randf_range(1, 20)
	if rng <= bdifficulty:
		b()

func bdisable():
	$bap.stop()
	binbackstage = false
	bindiningarea= false
	binoffice = false
	binsupplycloset = false
	binwesthall = false
	bcanjumpscare = false
	binmainstage = true
	$bap.play("RESET")

func one_two():
	if $"../../player".currentcam == 1 or $"../../player".currentcam == 2:
		$"../../player".camstatic()

func two_three():
	if $"../../player".currentcam == 2 or $"../../player".currentcam == 3:
		$"../../player".camstatic()

func one_three():
	if $"../../player".currentcam == 1 or $"../../player".currentcam == 3:
		$"../../player".camstatic()

func two_six():
	if $"../../player".currentcam == 2 or $"../../player".currentcam == 6:
		$"../../player".camstatic()

func one_seven():
	if $"../../player".currentcam == 1 or $"../../player".currentcam == 7:
		$"../../player".camstatic()

func two_five():
	if $"../../player".currentcam == 2 or $"../../player".currentcam == 5:
		$"../../player".camstatic()

func five_seven():
	if $"../../player".currentcam == 5 or $"../../player".currentcam == 7:
		$"../../player".camstatic()

func three():
	if $"../../player".currentcam == 3:
		$"../../player".camstatic()

func six_seven():
	if $"../../player".currentcam == 6 or $"../../player".currentcam == 7:
		$"../../player".camstatic()
