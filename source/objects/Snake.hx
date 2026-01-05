package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;

// your enum snake direction
enum SnakeDirection
{
	LEFT;
	RIGHT;
	UP;
	DOWN;
}

class Snake extends FlxGroup
{
	// snake color wowwww
	var snakeColor = FlxColor.GREEN;
	var tailColor = FlxColor.RED;

	// snake parts
	public var snakeHead:FlxSprite;
	public var snakeBody:FlxTypedSpriteGroup<FlxSprite>;

	// prev positions storey variable
	var prevPositions:Array<Array<Float>> = [];

	var timer:FlxTimer;

	// game over boolean
	public var gameOver:Bool = false;

	// direction
	public var direction:Null<SnakeDirection> = null;

	public function new(x:Float = 0, y:Float = 0, ?direction:SnakeDirection = RIGHT)
	{
		super();

		this.direction = direction;

		// set snakehead shit
		add(snakeHead = new FlxSprite());
		add(snakeBody = new FlxTypedSpriteGroup<FlxSprite>());

		snakeHead.makeGraphic(Constants.TILE_SIZE, Constants.TILE_SIZE);
		snakeHead.setPosition(x, y);
		snakeHead.color = snakeColor;

		timer = new FlxTimer().start(movementInterval / FlxG.updateFramerate, doTimer);

		doTimer();

	}

	// your movement timer
	public var movementInterval:Float = 8;

	private function doTimer(?tmr:FlxTimer):Void
	{
		if (!this.alive && tmr != null)
		{
			tmr = FlxDestroyUtil.destroy(tmr);
			return;
		}

		lastPosition();
		move();
		timer.start(movementInterval / FlxG.updateFramerate, doTimer);

	}

	@:noCompletion override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		// loop through snakebody members until gameover is not true
		if (!gameOver)
		{
			// wait until previous position = the snakebody.length. It has -1 because prevPosition it includes the head.
			if (prevPositions.length - 1 == snakeBody.length)
			{
				for (i => tails in snakeBody.members)
				{
					// move it to the previous position
					tails.x = prevPositions[i][0];
					tails.y = prevPositions[i][1];
					// check the tail collision to the head
					if (FlxCollision.pixelPerfectCheck(snakeHead, tails))
					{
						gameOver = true;
					}
				}
			}

		}

	}

	// snake grow function to add to the snakebody
	public function grow()
	{
		var tailSquare:FlxSprite = new FlxSprite();
		tailSquare.makeGraphic(Constants.TILE_SIZE, Constants.TILE_SIZE);
		tailSquare.x = -100;
		tailSquare.color = tailColor;

		snakeBody.add(tailSquare);
	}

	// move the snake and do screen wrapping
	function move():Void
	{

		if (direction != null && gameOver != true)
		{
			switch (direction)
			{
				case LEFT:
					snakeHead.x -= Constants.TILE_SIZE;
				case RIGHT:
					snakeHead.x += Constants.TILE_SIZE;
				case UP:
					snakeHead.y -= Constants.TILE_SIZE;
				case DOWN:
					snakeHead.y += Constants.TILE_SIZE;
			}
			FlxSpriteUtil.screenWrap(snakeHead);
		}
	}
	// store last moved position
	function lastPosition():Void
	{
		prevPositions = [];

		// add the head position
		prevPositions.push([snakeHead.x, snakeHead.y]);

		// store the tail body positions.
		for (member in snakeBody.members)
		{
			var tails:FlxSprite = cast member;
			prevPositions.push([tails.x, tails.y]);
		}
	}
}
