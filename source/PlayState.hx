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
		snakeSquare = new FlxSprite().makeGraphic(100, 100, FlxColor.GREEN);
		add(snakeSquare);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
