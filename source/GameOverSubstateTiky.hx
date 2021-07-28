package;

import flixel.util.FlxDestroyUtil;
import flixel.FlxSprite;
import Song.SwagSong;
import flixel.FlxState;
import lime.utils.Assets;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class GameOverSubstateTiky extends MusicBeatSubstate
{
	//var bf:Boyfriend;
	var camFollow:FlxObject;

	var stageSuffix:String = "";

	var daSong:SwagSong;

	var sign:FlxSprite;

	var startx:Float;
	var starty:Float;

	var animOffsets:Map<String, Array<Dynamic>> = new Map<String, Array<Dynamic>>();

	// public function new(x:Float, y:Float)
	// {
	// 	startx = x;
	// 	starty = y;
	// 	//var daBf:String = 'bf';
	// 	super();
	// }

	override function create()
	{
		super.create();
		Conductor.songPosition = 0;

		//bf = new Boyfriend(x, y, daBf);
		sign = new FlxSprite();

		sign.frames = Paths.getSparrowAtlas('signDeath','shared');
		sign.animation.addByPrefix('firstDeath', 'BF dies', 24, false);
		sign.animation.addByPrefix('deathLoop', 'BF Dead Loop', 24, false);
		sign.animation.addByPrefix('deathConfirm', 'BF Dead confirm', 24, false);
		//sign.screenCenter();
		sign.x = startx;
		sign.y = starty;

		sign.setGraphicSize(Std.int(sign.width*2));
		sign.updateHitbox();

		// addOffset('firstDeath', 131);
		// addOffset('deathLoop');
		// addOffset('deathConfirm', 0, 23);

		sign.antialiasing = false;
		//sign.flipX = true;

		//sign.screenCenter();
		add(sign);

		//bf.setGraphicSize(Std.int(bf.width*2));
		//bf.updateHitbox();
		//add(bf);

		//camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		//add(camFollow);

		FlxG.sound.play(Paths.sound('BF_Deathsound','shared'));
		FlxG.sound.play(Paths.sound('Micdrop','shared'));
		Conductor.changeBPM(200);

		//FlxG.camera.followLerp = 1;
		//FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		//FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		FlxG.camera.follow(sign, LOCKON, 0.01);
		
		//bf.playAnim('firstDeath');
		//bf.animation.resume();
		sign.x += 131;
		sign.x += 131;
		sign.y -= 250;
		sign.animation.play('firstDeath');
	}

	var playedMic:Bool = false;

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
			//clearCache();
			FlxG.switchState(new MainMenuState());
			//PlayState.loadRep = false;
		}

		if (sign.animation.curAnim.name == 'firstDeath' && sign.animation.curAnim.finished)
		{
			FlxG.sound.playMusic(Paths.music('gameOverTiky','shared'));
			sign.x += 131;
			sign.x += 131;
			sign.animation.play('deathLoop', true);
		}

		else if (sign.animation.curAnim.finished && sign.animation.curAnim.name != 'deathConfirm')
		{
			sign.animation.play('deathLoop', true);
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
			//bf.playAnim('deathConfirm', true);
			sign.y -= 23;
			sign.y -= 23;
			sign.animation.play('deathConfirm', true);
			//sign.screenCenter();
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEndTiky','shared'));
			var tempTimer = new FlxTimer();
			tempTimer.start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					//clearCache();
					LoadingState.loadAndSwitchState(new PlayState(), false);
					FlxDestroyUtil.destroy(tempTimer);
				});
			});
		}
	}
}
