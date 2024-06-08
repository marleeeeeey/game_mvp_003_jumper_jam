# Game MVP 003 - Jumper Jam

Jumper Jam - the game is implemented during the course "Master Mobile Game Development with Godot 4".
Gameplay is similar to the Doodle Jump game. The player jumps on the platforms and tries to reach the highest score.
- Course: https://www.udemy.com/course/mobile-game-godot/
- Created by: GameDev.tv Team, Kaan Alpar.
- Original Repo: https://gitlab.com/GameDevTV/godot-mobile/jumper-jam
- Site: https://www.gamedev.tv
- Discord: https://discord.gg/eUSFZdJ

## My info

- Planned duration: 11 Days
- Development start date: 2024-05-30
- MVP planned release date: 2024-06-09
- Name: Jumper Jam
- Learning goal: Learn how to make mobile games.
- Release link: TODO
- YouTube link: TODO

## Gameplay overview

- TODO

## Controls

- TODO

## Godot Guidelines

- Use `_physics_process` for physics related code.
- Use `move_toward(velocity.x, 0, speed/10)` for smooth speed change.
- Use `get_viewport_rect().size` to get the screen size. Once in `_ready` method.
- Name convention:
  - Scene: `PascalCase`
  - SubScene: `PascalCase`
  - files: `snake_case`
  - animation: `snake_case`
  - layers: `snake_case`
  - groups: `snake_case`
- Use type hints for variables and functions to get security from intellisense.
- Use undercore for method's arguments `func setup_camera(_player: Player):` to
  - fix name conflicts.
  - hide warning about unused variables.
- Check different screen sizes when testing the mobile game.
- Use `Camera.limit_bottom` to limit the camera movement.
- Use `get_tree().quit()` to quit the game.
- Prototype elements in the UI and then replace them with code behind setup.
- Use `any_node.find_child("Sprite2D")` to access the child of the node. Not only the direct child.
- Use `OS.get_name()` to check the platform.
- Use `get_tree().get_first_node_in_group("any_name")` to get the node by group name.
- Use `TextureRect` instead of `Sprite2D` for the UI elements. Allows for containers and scaling stuff.
- Use empty elements (Controls) as anchors for animations to support different screen sizes.
- Set `Control.Mouse.Filter` to `IGNORE` to prevent mouse events from the UI for debug layout as example.
- Use `Tween` class for animations to interpolate values easily and lightweight. Tween is like code behind animation player.
- Use `get_tree().call_group("buttons", "set_disabled", true)` to call the method for all nodes in the group.
- Use `DisplayServer.get_display_safe_area()` to get the safe area for the phone screen.
- Use `set_deferred` to set the property in the next frame. Example: `cshape.set_deferred("disabled", true)`.
- Use `print("msg")` to debug the code during the development.
- Use `await(get_tree().create_timer(0.75).timeout)` to add delay between the actions.
- Use `signal` to move from lower level to the higher level scene. Use `call` to move from the higher level to the lower level scene.
- Set `obj=null` and `path.to.obj=null` for references after calling `queue_free()` to prevent crashes.
- Use `"user://file_name.file_extension"` to save the file in the user directory for specific game.

## Files structure

- TODO

## Devlog

- Create project with Player jumping on platforms with camera following and camera limits : #2024-05-31
- Complete half of gameplay development. 18% of the course completed : #2024-06-31

## TODO

- TODO

## Assets

- https://www.udemy.com/course/mobile-game-godot/
- https://www.craftpix.net - need ask license if going to use in commercial project

## Tools

- TODO

## Course knowledge

- Course: https://www.udemy.com/course/mobile-game-godot/

### Scene organization

- Main as Node
  - Game as Node2D (Player, Platforms)
  - Screens as CanvasLayer (Title, GameOver, Shop)

### Orientation for mobile

- Project -> Project Settings -> Display -> Windows:
  - Orientation: Portrait
  - Width: 9*60 = 540
  - Height: 16*60 = 960
  - Stretch Mode: canvas_items
  - Stretch Aspect: keep_width

### Enable touch from Mouse and Mouse from Touch options

- Project -> Project Settings -> Input Devices -> Pointing:
  - Emulate Touch From Mouse: true
  - Emulate Mouse From Touch: true

### Create animation

- Add AnimationPlayer to the node
- Add new animation (name starts with lower case)
- Add keyframes (!)
  - texture
  - position
  - scale

### Good example of scene instancing

```js
@onready var platform_parent = $PlatformParent

func create_platform(location: Vector2):
	var platform = platform_scene.instantiate()
	platform.global_position = location
	platform_parent.add_child(platform)
	return platform
```

### Create parallax effect

- Create next structure:
  - ParallaxBackground
    - ParallaxLayer x times (use Ctrl+D to duplicate)
      - Sprite2D
- The top one ParallaxLayer (on the back) moves faster than the bottom one.
- Set `Sprite2D Offset Centered to OFF` to simplify the calculation in the code.
- Set `Sprite2D Scale` to nice values to make the parallax effect visible in editor. Will be changed in the code.
- Set `ParallaxLayer.Motion.Mirroring.y` to `height * image_scale.y`.
- Set `ParallaxLayer.Scale` for each layer: `0.1, 0.2, 0.3, ...` from top to bottom.

### Export to Android

- https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html
  - Install JDK
  - Install Android Studio
  - Customize Android studio with SDK, NDK, and etc.
