extends CanvasLayer

@onready var console = $Debug/ConsoleLog

@onready var title_screen = $TitleScreen
@onready var pause_screen = $PauseScreen
@onready var game_over_screen = $GameOverScreen

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
			print("Title play")
			change_screen(pause_screen)
		"PauseRetry":
			print("Pause retry")
			change_screen(game_over_screen)
		"PauseBack":
			print("Pause back")
		"PauseClose":
			print("Pause close")
		"GameOverRetry":
			print("Game over retry")
			change_screen(title_screen)
		"GameOverBack":
			print("Game over back")


func _on_toggle_console_pressed():
	console.visible = !console.visible


# Set null to disapear all screens.
func change_screen(new_screen):
	if current_screen:
		var disappear_tween = current_screen.disapear()
		await(disappear_tween.finished)
		current_screen.visible = false
	current_screen = new_screen
	if current_screen:
		var appear_tween = current_screen.appear()
		await(appear_tween.finished)
		# Enable all the screen buttons.
		get_tree().call_group("buttons", "set_disabled", false)
