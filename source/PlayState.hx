package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import haxe.Timer;
import openfl.display.Sprite;
import openfl.filters.ShaderFilter;

class PlayState extends FlxState
{
	var snake:Snake;

	var apple_timer:Timer;
	var crt:CrtShader;

	@:dox(hide) override public function create()
	{
		super.create();
		FlxG.camera.pixelPerfectRender = true;
		FlxG.camera.pixelPerfectShake = true;

		add(new GridSprite(FlxColor.WHITE));
		add(snake = new Snake(0, 0));
		apple_timer = new Timer(2000);
		apple_timer.run = spawnApple;

		crt = new CrtShader();
		FlxG.camera.filters = [new ShaderFilter(crt)];
	}

	public function spawnApple():Void
	{
		final apple:Apple = new Apple();
		apple.x = (FlxG.random.int(0, Std.int(FlxG.width / Constants.TILE_SIZE) - 1)) * Constants.TILE_SIZE;
		apple.y = (FlxG.random.int(0, Std.int(FlxG.height / Constants.TILE_SIZE) - 1)) * Constants.TILE_SIZE;
		add(apple);
	}

	@:dox(hide) override function destroy():Void
	{
		if (apple_timer != null)
			apple_timer.stop();
		super.destroy();
	}

	var prevElapsed:Float = 0;
	@:dox(hide) override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (crt != null && crt.iTime != null && crt.iTime.value != null)
		{
			crt.iTime.value[0] = prevElapsed + elapsed;
			prevElapsed = crt.iTime.value[0];
		}

		if (snake != null)
		{
			if (FlxG.keys.pressed.A)
			{
				snake.direction = LEFT;
			}
			else if (FlxG.keys.pressed.D)
			{
				snake.direction = RIGHT;
			}
			else if (FlxG.keys.pressed.W)
			{
				snake.direction = UP;
			}
			else if (FlxG.keys.pressed.S)
			{
				snake.direction = DOWN;
			}
		}
	}
}
