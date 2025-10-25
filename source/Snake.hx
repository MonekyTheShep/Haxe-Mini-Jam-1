package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;

enum SnakeDirection
{
	LEFT;
	RIGHT;
	UP;
	DOWN;
}

class Snake extends FlxSprite
{
	var snakeParts:Int = 6;
	var position:Array<Float> = [0, 0];
	var snakeColor = FlxColor.GREEN;
	var tailColor = FlxColor.RED;

	public var direction:Null<SnakeDirection> = null;

	public function new(x:Float = 0, y:Float = 0, ?direction:SnakeDirection = RIGHT)
	{
		this.setPosition(x, y);
		this.direction = direction;

		super(x, y);
		makeGraphic(Constants.TILE_SIZE, Constants.TILE_SIZE);
		doTimer();
	}

	var previousPositions:Array<Array<Float>> = [];
	var prevPos = [];
	@:noCompletion override public function draw():Void
	{
		super.draw();
		// var previousPos = [0, 0];
		// for (i in 0...snakeParts)
		// {
		// 	if (i == 0)
		// 	{
		// 		this.x = position[0] * Constants.TILE_SIZE + 5;
		// 		this.y = position[1] * Constants.TILE_SIZE + 5;
		// 		prevPos = [this.x, this.y];
		// 		trace(prevPos);
		// 		this.color = snakeColor;
		// 		super.draw();
		// 	}
		// 	else
		// 	{
		// 		this.x = previousPos[0] - prevPos[0];
		// 		this.y = previousPos[1] + prevPos[1];
		// 		this.color = tailColor;
		// 		super.draw();
		// 	}
		// }
	}

	public var movementInterval:Float = 8;

	private function doTimer(?tmr:FlxTimer):Void
	{
		if (!this.alive && tmr != null)
		{
			tmr = FlxDestroyUtil.destroy(tmr);
			return;
		}
		new FlxTimer().start(movementInterval / FlxG.updateFramerate, doTimer);
		move();
	}

	@:noCompletion override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		trace(this.direction);
		// move();
	}

	function move():Void
	{
		if (direction != null)
		{
			switch (direction)
			{
				case LEFT:
					this.x -= Constants.TILE_SIZE;
				case RIGHT:
					this.x += Constants.TILE_SIZE;
					trace(position[0]);
				case UP:
					this.y -= Constants.TILE_SIZE;
				case DOWN:
					this.y += Constants.TILE_SIZE;
			}
			FlxSpriteUtil.screenWrap(this);
		}
		trace(previousPositions);
	}
}
