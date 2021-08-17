package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class GameOverSubstateRon extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var meme:FlxSprite;
	var camFollow:FlxObject;

	var stageSuffix:String = "";

	public function new(x:Float, y:Float, nameofdathingy:String, frameofdathingy:Int)
	{
		var daStage = PlayState.curStage;
		var daBf:String = '';
		switch (PlayState.SONG.player1)
		{
			case 'bf-pixel':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			case 'ded-ron':
				daBf = 'ded-ron';
			default:
				daBf = 'bf';
		}

		super();

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, daBf);
		add(bf);
		meme = new FlxSprite().loadGraphic(Paths.image('ronDeath'));
		meme.x = bf.getGraphicMidpoint().x - meme.width/2;
		meme.y = bf.getGraphicMidpoint().y - meme.height/2;

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);
		FlxTween.tween(FlxG.camera, {zoom: 0.75}, 0.4, {ease: FlxEase.expoOut,});
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			FlxG.sound.play(Paths.music('what'));
			add(meme);
			new FlxTimer().start(2.2, function(tmr:FlxTimer)
			{
				FlxTween.tween(FlxG.camera, {zoom: 0.5}, 0.4, {ease: FlxEase.expoOut,});
				meme.loadGraphic(Paths.image('ronDeathLmao'));
				meme.x = bf.getGraphicMidpoint().x - meme.width/2;
				meme.y = bf.getGraphicMidpoint().y - meme.height/2;
			});
		});
		FlxG.sound.play(Paths.sound('fnf_loss_sfx_no_mic'));
		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		trace(nameofdathingy);
		trace(frameofdathingy);
		bf.animation.play('dedlol');

		FlxG.camera.follow(camFollow, LOCKON, 0.01);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				FlxG.switchState(new StoryMenuState());
			else
				FlxG.switchState(new FreeplayState());
			PlayState.loadRep = false;
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.sound('what_is_this_noise_it\'s_like_OOOOOOOOOOOOOOOOOOOOOOOOOO'));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
