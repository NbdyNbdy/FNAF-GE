extends Node3D
#==============================================GAME STUFF==============================================#
var sensitivity = 0.5
var turning_speed = 1.0
var camopen = false
var camcanrotate = true
var currentcam
var nighttime = 0
var power = 100
@onready var powert = $power
@onready var fo = $"../animatronics/foxy"
@onready var b = $"../animatronics/bonnie"
@onready var c = $"../animatronics/chica"
@onready var fr = $"../animatronics/freddy"
@onready var losescene = preload("res://fnaf/lose.tscn")
@onready var winscene = preload("res://fnaf/win.tscn")
func _ready():
	startgame()
func _process(delta):
	player(delta)
	animsai()
	nightime()
	camui()
#=========================================OTHER STUFF==================================================#
func startgame():
	power = 100
	nighttime = 0
	$player.set_current(true)
	$effects/camtransitionap.play("start")
	$power.start()
	$nighttime.start()
	$"../animatronics/foxy/fotimer".start()
	$"../animatronics/bonnie/btimer".start()
	$"../animatronics/chica/ctimer".start()
	$"../animatronics/freddy/frtimer".start()
	if Fnafdata.night == 1:
		$phonecall1.play()
	elif Fnafdata.night == 2:
		$phonecall2.play()
	elif Fnafdata.night == 3:
		$phonecall3.play()
	elif Fnafdata.night == 4:
		$phonecall4.play()
func player(delta):
	const ray_length = 1000
	var mouse_pos = get_viewport().get_mouse_position()
	var space_state = get_world_3d().direct_space_state
	var cam = $player
	var origin = cam.project_ray_origin(mouse_pos)
	var end = origin + cam.project_ray_normal(mouse_pos) * ray_length
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	#camera logic
	var screen_width = get_viewport().size.x
	var middle_range = screen_width / 8
	var rotate_amount = 0.0
	if camopen != true and camcanrotate:
		if mouse_pos.x < (screen_width / 2) - middle_range:
			rotate_amount = (screen_width / 2 - mouse_pos.x) * delta * sensitivity * turning_speed
		elif mouse_pos.x > (screen_width / 2) + middle_range:
			rotate_amount -= (mouse_pos.x - screen_width / 2) * delta * sensitivity * turning_speed
		else:
			rotate_amount = 0
	rotation.y += deg_to_rad(rotate_amount)
	rotation.y = clamp(rotation.y, deg_to_rad(-60.0), deg_to_rad(60.0))
	var result = space_state.intersect_ray(query)
	if result:
		if Input.is_action_just_pressed("interact") and result.collider.is_in_group("interactable"):
			result.collider.interact()
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
#===================================CAMERA STUFF=======================================================#
func camui():
	$effects/camborder1/cameraborder/power.text = "Power Left: " + str(power) + "%"
	if powert.wait_time >= 6:
		$effects/camborder1/cameraborder/usage.text = "Usage: Low"
	elif powert.wait_time >= 4:
		$effects/camborder1/cameraborder/usage.text = "Usage: Medium"
	elif powert.wait_time <= 2:
		$effects/camborder1/cameraborder/usage.text = "Usage: High"
	if power <= 0:
		nopower()
	$effects/camborder3/cameraborder/night.text = "Night " + str(Fnafdata.night)
	if currentcam == 10 and camopen:
		$effects/cam6/cam6.show()
	else:
		$effects/cam6/cam6.hide()
func nightime():
	if nighttime == 0:
		$effects/camborder3/cameraborder/time.text = "12:00 AM"
	elif nighttime == 60:
		$effects/camborder3/cameraborder/time.text = "1:00 AM"
	elif nighttime == 120:
		$effects/camborder3/cameraborder/time.text = "2:00 AM"
	elif nighttime == 180:
		$effects/camborder3/cameraborder/time.text = "3:00 AM"
	elif nighttime == 240:
		$effects/camborder3/cameraborder/time.text = "4:00 AM"
	elif nighttime == 300:
		$effects/camborder3/cameraborder/time.text = "5:00 AM"
	elif nighttime == 360:
		$effects/camborder3/cameraborder/time.text = "6:00 AM"
		win()
func _on_camerapane_mouse_entered():
	if camopen:
		$cameratabap.play("cameratabclose")
	elif camopen != true:
		$cameratabap.play("cameratabopen")
