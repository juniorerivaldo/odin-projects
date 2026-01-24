package src

import rl "vendor:raylib"

Player :: struct {
	rect:      rl.Rectangle,
	direction: rl.Vector2,
	speed:     f32,
}

update_player :: proc(player: ^Player, dt: f32) {
	player.direction = {0, 0}
	if rl.IsKeyDown(.W) {
		player.direction.y -= 1
	}
	if rl.IsKeyDown(.S) {
		player.direction.y += 1
	}
	if rl.IsKeyDown(.A) {
		player.direction.x -= 1
	}
	if rl.IsKeyDown(.D) {
		player.direction.x += 1
	}
	// normalizar velocidade nas diagonais só se estiver se movendo
	if player.direction != {0, 0} {
		player.direction = rl.Vector2Normalize(player.direction)
	}

	// aplicar direção a posição com base na velocidade
	player.rect.x += player.direction.x * player.speed * dt
	player.rect.y += player.direction.y * player.speed * dt

	// limitar movimento dentro da tela OBS: deve ser feito sempre após aplicar o movimento senão o player fica travado
	player.rect.x = clamp(player.rect.x, 0, 1280 - player.rect.width)
	player.rect.y = clamp(player.rect.y, 0, 720 - player.rect.height)

}

draw_player :: proc(player: Player) {
	rl.DrawRectangleRec(player.rect, rl.BLACK)
}
