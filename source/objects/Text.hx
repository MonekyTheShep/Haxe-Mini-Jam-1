package objects;

import flixel.text.FlxText;
import flixel.util.FlxColor;

class Text extends FlxText {
	public var constant(default,set):Bool;
	@:noCompletion inline function set_constant(v:Bool) : Bool {
		alive = active = !v;
		return this.constant = v;
	}

	public function new(X:Float = 0, Y:Float = 0, FieldWidth:Float = 0, ?Text:String, Size:Int = 16, EmbeddedFont:Bool = true, ?Font:String) {
		super(X, Y, FieldWidth, Text, Size, EmbeddedFont);
		setFormat(Font ?? AssetPaths.SnakeChan_MMoJ__ttf, Size, FlxColor.WHITE);
		antialiasing = false; textField.sharpness = 1200; textField.antiAliasType = openfl.text.AntiAliasType.ADVANCED;
	}

	@:noCompletion override function regenGraphic() : Void  {
		super.regenGraphic();
		graphic.persist = !this.constant;
	}
}