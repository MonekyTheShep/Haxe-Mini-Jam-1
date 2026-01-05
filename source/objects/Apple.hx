package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Apple extends FlxSprite
{
	public function new()
	{
		super();
		loadGraphic("assets/images/apple.png");

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
