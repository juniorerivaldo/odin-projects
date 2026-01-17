package game_01

import rl "vendor:raylib"

main :: proc() {
	// rl.SetConfigFlags({.VSYNC_HINT})
	rl.SetTargetFPS(60)
	rl.InitWindow(1280, 720, "game-01")

	//VARIAVEIS
	ballPosition := rl.Vector2{1280 / 2, 720 / 2}
	ballDirection := rl.Vector2{0, 0}
	ballSpeed: f32 = 200.0 // tem que ser f32 porque getFrameTime retorna f32


	for !rl.WindowShouldClose() {

		// UPDATE
		ballDirection = {0, 0} // resetando o direction para não acumular
		if rl.IsKeyDown(.W) {
			ballDirection.y -= 1
		}
		if rl.IsKeyDown(.S) {
			ballDirection.y += 1
		}
		if rl.IsKeyDown(.A) {
			ballDirection.x -= 1
		}
		if rl.IsKeyDown(.D) {
			ballDirection.x += 1
		}
		if ballDirection != {0, 0} {
			ballDirection = rl.Vector2Normalize(ballDirection)
			ballPosition += ballDirection * ballSpeed * rl.GetFrameTime()
		}

		// DRAW
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)
		//DRAW Rectangle
		rl.DrawRectangleV(ballPosition, 40, rl.GREEN)
		rl.EndDrawing()
	}
	rl.CloseWindow()
}
