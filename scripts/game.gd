extends Node2D

@onready var platform_parent = $PlatformParent

var camera_scene = preload("res://scenes/game_camera.tscn")
var platform_scene = preload("res://scenes/platform.tscn")

var camera: Camera2D = null

func _ready():
	camera = camera_scene.instantiate()
	camera.setup_camera($Player)
	add_child(camera)
	
	# Generate the ground.
	var viewport_size = get_viewport_rect().size
	var platform_width = 136 # Platform collision shape wight.
	var ground_layer_platform_count = (viewport_size.x / platform_width) + 1	
	var ground_layer_y_offset = 62 # PLatform sprite height.
	for i in range(ground_layer_platform_count):
		var ground_location = Vector2 (i * platform_width, viewport_size.y - ground_layer_y_offset)
		create_platform(ground_location)


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
