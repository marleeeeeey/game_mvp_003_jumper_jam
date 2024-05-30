class_name Player
extends CharacterBody2D

var speed = 300.0

var gravity = 15.0
var max_fall_velocity = 1000.0

var viewport_size

func _ready():
	viewport_size = get_viewport_rect().size 

func _process(delta: float):
	pass

func _physics_process(delta: float):
	
	# Apply gravity.
	velocity.y += gravity
	if velocity.y > max_fall_velocity:
		velocity.y = max_fall_velocity
	
	
	# Control left-right movement.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed/10)
	move_and_slide()
	
	# Teleport over the screen.
	var margin = 20
	if global_position.x > viewport_size.x + margin:
		global_position.x = -margin
	elif global_position.x < -margin:
		global_position.x = viewport_size.x + margin
	 
