package states;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.ui.FlxVirtualPad;
import flixel.util.FlxColor;
import objects.Apple;
import objects.GridSprite;
import objects.Snake;
import objects.shaders.CrtShader;
import openfl.filters.ShaderFilter;
import states.GameOver;
import states.Menu;
import utility.AppleHandling;
import utility.CollisionHandling;
import utility.InputHandling;
#if js
import js.Browser;
#end

class PlayState extends FlxState
{
	/**
	 * The Snake Player Thingy...
	 */
	var snake:Snake;
	var apple:Apple;
	var appleHandling:AppleHandling;
	var collectApple:FlxSound;
	var uiCamera:FlxCamera;
	var scoreText:FlxText;
	var score(default, set):Int = 0;
	var dPad:FlxVirtualDPadButtons = new FlxVirtualDPadButtons(FlxDPadMode.FULL);
	var collisionHandling:CollisionHandling;
	var inputHandling:InputHandling;

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

	@:dox(hide) override public function create()
	{
		super.create();

		initialiseUI();
		initialiseGame();
	}

	public function initialiseUI():Void
	{
		uiCamera = new FlxCamera();
		uiCamera.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.add(uiCamera, false);
		FlxG.camera.pixelPerfectRender = FlxG.camera.pixelPerfectShake = true;

		#if SHADERS_ALLOWED
		if (Menu.shadersEnabled)
		{
			// Set the shader
			FlxG.camera.filters = [new ShaderFilter(crt = new CrtShader())];
		}
		#end

		scoreText = new FlxText(10, 10, 0, "Score: [0]", 30);
		scoreText.cameras = [uiCamera];
		add(scoreText);

		#if mobile
		dPad.cameras = [uiCamera];
		dPad.y = FlxG.height - dPad.height;
		add(dPad);
		#end
	}

	public function initialiseGame():Void
	{
		add(new GridSprite(FlxColor.WHITE));

		add(snake = new Snake(FlxG.width / 2, FlxG.height / 2));
		collisionHandling = new CollisionHandling(apple, snake);

		apple = new Apple();
		appleHandling = new AppleHandling(apple, snake, collisionHandling);

		var randomPos = appleHandling.randomPosition();
		apple.x = randomPos.x;
		apple.y = randomPos.y;
		add(apple);

		initialiseInputHandling();

		// sounds
		collectApple = FlxG.sound.load(AssetPaths.collectsound__ogg);
		FlxG.sound.playMusic(AssetPaths.retro_arcade_game_music_297305__ogg, 1, true);
	}

	public function initialiseInputHandling():Void
	{
		// Input handling
		#if android
		inputHandling = new InputHandling(snake, dPad);
		#elseif desktop
		inputHandling = new InputHandling(snake, null);
		#end

		// user agent for mobile js platforms
		#if js
		inputHandling = new InputHandling(snake, null);
		#end
	}

	@:noCompletion var _prevElapsed:Float = 0;

	var accumulateDebounceTime:Float = 0;

	@:dox(hide) override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		// make sure you cant do double input
		accumulateDebounceTime += elapsed;

		if (!snake.gameOver)
		{

			if (collisionHandling.appleIsTouchingHead())
			{
				collectApple.play();
				snake.grow();
				appleHandling.moveApple();
				score += 1;
			}

			if ((Constants.movementInterval / 60) > accumulateDebounceTime)
			{
				accumulateDebounceTime = 0;
				inputHandling.input();
			}
		}
		else
		{
			openSubState(new GameOver());
		}

		#if SHADERS_ALLOWED
		// Update The CRT Shader...
		if (Menu.shadersEnabled && crt != null && crt.iTime != null && crt.iTime.value != null)
		{
			crt.iTime.value[0] = _prevElapsed + elapsed;
			_prevElapsed = crt.iTime.value[0];
		}
		#end
	}
}



