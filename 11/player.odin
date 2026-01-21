package game_11

import "core:fmt"
import rl "vendor:raylib"


Player :: struct {
	position:  rl.Vector2,
	direction: rl.Vector2,
	speed:     f32,
	width:     f32,
	height:    f32,
	score:     int,
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

	if player.direction != {0, 0} {
		player.direction = rl.Vector2Normalize(player.direction)
		player.position += player.direction * player.speed * dt
	}

}

draw_player :: proc(player: Player) {
	score_text := fmt.ctprintf("Score: %d", player.score)
	rl.DrawText(score_text, 10, 10, 32, rl.GREEN)
	rl.DrawRectangleV(player.position, {player.width, player.height}, rl.GREEN)
}
