package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;
import haxe.display.Display.SignatureItemKind;

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

	var snakeHead:FlxSprite = new FlxSprite();

	var snakeBody:FlxGroup = new FlxGroup();

	var snakeLength:Int = 5;

	var prevPositions:Array<Array<Float>> = [];

	public var direction:Null<SnakeDirection> = null;

	public function new(x:Float = 0, y:Float = 0, ?direction:SnakeDirection = RIGHT)
	{
		super();

		this.direction = direction;
		snakeHead.makeGraphic(Constants.TILE_SIZE, Constants.TILE_SIZE);
		snakeHead.setPosition(x, y);
		snakeHead.color = snakeColor;
		add(snakeHead);
		add(snakeBody);
		doTimer();
		for (i in 0...snakeLength)
		{
			var tailSquare:FlxSprite = new FlxSprite();
			tailSquare.makeGraphic(Constants.TILE_SIZE, Constants.TILE_SIZE);
			tailSquare.color = tailColor;
			snakeBody.add(tailSquare);
		}

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
		// loop through snakebody members
		for (member in snakeBody.members)
		{
			// create a variable for each member
			var tails:FlxSprite = cast member;
			// wait for the previous positions to equal the snake body length
			// it has -1 because it also stores the head
			if (prevPositions.length - 1 == snakeBody.length)
			{
				// use the previous position from the array
				tails.x = prevPositions[snakeBody.members.indexOf(member)][0];
				tails.y = prevPositions[snakeBody.members.indexOf(member)][1];
			}
		}

	}

	function move():Void
	{
		// every 200 ms this move function is called, so use it to store the previous values + the head
		prevPositions = [];
		prevPositions.push([snakeHead.x, snakeHead.y]);

		// store the tail body positions.
		for (member in snakeBody.members)
		{
			var tails:FlxSprite = cast member;
			prevPositions.push([tails.x, tails.y]);
		}
		
		if (direction != null)
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
		// debug shit
		trace(prevPositions);
		trace(prevPositions.length);
	
	}
}
