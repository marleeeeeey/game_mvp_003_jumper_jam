extends CanvasLayer

@onready var console = $Debug/ConsoleLog

func _ready() -> void:
	console.visible = false

func _on_toggle_console_pressed():
	console.visible = !console.visible
