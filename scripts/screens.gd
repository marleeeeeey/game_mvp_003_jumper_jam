extends CanvasLayer

signal start_game
signal delete_level

@onready var console = $Debug/ConsoleLog

@onready var title_screen = $TitleScreen
@onready var pause_screen = $PauseScreen
@onready var game_over_screen = $GameOverScreen
@onready var game_over_score_label = $GameOverScreen/Box/ScoreLabel
@onready var game_over_highscore_label = $GameOverScreen/Box/HighScoreLabel

var current_screen = null


func _ready() -> void:
	console.visible = false
	register_buttons()
	change_screen(title_screen)


func register_buttons():
	var buttons = get_tree().get_nodes_in_group("buttons")
	if buttons.size() > 0:
		for button in buttons:
			if button is ScreenButton:
				button.clicked.connect(_on_button_pressed)


func _on_button_pressed(button: ScreenButton):
	match button.name:
		"TitlePlay":
			change_screen(null)
			# Wait when fade-in/out animations is done.
			await (get_tree().create_timer(0.5).timeout)
			start_game.emit()
		"PauseRetry":
			print("Pause retry")
			change_screen(game_over_screen)
		"PauseBack":
			print("Pause back")
		"PauseClose":
			print("Pause close")
		"GameOverRetry":
			change_screen(null)
			await (get_tree().create_timer(0.5).timeout)
			start_game.emit()
		"GameOverBack":
			change_screen(title_screen)
			delete_level.emit()


func _on_toggle_console_pressed():
	console.visible = !console.visible


# Set null to disapear all screens.
func change_screen(new_screen):
	if current_screen:
		var disappear_tween = current_screen.disapear()
		await (disappear_tween.finished)
		current_screen.visible = false
	current_screen = new_screen
	if current_screen:
		var appear_tween = current_screen.appear()
		await (appear_tween.finished)
		# Enable all the screen buttons.
		get_tree().call_group("buttons", "set_disabled", false)


func game_over(score, highscore):
	game_over_score_label.text = "Score: " + str(score)
	game_over_highscore_label.text = "Best: " + str(highscore)
	change_screen(game_over_screen)
