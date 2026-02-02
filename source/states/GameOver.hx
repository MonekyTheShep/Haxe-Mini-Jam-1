package states;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.sound.FlxSound;
import flixel.ui.FlxButton;

class GameOver extends FlxSubState
{
	var explosion:FlxSound;

	public function new()
	{
		super(0x33000000);
	}

	override function create()
	{
		super.create();
		explosion = FlxG.sound.load(AssetPaths.explosion__ogg);
		explosion.play();
		FlxG.camera.shake(1, .5);
		
		var button = new FlxButton(0, 0, "Main Menu.", closeSub);
		button.screenCenter();

		add(button);
	}

	private function closeSub():Void
	{
		FlxG.resetGame();
		Menu.shadersEnabled = true;
	}
}
