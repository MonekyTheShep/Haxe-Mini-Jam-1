package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxVirtualPad;
import flixel.util.FlxColor;

class Menu extends FlxState
{
	var background:FlxSprite;
	var items:FlxTypedGroup<Text>;
	var dPad:FlxVirtualPad = new FlxVirtualPad(FlxDPadMode.FULL, FlxActionMode.A);


    public static var shadersEnabled:Bool = true;
	var options:Array<TOptionsStruc> = [
		{
			name: 'Play',
			onClick: (w) ->
			{
				return PlayState;
			}
		},
		{
			name: 'Shader Enabled',
			onClick: (w) ->
			{
                shadersEnabled = !shadersEnabled;
                w.text = shadersEnabled ? 'Shader Enabled': 'Shader Disabled';
                return null;
				//return PlayState;
			}
		}
	];

	override function create():Void
	{
		super.create();


		add(background = new FlxSprite().loadGraphic(AssetPaths.background__png));
		background.setGraphicSize(FlxG.width, FlxG.height);
		background.screenCenter();
		FlxTween.tween(background, {alpha: 1}, 1, {ease: FlxEase.quadInOut});

		add(items = new FlxTypedGroup<Text>());
		#if android
		dPad.y = FlxG.height - dPad.height;
		add(dPad);
		#end


		for (i => v in options)
		{
			final txt:Text = new Text(0, 0, 0, v.name, 32);
			txt.y = 200 + (i * (txt.height));
			txt.screenCenter(X);
			txt.constant = true;
			txt.ID = i;
			items.add(txt);
		}
		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(AssetPaths.mainmenu__ogg, 1, true);
		}
		changeItem();
	}

	public function accept():Void
	{
		final ret:Dynamic = options[curSelected].onClick(items.members[curSelected]);
		try
		{
			if (ret != null)
			{
				FlxG.switchState(Type.createInstance(ret, []));
			}
		}
		catch (_)
		{
			trace(_);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		#if !android
		if (FlxG.keys.anyJustPressed([W, UP]))
		{
			changeItem(-1);
		}
		else if (FlxG.keys.anyJustPressed([DOWN, S]))
		{
			changeItem(1);
		}
		else if (FlxG.mouse.wheel != 0)
		{
			changeItem(-FlxG.mouse.wheel);
		}

		if (FlxG.keys.justPressed.ENTER)
		{
			accept();
		}
		#end

		#if android
		if (dPad.getButton(UP).justPressed)
		{
			changeItem(-1);
		}
		else if (dPad.getButton(DOWN).justPressed)
		{
			changeItem(1);
		}
		if (dPad.getButton(A).justPressed)
		{
			accept();
		}
		#end

	}

	@:noCompletion var curSelected:Int = 0;

	function changeItem(v:Int = 0):Void
	{
		if (items.length <= 0) return;
		curSelected = FlxMath.wrap(curSelected + v, 0, items.length - 1);
		items.forEach(_ -> _.color = _.ID == curSelected ? FlxColor.RED : FlxColor.WHITE);

	}
}

typedef TOptionsStruc =
{
	name:String,
	?onClick:(w:Text) -> Class<FlxState>
}

class Text extends FlxText
{
	public var constant(default, set):Bool;

	@:noCompletion inline function set_constant(v:Bool):Bool
	{
		alive = active = !v;
		return this.constant = v;
	}

	public function new(X:Float = 0, Y:Float = 0, FieldWidth:Float = 0, ?Text:String, Size:Int = 16, EmbeddedFont:Bool = true, ?Font:String)
	{
		super(X, Y, FieldWidth, Text, Size, EmbeddedFont);
		setFormat(Font ?? AssetPaths.SnakeChan_MMoJ__ttf, Size, FlxColor.WHITE);
		antialiasing = true;
		textField.antiAliasType = openfl.text.AntiAliasType.ADVANCED;
	}

	@:noCompletion override function regenGraphic():Void
	{
		super.regenGraphic();
		graphic.persist = !this.constant;
	}
}