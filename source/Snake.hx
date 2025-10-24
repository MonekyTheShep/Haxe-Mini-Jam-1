package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Snake extends FlxSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		this.x = x;
		this.y = y;

		super(this.x, this.y);

		makeGraphic(20, 20, FlxColor.GREEN);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}