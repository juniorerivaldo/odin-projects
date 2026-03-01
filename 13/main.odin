package game_13

import rl "vendor:raylib"


main :: proc() {
	rl.SetTargetFPS(60)
	rl.InitWindow(1280, 720, "game_13")

	for !rl.WindowShouldClose() {

		// UPDATE

		// DRAW
		rl.BeginDrawing()
		rl.ClearBackground(rl.BEIGE)

		rl.EndDrawing()
	}

	rl.CloseWindow()
}
