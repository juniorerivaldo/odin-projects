package game_07

import rl "vendor:raylib"

Player :: struct {
	texture:      rl.Texture2D,
	position:     rl.Vector2,
	speed:        f32,
	frameRect:    rl.Rectangle,
	currentFrame: int,
	frameTime:    f32,
	frameSpeed:   f32,
}

MAX_FRAME :: 5

update_player :: proc(player: ^Player, dt: f32) {

	player.frameTime += dt

	if player.frameTime >= player.frameSpeed {
		player.currentFrame += 1
		if player.currentFrame >= MAX_FRAME {
			player.currentFrame = 0
		}
		player.frameTime = 0
	}

	// atribuir movimento
	player.frameRect.x = f32(player.currentFrame) * f32(player.texture.width / 6)

}
draw_player :: proc(player: Player) {
	// rl.DrawTexture(player.texture, i32(player.position.x), i32(player.position.y), rl.WHITE)
	rl.DrawTextureRec(player.texture, player.frameRect, player.position, rl.WHITE)
}

main :: proc() {

	rl.SetTargetFPS(60)
	rl.InitWindow(1280, 720, "game_07")

	// como tem texture precisa iniciar depois de iniciar o window
	playerTexture := rl.LoadTexture("scarfy.png")
	player := Player {
		position     = {640, 360},
		speed        = 30,
		texture      = playerTexture,
		currentFrame = 0,
		frameRect    = rl.Rectangle{0, 0, f32(playerTexture.width / 6), f32(playerTexture	.height)},
		frameTime    = 0,
		frameSpeed   = 0.2,
	}

	//VARIABLES

	for !rl.WindowShouldClose() {
		//UPDATE
		update_player(&player, rl.GetFrameTime())
		//DRAW
		rl.BeginDrawing()
		rl.ClearBackground(rl.LIME)
		//Draw Player
		draw_player(player)
		rl.EndDrawing()
	}
	rl.CloseWindow()
}
