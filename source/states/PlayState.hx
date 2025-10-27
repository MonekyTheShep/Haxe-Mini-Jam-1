package states;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import objects.Apple;
import objects.GridSprite;
import objects.Snake;
import objects.shaders.CrtShader;
import openfl.filters.ShaderFilter;
import states.Menu;

class PlayState extends FlxState
{
	/**
	 * The Snake Player Thingy...
	 */
	var snake:Snake;

	var collectApple:FlxSound;
	var uiCamera:FlxCamera;
	var scoreText:FlxText;
	var score(default, set):Int = 0;

	@:noCompletion function set_score(e):Int
	{
		scoreText.text = 'Score: {$e}';
		return score = e;
	}

	#if SHADERS_ALLOWED
	/**
	 * The CRT shader.
	 * This shader is used for the whole game.
	 */
	var crt:CrtShader;
	#end
	var tween:FlxTween;

	/**
	 * The Apple collectable group.
	 */
	var appleGroup:FlxTypedSpriteGroup<Apple>;

	@:dox(hide) override public function create()
	{
		new states.Menu();

		super.create();
		collectApple = FlxG.sound.load(AssetPaths.collectsound__ogg);

		uiCamera = new FlxCamera();
		uiCamera.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.add(uiCamera, false);
		FlxG.camera.pixelPerfectRender = FlxG.camera.pixelPerfectShake = true;

		scoreText = new FlxText(10, 10, 0, "Score: [0]", 30);
		scoreText.cameras = [uiCamera];

		add(new GridSprite(FlxColor.WHITE));
		add(appleGroup = new FlxTypedSpriteGroup<Apple>());
		add(snake = new Snake(FlxG.width / 2, FlxG.height / 2));
		add(scoreText);

		#if SHADERS_ALLOWED
		if (Menu.shadersEnabled)
		{
			// Set the shader
			FlxG.camera.filters = [new ShaderFilter(crt = new CrtShader())];
		}
		#end

		FlxG.sound.playMusic(AssetPaths.retro_arcade_game_music_297305__ogg, 1, true);
		final padding:Int = Constants.TILE_SIZE * 2;
		var randomPos = randomPosition();
		var startApple = new Apple(randomPos.x, randomPos.y);
		FlxTween.tween(startApple.offset, {x: 0, y: 2}, 3, {
			type: PINGPONG,
			startDelay: 0,
			loopDelay: 1
		});
		appleGroup.add(startApple);

	}

	/**
	 * Whether you can spawn apples or not...
	 */

	@:noCompletion var _prevElapsed:Float = 0;
	@:noCompletion var _appleSpawnTimer:Float = 0;

	@:dox(hide) override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		// Spawn the apples, every 2 seconds.
		if (snake.gameOver != true)
		{
			// Handle Apple Collisions...
			appleGroup.forEachAlive((spr:Apple) ->
			{
				if (spr != null && FlxCollision.pixelPerfectCheck(snake.snakeHead, spr))
				{
					// Create new apple

					var randomPos = randomPosition();
					var newApple = new Apple(randomPos.x, randomPos.y);

					// Keep moving apple until it's not colliding with snake
					var validPosition = false;
					while (validPosition != true)
					{
						validPosition = true; // assume okay until proven otherwise

						// Check against head
						if (FlxCollision.pixelPerfectCheck(newApple, snake.snakeHead))
						{
							validPosition = false;
						}

						// Check against body
						@:privateAccess for (snakeBody in snake.snakeBody.members)
						{
							if (snakeBody != null && FlxCollision.pixelPerfectCheck(newApple, snakeBody))
							{
								validPosition = false;
								break;
							}
						}

						// If invalid, move apple again
						if (validPosition != true)
						{
							randomPos = randomPosition();
							newApple.x = randomPos.x;
							newApple.y = randomPos.y;
							trace("Moved Apple");
						}
					}

					// Once valid, add it to the game
					snake.grow();
					score++;
					collectApple.play();
					FlxTween.tween(newApple.offset, {x: 0, y: 2}, 5, {
						type: PINGPONG,
						ease: FlxEase.quadInOut,
						startDelay: 0,
						loopDelay: 1
					});
					appleGroup.add(newApple);
					appleGroup.remove(spr);
					spr.kill();
					spr.destroy();
				}
			});
		}
		else
		{
			openSubState(new GamerOver());
		}

		#if SHADERS_ALLOWED
		// Update The CRT Shader...
		if (Menu.shadersEnabled && crt != null && crt.iTime != null && crt.iTime.value != null)
		{
			crt.iTime.value[0] = _prevElapsed + elapsed;
			_prevElapsed = crt.iTime.value[0];
		}
		#end

		// Handle Movement...
		if (snake != null)
		{
			if (FlxG.keys.anyJustPressed([A, LEFT]) && snake.direction != RIGHT)
				snake.direction = LEFT;
			else if (FlxG.keys.anyJustPressed([D, RIGHT]) && snake.direction != LEFT)
				snake.direction = RIGHT;
			else if (FlxG.keys.anyJustPressed([W, UP]) && snake.direction != DOWN)
				snake.direction = UP;
			else if (FlxG.keys.anyJustPressed([S, DOWN]) && snake.direction != UP)
				snake.direction = DOWN;
		}
	}
	function randomPosition():FlxPoint
	{
		final padding:Int = Constants.TILE_SIZE * 2;
		var x:Float = (FlxG.random.int(Std.int(padding / Constants.TILE_SIZE),
			Std.int((FlxG.width - padding) / Constants.TILE_SIZE) - 1)) * Constants.TILE_SIZE;
		var y:Float = (FlxG.random.int(Std.int(padding / Constants.TILE_SIZE),
			Std.int((FlxG.height - padding) / Constants.TILE_SIZE) - 1)) * Constants.TILE_SIZE;
		return FlxPoint.get(x, y);
	}
		
}

class GamerOver extends FlxSubState
{
	var explosion:FlxSound;

	public function new()
	{
		super(0x33000000);
	}

	override function create()
	{
		super.create();
		FlxG.camera.shake(1, .5);
		explosion = FlxG.sound.load(AssetPaths.explosion__ogg);
		var button = new FlxButton(0, 0, "Main Menu.", closeSub);
		button.screenCenter();
		explosion.play();
		add(button);
	}

	private function closeSub():Void
	{
		FlxG.resetGame();
		Menu.shadersEnabled = true;
	}
}