package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxCamera;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class GameOverSubstateSonic extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var camFollow:FlxObject;
	var majinBf:FlxSprite;
	var countdown:FlxText;
	var timer:Int = 10;
	var coolcamera:FlxCamera;
	var holdup:Bool = true;
	var islol:Bool = true;
	var toolateurfucked:Bool = false;
	var bluevg:FlxSprite;
	var topMajins:FlxSprite;
	var bottomMajins:FlxSprite;
	var actuallynotfuckd:Bool = false;

	var stageSuffix:String = "";

	public function new(x:Float, y:Float)
	{
		var daStage = PlayState.curStage;
		var daBf:String = '';
		switch (PlayState.SONG.player1)
		{
			case 'bf-pixel':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			default:
				daBf = 'bf';
		}

		super();

		Conductor.songPosition = 0;
		
		bluevg = new FlxSprite();
		bluevg.loadGraphic(Paths.image('blueVg', 'shared'));
		bluevg.alpha = 0;
		add(bluevg);


		

		coolcamera = new FlxCamera();
		coolcamera.bgColor.alpha = 0;
		FlxG.cameras.add(coolcamera);

		bluevg.cameras = [coolcamera];

		countdown = new FlxText(614, 118 - 30, 100, '10', 40);
		countdown.setFormat('Sonic CD Menu Font Regular', 40, FlxColor.WHITE);
		countdown.setBorderStyle(SHADOW, FlxColor.BLACK, 4, 1);
		
		bf = new Boyfriend(x, y, daBf);

		majinBf = new FlxSprite(x - 100, y - 100 );
		majinBf.frames = Paths.getSparrowAtlas('MajinBFAnims', 'shared');
		majinBf.animation.addByPrefix('premajin', 'BF hit instance 1', false);
		majinBf.animation.addByPrefix('majin', 'BF MAJINATION instance 1', false);

		bottomMajins = new FlxSprite(bf.x - 50 - 200 - 250, bf.y - 300).loadGraphic(Paths.image('bottomMajins', 'shared'));
		bottomMajins.scale.x = 1.1;
		bottomMajins.scale.y = 1.1;

		bottomMajins.alpha = 0;

		if (PlayState.SONG.song.toLowerCase() == 'endless')
		{
			add(countdown);
			countdown.alpha = 0;
			countdown.cameras = [coolcamera];
		}

		add(bottomMajins);


		

		add(bf);

		majinBf.visible = false;
		majinBf.antialiasing = true;

		topMajins = new FlxSprite(bf.x - 50 - 200 - 250, bf.y - 300).loadGraphic(Paths.image('topMajins', 'shared'));
		topMajins.scale.x = 1.1;
		topMajins.scale.y = 1.1;
		topMajins.alpha = 0;
		add(topMajins);

		add(majinBf);
		

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);

		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix), .2);
		Conductor.changeBPM(100);


		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');
		FlxG.sound.play(Paths.sound('woooshFIRSTDEATH', 'shared'));

		
	}

	function startCountdown():Void
	{
		if (islol)
		{

			holdup = false;
			add(bluevg);
			FlxTween.tween(countdown, {alpha: 1}, 1);
			FlxTween.tween(topMajins, {alpha: 1}, 5);
			FlxTween.tween(bottomMajins, {alpha: 1}, 10);
			FlxG.sound.play(Paths.sound('buildUP', 'shared'), 1);
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				timer --;
				countdown.text = Std.string(timer);
				if (timer == 9)
				{
					countdown.x += 15;
				}
				if (timer == 0)
				{
					if (!actuallynotfuckd) youFuckedUp();
				}
				else
					tmr.reset();
			});
		}
	}

	function youFuckedUp():Void
	{
		toolateurfucked = true;
		FlxG.sound.music.stop();
		FlxTween.tween(countdown, {alpha: 0}, 0.5);
		remove(topMajins);
		remove(bottomMajins);
		bf.visible = false;
		majinBf.visible = true;
		majinBf.animation.play('premajin');
		FlxG.sound.play(Paths.sound('firstLOOK', 'shared'), 1);

		FlxTween.tween(bluevg, {alpha: 1}, 0.2, {
			onComplete: function(twn:FlxTween)
			{
				FlxTween.tween(bluevg, {alpha: 0}, 0.9);
			}
		});	
		FlxTween.tween(FlxG.camera, {zoom: 1.7}, 1.5, {ease: FlxEase.quartOut});
		new FlxTimer().start(2.6, function(tmr:FlxTimer)
		{
			FlxTween.tween(FlxG.camera, {zoom: 1}, 0.3, {ease: FlxEase.quartOut});
			majinBf.x -= 150;
			majinBf.y -= 150;
			majinBf.animation.play('majin');
			FlxG.camera.shake(0.01, 0.2);
			FlxG.camera.flash(FlxColor.fromRGB(75, 60, 240), .5);
			FlxG.sound.play(Paths.sound('secondLOOK', 'shared'), 1);


			new FlxTimer().start(.4, function(tmr:FlxTimer)
				{
					FlxTween.tween(FlxG.camera, {zoom: 1.5}, 6, {ease: FlxEase.circIn});

		
				});

			new FlxTimer().start(5.5, function(tmr:FlxTimer)
				{
					majinBf.visible = false;
				});

			new FlxTimer().start(8, function(tmr:FlxTimer)
				{
					FlxG.sound.play(Paths.sound('VLs/ENDLESS-DEATH-VL'));
				});

			new FlxTimer().start(15, function(tmr:FlxTimer)
				{
					FlxG.switchState(new FreeplayState());
				});

		});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			if (!toolateurfucked) 
			{
				actuallynotfuckd = true;
				endBullshit();
			}
		}

		if (controls.BACK)
		{
			if (!toolateurfucked)
			{
				actuallynotfuckd = true;

				FlxG.sound.music.stop();

				if (PlayState.isStoryMode)
					FlxG.switchState(new StoryMenuState());
				else
					FlxG.switchState(new FreeplayState());
				PlayState.loadRep = false;
			}
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.curFrame == 12)
		{
			FlxG.camera.follow(camFollow, LOCKON, 0.01);
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
		{
			FlxG.sound.playMusic(Paths.music('gameOverSonic' + stageSuffix));
			if (holdup && PlayState.SONG.song.toLowerCase() == 'endless') startCountdown();
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
			bf.playAnim('deathConfirm', true);
			new FlxTimer().start(0.1, function(tmr:FlxTimer)
				{
					bf.visible = false;
					remove(countdown);
					remove(topMajins);
					remove(bottomMajins);
					islol = false;
					FlxG.camera.flash(FlxColor.RED, 4);
					
				});
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix), 0);
			FlxG.sound.play(Paths.sound('retrySLAM', 'shared'));
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
