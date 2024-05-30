# Game MVP 003 - Mobile Game Like Doogle Jump

The game is implemented during the course "Master Mobile Game Development with Godot 4".
- Course: https://www.udemy.com/course/mobile-game-godot/
- Created by: GameDev.tv Team, Kaan Alpar.
- Repo: https://gitlab.com/GameDevTV/godot-mobile/jumper-jam
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
  - files: `snake_case`
  - animation: `snake_case`
  - layers: `snake_case`
- Use type hints for variables and functions to get security from intellisense.
- Use undercore for method's arguments: `func setup_camera(_player: Player):`.
- Check different screen sizes when testing the mobile game.

## Files structure

- TODO

## Devlog

- TODO

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
