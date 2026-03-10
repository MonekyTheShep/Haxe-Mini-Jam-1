package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.math.FlxPoint;
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
	var snakeColor = FlxColor.GREEN;
	var tailColor = FlxColor.RED;
	
	public var snakeHead:FlxSprite;
	public var snakeBody:FlxTypedSpriteGroup<FlxSprite>;
	
	var prevPositions:Array<FlxPoint>;

	var timer:FlxTimer;

	public var gameOver:Bool = false;

	public var direction:Null<SnakeDirection> = null;

	public function new(x:Float = 0, y:Float = 0, ?direction:SnakeDirection = RIGHT)
	{
		super();

		this.direction = direction;
		this.prevPositions = new Array<FlxPoint>();
		this.snakeHead = new FlxSprite();
		this.snakeBody = new FlxTypedSpriteGroup<FlxSprite>();
	
		snakeHead.makeGraphic(Constants.TILE_SIZE, Constants.TILE_SIZE);
		snakeHead.setPosition(x, y);
		snakeHead.color = snakeColor;

		add(snakeHead);
		add(snakeBody);
		
		timer = new FlxTimer().start(Constants.movementInterval / FlxG.updateFramerate, doTimer);
		doTimer();
	}

	private function doTimer(?tmr:FlxTimer):Void
	{
		if (!this.alive && tmr != null)
		{
			tmr = FlxDestroyUtil.destroy(tmr);
			return;
		}

		lastPosition();
		move();
		
		timer.start(Constants.movementInterval / FlxG.updateFramerate, doTimer);
	}

	@:noCompletion override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (!gameOver)
		{
			moveTailPrevPositions();
			handleTailCollision();
		}
	}

	public function grow():Void
	{
		var tailSquare:FlxSprite = new FlxSprite();
		tailSquare.makeGraphic(Constants.TILE_SIZE, Constants.TILE_SIZE);
		// move tail square to end of snake
		tailSquare.x = prevPositions[prevPositions.length - 1].x;
		tailSquare.y = prevPositions[prevPositions.length - 1].y;

		tailSquare.color = tailColor;

		snakeBody.add(tailSquare);
	}

	function moveTailPrevPositions():Void
	{
		// wait until previous position = the snakebody.length. It has -1 because prevPosition it includes the head.
		if (prevPositions.length - 1 == snakeBody.length)
		{
			for (i => tails in snakeBody.members)
			{
				tails.x = prevPositions[i].x;
				tails.y = prevPositions[i].y;
			}
		}
	}

	function handleTailCollision() 
	{
		for (i => tails in snakeBody.members)
		{
			var snakeHeadOverlapTailX:Bool = snakeHead.x == tails.x;
			var snakeHeadOverlapTailY:Bool = snakeHead.y == tails.y;

			if (snakeHeadOverlapTailX && snakeHeadOverlapTailY)
			{
				gameOver = true;
			}
				
		}
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
		for (prevPos in prevPositions)
		{
			prevPos.put();
		}

		prevPositions.resize(0);

		// add the head position
		prevPositions.push(FlxPoint.get(snakeHead.x, snakeHead.y));

		// store the tail body positions.
		for (member in snakeBody.members)
		{
			var tails:FlxSprite = cast(member, FlxSprite);
			prevPositions.push(FlxPoint.get(tails.x, tails.y));
		}
	}
}
