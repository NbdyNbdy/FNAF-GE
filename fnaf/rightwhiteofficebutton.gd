extends StaticBody3D

var on = false

func interact():
	if on != true:
		$ap.play("on")
		on = true
		$"../../player".powert.wait_time -= 2
		$buzz.play()
	else:
		$ap.play_backwards("on")
		on = false
		$"../../player".powert.wait_time += 2
		$buzz.stop()
