extends Camera2D

var player: Player = null

func setup_camera(_player: Player):
	if _player:
		player = _player

func _physics_process(delta):
	if player:
		global_position.y = player.global_position.y

func _ready():	
	# Centered the camera. It should be done code behind to support any screen resolutions.
	global_position.x = get_viewport_rect().size.x / 2
