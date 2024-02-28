extends KinematicBody2D

export (int) var speed = 400
export (int) var GRAVITY = 1200
export (int) var jump_speed = -600
var jump_count = 0
var max_jump = 2
var is_crouching = false
var anim_sprite : AnimatedSprite


const UP = Vector2(0,-1)

var velocity = Vector2()

func _ready():
	anim_sprite = $AnimatedSprite
	anim_sprite.play("default")

func get_input():
	velocity.x = 0
	var is_moving = false
	if is_on_floor():
		jump_count = 0
	if Input.is_action_just_pressed('ui_up') and jump_count < max_jump and !is_crouching:
		velocity.y = jump_speed
		jump_count += 1
	if Input.is_action_pressed('ui_right'):
		velocity.x += speed
		is_moving = true
		anim_sprite.flip_h = false
	if Input.is_action_pressed('ui_left'):
		velocity.x -= speed
		anim_sprite.flip_h = true
		is_moving = true
	if Input.is_action_pressed('ui_down'):
		is_crouching = true
		anim_sprite.play("Crouch")
		$CollisionShape2D.scale.y = 0.8
		speed = 200
	elif Input.is_action_just_released("ui_down"):
		is_crouching = false
		$CollisionShape2D.scale.y = 1.0
		anim_sprite.play("default")
		speed = 400
	if Input.is_action_pressed("shift") and is_on_floor() and !is_crouching:
		speed = 800
	elif Input.is_action_just_released("shift"):
		speed = 400
		
	if is_moving:
		anim_sprite.play("Walk")
	elif is_crouching:
		anim_sprite.play("Crouch")
	else:
		anim_sprite.play("default")

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)
