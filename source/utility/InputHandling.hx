package utility;
import flixel.FlxG;
import flixel.ui.FlxVirtualPad;
import objects.Snake;

class InputHandling
{
	var snake:Snake;
	var dPad:FlxVirtualDPadButtons;

	public function new(snake:Snake, dPad:FlxVirtualDPadButtons)
	{
		this.snake = snake;
		this.dPad = dPad;
	}

	public function input():Void
	{

		#if (desktop || js)
		// Handle desktop and web movement
		if (snake != null)
		{
			if (FlxG.keys.anyJustPressed([A, LEFT]) && snake.direction != RIGHT)
				snake.direction = LEFT;
			else if (FlxG.keys.anyJustPressed([D, RIGHT]) && snake.direction != LEFT)
				snake.direction = RIGHT;
			else if (FlxG.keys.anyJustPressed([W, UP]) && snake.direction != DOWN)
				snake.direction = UP;
			else if (FlxG.keys.anyJustPressed([S, DOWN]) && snake.direction != UP)
				snake.direction = DOWN;
		}
		#end


		#if android
		// Handle Android Movement...
		if (snake != null && dPad != null)
		{
			if (dPad.getButton(LEFT).justPressed && snake.direction != RIGHT)
				snake.direction = LEFT;
			else if (dPad.getButton(RIGHT).justPressed && snake.direction != LEFT)
				snake.direction = RIGHT;
			else if (dPad.getButton(UP).justPressed && snake.direction != DOWN)
				snake.direction = UP;
			else if (dPad.getButton(DOWN).justPressed && snake.direction != UP)
				snake.direction = DOWN;
		}
		#end

	}
}