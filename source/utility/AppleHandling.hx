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
		var validPosition = false;
		// makes sure the apple never spawns in the snake
		while (!validPosition)
		{
			validPosition = true; // assume okay until proven otherwise
			if (collisionHandling.appleIsTouchingHead())
			{
				validPosition = false;
			}

			if (collisionHandling.appleIsTouchingBody())
			{
				validPosition = false;
			}

			if (!validPosition)
			{
				var randomPos = randomPosition();
				apple.x = randomPos.x;
				apple.y = randomPos.y;
			}
		}
	}

	// spawn apple at random location
	public function randomPosition():FlxPoint
	{
		var x:Float =  (FlxG.random.int(0,
			Std.int(FlxG.width / Constants.TILE_SIZE)));
		var y:Float = (FlxG.random.int(0,
			Std.int(FlxG.height / Constants.TILE_SIZE)));

		return FlxPoint.weak(x * Constants.TILE_SIZE, y * Constants.TILE_SIZE);
	}
}