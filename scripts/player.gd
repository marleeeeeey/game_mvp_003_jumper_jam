extends CharacterBody2D

var speed = 300.0

var viewport_size

func _ready() -> void:
	viewport_size = get_viewport_rect().size 

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
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
	 
