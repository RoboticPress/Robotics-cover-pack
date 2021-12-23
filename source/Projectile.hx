package;

import flixel.tweens.FlxTween;
import flixel.math.FlxRandom;
import flixel.math.FlxPoint;
import flixel.math.FlxAngle;
import flixel.FlxG;
import flixel.math.FlxVelocity;
import flixel.FlxSprite;

class Projectile extends FlxSprite
{
	var target:Character;
	override public function new(_target:Character, newX:Float = 0, newY:Float = 0)
	{
		super();
		target = _target;
		x = newX;
		y = newY;
		FlxTween.tween(this, {x: target.getMidpoint().x + 90, y: target.getMidpoint().y + 120}, 3);
	}

	override function update(elapsed:Float)
	{
		angle += 1;
    }

	override public function kill()
	{
		super.kill();
	}
}