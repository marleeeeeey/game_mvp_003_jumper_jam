extends Node2D

@onready var platform_parent = $PlatformParent
@onready var viewport_size = get_viewport_rect().size
@onready var generated_platform_count = 0

var camera_scene = preload("res://scenes/game_camera.tscn")
var platform_scene = preload("res://scenes/platform.tscn")

var camera: Camera2D = null

# Level generation variables
var start_platform_y
var y_distance_between_platforms = 100
var level_size = 50


func _ready():
	camera = camera_scene.instantiate()
	camera.setup_camera($Player)
	add_child(camera)

	# Generation first iteration of level with ground.
	start_platform_y = viewport_size.y - (y_distance_between_platforms * 2)
	generate_level(start_platform_y, true)


func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func create_platform(location: Vector2):
	var platform = platform_scene.instantiate()
	platform.global_position = location
	platform_parent.add_child(platform)
	return platform


func generate_level(start_y: float, generate_ground: bool):
	var platform_width = 136  # Platform collision shape wight.

	if generate_ground:
		# Generate the ground.
		var ground_layer_platform_count = (viewport_size.x / platform_width) + 1
		var ground_layer_y_offset = 62  # PLatform sprite height.
		for i in range(ground_layer_platform_count):
			var ground_location = Vector2(
				i * platform_width, viewport_size.y - ground_layer_y_offset
			)
			create_platform(ground_location)

	# Generate random location platforms.
	for i in range(level_size):
		var min_x_position = 0
		var max_x_position = viewport_size.x - platform_width
		var random_x = randf_range(min_x_position, max_x_position)
		var location: Vector2
		location.x = random_x
		location.y = start_y - (y_distance_between_platforms * i)
		create_platform(location)
		generated_platform_count += 1
