package src

import rl "vendor:raylib"

Falling_Object :: struct {
	rect:      rl.Rectangle,
	direction: rl.Vector2,
	speed:     f32,
}

update_falling_object :: proc(obj: ^Falling_Object, dt: f32) {
	obj.rect.x += obj.direction.x * obj.speed * dt
	obj.rect.y += obj.direction.y * obj.speed * dt
}

draw_falling_object :: proc(obj: Falling_Object) {
	rl.DrawRectangleRec(obj.rect, rl.RED)
}
