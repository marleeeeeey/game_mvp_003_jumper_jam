extends Node

@onready var game = $Game
@onready var screens = $Screens

var game_in_progress = false


func _ready() -> void:
	DisplayServer.window_set_window_event_callback(_on_windows_event)

	screens.start_game.connect(_on_screens_start_game)
	screens.delete_level.connect(_on_screens_delete_level)

	game.player_died.connect(_on_player_died)
	game.pause_game.connect(_on_game_pause_game)


func _on_windows_event(event):
	match event:
		DisplayServer.WINDOW_EVENT_FOCUS_IN:
			print("Focus in")
			MyUtility.add_log_msg("Focus in")
		DisplayServer.WINDOW_EVENT_FOCUS_OUT:
			print("Focus out")
			MyUtility.add_log_msg("Focus out")
			if game_in_progress && !get_tree().paused:
				_on_game_pause_game()
				print("Windows minimized. Paused the game.")
				MyUtility.add_log_msg("Windows minimized. Paused the game.")
		DisplayServer.WINDOW_EVENT_CLOSE_REQUEST:
			get_tree().quit()


func _on_screens_start_game():
	game_in_progress = true
	game.new_game()


func _on_screens_delete_level():
	game.reset_game()
	game_in_progress = false


func _on_player_died(score, highscore):
	game_in_progress = false
	await (get_tree().create_timer(0.75).timeout)
	screens.game_over(score, highscore)


func _on_game_pause_game():
	get_tree().paused = true
	screens.pause_game()
