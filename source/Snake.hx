package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

enum SnakeDirection
{
	LEFT;
	RIGHT;
	UP;
	DOWN;

	NULL; // used for init...
}

class Snake extends FlxSprite
{
	var snakeParts:Int = 6;
	var position:Array<Float> = [0, 0];
	var snakeColor = FlxColor.GREEN;
	var tailColor = FlxColor.RED;

	public var direction:SnakeDirection = NULL;

	public function new(x:Float = 0, y:Float = 0, ?direction:SnakeDirection = RIGHT)
	{
		this.setPosition(x, y);
		this.direction = direction;

		super(x, y);
		makeGraphic(Constants.TILE_SIZE, Constants.TILE_SIZE);
	}

	@:noCompletion override public function draw():Void
	{
		super.draw();
		var previousPos = [0, 0];
		for (i in 0...snakeParts)
		{
			if (i == 0)
			{
				this.x = position[0] * Constants.TILE_SIZE + 5;
				this.y = position[1] * Constants.TILE_SIZE + 5;
				this.color = snakeColor;
				super.draw();
			}
			else
			{
				this.x = i;
				this.y = i;
				this.color = tailColor;
				super.draw();
			}
		}
	}

	@:noCompletion override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		trace(this.direction);
		move();
	}
	function move():Void
	{
		switch (direction)
		{
			case LEFT:
				position[0] -= 1;
			case RIGHT:
				position[0] += 1;
				trace(position[0]);
			case UP:
				position[1] -= 1;
			case DOWN:
				position[1] += 1;
			case NULL:
			default:
		}
	}
}
