extends Camera2D

onready var player = get_node("/root/Root/KinematicBody2D/AnimatedSprite")

func _process(delta):
	if player:
		global_position = player.global_position # Set posisi kamera sama dengan posisi karakter
