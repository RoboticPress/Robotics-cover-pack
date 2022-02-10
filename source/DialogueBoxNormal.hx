package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

#if windows
import Sys;
import sys.FileSystem;
#end

using StringTools;

// NO COSE I AM NOT DRAWING GARCELLO PORN HERE USING ASCII

class DialogueBoxNormal extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitMiddle:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		if (PlayState.SONG.song.toLowerCase() != 'the sunday revolving' && PlayState.SONG.song.toLowerCase() != 'big piece')
		{
			add(bgFade);
			new FlxTimer().start(0.83, function(tmr:FlxTimer)
			{
				bgFade.alpha += (1 / 5) * 0.7;
				if (bgFade.alpha > 0.7)
					bgFade.alpha = 0.7;
			}, 5);
		}
		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'the sunday revolving':
				hasDialog = true;
				box.loadGraphic(Paths.image('the sunday revolving/box'));
			case 'big piece':
				hasDialog = true;
			default:
				hasDialog = true;
				box.loadGraphic(Paths.image('robo/robo_text'));
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(160, 190);
		portraitLeft.frames = Paths.getSparrowAtlas('robo/port');
		portraitLeft.animation.addByPrefix('robo', 'port robo normal', 24, false);
		portraitLeft.animation.addByPrefix('robo-sick', 'port robo help :)', 24, false);
		portraitLeft.animation.addByPrefix('robo-done-with-your-shit', 'port robodonewithyourshit', 24, false);
		portraitLeft.animation.addByPrefix('garcello', 'port garcello', 24, false);
		portraitLeft.animation.addByPrefix('bf', 'port bf0', 24, false);
		portraitLeft.animation.addByPrefix('pegmepleaseuwu', 'port pegmepleaseuwu', 24, false);
		portraitLeft.animation.addByPrefix('lav3', 'port lav3', 24, false);
		portraitLeft.animation.addByPrefix('gardead', 'port gardead', 24, false);
		portraitLeft.animation.addByPrefix('ded-ron', 'port ded-ron', 24, false);
		portraitLeft.animation.addByPrefix('qt', 'port qt', 24, false);
		portraitLeft.animation.addByPrefix('kb', 'port kb', 24, false);
		portraitLeft.animation.addByPrefix('sonicfun', 'port sonicfun', 24, false);
		portraitLeft.animation.addByPrefix('rose', 'port rose0', 24, false);
		portraitLeft.animation.addByPrefix('rose-fall', 'port rosefall0', 24, false);
		portraitLeft.animation.addByPrefix('rose-fall-mad', 'port rosefallmad0', 24, false);
		portraitLeft.animation.addByPrefix('sus', 'port SUSSY BAKA', 24, false);
		portraitLeft.animation.addByPrefix('robo-undertale', 'port robo-undertale', 24, false);
		portraitLeft.animation.addByPrefix('bf-undertale', 'port bf-undertale', 24, false);
		portraitLeft.animation.addByPrefix('jevil-sunday', 'port jevil-sunday', 24, false);
		portraitLeft.animation.addByPrefix('susie where', 'port susie where', 24, false);
		portraitLeft.animation.addByPrefix('susie oh', 'port susie oh', 24, false);
		portraitLeft.animation.addByPrefix('susie wait', 'port susie wait', 24, false);
		portraitLeft.animation.addByPrefix('ralsei-normal', 'port ralsei-normal', 24, false);
		portraitLeft.animation.addByPrefix('ralsei', 'port ralsei0', 24, false);
		portraitLeft.animation.addByPrefix('hk-undertale', 'port hk-spamton', 24, false);
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		portraitLeft.flipX = true;
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(860, 190);
		portraitRight.frames = Paths.getSparrowAtlas('robo/port');
		portraitRight.animation.addByPrefix('robo', 'port robo normal', 24, false);
		portraitRight.animation.addByPrefix('robo-sick', 'port robo help :)', 24, false);
		portraitRight.animation.addByPrefix('robo-done-with-your-shit', 'port robodonewithyourshit', 24, false);
		portraitRight.animation.addByPrefix('garcello', 'port garcello', 24, false);
		portraitRight.animation.addByPrefix('bf', 'port bf0', 24, false);
		portraitRight.animation.addByPrefix('pegmepleaseuwu', 'port pegmepleaseuwu', 24, false);
		portraitRight.animation.addByPrefix('lav3', 'port lav3', 24, false);
		portraitRight.animation.addByPrefix('gardead', 'port gardead', 24, false);
		portraitRight.animation.addByPrefix('ded-ron', 'port ded-ron', 24, false);
		portraitRight.animation.addByPrefix('qt', 'port qt', 24, false);
		portraitRight.animation.addByPrefix('kb', 'port kb', 24, false);
		portraitRight.animation.addByPrefix('sonicfun', 'port sonicfun', 24, false);
		portraitRight.animation.addByPrefix('rose', 'port rose0', 24, false);
		portraitRight.animation.addByPrefix('rose-fall', 'port rosefall0', 24, false);
		portraitRight.animation.addByPrefix('rose-fall-mad', 'port rosefallmad0', 24, false);
		portraitRight.animation.addByPrefix('sus', 'port SUSSY BAKA', 24, false);
		portraitRight.animation.addByPrefix('robo-undertale', 'port robo-undertale', 24, false);
		portraitRight.animation.addByPrefix('bf-undertale', 'port bf-undertale', 24, false);
		portraitRight.animation.addByPrefix('jevil-sunday', 'port jevil-sunday', 24, false);
		portraitRight.animation.addByPrefix('susie where', 'port susie where', 24, false);
		portraitRight.animation.addByPrefix('susie oh', 'port susie oh', 24, false);
		portraitRight.animation.addByPrefix('susie wait', 'port susie wait', 24, false);
		portraitRight.animation.addByPrefix('ralsei-normal', 'port ralsei-normal', 24, false);
		portraitRight.animation.addByPrefix('ralsei', 'port ralsei0', 24, false);
		portraitRight.animation.addByPrefix('hk-undertale', 'port hk-spamton', 24, false);
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		portraitRight.visible = false;

		portraitMiddle = new FlxSprite(160, 190);
		portraitMiddle.frames = Paths.getSparrowAtlas('robo/port');
		portraitMiddle.animation.addByPrefix('robo', 'port robo normal', 24, false);
		portraitMiddle.animation.addByPrefix('robo-sick', 'port robo help :)', 24, false);
		portraitMiddle.animation.addByPrefix('robo-done-with-your-shit', 'port robodonewithyourshit', 24, false);
		portraitMiddle.animation.addByPrefix('garcello', 'port garcello', 24, false);
		portraitMiddle.animation.addByPrefix('bf', 'port bf0', 24, false);
		portraitMiddle.animation.addByPrefix('pegmepleaseuwu', 'port pegmepleaseuwu', 24, false);
		portraitMiddle.animation.addByPrefix('lav3', 'port lav3', 24, false);
		portraitMiddle.animation.addByPrefix('gardead', 'port gardead', 24, false);
		portraitMiddle.animation.addByPrefix('ded-ron', 'port ded-ron', 24, false);
		portraitMiddle.animation.addByPrefix('qt', 'port qt', 24, false);
		portraitMiddle.animation.addByPrefix('kb', 'port kb', 24, false);
		portraitMiddle.animation.addByPrefix('sonicfun', 'port sonicfun', 24, false);
		portraitMiddle.animation.addByPrefix('rose', 'port rose0', 24, false);
		portraitMiddle.animation.addByPrefix('rose-fall', 'port rosefall0', 24, false);
		portraitMiddle.animation.addByPrefix('rose-fall-mad', 'port rosefallmad0', 24, false);
		portraitMiddle.animation.addByPrefix('sus', 'port SUSSY BAKA', 24, false);
		portraitMiddle.animation.addByPrefix('robo-undertale', 'port robo-undertale', 24, false);
		portraitMiddle.animation.addByPrefix('bf-undertale', 'port bf-undertale', 24, false);
		portraitMiddle.animation.addByPrefix('jevil-sunday', 'port jevil-sunday', 24, false);
		portraitMiddle.animation.addByPrefix('susie where', 'port susie where', 24, false);
		portraitMiddle.animation.addByPrefix('susie oh', 'port susie oh', 24, false);
		portraitMiddle.animation.addByPrefix('susie wait', 'port susie wait', 24, false);
		portraitMiddle.animation.addByPrefix('ralsei-normal', 'port ralsei-normal', 24, false);
		portraitMiddle.animation.addByPrefix('ralsei', 'port ralsei0', 24, false);
		portraitMiddle.animation.addByPrefix('hk-undertale', 'port hk-spamton', 24, false);
		portraitMiddle.updateHitbox();
		portraitMiddle.scrollFactor.set();
		portraitMiddle.flipX = true;
		portraitMiddle.visible = false;

		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'the sunday revolving':
				add(box);
				add(portraitLeft);
				add(portraitRight);
				add(portraitMiddle);
				portraitLeft.y += 250;
				portraitRight.y += 250;
				portraitMiddle.y += 250;

				box.screenCenter(X);
				portraitMiddle.screenCenter(X);
				dropText = new FlxText(402, 502, Std.int(FlxG.width * 0.5), "", 32);
				dropText.font = 'Pixel Arial 11 Bold';
				dropText.color = 0xFFD89494;
				add(dropText);
		
				swagDialogue = new FlxTypeText(400, 500, Std.int(FlxG.width * 0.5), "", 32);
				swagDialogue.font = 'Pixel Arial 11 Bold';
				swagDialogue.color = 0xFF3F2021;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
				add(swagDialogue);
			case 'big piece':
				add(portraitLeft);
				add(portraitRight);
				add(portraitMiddle);
				portraitLeft.y += 300;
				portraitRight.y += 300;
				portraitMiddle.y += 300;

				box.screenCenter(X);
				portraitMiddle.screenCenter(X);
				dropText = new FlxText(402, 602, Std.int(FlxG.width * 0.6), "", 32);
				dropText.font = 'Pixel Arial 11 Bold';
				dropText.color = 0xFFD89494;
		
				swagDialogue = new FlxTypeText(400, 600, Std.int(FlxG.width * 0.6), "", 32);
				swagDialogue.font = 'Pixel Arial 11 Bold';
				swagDialogue.color = 0xFF3F2021;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
				add(swagDialogue);
			default:
				add(portraitLeft);
				add(portraitRight);
				add(portraitMiddle);
				add(box);

				box.screenCenter(X);
				portraitMiddle.screenCenter(X);
				dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
				dropText.font = 'Pixel Arial 11 Bold';
				dropText.color = 0xFFD89494;
				add(dropText);
		
				swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
				swagDialogue.font = 'Pixel Arial 11 Bold';
				swagDialogue.color = 0xFF3F2021;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
				add(swagDialogue);
		}

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;
	var cantUse:Bool = false;
	var goNext:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}
		if (PlayState.SONG.song.toLowerCase() == 'the sunday revolving' || PlayState.SONG.song.toLowerCase() == 'big piece')
		{
			swagDialogue.setFormat(Paths.font("DeterminationMonoWebRegular.ttf"), 46, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}
		if (swagDialogue.text == 'YOOOOOO')
		{
			goNext = true;
		}

		dropText.text = swagDialogue.text;

		dialogueOpened = true;

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if ((FlxG.keys.justPressed.ANY  && dialogueStarted == true && !cantUse) || goNext)
		{
			goNext = false;
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					if (PlayState.SONG.song.toLowerCase() != 'the sunday revolving' && PlayState.SONG.song.toLowerCase() != 'big piece')
					{
						new FlxTimer().start(0.2, function(tmr:FlxTimer)
						{
							box.alpha -= 1 / 5;
							bgFade.alpha -= 1 / 5 * 0.7;
							portraitLeft.visible = false;
							portraitRight.visible = false;
							portraitMiddle.visible = false;
							swagDialogue.alpha -= 1 / 5;
							dropText.alpha = swagDialogue.alpha;
						}, 5);

						new FlxTimer().start(1.2, function(tmr:FlxTimer)
						{
							finishThing();
							kill();
						});
					}
					else
					{
						box.alpha = 0;
						bgFade.alpha = 0;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						portraitMiddle.visible = false;
						swagDialogue.alpha = 0;
						dropText.alpha = swagDialogue.alpha;

						finishThing();
						kill();
					}
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		if (dialogueList[0] == 'GOD F*CKING DAMMIT KRIS WHERE THE HELL ARE WE?')
		{
			FlxG.sound.play(Paths.sound('deltarune/snd_whip_hard'), 1);
			PlayState.susie.loadGraphic(Paths.image('the sunday revolving/w i d e   s u s i e'));
			PlayState.susie.setGraphicSize(Std.int(PlayState.susie.width * 3));
			PlayState.susie.antialiasing = false;
		}
		if (dialogueList[0] == 'Oh wait we know this place')
		{
			PlayState.susie.loadGraphic(Paths.image('the sunday revolving/susie'));
			PlayState.susie.setGraphicSize(Std.int(PlayState.susie.width * 3));
			PlayState.susie.antialiasing = false;
		}
		swagDialogue.start(0.04, true);

		var anim:String = '';
		var direction:String = '';

		if (curCharacter.toLowerCase().endsWith('dadchange'))
		{
			direction = 'dadchange';
		}
		else if (curCharacter.toLowerCase().endsWith('left'))
		{
			direction = 'left';
		}
		else if (curCharacter.toLowerCase().endsWith('middle'))
		{
			direction = 'middle';
		}
		else
		{
			direction = 'right';
		}

		trace(curCharacter);
		trace(direction);
		if (curCharacter.toLowerCase().endsWith('dadchange'))
		{
			curCharacter = curCharacter.substr(0, curCharacter.length - (direction.length + 1));
		}
		else if (curCharacter.toLowerCase().endsWith('left'))
		{
			curCharacter = curCharacter.substr(0, curCharacter.length - (direction.length + 1));
		}
		else if (curCharacter.toLowerCase().endsWith('middle'))
		{
			curCharacter = curCharacter.substr(0, curCharacter.length - (direction.length + 1));
		}
		else
		{
			curCharacter = curCharacter.substr(0, curCharacter.length);
		}
		anim = curCharacter;
		trace(curCharacter);
		trace(direction);
		trace(curCharacter.length - (direction.length + 1));
		if (PlayState.SONG.song.toLowerCase() == 'the sunday revolving' || PlayState.SONG.song.toLowerCase() == 'big piece' )
		{
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('snd_text'), 1)];
			if (curCharacter.toLowerCase().startsWith('robo-undertale'))
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('deltarune/robo'), 1)];
			if (curCharacter.toLowerCase().startsWith('bf-undertale'))
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('deltarune/bf'), 1)];
			else if (curCharacter.toLowerCase().startsWith('jevil-sunday'))
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('deltarune/sunday'), 1)];
			else if (curCharacter.toLowerCase().startsWith('susie where'))
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('deltarune/snd_txtsus'), 1)];
			else if (curCharacter.toLowerCase().startsWith('susie oh'))
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('deltarune/snd_txtsus'), 1)];
			else if (curCharacter.toLowerCase().startsWith('susie wait'))
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('deltarune/snd_txtsus'), 1)];
			else if (curCharacter.toLowerCase().startsWith('ralsei'))
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('deltarune/snd_txtral'), 1)];
			else if (curCharacter.toLowerCase().startsWith('hk'))
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('deltarune/hk'), 1)];
		}

		if (direction == 'dadchange')
		{
			PlayState.change = true;
			PlayState.changeStuff = [curCharacter, 100, 400];
			cantUse = true;
			box.visible = false;
			bgFade.visible = false;
			portraitLeft.visible = false;
			portraitRight.visible = false;
			portraitMiddle.visible = false;
			swagDialogue.alpha = 0;
			dropText.alpha = swagDialogue.alpha;
			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				goNext = true;
				cantUse = false;
				box.visible = true;
				bgFade.visible = true;
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitMiddle.visible = true;
				swagDialogue.alpha = 1;
				dropText.alpha = swagDialogue.alpha;
			});
		}
		else if (direction == 'left')
		{
			portraitLeft.visible = false;
			portraitMiddle.visible = false;
			portraitRight.visible = true;
			portraitRight.loadGraphic(Paths.image('robo/$anim'));
			if (PlayState.SONG.song.toLowerCase() != 'the sunday revolving' && PlayState.SONG.song.toLowerCase() != 'big piece')
				portraitRight.y = 450 - portraitLeft.height;
		}
		else if (direction == 'middle')
		{
			portraitLeft.visible = false;
			portraitRight.visible = false;
			portraitMiddle.visible = true;
			portraitMiddle.loadGraphic(Paths.image('robo/$anim'));
			if (PlayState.SONG.song.toLowerCase() != 'the sunday revolving' && PlayState.SONG.song.toLowerCase() != 'big piece')
				portraitMiddle.y = 450 - portraitMiddle.height;
		}
		else
		{
			portraitRight.visible = false;
			portraitMiddle.visible = false;
			portraitLeft.visible = true;
			portraitLeft.loadGraphic(Paths.image('robo/$anim'));
			if (PlayState.SONG.song.toLowerCase() != 'the sunday revolving' && PlayState.SONG.song.toLowerCase() != 'big piece')
				portraitLeft.y = 450 - portraitLeft.height;
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
