package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import openfl.filters.ShaderFilter;

class PlayState extends FlxState
{
	/**
	 * The Snake Player Thingy...
	 */
	var snake:Snake;

	#if SHADERS_ALLOWED
	/**
	 * The CRT shader.
	 * This shader is used for the whole game.
	 */
	var crt:CrtShader;
	#end

	/**
	 * The Apple collectable group.
	 */
	var appleGroup:FlxTypedSpriteGroup<Apple>;

	@:dox(hide) override public function create()
	{
		super.create();
		FlxG.camera.pixelPerfectRender = FlxG.camera.pixelPerfectShake = true;

		add(new GridSprite(FlxColor.WHITE));
		add(appleGroup = new FlxTypedSpriteGroup<Apple>());
		add(snake = new Snake(0, 0));

		#if SHADERS_ALLOWED
		// Set the shader
		FlxG.camera.filters = [new ShaderFilter(crt = new CrtShader())];
		#end
	}

	/**
	 * Whether you can spawn apples or not...
	 */
	var CAN_SPAWN_APPLES:Bool = true;

	@:noCompletion var _prevElapsed:Float = 0;
	@:noCompletion var _appleSpawnTimer:Float = 0;

	@:dox(hide) override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		// Spawn the apples, every 2 seconds.
		if (CAN_SPAWN_APPLES)
		{
			_appleSpawnTimer += elapsed;

			if (_appleSpawnTimer >= 2)
			{
				appleGroup.add(new Apple());
				_appleSpawnTimer = 0;
			}
		}

		#if SHADERS_ALLOWED
		// Update The CRT Shader...
		if (crt != null && crt.iTime != null && crt.iTime.value != null)
		{
			crt.iTime.value[0] = _prevElapsed + elapsed;
			_prevElapsed = crt.iTime.value[0];
		}
		#end

		// Handle Apple Collisions...
		appleGroup.forEachAlive((spr:Apple) ->
		{
			if (spr != null && FlxCollision.pixelPerfectCheck(snake, spr))
			{
				appleGroup.remove(spr);
				spr.kill();
				spr.destroy();
			}
		});

		// Handle Movement...
		if (snake != null)
		{
			if (FlxG.keys.anyJustPressed([A, LEFT]))
				snake.direction = LEFT;
			else if (FlxG.keys.anyJustPressed([D, RIGHT]))
				snake.direction = RIGHT;
			else if (FlxG.keys.anyJustPressed([W, UP]))
				snake.direction = UP;
			else if (FlxG.keys.anyJustPressed([S, DOWN]))
				snake.direction = DOWN;
		}
	}
}
