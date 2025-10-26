package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class GridSprite extends FlxSprite
{
	public function new(?color:FlxColor = FlxColor.WHITE)
	{
		super();

		makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);

		for (i in 0...Std.int(FlxG.width / Constants.TILE_SIZE))
		{
			final x:Int = i * Constants.TILE_SIZE;
			FlxSpriteUtil.drawLine(this, x, 0, x, FlxG.height, { color: color, thickness: .5 });
		}

		for (i in 0...Std.int(FlxG.height / Constants.TILE_SIZE))
		{
			final y:Int = i * Constants.TILE_SIZE;
			FlxSpriteUtil.drawLine(this, 0, y, FlxG.width, y, { color: color, thickness: .5 });
		}
	}
}
