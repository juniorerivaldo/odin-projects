package game_06

import "core:math"
import rl "vendor:raylib"

Player :: struct {
	pos:      rl.Vector2,
	dir:      rl.Vector2,
	speed:    f32,
	rotation: f32,
	size:     f32,
}

update_player :: proc(player: ^Player, dt: f32) { 	// o ^é um ponteiro ele modifica o original
	player.dir = {0, 0}

	// Define DIREÇÃO (sem speed)
	if rl.IsKeyDown(.W) do player.dir.y -= 1
	if rl.IsKeyDown(.S) do player.dir.y += 1
	if rl.IsKeyDown(.A) do player.dir.x -= 1
	if rl.IsKeyDown(.D) do player.dir.x += 1

	//normalizar as diagonais
	if player.dir != {0, 0} {
		player.dir = rl.Vector2Normalize(player.dir)
	}

	// Rotação do mouse
	mousePos := rl.GetMousePosition()
	direction := mousePos - player.pos
	angleRad := math.atan2(direction.y, direction.x)
	player.rotation = math.to_degrees(angleRad)

	// Aplica velocidade aqui
	player.pos += player.dir * player.speed * dt
}

draw_player :: proc(player: Player) { 	// aqui não vai ponteiro porque só le os dados
	// origem da rotação
	origin := rl.Vector2{player.size / 2, player.size / 2}
	rect := rl.Rectangle {
		x      = player.pos.x,
		y      = player.pos.y,
		width  = player.size,
		height = player.size,
	}
	// Desenha com rotaçãoporque 
	rl.DrawRectanglePro(rect, origin, player.rotation, rl.WHITE)
}

main :: proc() {


	rl.SetTargetFPS(60)
	rl.InitWindow(1280, 720, "game_06")

	//VARIAVEIS
	player := Player {
		pos      = {640, 360},
		size     = 50,
		speed    = 200,
		dir      = {0, 0},
		rotation = 0,
	}

	for !rl.WindowShouldClose() {


		//UPDATE
		update_player(&player, rl.GetFrameTime())


		//DRAW
		rl.BeginDrawing()
		rl.ClearBackground(rl.DARKPURPLE)
		//DRAW Rectangle
		draw_player(player)
		rl.EndDrawing()
	}

	rl.CloseWindow()
}
