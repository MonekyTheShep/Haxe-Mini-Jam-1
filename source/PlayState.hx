package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
class PlayState extends FlxState
{
	var snake = new Snake(0, 0, "RIGHT");

	override public function create()
	{
		super.create();
		add(snake);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.keys.pressed.A)
		{
			snake.direction = "LEFT";
		}
		else if (FlxG.keys.pressed.D)
		{
			snake.direction = "RIGHT";
		}
		else if (FlxG.keys.pressed.W)
		{
			snake.direction = "UP";
		}
		else if (FlxG.keys.pressed.S)
		{
			snake.direction = "DOWN";
		}

	}
}
