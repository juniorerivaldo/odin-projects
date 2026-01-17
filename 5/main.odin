package game_05

import "core:math"
import rl "vendor:raylib"


main :: proc() {


	rl.SetTargetFPS(60)
	rl.InitWindow(1280, 720, "game_05")

	//VARIAVEIS
	playerPos := rl.Vector2{1280 / 2, 720 / 2}
	playerVel: f32 = 0
	MaxplayerVel: f32 = 300
	acceleration: f32 = 10

	for !rl.WindowShouldClose() {

		//UPDATE

		if rl.IsKeyDown(.D) {
			playerVel += acceleration
		} else if rl.IsKeyDown(.A) {
			playerVel -= acceleration
		} else {
			// Desaceleração gradual
			if playerVel > 0 {
				playerVel -= acceleration
				if playerVel < 0 {
					playerVel = 0
				}
			}
			if playerVel < 0 {
				playerVel += acceleration
				if playerVel > 0 {
					playerVel = 0
				}
			}
		}

		playerVel = math.clamp(playerVel, -MaxplayerVel, MaxplayerVel) // TRAVANDO A VELOCIDADE

		playerPos.x += playerVel * rl.GetFrameTime()

		//DRAW
		rl.BeginDrawing()
		rl.ClearBackground(rl.BROWN)
		// Draw Rectangle
		rl.DrawRectangleV(playerPos, {50, 50}, rl.BLACK)
		rl.EndDrawing()

	}
	rl.CloseWindow()

}
