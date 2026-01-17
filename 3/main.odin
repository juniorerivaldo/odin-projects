package game_03

import rl "vendor:raylib"

main :: proc() {

	rl.SetTargetFPS(60)
	rl.InitWindow(1280, 720, "game_o3")

	//VARIAVEIS
	playerPos := rl.Vector2{1280 / 2, 720 / 2}
	playerSpeed := rl.Vector2{0, 0}
	gravity: f32 = 500.0
	isGrounded: bool

	for !rl.WindowShouldClose() {
		if playerPos.y + 50 >= 720 {
			playerPos.y = 720 - 50
			playerSpeed.y = 0
			isGrounded = true
		}
		playerSpeed.x = 0 // reseta todo frame a speed X
		// UPDATE
		if rl.IsKeyDown(.A) {
			playerSpeed.x = -300
		}
		if rl.IsKeyDown(.D) {
			playerSpeed.x = 300
		}

		playerSpeed.y += gravity * rl.GetFrameTime() // gravidade

		if rl.IsKeyPressed(.W) && isGrounded {
			playerSpeed.y = -300
			isGrounded = false
		}
		playerPos += playerSpeed * rl.GetFrameTime()

		//DRAW
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)
		//DRAW Rectangle
		rl.DrawRectangleV(playerPos, {50, 50}, rl.WHITE)
		rl.EndDrawing()

	}

	rl.CloseWindow()


}
