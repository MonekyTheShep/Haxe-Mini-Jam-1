package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import openfl.display.Sprite;

class PlayState extends FlxState
{
	var snake:Snake;

	@:dox(hide) override public function create()
	{
		super.create();
		add(new GridSprite(FlxColor.WHITE));
		add(snake = new Snake(0, 0));
	}

	@:dox(hide) override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (snake != null)
		{
			if (FlxG.keys.pressed.A)
			{
				snake.direction = LEFT;
			}
			else if (FlxG.keys.pressed.D)
			{
				snake.direction = RIGHT;
			}
			else if (FlxG.keys.pressed.W)
			{
				snake.direction = UP;
			}
			else if (FlxG.keys.pressed.S)
			{
				snake.direction = DOWN;
			}
		}
	}
}
