package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Apple extends FlxSprite
{
	public function new()
	{
		super();
		makeGraphic(Constants.TILE_SIZE, Constants.TILE_SIZE, FlxColor.RED);
		loadGraphic("assets/images/apple.png");
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