- Editor -> Editor Settings -> Export -> Android:
  - Java SDK Path: `C:\Program Files\Eclipse Adoptium\jdk-17.0.11.9-hotspot\`
  - Android SDK Path: `C:/Users/<USER>/AppData/Local/Android/Sdk`
  - Debug Keystore: `C:/Users/<USER>/.android/debug.keystore`
- Project -> Export -> Android:
  - Unique Name: `com.example.mygame`
  - Name: `My Game`
  - Export path: `C:/your/export/path`
  - Try export to APK.
- Enable Developer mode on the device.
  - Connect Android device to the computer.
  - Accept the connection on the device.
  - Check the device in the Godot editor (Top right corner icon - Remote Debug).
  - You should see the device in the list.
- CMD commnds:
  - `adb devices` - list of connected devices.
  - `adb -s <device_name> logcat` - show logs from the device.
  - `adb install -r path_to_apk` - install the APK to the device.
  - `adb uninstall com.example.mygame` - uninstall the APK from the device.

### Create singleton code behind class to access from any scene

- Create new script file with the name `utility.gd`
- Project -> Project Settings -> AutoLoad:
  - Path: `res://srcipts/utility.gd`
  - Node Name: `MyUtility` (to prevent name conflicts)
  - Add
  - Set `Enable` to `On`
- Usage:
  - `MyUtility.my_function()`
- Access to custom consolse log from script:
  - Attach group "debug_console" to the console node.
  - In the script check if the console is available and use it.

```js
func add_log_msg(log_str: String):
	var console = get_tree().get_first_node_in_group("debug_console")
	if cosole:
		pass
```

### Create a central callback for every button in the game

- Create a new scene ScreenButton as TextureButton
- Create a new script for the ScreenButton with custom signal: `signal clicked(button)`
- Emit the signal with self in the `_on_pressed()` method: `clicked.emit(self)`
- Add the ScreenButton to the group "buttons"
- In the main script iterate over all buttons: `get_tree().get_nodes_in_group("buttons")`
- Connect the signal to the main script method: `button.connect.clicked(_on_button_pressed)`
- Use `match` to check the button name: `match button.name: "start": _start_game()`

### Create a one script for several scenes

- Create a new script file with the name `base_screen.gd`
- Drug and drop the script to the scenes where you want to use it.
- In the script use `extends Controls` to get access to the UI elements as example.
- Write the common code in the script.

### Create fade in/out animation for the screens

https://docs.godotengine.org/en/stable/classes/class_tween.html

```js

func disapear():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5) # set modulate.alpha property
	return tween

func change_screen(new_screen):
	if current_screen:
		var disappear_tween = current_screen.disapear()
		await(disappear_tween.finished)
		current_screen.visible = false
	current_screen = new_screen
	if current_screen:
		var appear_tween = current_screen.appear()
```

- Disable buttons during the transition to prevent double clicks.

### Pattern to implement StartGame click from one csene to another

- We have next sceene structure:
  - Main
    - Game
    - Screens (contains StartGame button)
- Add signal to the Screens scene: `signal start_game`
- Subscribe to the signal in the Main script: `screens.start_game.connect(_on_screens_start_game)`

### Pattern to implement player died event - signal from lower level to the higher level and back to lower again

The main idea is to emit signal from lower level to the higher level. Then call method from the higher level to the lower level but for another scenes. On the way, we can do some logic in any level.

- We have next scene structure:
  - Main
    - Game
      - Player
    - Screens
      - GameOverScreen
        - ScoreLabel
        - HighScoreLabel

- `Player` emits signal `died`
- `Game` script subscribes to the signal and:
  - does some logic when player dies
  - emits `player_died` signal
- `Main` scene catch player_died signal and call `screens.game_over(score, highscore)`

### Save scores between the game sessions

- `var save_file_path = "user://highscore.save"` - path to the save file

```js
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
```

### Pause the game

- Add action on pause button: `get_tree().paused = !get_tree().paused`.
- Set `Node.Process.Mode` to `ALWAYS` for UI elements to update them during the pause.
- Set `tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)` to continue the animation during the pause.
- Pause the game when lost focus:

```
DisplayServer.window_set_window_event_callback(_on_windows_event)

func _on_windows_event(event):
	match event:
		DisplayServer.WINDOW_EVENT_FOCUS_OUT:
			_on_game_pause_game()
		DisplayServer.WINDOW_EVENT_CLOSE_REQUEST:
			get_tree().quit()

```

### Pattern to create sound fx script to play any sound from any scene

- Create scene SoundFX as Node.
- Set `SoundFX.Process.Mode` to `ALWAYS` to play sounds during the pause.
- Add AudioStreamPlayer x 5 to the SoundFX.
- Add scene to autoload: Project -> Project Settings -> AutoLoad -> Add -> Path: `res://scenes/sound_fx.tscn`.
- Create script for the SoundFX scene with the next methods:

```js

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

```

### IAP (In-App Purchase) Android build preparations

#### Install Android Build Template and Gradle

https://docs.godotengine.org/en/stable/tutorials/export/android_gradle_build.html

- Project -> Install Android Build Template
- Export -> Android:
  - Use Gradle Build = true
  - Export Format = AAB
  - Export Path = *.aab
- Start remote debug on the android device - it should trigger the build process via Gradle.

#### Add IAP plugin to the project

https://docs.godotengine.org/en/stable/tutorials/platform/android/android_in_app_purchases.html

- Dowbload the IAP plugin: https://github.com/godotengine/godot-google-play-billing/releases/tag/1.2.0
- Copy the plugin to the project folder: `res://android/plugins/`
- Project -> Export -> Android -> Plugins -> "Godot Google Play Billing" = true
- `Engine.get_singleton("GodotGooglePlayBilling")` to access the plugin from the script.