func cameratabclose():
	$effects/vhseffect.show()
	$effects/crteffect.hide()
	$effects/cammap.hide()
	$effects/camborder1.hide()
	$effects/camborder2.hide()
	$effects/camborder3.hide()
	$effects/camborder4.hide()
	camopen = false
	powert.wait_time += 2
	$player.set_current(true)
func cameratabopen():
	$effects/vhseffect.hide()
	$effects/crteffect.show()
	$effects/camborder1.show()
	$effects/camborder2.show()
	$effects/camborder3.show()
	$effects/camborder4.show()
	powert.wait_time -= 2
	$effects/camtransitionap.play("camtransition")
	$effects/cammap.show()
	if currentcam == 1:
		$"../camera/camera1a/head/Camera3D".set_current(true)
	elif currentcam == 2:
		$"../camera/camera1b/head/Camera3D".set_current(true)
	elif currentcam == 3:
		$"../camera/camera5/head/Camera3D".set_current(true)
	elif currentcam == 4:
		$"../camera/camera1c/head/Camera3D".set_current(true)
	elif currentcam == 5:
		$"../camera/camera3/head/Camera3D".set_current(true)
	elif currentcam == 6:
		$"../camera/camera2a/head/Camera3D".set_current(true)
	elif currentcam == 7:
		$"../camera/camera2b/head/Camera3D".set_current(true)
	elif currentcam == 8:
		$"../camera/camera4b/head/Camera3D".set_current(true)
	elif currentcam == 9:
		$"../camera/camera4a/head/Camera3D".set_current(true)
	elif currentcam == 10:
		$"../camera/camera6/head/Camera3D".set_current(true)
	elif currentcam == 11:
		$"../camera/camera7/head/Camera3D".set_current(true)
	else:
		$"../camera/camera2b/head/Camera3D".set_current(true)
	camopen = true
	if $"../interactable/leftwhiteofficebutton".on:
		$"../interactable/leftwhiteofficebutton".interact()
	elif $"../interactable/rightwhiteofficebutton".on:
		$"../interactable/rightwhiteofficebutton".interact()
func _on_cam_2a_pressed():
	currentcam = 6
	camstatic()
	$"../camera/camera2a/head/Camera3D".set_current(true)
func _on_cam_2b_pressed():
	currentcam = 7
	camstatic()
	$"../camera/camera2b/head/Camera3D".set_current(true)
func _on_cam_4b_pressed():
	currentcam = 8
	camstatic()
	$"../camera/camera4b/head/Camera3D".set_current(true)
func _on_cam_4a_pressed():
	currentcam = 9
	camstatic()
	$"../camera/camera4a/head/Camera3D".set_current(true)
func _on_cam_3_pressed():
	currentcam = 5
	camstatic()
	$"../camera/camera3/head/Camera3D".set_current(true)
func _on_cam_1c_pressed():
	currentcam = 4
	camstatic()
	$"../camera/camera1c/head/Camera3D".set_current(true)
func _on_cam_1b_pressed():
	currentcam = 2
	camstatic()
	$"../camera/camera1b/head/Camera3D".set_current(true)
func _on_cam_7_pressed():
	currentcam = 11
	camstatic()
	$"../camera/camera7/head/Camera3D".set_current(true)
func _on_cam_5_pressed():
	currentcam = 3
	camstatic()
	$"../camera/camera5/head/Camera3D".set_current(true)
func _on_cam_1a_pressed():
	currentcam = 1
	camstatic()
	$"../camera/camera1a/head/Camera3D".set_current(true)
func _on_cam_6_pressed():
	currentcam = 10
	camstatic()
	$"../camera/camera6/head/Camera3D".set_current(true)
	if currentcam == 10 and c.cinkitchen:
		$chicainkitchen.play()
func camstatic():
	if camopen:
		$camui/cameraswitch.play()
		$effects/camtransitionap.play("camtransition")
	if currentcam != 10:
		$chicainkitchen.stop()
