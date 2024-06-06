extends Node2D

signal player_died(score, highscore)
signal pause_game

@onready var level_generator = $LevelGenerator
@onready var ground_sprite = $GroundSprite

@onready var parallax1 = $ParallaxBackground/ParallaxLayer
@onready var parallax2 = $ParallaxBackground/ParallaxLayer2
@onready var parallax3 = $ParallaxBackground/ParallaxLayer3

@onready var hud = $UILayer/HUD

var player_scene = preload("res://scenes/player.tscn")
var player: Player = null
var player_spawn_pos: Vector2

var camera_scene = preload("res://scenes/game_camera.tscn")
var camera: Camera2D = null

@onready var viewport_size = get_viewport_rect().size

var score: int = 0
var highscore: int = 0
var save_file_path = "user://highscore.save"


func _ready():
	var player_spawn_pos_y_offset = 135
	player_spawn_pos.x = viewport_size.x / 2.0
	player_spawn_pos.y = viewport_size.y - player_spawn_pos_y_offset

	ground_sprite.global_position.x = viewport_size.x / 2.0
	ground_sprite.global_position.y = viewport_size.y

	setup_parallax_layer(parallax1)
	setup_parallax_layer(parallax2)
	setup_parallax_layer(parallax3)

	hud.visible = false
	hud.set_score(0)
	hud.pause_game.connect(_on_hud_pause_game)
	ground_sprite.visible = false

	load_score()


# Sprite2D scale need to setup correct setting for parallax
func get_parallax_sprite_scale(parralax_sprite: Sprite2D):
	var parallax_texture = parralax_sprite.get_texture()
	var parallax_texture_width = parallax_texture.get_width()

	var scale = viewport_size.x / parallax_texture_width
	var result = Vector2(scale, scale)
	return result


# Setup correct setting for parallax:
# ParallaxLayer.Motion.Mirroring.y = sprite_scale.y * texture_height
func setup_parallax_layer(parallax_layer: ParallaxLayer):
	var parallax_sprite: Sprite2D = parallax_layer.find_child("Sprite2D")
	if parallax_sprite:
		parallax_sprite.scale = get_parallax_sprite_scale(parallax_sprite)
		var my = parallax_sprite.scale.y * parallax_sprite.get_texture().get_height()
		parallax_layer.motion_mirroring.y = my


func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

	if player:
		var new_score = viewport_size.y - player.global_position.y
		if score < new_score:
			score = new_score
			hud.set_score(score)


func new_game():
	reset_game()

	player = player_scene.instantiate()
	player.position = player_spawn_pos
	player.died.connect(_on_player_died)
	add_child(player)

	camera = camera_scene.instantiate()
	camera.setup_camera(player)
	add_child(camera)

	if player:
		level_generator.setup(player)
		level_generator.start_generation()

	hud.visible = true
	ground_sprite.visible = true
	score = 0


func _on_player_died():
	hud.visible = false

	if score > highscore:
		highscore = score
		save_score()

	player_died.emit(score, highscore)


func reset_game():
	ground_sprite.visible = false
	hud.set_score(0)
	hud.visible = false
	level_generator.reset_level()
	if player != null:
		player.queue_free()
		player = null
		level_generator.player = null
	if camera:
		camera.queue_free()
		camera = null


func save_score():
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	file.store_var(highscore)
	file.close()


func load_score():
	if FileAccess.file_exists(save_file_path):
		var file = FileAccess.open(save_file_path, FileAccess.READ)
		highscore = file.get_var()
		file.close()
	else:
		highscore = 0


func _on_hud_pause_game():
	pause_game.emit()
