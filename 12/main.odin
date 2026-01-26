package game_12

import src "src"
import rl "vendor:raylib"


main :: proc() {

	rl.SetTargetFPS(60)
	rl.InitWindow(1280, 720, "game_12")

	// INICIANDO AS TELAS
	game_state := Game_State {
		current_screen = Game_Screen.MENU,
		score          = 0,
	}

	// VARIAVEIS
	spawn_timer: f32 = 0.0
	spawn_interval: f32 = 2.0
	score_timer: f32 = 2.0

	falling_objects := [dynamic]src.Falling_Object{}

	player := src.Player {
		rect = rl.Rectangle{x = 1280 / 2, y = 720 / 2, width = 50, height = 50},
		direction = {0, 0},
		speed = 280,
	}


	for !rl.WindowShouldClose() {

		// UPDATE
		switch game_state.current_screen {

		case .MENU:
			if rl.IsKeyPressed(.SPACE) {
				game_state.current_screen = Game_Screen.GAMEPLAY
			}

		case .GAMEPLAY:
			dt := rl.GetFrameTime()
			spawn_timer += dt
			score_timer -= dt
			update_all_falling_objects(&falling_objects, &player, &game_state)

			if score_timer <= 0 {
				game_state.score += 1
				score_timer = 2.0
			}

			if spawn_timer >= spawn_interval {
				spawn_falling_object(&falling_objects)
				spawn_timer = 0
				if spawn_interval >= 0.2 {
					spawn_interval -= 0.1
				}
			}

			src.update_player(&player, dt)
			for &obj in falling_objects {
				src.update_falling_object(&obj, dt)
			}

			if rl.IsKeyPressed(.SPACE) {
				game_state.current_screen = Game_Screen.MENU
			}

		case .GAMEOVER:
			if rl.IsKeyPressed(.SPACE) {
				clear(&falling_objects)
				game_state.score = 0
				game_state.current_screen = .MENU
			}

		}

		//DRAW
		rl.BeginDrawing()
		rl.ClearBackground(rl.BROWN)

		switch game_state.current_screen {
		case .MENU:
			rl.DrawText("MENU - PRESSIONE ESPAÇO", 350, 300, 40, rl.WHITE)

		case .GAMEPLAY:
			for obj in falling_objects {
				src.draw_falling_object(obj)
			}

			rl.DrawText(rl.TextFormat("Score: %d", game_state.score), 30, 20, 32, rl.WHITE)
			src.draw_player(player)

		case .GAMEOVER:
			rl.DrawText("GAME OVER", 450, 300, 60, rl.RED)
		}

		rl.EndDrawing()
	}
	rl.CloseWindow()
}


Game_Screen :: enum {
	MENU,
	GAMEPLAY,
	GAMEOVER,
}

Game_State :: struct {
	current_screen: Game_Screen,
	score:          int,
}

spawn_falling_object :: proc(falling_objects: ^[dynamic]src.Falling_Object) {
	new_falling_object := src.Falling_Object {
		rect = {
			x = f32(rl.GetRandomValue(50, 1280 - 50)),
			y = -500,
			width = f32(rl.GetRandomValue(30, 55)),
			height = f32(rl.GetRandomValue(30, 45)),
		},
		direction = {0, 1},
		speed = f32(rl.GetRandomValue(150, 550)),
	}
	append(falling_objects, new_falling_object)
}

update_all_falling_objects :: proc(
	falling_objects: ^[dynamic]src.Falling_Object,
	player: ^src.Player,
	game_state: ^Game_State,
) {
	for i := len(falling_objects) - 1; i >= 0; i -= 1 {
		falling_object := falling_objects[i]
		if falling_object.rect.y > 720 - falling_object.rect.height {
			ordered_remove(falling_objects, i)
		}
		if check_for_collision(falling_object, player^) {
			game_state.current_screen = .GAMEOVER
		}
	}
}

check_for_collision :: proc(falling_object: src.Falling_Object, player: src.Player) -> bool {
	return rl.CheckCollisionRecs(player.rect, falling_object.rect)
}