#===============================ANIMATRONIC STUFFS=====================================================#
func animsai():
	if Fnafdata.night == 1:
		if nighttime == 120:
			b.bdifficulty = 1
		elif nighttime == 180:
			b.bdifficulty = 2
			fo.fodifficulty = 1
			c.cdifficulty = 1
		elif nighttime == 240:
			b.bdifficulty = 3
			fo.fodifficulty = 2
			c.cdifficulty = 2
	elif Fnafdata.night == 2:
		if nighttime == 0:
			c.cdifficulty = 1
			b.bdifficulty = 3
			fr.frdifficulty = 1
			fo.fodifficulty = 0
		elif nighttime == 180:
			b.bdifficulty = 2
			fo.fodifficulty = 1
			c.cdifficulty = 1
		elif nighttime == 240:
			b.bdifficulty = 5
			fo.fodifficulty = 3
			c.cdifficulty = 3
	elif Fnafdata.night == 3:
		if nighttime == 0:
			fo.fodifficulty = 2
			c.cdifficulty = 5
			fr.frdifficulty = 1
		elif nighttime == 120:
			fo.fodifficulty = 2
			c.cdifficulty = 5
			fr.frdifficulty = 1
			b.bdifficulty = 1
		elif nighttime == 180:
			fo.fodifficulty = 3
			c.cdifficulty = 6
			fr.frdifficulty = 1
			b.bdifficulty = 2
		elif nighttime == 240:
			fo.fodifficulty = 4
			c.cdifficulty = 7
			fr.frdifficulty = 1
			b.bdifficulty = 3
	elif Fnafdata.night == 4:
		if nighttime == 0:
			fo.fodifficulty = 6
			c.cdifficulty = 4
			b.bdifficulty = 2
			var rng = randf_range(1, 2)
			if rng == 1:
				fr.frdifficulty = 1
			else:
				fr.frdifficulty = 2
		elif nighttime == 120:
			b.bdifficulty = 3
			var rng = randf_range(1, 2)
			if rng == 1:
				fr.frdifficulty = 1
			else:
				fr.frdifficulty = 2
		elif nighttime == 180:
			fo.fodifficulty = 7
			c.cdifficulty = 5
			b.bdifficulty = 4
			var rng = randf_range(1, 2)
			if rng == 1:
				fr.frdifficulty = 1
			else:
				fr.frdifficulty = 2
		elif nighttime == 240:
			fo.fodifficulty = 8
			c.cdifficulty = 6
			b.bdifficulty = 5
			var rng = randf_range(1, 2)
			if rng == 1:
				fr.frdifficulty = 1
			else:
				fr.frdifficulty = 2
	elif Fnafdata.night == 5:
		if nighttime == 0:
			fr.frdifficulty = 3
			b.bdifficulty = 5
			c.cdifficulty = 7
			fo.fodifficulty = 5
		elif nighttime == 120:
			b.bdifficulty = 6
		elif nighttime == 180:
			b.bdifficulty = 7
			c.cdifficulty = 8
			fo.fodifficulty = 6
		elif nighttime == 240:
			b.bdifficulty = 8
			c.cdifficulty = 9
			fo.fodifficulty = 7
	elif Fnafdata.night == 5:
		if nighttime == 0:
			fr.frdifficulty = 4
			b.bdifficulty = 10
			c.cdifficulty = 12
			fo.fodifficulty = 16
		elif nighttime == 120:
			b.bdifficulty = 11
		elif nighttime == 180:
			b.bdifficulty = 12
			c.cdifficulty = 13
			fo.fodifficulty = 17
		elif nighttime == 240:
			b.bdifficulty = 13
			c.cdifficulty = 14
			fo.fodifficulty = 18
#========================================OFFICE STUFFS=================================================#
func _on_power_timeout():
	power -= 1
func _on_nighttime_timeout():
	nighttime += 1
#==================================WIN LOGIC===========================================================#
func endgame():
	b.bdisable()
	fo.fodisable()
	c.cdisable()
	fr.frdisable()
	nighttime = 0
	$power.stop()
	$nighttime.stop()
	if $"../interactable/leftredofficebutton".on:
		$"../interactable/leftredofficebutton".interact()
	elif $"../interactable/leftwhiteofficebutton".on:
		$"../interactable/leftwhiteofficebutton".interact()
	elif $"../interactable/rightredofficebutton".on:
		$"../interactable/rightredofficebutton".interact()
	elif $"../interactable/rightwhiteofficebutton".on:
		$"../interactable/rightwhiteofficebutton".interact()
	camcanrotate = true
func win():
	if camopen:
		$cameratabap.play("cameratabclose2")
	$nighttime.stop()
	endgame()
	if Fnafdata.night < 6:
		Fnafdata.night += 1
	get_tree().change_scene_to_packed(winscene)
#=====================================LOSE LOGIC=======================================================#
func nopower():
	if camopen:
		$cameratabap.play("cameratabclose2")
	$nighttime.stop()
	endgame()
func lose():
	if camopen:
		$cameratabap.play("cameratabclose2")
	$nighttime.stop()
	endgame()
	get_tree().change_scene_to_packed(losescene)
