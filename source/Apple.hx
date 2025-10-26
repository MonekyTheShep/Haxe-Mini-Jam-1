package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class Apple extends FlxSprite
{
	var tween:FlxTween;
	public function new()
	{
		super();
		// makeGraphic(Constants.TILE_SIZE, Constants.TILE_SIZE, FlxColor.RED);
		loadGraphic("assets/images/apple.png");
		final padding:Int = Constants.TILE_SIZE * 2;
		this.x = (FlxG.random.int(Std.int(padding / Constants.TILE_SIZE), Std.int((FlxG.width - padding) / Constants.TILE_SIZE) - 1)) * Constants.TILE_SIZE;
		this.y = (FlxG.random.int(Std.int(padding / Constants.TILE_SIZE), Std.int((FlxG.height - padding) / Constants.TILE_SIZE) - 1)) * Constants.TILE_SIZE;
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
