package src

import rl "vendor:raylib"

Snake :: struct{
	positions: [dynamic]rl.Vector2,
	direction : rl.Vector2,
	cell_size : f32,
	move_timer : f32,
	move_interval : f32
}

update_snake