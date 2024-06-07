extends Node

# Load all audio files to the game once.
var sounds = {
	"Click": load("res://assets/sound/Click.wav"),
	"Fall": load("res://assets/sound/Fall.wav"),
	"Jump": load("res://assets/sound/Jump.wav"),
}

# All audio players here.
@onready var sound_players = get_children()


func play(sound_name):
	var sound_to_play = sounds[sound_name]

	# Search free player and play sound in it.
	for sound_player: AudioStreamPlayer in sound_players:
		if !sound_player.playing:
			sound_player.stream = sound_to_play
			sound_player.play()
			return

	print("Too many sounds playing at once, not anough sound players")
