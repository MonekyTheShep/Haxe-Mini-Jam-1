package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Apple extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super();
		// makeGraphic(Constants.TILE_SIZE, Constants.TILE_SIZE, FlxColor.RED);
		loadGraphic("assets/images/apple.png");
		this.x = x;
		this.y = y;

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
