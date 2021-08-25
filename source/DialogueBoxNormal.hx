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
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'gospel':
				hasDialog = true;
				box.loadGraphic(Paths.image('robo/robo_text'));
			case 'expurgation':
				hasDialog = true;
				box.loadGraphic(Paths.image('robo/robo_text'));
			case 'headache':
				hasDialog = true;
				box.loadGraphic(Paths.image('robo/robo_text'));
			case 'release':
				hasDialog = true;
				box.loadGraphic(Paths.image('robo/robo_text'));
			case 'glitcher':
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
		portraitLeft.animation.addByPrefix('bf', 'port bf', 24, false);
		portraitLeft.animation.addByPrefix('pegmepleaseuwu', 'port pegmepleaseuwu', 24, false);
		portraitLeft.animation.addByPrefix('lav3', 'port lav3', 24, false);
		portraitLeft.animation.addByPrefix('rose', 'port rose', 24, false);
		portraitLeft.animation.addByPrefix('gardead', 'port gardead', 24, false);
		portraitLeft.animation.addByPrefix('ded-ron', 'port ded-ron', 24, false);
		portraitLeft.animation.addByPrefix('qt', 'port qt', 24, false);
		portraitLeft.animation.addByPrefix('kb', 'port kb', 24, false);
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		portraitLeft.flipX = true;
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(860, 190);
		portraitRight.frames = Paths.getSparrowAtlas('robo/port');
		portraitRight.animation.addByPrefix('robo', 'port robo normal', 24, false);
		portraitRight.animation.addByPrefix('robo-sick', 'port robo help :)', 24, false);
		portraitRight.animation.addByPrefix('robo-done-with-your-shit', 'port robodonewithyourshit', 24, false);
		portraitRight.animation.addByPrefix('garcello', 'port garcello', 24, false);
		portraitRight.animation.addByPrefix('bf', 'port bf', 24, false);
		portraitRight.animation.addByPrefix('pegmepleaseuwu', 'port pegmepleaseuwu', 24, false);
		portraitRight.animation.addByPrefix('lav3', 'port lav3', 24, false);
		portraitRight.animation.addByPrefix('rose', 'port rose', 24, false);
		portraitRight.animation.addByPrefix('gardead', 'port gardead', 24, false);
		portraitRight.animation.addByPrefix('ded-ron', 'port ded-ron', 24, false);
		portraitRight.animation.addByPrefix('qt', 'port qt', 24, false);
		portraitRight.animation.addByPrefix('kb', 'port kb', 24, false);
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		portraitMiddle = new FlxSprite(160, 190);
		portraitMiddle.frames = Paths.getSparrowAtlas('robo/port');
		portraitMiddle.animation.addByPrefix('robo', 'port robo normal', 24, false);
		portraitMiddle.animation.addByPrefix('robo-sick', 'port robo help :)', 24, false);
		portraitMiddle.animation.addByPrefix('robo-done-with-your-shit', 'port robodonewithyourshit', 24, false);
		portraitMiddle.animation.addByPrefix('garcello', 'port garcello', 24, false);
		portraitMiddle.animation.addByPrefix('bf', 'port bf', 24, false);
		portraitMiddle.animation.addByPrefix('pegmepleaseuwu', 'port pegmepleaseuwu', 24, false);
		portraitMiddle.animation.addByPrefix('lav3', 'port lav3', 24, false);
		portraitMiddle.animation.addByPrefix('rose', 'port rose', 24, false);
		portraitMiddle.animation.addByPrefix('gardead', 'port gardead', 24, false);
		portraitMiddle.animation.addByPrefix('ded-ron', 'port ded-ron', 24, false);
		portraitMiddle.animation.addByPrefix('qt', 'port qt', 24, false);
		portraitMiddle.animation.addByPrefix('kb', 'port kb', 24, false);
		portraitMiddle.updateHitbox();
		portraitMiddle.scrollFactor.set();
		portraitMiddle.flipX = true;
		add(portraitMiddle);
		portraitMiddle.visible = false;

		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitMiddle.screenCenter(X);

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

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

		dropText.text = swagDialogue.text;

		dialogueOpened = true;

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

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
		swagDialogue.start(0.04, true);

		var anim:String = '';

		if (curCharacter.toLowerCase().startsWith('garcello'))
			anim = 'garcello';
		else if (curCharacter.toLowerCase().startsWith('robo-sick'))
			anim = 'robo-sick';
		else if (curCharacter.toLowerCase().startsWith('robo-done-with-your-shit'))
			anim = 'robo-done-with-your-shit';
		else if (curCharacter.toLowerCase().startsWith('robo'))
			anim = 'robo';
		else if (curCharacter.toLowerCase().startsWith('bf'))
			anim = 'bf';
		else if (curCharacter.toLowerCase().startsWith('pegmepleaseuwu'))
			anim = 'pegmepleaseuwu';
		else if (curCharacter.toLowerCase().startsWith('lav3'))
			anim = 'lav3';
		else if (curCharacter.toLowerCase().startsWith('rose'))
			anim = 'rose';
		else if (curCharacter.toLowerCase().startsWith('gardead'))
			anim = 'gardead';
		else if (curCharacter.toLowerCase().startsWith('ded-ron'))
			anim = 'ded-ron';
		else if (curCharacter.toLowerCase().startsWith('qt'))
			anim = 'qt';
		else if (curCharacter.toLowerCase().startsWith('kb'))
			anim = 'kb';

		if (curCharacter.toLowerCase().endsWith('left'))
		{
			portraitLeft.visible = false;
			portraitMiddle.visible = false;
			portraitRight.visible = true;
			portraitRight.animation.play(anim);
		}
		else if (curCharacter.toLowerCase().endsWith('middle'))
		{
			portraitLeft.visible = false;
			portraitRight.visible = false;
			portraitMiddle.visible = true;
			portraitMiddle.animation.play(anim);
		}
		else
		{
			portraitRight.visible = false;
			portraitMiddle.visible = false;
			portraitLeft.visible = true;
			portraitLeft.animation.play(anim);
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
