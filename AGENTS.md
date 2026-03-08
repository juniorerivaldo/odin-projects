# AGENTS.md - Odin + Raylib Game Projects

This repository contains 50 incremental game challenges using Odin and Raylib.

## Build Commands

### Building a Single Game

Use VSCode tasks: Press `Ctrl+Shift+P` → "Tasks: Run Task" → "Build Game (F5)", then enter the game number.

Or via command line:
```bash
# Build game N (debug)
odin build ./N -debug -out:./N/build/debug.exe

# Build game N (release)
odin build ./N -out:./N/build/release.exe

# Run compiled executable
./N/build/debug.exe
```

### Project Structure

```
N/
├── main.odin          # Entry point, game loop
├── player.odin        # Player entity (if needed)
├── game.odin          # Game logic
├── src/               # Additional source files
│   └── *.odin
├── build/             # Output directory (gitignored)
└── README.md          # Challenge description
```

### Running Tests

Odin has no built-in test framework. Tests are manual verification by running the game.

To verify code correctness:
```bash
# Syntax check only (no build)
odin build ./N -file-check-only
```

---

## Code Style Guidelines

### Package Declaration
```odin
package game_01  // Use game_N naming
```

### Imports
```odin
import rl "vendor:raylib"           // Raylib bindings (always use alias)
import "core:fmt"                    // Standard library
import "core:math"                   // Math utilities
import "core:time"                   // Time functions
```
- Always use `vendor:raylib` for Raylib
- Use explicit imports from core library

### Types

#### Structs
```odin
Player :: struct {
    position:  rl.Vector2,
    velocity:  rl.Vector2,
    speed:    f32,
    isGrounded: bool,
}
```
- Use PascalCase for struct names, snake_case for field names

#### Primitive Types
- Use `f32` for physics/time values: `speed: f32 = 200.0`
- Use `int` for scores/counters: `score: int`

#### Constants
```odin
GRAVITY :: 880.0
SCREEN_WIDTH :: 1280
SCREEN_HEIGHT :: 720
```
- Use SCREAMING_SNAKE_CASE

### Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Packages | `game_N` | `game_13` |
| Structs | PascalCase | `Player`, `Platform` |
| Procedures | snake_case | `update_player` |
| Variables | snake_case | `ball_position` |
| Constants | SCREAMING_SNAKE_CASE | `GRAVITY` |

### Game Loop Structure
```odin
main :: proc() {
    rl.SetTargetFPS(60)
    rl.InitWindow(1280, 720, "game_N")

    player := Player{...}

    for !rl.WindowShouldClose() {
        dt := rl.GetFrameTime()
        update_player(&player, dt)

        rl.BeginDrawing()
        rl.ClearBackground(rl.BLACK)
        draw_player(player)
        rl.EndDrawing()
    }
    rl.CloseWindow()
}
```

### Procedures
```odin
// Update: use pointer for mutation
update_player :: proc(player: ^Player, dt: f32) {
    player.position += player.velocity * dt
}

// Draw: use value for read-only
draw_player :: proc(player: Player) {
    rl.DrawRectangleV(player.position, {50, 50}, rl.GREEN)
}
```
- Use `^Player` (pointer) for update procedures that modify state
- Use `Player` (value) for draw procedures
- Pass `dt: f32` for frame-independent movement

### Vector Operations
```odin
position := rl.Vector2{1280 / 2, 720 / 2}
direction := rl.Vector2{0, 0}

if direction != {0, 0} {
    direction = rl.Vector2Normalize(direction)
}
position += direction * speed * dt
```

### Input Handling
```odin
// Continuous input
if rl.IsKeyDown(.W) { player.direction.y -= 1 }

// Single press
if rl.IsKeyPressed(.SPACE) {
    player.velocity.y = -jump_force
}
```

### Error Handling
```odin
result, ok := some_procedure()
if !ok { /* handle error */ }

// Use assert for invariants
assert(player != nil, "Player must not be nil")
```
- Use `ok` pattern for procedures returning error tuples

### Best Practices

1. **Frame-independent movement**: Always multiply by `dt`
2. **Normalization**: Normalize diagonal movement vectors
3. **Structure**: Separate update and draw into different procedures
4. **Window cleanup**: Always call `rl.CloseWindow()` at the end
5. **FPS cap**: Set target FPS (typically 60)
6. **Vectors**: Use `rl.Vector2` for 2D positions/directions

### Common Patterns

#### Collision Detection
```odin
player_rect := rl.Rectangle{
    x = player.position.x, y = player.position.y,
    width = 50, height = 50,
}
if rl.CheckCollisionRecs(player_rect, other_rect) { /* collision */ }
```

#### Dynamic Arrays
```odin
items := [dynamic]Item{}
append(&items, new_item)

// Iterate backwards when removing
for i := len(items) - 1; i >= 0; i -= 1 {
    ordered_remove(&items, i)
}
```

---

## VSCode Configuration

The `.vscode/` folder contains `tasks.json` (build tasks) and `launch.json` (debug config). Press `F5` to build and debug the selected game.
