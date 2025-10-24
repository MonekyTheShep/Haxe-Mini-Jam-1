package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class Snake extends FlxSprite
{
	var snakeParts:Int = 6;
	var position:Array<Float> = [0, 0];
	var tileSize:Int = 20;
	var snakeColor = FlxColor.GREEN;
	var tailColor = FlxColor.RED;
	public var direction:String = "";

	public function new(x:Float = 0, y:Float = 0, direction:String = "RIGHT")
	{
		this.x = x;
		this.y = y;
		this.direction = direction;

		super(this.x, this.y);
		makeGraphic(tileSize, tileSize);
	}

	override public function draw():Void
	{
		super.draw();
		var previousPos = [0, 0];
		for (i in 0...snakeParts){
			if (i == 0){
				this.x = position[0] * tileSize + 5;
				this.y = position[1] * tileSize + 5;
				this.color = snakeColor;
				super.draw();
			} 
			else 
			{
				this.x = i;
				this.y = i;
				this.color = tailColor;
				super.draw();
			}
		}


	}


	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		trace(this.direction);
		move();
	}
	function move() {
		if (direction == "LEFT") {
			position[0] -= 1;
		} else if (direction == "RIGHT") {
			position[0] += 1;
			trace(position[0]);
		} else if (direction == "UP") {
			position[1] -= 1;
		} else if (direction == "DOWN") {
			position[1] += 1;
		}
	}
}
