package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
class PlayState extends FlxState
{
	var snakeSquare:FlxSprite;
	override public function create()
	{
		super.create();
		var snake = new Snake();
		add(snake);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
