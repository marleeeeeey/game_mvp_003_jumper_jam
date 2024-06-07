class_name Player
extends CharacterBody2D

signal died

@onready var animator = $AnimationPlayer
@onready var cshape = $CollisionShape2D

var speed = 300.0
var accelerometer_speed = 130.0

var gravity = 15.0
var max_fall_velocity = 1000.0
var jump_velocity = -800

var viewport_size

var use_accelerometer = false

var dead = false


func _ready():
	viewport_size = get_viewport_rect().size

	var os_name = OS.get_name()
	use_accelerometer = (os_name == "Android" or os_name == "iOS")


func _process(_delta: float):
	# Change animation when falling and jumping.
	if velocity.y > 0:
		if animator.current_animation != "fall":
			animator.play("fall")
	elif velocity.y < 0:
		if animator.current_animation != "jump":
			animator.play("jump")


func _physics_process(_delta: float):
	# Apply gravity.
	velocity.y += gravity
	if velocity.y > max_fall_velocity:
		velocity.y = max_fall_velocity

	if !dead:
		if use_accelerometer == true:
			var mobile_input = Input.get_accelerometer()
			velocity.x = mobile_input.x * accelerometer_speed
		else:
			# Control left-right movement.
			var direction = Input.get_axis("move_left", "move_right")
			if direction:
				velocity.x = direction * speed
			else:
				velocity.x = move_toward(velocity.x, 0, speed / 10)

	move_and_slide()

	# Teleport over the screen.
	var margin = 20
	if global_position.x > viewport_size.x + margin:
		global_position.x = -margin
	elif global_position.x < -margin:
		global_position.x = viewport_size.x + margin


func jump():
	velocity.y = jump_velocity
	MyUtility.add_log_msg("Player jumped")
	SoundFX.play("Jump")


func _on_visible_on_screen_notifier_2d_screen_exited():
	die()


func die():
	if !dead:
		cshape.set_deferred("disabled", true)
		dead = true
		died.emit()
	SoundFX.play("Fall")
