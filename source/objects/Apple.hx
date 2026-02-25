package objects;

import flixel.FlxSprite;

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
