package buttons_game

import rl "vendor:raylib"

main:: proc(){

	Button :: struct{
		rect: rl.Rectangle,
		text: cstring,
		normalColor: rl.Color,
		hoveredColor: rl.Color,
		pressedColor : rl.Color,
		clicked: bool,
	}

	create_button :: proc(buttonRect : rl.Rectangle, text: cstring, normalColor:rl.Color, hoveredColor: rl.Color, pressedColor:rl.Color) -> Button {
		return Button{
			rect = buttonRect,
			text = text,
			normalColor = normalColor,
			hoveredColor = hoveredColor,
			pressedColor = pressedColor, 
			clicked = false
		}
	}

	update_button:: proc(button: ^Button){
		mousePos := rl.GetMousePosition()

		is_hovered := rl.CheckCollisionPointRec(mousePos, button.rect)

		if is_hovered && rl.IsMouseButtonDown(.LEFT){
			button.clicked = true
		} else if rl.IsMouseButtonReleased(.LEFT){
			button.clicked = false
		}
	}

	draw_button :: proc(button: Button){
		mousePos := rl.GetMousePosition()
		is_hovered := rl.CheckCollisionPointRec(mousePos,button.rect)
		
		color := button.normalColor

		if is_hovered{
			color = button.hoveredColor
		}
		if button.clicked{
			color = button.pressedColor
		}

		rl.DrawRectangleRec(button.rect,color)

		textWidth := rl.MeasureText(button.text,32)
		textX := button.rect.x + (button.rect.width - f32(textWidth)) /2
		textY := button.rect.y + (button.rect.height - 32) / 2

		rl.DrawText(button.text,i32(textX), i32(textY), 32, rl.WHITE)
	}



	rl.SetTargetFPS(60)
	rl.InitWindow(1280,720,"Game About Buttons :)")

	playButton := create_button(
		rl.Rectangle{
			x = 530,
			y = 300,
			width = 200,
			height = 80,
		},
		"Play",
		rl.GREEN,
		rl.BROWN,
		rl.RED,
	)

	for !rl.WindowShouldClose(){

		update_button(&playButton)
		rl.BeginDrawing()

		rl.ClearBackground(rl.GRAY)
		draw_button(playButton)
		rl.EndDrawing()

	}

	rl.CloseWindow()

}