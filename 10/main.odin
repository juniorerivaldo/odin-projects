package game_10

import rl "vendor:raylib"

Player :: struct {
	position:     rl.Vector2,
	velocity:     rl.Vector2,
	isGrounded:   bool,
	idDashing:    bool,
	speed:        f32,
	jumpForce:    f32,
	dashTime:     f32,
	dashCooldown: f32,
}


Platform :: struct {
	position:  rl.Vector2,
	direction: rl.Vector2,
	speed:     f32,
	size:      rl.Vector2,
}

check_collision :: proc(player: ^Player, platform: Platform, dt: f32) {
	player_rect := rl.Rectangle {
		x      = player.position.x,
		y      = player.position.y,
		width  = 50,
		height = 50,
	}
	platform_rect := rl.Rectangle {
		x      = platform.position.x,
		y      = platform.position.y,
		width  = platform.size.x,
		height = platform.size.y,
	}

	if (rl.CheckCollisionRecs(player_rect, platform_rect)) {
		player_bottom := player.position.y + 50
		plataform_top := platform.position.y

		if player.velocity.y > 0 && player_bottom - player.velocity.y * dt <= plataform_top + 10 {
			player.position.y = platform.position.y - 50
			player.position.x += platform.direction.x * platform.speed * dt // se mover junto
			player.isGrounded = true
			player.velocity.y = 0
		}
	}
}

update_player :: proc(player: ^Player, dt: f32, gravity: f32, platfom: Platform) {
	// Input horizontal
	player.velocity.x = 0

	if rl.IsKeyDown(.D) {
		player.velocity.x = player.speed
	}
	if rl.IsKeyDown(.A) {
		player.velocity.x = -player.speed
	}

	// Pulo
	if player.isGrounded && rl.IsKeyPressed(.SPACE) {
		player.velocity.y = -player.jumpForce // impulso para cima
		player.isGrounded = false
	}
	player.isGrounded = false

	player.velocity.y += gravity * dt

	// Atualizar posição
	player.position += player.velocity * dt

	check_collision(player, platfom, dt)


	// Colisão com chão
	if player.position.y + 50 >= 720 {
		player.position.y = 720 - 50
		player.velocity.y = 0
		player.isGrounded = true
	}


}

draw_player :: proc(player: Player) {
	rl.DrawRectangleV(player.position, {50, 50}, rl.DARKPURPLE)
}

update_platform :: proc(platform: ^Platform, dt: f32) {
	if platform.position.x <= 0 {
		platform.direction.x *= -1
	}
	if platform.position.x >= 1280 - platform.size.x {
		platform.direction.x *= -1
	}
	platform.position += platform.direction * platform.speed * dt
}

draw_platform :: proc(platform: Platform) {
	rl.DrawRectangleV(platform.position, platform.size, rl.BLUE)
}

main :: proc() {
	rl.SetTargetFPS(60)
	rl.InitWindow(1280, 720, "game_10")

	gravity: f32 = 880.0
	player := Player {
		position   = {1280 / 2, 720 / 2},
		velocity   = {0, 0},
		speed      = 200.0,
		jumpForce  = 400.0, // força do pulo
		isGrounded = false,
	}

	platform := Platform {
		position  = {1280 / 2, 630},
		direction = {100.0, 0},
		speed     = 4.0,
		size      = {300, 40},
	}

	for !rl.WindowShouldClose() {
		update_player(&player, rl.GetFrameTime(), gravity, platform)
		update_platform(&platform, rl.GetFrameTime())
		rl.BeginDrawing()
		rl.ClearBackground(rl.LIGHTGRAY)
		draw_platform(platform)
		draw_player(player)
		rl.EndDrawing()
	}

	rl.CloseWindow()
}
