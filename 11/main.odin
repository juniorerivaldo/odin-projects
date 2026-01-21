package game_11

import "core:fmt"
import rl "vendor:raylib"


Item :: struct {
	position:  rl.Vector2,
	direction: rl.Vector2,
	speed:     f32,
	width:     f32,
	height:    f32,
}

spawn_itens :: proc(itens: ^[dynamic]Item) {


	// criar o novo iten em posição aleatória
	new_item := Item {
		position  = {f32(rl.GetRandomValue(50, 1280)), f32(rl.GetRandomValue(-60, -30))},
		direction = {f32(rl.GetRandomValue(-3, 3)), 1},
		speed     = f32(rl.GetRandomValue(40, 150)),
		width     = 50.0,
		height    = 50.0,
	}

	// fazer o append do novo item dentro do array de itens
	append(itens, new_item)
	// fmt.printf("TOTAL DE ITENS", len(itens))
}

update_itens :: proc(itens: ^[dynamic]Item, dt: f32, player: Player) {
	for i := len(itens) - 1; i >= 0; i -= 1 {
		itens[i].position += itens[i].direction * itens[i].speed * dt

		if check_collision(itens[i], player) {
			ordered_remove(itens, i)
		}

		// remover os itens que sairam da tela
		if itens[i].position.x > 1280 + itens[i].width ||
		   itens[i].position.x < -itens[i].width ||
		   itens[i].position.y > itens[i].width + 720 {
			ordered_remove(itens, i)
			// fmt.printf("TOTAL DE ITENS DEPOIS DE REMOVER", len(itens))

		}
	}
}

draw_itens :: proc(itens: [dynamic]Item) {
	for item in itens {
		rl.DrawRectangleV(item.position, {50, 50}, rl.WHITE)
	}
}

check_collision :: proc(item: Item, player: Player) -> bool {
	player_rect := rl.Rectangle {
		x      = player.position.x,
		y      = player.position.y,
		width  = player.width,
		height = player.height,
	}
	item_rect := rl.Rectangle {
		x      = item.position.x,
		y      = item.position.y,
		width  = item.width,
		height = item.height,
	}
	return rl.CheckCollisionRecs(player_rect, item_rect)
}

main :: proc() {


	rl.SetTargetFPS(60)
	rl.InitWindow(1280, 720, "game_11")
	items := [dynamic]Item{}
	spawn_timer: f32 = 0.0
	spawn_interval: f32 = 0.4

	player := Player {
		position  = {1280 / 2, 720 / 2},
		direction = {0, 0},
		speed     = 140,
		width     = 50.0,
		height    = 50.0,
	}


	for !rl.WindowShouldClose() {
		// UPDATE
		dt := rl.GetFrameTime()

		spawn_timer += dt

		if spawn_timer >= spawn_interval {
			spawn_itens(&items)
			spawn_timer = 0
		}

		update_itens(&items, dt, player)
		update_player(&player, dt)


		//DRAW
		rl.BeginDrawing()
		rl.ClearBackground(rl.MAGENTA)
		draw_player(player)
		draw_itens(items)
		rl.EndDrawing()
	}
	rl.CloseWindow()

}
