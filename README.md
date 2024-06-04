# Game MVP 003 - Mobile Game Like Doogle Jump

The game is implemented during the course "Master Mobile Game Development with Godot 4".
- Course: https://www.udemy.com/course/mobile-game-godot/
- Created by: GameDev.tv Team, Kaan Alpar.
- Original Repo: https://gitlab.com/GameDevTV/godot-mobile/jumper-jam
- Site: https://www.gamedev.tv
- Discord: https://discord.gg/eUSFZdJ

## My info

- Planned duration: 11 Days
- Development start date: 2024-05-30
- MVP planned release date: 2024-06-09
- Name: TODO
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
