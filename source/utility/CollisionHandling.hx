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

		var appleOverSnakeHeadX:Bool = snake.snakeHead.x == apple.x;
		var appleOverSnakeHeadY:Bool = snake.snakeHead.y == apple.y;

		if (appleOverSnakeHeadX && appleOverSnakeHeadY)
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
			var appleOverSnakeBodyX:Bool = snakePart.x == apple.x;
			var appleOverSnakeBodyY:Bool = snakePart.y == apple.y;
			if (appleOverSnakeBodyX && appleOverSnakeBodyY)
			{
				return true;
			}
		}
		return false;
	}
}
