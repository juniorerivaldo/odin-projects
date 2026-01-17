package game_09

import rl "vendor:raylib"

Player :: struct {
	position:     rl.Vector2,
	direction:    rl.Vector2,
	speed:        f32,
	isDash:       bool,
	dashTime:     f32,
	cooldownTime: f32,  // NOVO
}

update_player :: proc(player: ^Player, dt: f32) {
	player.direction = {0, 0}
	
	// Input
	if rl.IsKeyDown(.D) {
		player.direction.x += 1
	}
	if rl.IsKeyDown(.A) {
		player.direction.x -= 1
	}

	// Normaliza e move
	if player.direction.x != 0 {
		player.direction = rl.Vector2Normalize(player.direction)
		player.position.x += player.direction.x * player.speed * dt
	}

	// Dash - aperta ESPAÇO (só se cooldown terminou)
	if rl.IsKeyPressed(.SPACE) && player.isDash == false && player.cooldownTime >= 1.0 {
		player.isDash = true
		player.dashTime = 0
		player.speed = 900
	}

	// aqui tudo é dentro do dash
	// Conta tempo do dash
	if player.isDash {
		player.dashTime += dt
		
		// Volta ao normal depois de 0.3 segundos
		if player.dashTime >= 0.3 {
			player.isDash = false
			player.speed = 200
			player.cooldownTime = 0  // Reseta cooldown
		}
	} else {
		// Conta cooldown quando não está em dash se chegar em 1 ai libera para o if la de cima
		player.cooldownTime += dt
	}
}

draw_player :: proc(player: Player) {
	rl.DrawRectangleV(player.position, {50, 50}, rl.WHITE)
}

main :: proc() {
	rl.SetTargetFPS(60)
	rl.InitWindow(1280, 720, "game_09")

	player := Player {
		position     = {1280 / 2, 720 / 2},
		direction    = {0, 0},
		speed        = 200,
		isDash       = false,
		dashTime     = 0,
		cooldownTime = 1.0,  // Começa pronto pra usar
	}

	for !rl.WindowShouldClose() {
		//UPDATE
		update_player(&player, rl.GetFrameTime())
		//DRAW
		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)
		draw_player(player)
		rl.EndDrawing()
	}

	rl.CloseWindow()
}