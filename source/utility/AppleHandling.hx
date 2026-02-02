package utility;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import objects.Apple;
import objects.Snake;

class AppleHandling
{
	var apple:Apple;
	var snake:Snake;

	public function new(apple:Apple, snake:Snake)
	{
		this.apple = apple;
		this.snake = snake;
	}

	public function moveApple()
	{
		var collisionHandling:CollisionHandling = new CollisionHandling(apple, snake);
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
		final padding:Int = Constants.TILE_SIZE * 2;
		var x:Float = (FlxG.random.int(Std.int(padding / Constants.TILE_SIZE),
			Std.int((FlxG.width - padding) / Constants.TILE_SIZE) - 1)) * Constants.TILE_SIZE;
		var y:Float = (FlxG.random.int(Std.int(padding / Constants.TILE_SIZE),
			Std.int((FlxG.height - padding) / Constants.TILE_SIZE) - 1)) * Constants.TILE_SIZE;
		return FlxPoint.get(x, y);
	}
}