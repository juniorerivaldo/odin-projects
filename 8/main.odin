package game_08

import rl "vendor:raylib"


main :: proc() {

	rl.SetTargetFPS(60)
	rl.InitWindow(1280, 720, "game_08")

	//VARIABLES

	for !rl.WindowShouldClose() {
		//UPDATE

		//DRAW
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLUE)

		// Draw Player
		rl.EndDrawing()
	}

	rl.CloseWindow()
}
