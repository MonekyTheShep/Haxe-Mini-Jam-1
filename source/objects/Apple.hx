package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Apple extends FlxSprite
{
	var tween:FlxTween;
	public function new(x:Float, y:Float)
	{
		super();
		// makeGraphic(Constants.TILE_SIZE, Constants.TILE_SIZE, FlxColor.RED);
		loadGraphic("assets/images/apple.png");
		this.x = x;
		this.y = y;
		FlxTween.tween(this, {x: this.x, y: this.y - 2}, 4, {
			type: PINGPONG,
			ease: FlxEase.quadInOut,
			startDelay: 0,
			loopDelay: 0
		});
		// tween = FlxTween.tween(this, {x: 0, y: 0}, 2);

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
