package game_04

import "core:relative"
import rl "vendor:raylib"

main :: proc() {
	windowWidth: i32 = 1280
	windowHeight: i32 = 720
	playerPosition := rl.Vector2{f32(windowWidth / 2), f32(windowHeight / 2)}
	playerDirection := rl.Vector2{100.0, 0}
	playerSpeed: f32 = 4.0


	rl.SetTargetFPS(60)
	rl.InitWindow(windowWidth, windowHeight, "game_04")

	for !rl.WindowShouldClose() {

		// UPDATE
		if playerPosition.x >= f32(windowWidth - 50) {
			playerDirection.x *= -1
		}
		if playerPosition.x <= 0 {
			playerDirection.x *= -1
		}
		playerPosition += playerDirection * playerSpeed * rl.GetFrameTime()

		//DRAW
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)
		// DRAW Rectange
		rl.DrawRectangleV(playerPosition, {50, 50}, rl.GREEN)
		rl.EndDrawing()

	}
	rl.CloseWindow()
}
