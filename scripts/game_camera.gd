extends Camera2D

var player: Player = null

@onready var viewport_size = get_viewport_rect().size
@onready var destroyer = $Destroyer
@onready var destroyer_shape = $Destroyer/CollisionShape2D


func setup_camera(_player: Player):
	if _player:
		player = _player


func _physics_process(delta):
	if player:
		global_position.y = player.global_position.y


func _ready():
	# Centered the camera. It should be done code behind to support any screen resolutions.
	global_position.x = viewport_size.x / 2

	# Set camera limits.
	limit_bottom = viewport_size.y
	limit_left = 0
	limit_right = viewport_size.x

	# Create platform destroyer.
	destroyer.position.y = viewport_size.y / 2.0  # Position relative to camera.
	var rect_shape = RectangleShape2D.new()
	var rect_shape_size = Vector2(viewport_size.x, 200)
	rect_shape.set_size(rect_shape_size)
	destroyer_shape.shape = rect_shape


func _process(delta):
	if player:
		var limit_distance = 420
		if limit_bottom > player.global_position.y + limit_distance:
			limit_bottom = player.global_position.y + limit_distance
