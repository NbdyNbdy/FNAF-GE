extends Node3D

func _ready():
	ss()

func ss():
	await RenderingServer.frame_post_draw
	
	var vpt = get_viewport();
	var tex = vpt.get_texture();
	var img = tex.get_image();
	img.flip_y()
	img.save_png("user://iconnew.png");
