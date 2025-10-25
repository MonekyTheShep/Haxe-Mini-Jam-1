package states;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Menu extends FlxState {
    var background:FlxSprite;

    override function create() : Void {
        super.create();

        add(background = new FlxSprite().loadGraphic(AssetPaths.background__png));
        background.screenCenter(); FlxTween.tween(background, {alpha: 1}, 1, {ease: FlxEase.quadInOut});
    }
}