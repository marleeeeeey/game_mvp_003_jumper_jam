extends Node2D

@onready var platform_parent = $PlatformParent
@onready var viewport_size = get_viewport_rect().size
@onready var generated_platform_count = 0

var platform_scene = preload("res://scenes/platform.tscn")

var start_platform_y
var y_distance_between_platforms = 100
var level_size = 50
var player: Player = null


func setup(_player: Player):
	if _player:
		player = _player

func _ready():
	# Generate the first iteration of level with ground.
	start_platform_y = viewport_size.y - (y_distance_between_platforms * 2)
	generate_level(start_platform_y, true)

func _process(_delta):	
	if player:
		var py = player.global_position.y
		var end_of_level_pos = start_platform_y - ( generated_platform_count * y_distance_between_platforms)
		var threshhold = end_of_level_pos + (y_distance_between_platforms * 6)
		if py <= threshhold:
			generate_level(end_of_level_pos, false)

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
		var location: Vector2 = Vector2.ZERO
		location.x = random_x
		location.y = start_y - (y_distance_between_platforms * i)
		create_platform(location)
		generated_platform_count += 1


func create_platform(location: Vector2):
	var platform = platform_scene.instantiate()
	platform.global_position = location
	platform_parent.add_child(platform)
	return platform
