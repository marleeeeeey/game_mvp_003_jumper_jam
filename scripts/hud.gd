extends Control

signal pause_game

@onready var topbar = $TopBar
@onready var topbar_bg = $TopBarBG
@onready var score_label = $TopBar/ScoreLabel


func _ready():
	var os_name = OS.get_name()
	var is_phone = os_name == "Android" or os_name == "iOS"
	if is_phone:
		var safe_area = DisplayServer.get_display_safe_area()
		var safe_area_top = safe_area.position.y

		if os_name == "iOS":
			# The method is callable in OS systems.
			var screen_scale = DisplayServer.screen_get_scale()
			safe_area_top = safe_area_top / screen_scale
			MyUtility.add_log_msg("iOS screen_scale: " + str(screen_scale))

		topbar.position.y += safe_area_top
		var margin = 10
		topbar_bg.size.y += safe_area_top + margin

		MyUtility.add_log_msg("Safe area: " + str(safe_area))
		MyUtility.add_log_msg("Window size: " + str(DisplayServer.window_get_size()))
		MyUtility.add_log_msg("safe_area_top: " + str(safe_area_top))
		MyUtility.add_log_msg("top bar pos: " + str(topbar.position))


func _on_pause_button_pressed():
	SoundFX.play("Click")
	pause_game.emit()


func set_score(new_score):
	score_label.text = str(new_score)
