extends CanvasLayer

@onready var console = $Debug/ConsoleLog


func _ready() -> void:
	console.visible = false
	register_buttons()


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
		"PauseRetry":
			print("Pause retry")
		"PauseBack":
			print("Pause back")
		"PauseClose":
			print("Pause close")
		"GameOverRetry":
			print("Game over retry")
		"GameOverBack":
			print("Game over back")


func _on_toggle_console_pressed():
	console.visible = !console.visible
