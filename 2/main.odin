package game_02

import rl "vendor:raylib"

main :: proc() {

	rl.InitWindow(1280, 720, "game_02")
	rl.SetTargetFPS(60)

	ballPosition := rl.Vector2{1280 / 2, 720 / 2}

	for !rl.WindowShouldClose() {


		// UPDATE
		ballPosition = rl.GetMousePosition()

		//DRAW
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)
		rl.DrawText(
			rl.TextFormat(
				"MousePos: %.0f, %.0f",
				rl.GetMousePosition().x,
				rl.GetMousePosition().y,
			),
			10,
			10,
			20,
			rl.WHITE,
		)
		// DRAW Circle
		rl.DrawCircleV(ballPosition, 50, rl.WHITE)
		rl.EndDrawing()
	}

	rl.CloseWindow()

}
