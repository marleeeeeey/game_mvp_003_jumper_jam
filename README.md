# Game MVP 003 - Mobile Game Like Doogle Jump

The game is implemented during the course "Master Mobile Game Development with Godot 4". Created by GameDev.tv Team, Kaan Alpar.
https://www.udemy.com/course/mobile-game-godot/

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

- Project Settings -> Display -> Window -> Always on Top - ENABLE.
- Save vieport size on rezising: Project Settings -> Display -> Window -> Stretch: Mode = Viewport, Aspect = Keep.
- Scene link is better to do via UI (drag and drop) instead of `preload`, bacause IDE will update paths if they change.
- Try to use less `@export` variables. Prioritize: local variables -> class variables -> exported variables.
- Use push_error and push_warning for errors and warnings.
- Use `Scene -> Save Branch As Scene` to simplify the scene and reuse it.
- `Input.IsActionJustPressed(...)` (this frame only) for jumping instead of `Input.IsActionPressed(...)`.
- Drug and drop scene elements to the script to create variables.
- `Help -> Search` or `F1` - to find the documentation for any class or method.
- Create small methods like `instance_bullet()`, `animations()`, `target_mouse()`.
- Use global coordinates (bullet.global_position) to simplify the calculations in the game.
- `get_tree().root` - to get The SceneTree's root Window.
- Use Node2D.ZIndex to set the order of rendering. 1 - top, -1 - bottom.
- Signature of contructor: `func _init(starting_position, new_borders) -> void:`.
- Instantiate class: `var bullet = Bullet.new()`.
- `randomize()` - to randomize the random number generator.
- `get_tree().reload_current_scene()` - to reload the current scene.
- Use groups (`Node -> Group -> Add`) for requesting/filtering nodes by group name.
- `get_tree().root.add_child(trail)` - set new object independent from the parent.
- `object.has_method("smash")` - to check if the object has a method.
- `self` - to refer to the current object.
- `lerp` - to interpolate between two values.

## Files structure

The project is structured in a way that allows to easily reuse common scenes and tilesets across multiple projects. This approach will teach you to create convenient components for future games.

The structure is as follows:

```
- GodotProjectFoler
  - 010_globals (keep link to the Camera2D, ...)
    - globals.gd
  - 015_scripts (reusable scripts without scenes)
    - *.gd
  - 017_standalone_tilesets (tilesets without dependencies)
    - <name>
      - *.tres
      - *.png
  - 020_standalone_scenes (scenes without dependencies)
    - <name>
      - *.tres
      - *.gd
      - *.tscn
      - art/
        - *.png
        - *.mp3
        - *.wav
  - 030_deps_scenes (scenes with dependencies from standalone scenes)
    - <name>
      - *.tres
      - *.gd
      - *.tscn
      - art/
        - *.png
        - *.mp3
        - *.wav
  - 090_this (game specific scenes, scripts and art)
    - main.tscn
    - main.gd
    - <name>.tscn
    - <name>.gd
    - art
      - *.png
      - *.mp3
      - *.wav
```

## Devlog

- TODO

## TODO

- TODO

## Assets

- https://www.udemy.com/course/mobile-game-godot/

## Tools

- TODO
