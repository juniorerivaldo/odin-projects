package game_12

import src "src"
import rl "vendor:raylib"

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
			y = -50,
			width = f32(rl.GetRandomValue(30, 55)),
			height = f32(rl.GetRandomValue(30, 45)),
		},
		direction = {0, 1},
		speed = f32(rl.GetRandomValue(100, 450)),
	}
	append(falling_objects, new_falling_object)
}

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
	spawn_interval: f32 = 0.5

	falling_objects := [dynamic]src.Falling_Object{}

	player := src.Player {
		rect = rl.Rectangle{x = 1280 / 2, y = 720 / 2, width = 50, height = 50},
		direction = {0, 0},
		speed = 280,
	}


	for !rl.WindowShouldClose() {

		if rl.IsKeyDown(.SPACE) {
			game_state.current_screen = Game_Screen.GAMEPLAY
		}

		switch game_state.current_screen {
			case .MENU{
				
			}
		}
		dt := rl.GetFrameTime()
		spawn_timer += dt

		if spawn_timer >= spawn_interval {
			spawn_falling_object(&falling_objects)
			spawn_timer = 0
		}

		// UPDATE
		src.update_player(&player, dt)
		for &obj in falling_objects {
			src.update_falling_object(&obj, dt)
		}

		//DRAW
		rl.BeginDrawing()
		rl.ClearBackground(rl.BROWN)

		for obj in falling_objects {
			src.draw_falling_object(obj)
		}

		src.draw_player(player)


		rl.EndDrawing()
	}
	rl.CloseWindow()
}
