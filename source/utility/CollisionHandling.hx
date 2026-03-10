package utility;

import flixel.math.FlxPoint;
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

	public function appleIsTouchingHead(?newPos:FlxPoint):Bool
	{
		// Check against body
		var appleOverSnakeHeadX:Bool = (newPos == null) ? (snake.snakeHead.x == apple.x) : (snake.snakeHead.x == newPos.x);
		var appleOverSnakeHeadY:Bool = (newPos == null) ? (snake.snakeHead.y == apple.y) : (snake.snakeHead.y == newPos.y);

		if (appleOverSnakeHeadX && appleOverSnakeHeadY)
		{
			return true;
		}
		else  
		{
			return false;
		}
	}

	public function appleIsTouchingBody(?newPos:FlxPoint):Bool
	{
		for (snakePart in snake.snakeBody.members)
		{
			var appleOverSnakeBodyX:Bool = (newPos == null) ? (snakePart.x == apple.x) : (snakePart.x == newPos.x);
			var appleOverSnakeBodyY:Bool = (newPos == null) ? (snakePart.y == apple.y) : (snakePart.y == newPos.y);
			if (appleOverSnakeBodyX && appleOverSnakeBodyY)
			{
				return true;
			}
		}
		return false;
	}
}
