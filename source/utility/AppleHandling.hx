package utility;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import objects.Apple;
import objects.Snake;
import utility.CollisionHandling;

class AppleHandling
{
	var apple:Apple;
	var snake:Snake;
	var collisionHandling:CollisionHandling;

	public function new(apple:Apple, snake:Snake, collisionHandling:CollisionHandling)
	{
		this.apple = apple;
		this.snake = snake;
		this.collisionHandling = collisionHandling;
	}

	public function moveApple()
	{
		var validPosition:Bool = false;
		var newApplePos:FlxPoint = randomPosition();
		
		// makes sure the apple never spawns in the snake
		while (!validPosition)
		{
			validPosition = true; // assume okay until proven otherwise
			if (collisionHandling.appleIsTouchingHead(newApplePos))
			{
				validPosition = false;
			}

			if (collisionHandling.appleIsTouchingBody(newApplePos))
			{
				validPosition = false;
			}

			if (!validPosition)
			{
				
				newApplePos = randomPosition();
			}
		}

		apple.x = newApplePos.x;
		apple.y = newApplePos.y;
	}

	// spawn apple at random location
	public function randomPosition():FlxPoint
	{
		var x:Float =  (FlxG.random.int(0,
		Std.int(FlxG.width / Constants.TILE_SIZE) - 1));
		var y:Float = (FlxG.random.int(0,
		Std.int(FlxG.height / Constants.TILE_SIZE) - 1));

		return FlxPoint.weak(x * Constants.TILE_SIZE, y * Constants.TILE_SIZE);
	}
}