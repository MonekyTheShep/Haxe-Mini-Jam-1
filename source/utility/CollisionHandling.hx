package utility;
import flixel.util.FlxCollision;
import objects.Apple;
import objects.Snake;

class CollisionHandling
{
	var snake:Snake;
	var apple:Apple;

	public function new(apple:Apple, snake:Snake)
	{
		this.snake = snake;
		this.apple = apple;
	}

	public function appleIsTouchingHead():Bool
	{
		// Check against body

		if (FlxCollision.pixelPerfectCheck(snake.snakeHead, apple))
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	public function appleIsTouchingBody():Bool
	{
		for (snakePart in snake.snakeBody.members)
		{
			if (snakePart != null && FlxCollision.pixelPerfectCheck(apple, snakePart))
			{
				return true;
			}
		}
		return false;
	}
}
