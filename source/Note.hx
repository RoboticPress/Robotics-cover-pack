package;

import flixel.addons.effects.FlxSkewedSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
#if polymod
import polymod.format.ParseRules.TargetSignatureElement;
#end
import PlayState;

using StringTools;

class Note extends FlxSprite
{
	public var strumTime:Float = 0;
	public var noteType:Int = 0;

	public var mustPress:Bool = false;
	public var gottaHITIT:Bool = false;
	public var spamton:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var prevNote:Note;
	public var modifiedByLua:Bool = false;
	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;
	public var burning:Bool = false;
	public var burning2:Bool = false;
	public var burning3:Bool = false;
	public var dataColor:Array<String> = ['purple', 'blue', 'green', 'red'];

	public var noteScore:Float = 1;

	public static var swagWidth:Float = 160 * 0.7;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;

	public var rating:String = "shit";

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, ?burning = false, ?burning2 = false, ?burning3 = false, ?gottaHIT = false, ?spamton = false, ?noteType:Int = 0)
	{
		super();

		if (prevNote == null)
			prevNote = this;

		this.prevNote = prevNote;
		this.noteType = noteType;
		isSustainNote = sustainNote;

		x += 50;
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;
		this.strumTime = Math.round(strumTime);

		if (this.strumTime < 0 )
			this.strumTime = 0;

		this.noteData = noteData;
		if (PlayState.SONG.song.toLowerCase() != 'triple-trouble')
		{
			if (isSustainNote && prevNote.noteData > 7 && prevNote.noteData < 16)
			{
				burning = true;
			}
			if (isSustainNote && prevNote.noteData > 15 && prevNote.noteData < 24)
			{
				burning2 = true;
			}
			if (isSustainNote && prevNote.noteData > 23)
			{
				burning3 = true;
			}
		}

		if (isSustainNote && FlxG.save.data.downscroll)
			flipY = true;
		this.burning = burning;
		this.burning2 = burning2;
		this.burning3 = burning3;
		this.gottaHITIT = gottaHIT;
		this.spamton = spamton;

		if (PlayState.SONG.song.toLowerCase() == 'triple-trouble')
			noteData = noteData % 5;
		else
			noteData = noteData % 4;

		var daStage:String = PlayState.curStage;

		//defaults if no noteStyle was found in chart
		var noteTypeCheck:String = 'normal';

		if (PlayState.SONG.noteStyle == null)
		{
			switch (PlayState.storyWeek)
			{
				case 6:
					noteTypeCheck = 'pixel';
			}
		}
		else
		{
			noteTypeCheck = PlayState.SONG.noteStyle;
		}

		switch (noteTypeCheck)
		{
			case 'pixel':
				loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels','week6'), true, 17, 17);

				animation.add('greenScroll', [6]);
				animation.add('redScroll', [7]);
				animation.add('blueScroll', [5]);
				animation.add('purpleScroll', [4]);

				if (isSustainNote)
				{
					loadGraphic(Paths.image('weeb/pixelUI/arrowEnds','week6'), true, 7, 6);

					animation.add('purpleholdend', [4]);
					animation.add('greenholdend', [6]);
					animation.add('redholdend', [7]);
					animation.add('blueholdend', [5]);

					animation.add('purplehold', [0]);
					animation.add('greenhold', [2]);
					animation.add('redhold', [3]);
					animation.add('bluehold', [1]);
				}

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
			
			case 'cross':
				frames = Paths.getSparrowAtlas('NOTE_assets2');

				animation.addByPrefix('greenScroll', 'green0');
				animation.addByPrefix('redScroll', 'red0');
				animation.addByPrefix('blueScroll', 'blue0');
				animation.addByPrefix('purpleScroll', 'purple0');

				animation.addByPrefix('purpleholdend', 'pruple end hold');
				animation.addByPrefix('greenholdend', 'green hold end');
				animation.addByPrefix('redholdend', 'red hold end');
				animation.addByPrefix('blueholdend', 'blue hold end');

				animation.addByPrefix('purplehold', 'purple hold piece');
				animation.addByPrefix('greenhold', 'green hold piece');
				animation.addByPrefix('redhold', 'red hold piece');
				animation.addByPrefix('bluehold', 'blue hold piece');

				setGraphicSize(Std.int(width * 0.7));
				updateHitbox();
				antialiasing = true;

			case 'majinNOTES':

				frames = Paths.getSparrowAtlas('Majin_Notes');
				animation.addByPrefix('greenScroll', 'green0');
				animation.addByPrefix('redScroll', 'red0');
				animation.addByPrefix('blueScroll', 'blue0');
				animation.addByPrefix('purpleScroll', 'purple0');

				animation.addByPrefix('purpleholdend', 'pruple end hold'); //PRUPLE Its not typo in the programming, but it is a typo in adobe animate hence why its in da xml like dat
				animation.addByPrefix('greenholdend', 'green hold end');
				animation.addByPrefix('redholdend', 'red hold end');
				animation.addByPrefix('blueholdend', 'blue hold end');

				animation.addByPrefix('purplehold', 'purple hold piece');
				animation.addByPrefix('greenhold', 'green hold piece');
				animation.addByPrefix('redhold', 'red hold piece');
				animation.addByPrefix('bluehold', 'blue hold piece');

				setGraphicSize(Std.int(width * 0.7));
				
				updateHitbox();
				antialiasing = true;

			case 'eteled':

				frames = Paths.getSparrowAtlas('eteled', 'shared');

				for (i in 0...4)
				{
					animation.addByPrefix(dataColor[i] + 'Scroll', dataColor[i] + ' alone'); // Normal notes
					animation.addByPrefix(dataColor[i] + 'hold', dataColor[i] + ' hold'); // Hold
					animation.addByPrefix(dataColor[i] + 'holdend', dataColor[i] + ' tail'); // Tails
				}

				setGraphicSize(Std.int(width * 0.7));
				updateHitbox();
				
				if(FlxG.save.data.antialiasing)
					{
						antialiasing = true;
					}
			case 'spinel':
				frames = Paths.getSparrowAtlas('spinel');

				animation.addByPrefix('greenScroll', 'green0');
				animation.addByPrefix('redScroll', 'red0');
				animation.addByPrefix('blueScroll', 'blue0');
				animation.addByPrefix('purpleScroll', 'purple0');

				animation.addByPrefix('purpleholdend', 'pruple end hold');
				animation.addByPrefix('greenholdend', 'green hold end');
				animation.addByPrefix('redholdend', 'red hold end');
				animation.addByPrefix('blueholdend', 'blue hold end');

				animation.addByPrefix('purplehold', 'purple hold piece');
				animation.addByPrefix('greenhold', 'green hold piece');
				animation.addByPrefix('redhold', 'red hold piece');
				animation.addByPrefix('bluehold', 'blue hold piece');

				setGraphicSize(Std.int(width * 0.7));
				updateHitbox();
				antialiasing = true;
			case 'FEVER':
				frames = Paths.getSparrowAtlas('NOTE_assets_FT');

				animation.addByPrefix('greenScroll', 'green0');
				animation.addByPrefix('redScroll', 'red0');
				animation.addByPrefix('blueScroll', 'blue0');
				animation.addByPrefix('purpleScroll', 'purple0');

				animation.addByPrefix('purpleholdend', 'pruple end hold');
				animation.addByPrefix('greenholdend', 'green hold end');
				animation.addByPrefix('redholdend', 'red hold end');
				animation.addByPrefix('blueholdend', 'blue hold end');

				animation.addByPrefix('purplehold', 'purple hold piece');
				animation.addByPrefix('greenhold', 'green hold piece');
				animation.addByPrefix('redhold', 'red hold piece');
				animation.addByPrefix('bluehold', 'blue hold piece');
				switch(noteType)
				{
					case 3:
					{
						frames = Paths.getSparrowAtlas('PhantomNote');
						animation.addByPrefix('greenScroll', 'green withered');
						animation.addByPrefix('redScroll', 'red withered');
						animation.addByPrefix('blueScroll', 'blue withered');
						animation.addByPrefix('purpleScroll', 'purple withered');
					}

					case 2:
					{
						frames = Paths.getSparrowAtlas('staticNotes');
						animation.addByPrefix('greenScroll', 'green static');
						animation.addByPrefix('redScroll', 'red static');
						animation.addByPrefix('blueScroll', 'blue static');
						animation.addByPrefix('purpleScroll', 'purple static');

						animation.addByPrefix('purpleholdend', 'pruple end hold');
						animation.addByPrefix('greenholdend', 'green hold end');
						animation.addByPrefix('redholdend', 'red hold end');
						animation.addByPrefix('blueholdend', 'blue hold end');

						animation.addByPrefix('purplehold', 'purple hold piece');
						animation.addByPrefix('greenhold', 'green hold piece');
						animation.addByPrefix('redhold', 'red hold piece');
						animation.addByPrefix('bluehold', 'blue hold piece');
					}
				}

				setGraphicSize(Std.int(width * 0.7));
				updateHitbox();
				antialiasing = true;

			default:
				frames = Paths.getSparrowAtlas('NOTE_assets');

				animation.addByPrefix('greenScroll', 'green0');
				animation.addByPrefix('redScroll', 'red0');
				animation.addByPrefix('blueScroll', 'blue0');
				animation.addByPrefix('purpleScroll', 'purple0');

				animation.addByPrefix('purpleholdend', 'pruple end hold');
				animation.addByPrefix('greenholdend', 'green hold end');
				animation.addByPrefix('redholdend', 'red hold end');
				animation.addByPrefix('blueholdend', 'blue hold end');

				animation.addByPrefix('purplehold', 'purple hold piece');
				animation.addByPrefix('greenhold', 'green hold piece');
				animation.addByPrefix('redhold', 'red hold piece');
				animation.addByPrefix('bluehold', 'blue hold piece');

				if (burning || burning2 || burning3)
				{
					if (PlayState.curStage == 'auditorHell' || PlayState.curStage == 'jevil')
					{
						frames = Paths.getSparrowAtlas('fourth/mech/ALL_deathnotes', "shared");
						animation.addByPrefix('greenScroll', 'Green Arrow');
						animation.addByPrefix('redScroll', 'Red Arrow');
						animation.addByPrefix('blueScroll', 'Blue Arrow');
						animation.addByPrefix('purpleScroll', 'Purple Arrow');
						x -= 165;
					}
					else if (PlayState.curStage == 'spamton')
					{
						//visible = false;
						if (burning)
						{
							if (spamton)
								frames = Paths.getSparrowAtlas('NOTE_assets_cum', "shared");
							else if (!gottaHITIT)
								frames = Paths.getSparrowAtlas('NOTE_assets_miku', "shared");
							else
								frames = Paths.getSparrowAtlas('NOTE_assets_robo', "shared");
							animation.addByPrefix('greenScroll', 'green0');
							animation.addByPrefix('redScroll', 'red0');
							animation.addByPrefix('blueScroll', 'blue0');
							animation.addByPrefix('purpleScroll', 'purple0');
			
							animation.addByPrefix('purpleholdend', 'pruple end hold');
							animation.addByPrefix('greenholdend', 'green hold end');
							animation.addByPrefix('redholdend', 'red hold end');
							animation.addByPrefix('blueholdend', 'blue hold end');
			
							animation.addByPrefix('purplehold', 'purple hold piece');
							animation.addByPrefix('greenhold', 'green hold piece');
							animation.addByPrefix('redhold', 'red hold piece');
							animation.addByPrefix('bluehold', 'blue hold piece');
							x -= 165;
						}
						else if (burning2)
						{
							frames = Paths.getSparrowAtlas('NOTE_assets_sunday', "shared");
							animation.addByPrefix('greenScroll', 'green0');
							animation.addByPrefix('redScroll', 'red0');
							animation.addByPrefix('blueScroll', 'blue0');
							animation.addByPrefix('purpleScroll', 'purple0');
			
							animation.addByPrefix('purpleholdend', 'pruple end hold');
							animation.addByPrefix('greenholdend', 'green hold end');
							animation.addByPrefix('redholdend', 'red hold end');
							animation.addByPrefix('blueholdend', 'blue hold end');
			
							animation.addByPrefix('purplehold', 'purple hold piece');
							animation.addByPrefix('greenhold', 'green hold piece');
							animation.addByPrefix('redhold', 'red hold piece');
							animation.addByPrefix('bluehold', 'blue hold piece');
							x -= 165;
						}
						else if (burning3)
						{
							frames = Paths.getSparrowAtlas('Note_assets_lmao', "shared");
							animation.addByPrefix('greenScroll', 'green0');
							animation.addByPrefix('redScroll', 'red0');
							animation.addByPrefix('blueScroll', 'blue0');
							animation.addByPrefix('purpleScroll', 'purple0');
			
							animation.addByPrefix('purpleholdend', 'pruple end hold');
							animation.addByPrefix('greenholdend', 'green hold end');
							animation.addByPrefix('redholdend', 'red hold end');
							animation.addByPrefix('blueholdend', 'blue hold end');
			
							animation.addByPrefix('purplehold', 'purple hold piece');
							animation.addByPrefix('greenhold', 'green hold piece');
							animation.addByPrefix('redhold', 'red hold piece');
							animation.addByPrefix('bluehold', 'blue hold piece');
							x -= 165;
						}
					}
					else
					{
						frames = Paths.getSparrowAtlas('NOTE_fire', "shared");
						if (!FlxG.save.data.downscroll)
						{
							animation.addByPrefix('blueScroll', 'blue fire');
							animation.addByPrefix('greenScroll', 'green fire');
						}
						else
						{
							animation.addByPrefix('greenScroll', 'blue fire');
							animation.addByPrefix('blueScroll', 'green fire');
						}
						animation.addByPrefix('redScroll', 'red fire');
						animation.addByPrefix('purpleScroll', 'purple fire');

						if (FlxG.save.data.downscroll)
							flipY = true;

						x -= 50;
					}
					/*if (PlayState.curStage == 'jevil')
					{
						//visible = false;
						frames = Paths.getSparrowAtlas('Note_assets_lmao', "shared");
						animation.addByPrefix('greenScroll', 'green0');
						animation.addByPrefix('redScroll', 'red0');
						animation.addByPrefix('blueScroll', 'blue0');
						animation.addByPrefix('purpleScroll', 'purple0');
		
						animation.addByPrefix('purpleholdend', 'pruple end hold');
						animation.addByPrefix('greenholdend', 'green hold end');
						animation.addByPrefix('redholdend', 'red hold end');
						animation.addByPrefix('blueholdend', 'blue hold end');
		
						animation.addByPrefix('purplehold', 'purple hold piece');
						animation.addByPrefix('greenhold', 'green hold piece');
						animation.addByPrefix('redhold', 'red hold piece');
						animation.addByPrefix('bluehold', 'blue hold piece');
						x -= 165;
					}*/
				}
				if (PlayState.curStage == 'jevil')
					visible = false;

				setGraphicSize(Std.int(width * 0.7));
				updateHitbox();
				antialiasing = true;
			
			case 'sonic':
					frames = Paths.getSparrowAtlas('NOTE_assets');
					var fuckingSussy = Paths.getSparrowAtlas('staticNotes');
					for(amogus in fuckingSussy.frames)
						{
							this.frames.pushFrame(amogus);
						}

					switch(noteType)
					{
						case 3:
						{
							frames = Paths.getSparrowAtlas('PhantomNote');
							animation.addByPrefix('greenScroll', 'green withered');
							animation.addByPrefix('redScroll', 'red withered');
							animation.addByPrefix('blueScroll', 'blue withered');
							animation.addByPrefix('purpleScroll', 'purple withered');

							setGraphicSize(Std.int(width * 0.7));
								
							updateHitbox();
							antialiasing = true;
						}

						case 2:
						{
							frames = Paths.getSparrowAtlas('staticNotes');
							animation.addByPrefix('greenScroll', 'green static');
							animation.addByPrefix('redScroll', 'red static');
							animation.addByPrefix('blueScroll', 'blue static');
							animation.addByPrefix('purpleScroll', 'purple static');

							animation.addByPrefix('purpleholdend', 'pruple end hold');
							animation.addByPrefix('greenholdend', 'green hold end');
							animation.addByPrefix('redholdend', 'red hold end');
							animation.addByPrefix('blueholdend', 'blue hold end');

							animation.addByPrefix('purplehold', 'purple hold piece');
							animation.addByPrefix('greenhold', 'green hold piece');
							animation.addByPrefix('redhold', 'red hold piece');
							animation.addByPrefix('bluehold', 'blue hold piece');

							setGraphicSize(Std.int(width * 0.7));
							
							updateHitbox();
							antialiasing = true;
						}
						default:
						{
							frames = Paths.getSparrowAtlas('NOTE_assets');
							animation.addByPrefix('greenScroll', 'green0');
							animation.addByPrefix('redScroll', 'red0');
							animation.addByPrefix('blueScroll', 'blue0');
							animation.addByPrefix('purpleScroll', 'purple0');
							if (PlayState.SONG.song.toLowerCase() == 'triple-trouble') animation.addByPrefix('goldScroll', 'gold0');

							animation.addByPrefix('purpleholdend', 'pruple end hold');
							animation.addByPrefix('greenholdend', 'green hold end');
							animation.addByPrefix('redholdend', 'red hold end');
							animation.addByPrefix('blueholdend', 'blue hold end');
							if (PlayState.SONG.song.toLowerCase() == 'triple-trouble') animation.addByPrefix('goldholdend', 'red hold end');

							animation.addByPrefix('purplehold', 'purple hold piece');
							animation.addByPrefix('greenhold', 'green hold piece');
							animation.addByPrefix('redhold', 'red hold piece');
							animation.addByPrefix('bluehold', 'blue hold piece');
							if (PlayState.SONG.song.toLowerCase() == 'triple-trouble') animation.addByPrefix('goldhold', 'red hold piece');

							setGraphicSize(Std.int(width * 0.7));
							updateHitbox();
							antialiasing = true;
						}
					}

			}

		if (PlayState.curStage != 'spamton')
		{
			if (burning)
				setGraphicSize(Std.int(width * 0.86));
			if (burning2)
				setGraphicSize(Std.int(width * 0.86));
			if (burning3)
				setGraphicSize(Std.int(width * 0.86));
		}
		if (PlayState.SONG.song.toLowerCase() == 'triple-trouble')
		{
			switch (noteData)
			{
				case 0:
					x += swagWidth * 0;
					animation.play('purpleScroll');
				case 1:
					x += swagWidth * 1;
					animation.play('blueScroll');
				case 2:
					x += swagWidth * 2;
					animation.play('goldScroll');
				case 3:
					x += swagWidth * 2;
					animation.play('greenScroll');
				case 4:
					x += swagWidth * 3;
					animation.play('redScroll');
			}
		}
		else
		{
			switch (noteData)
			{
				case 0:
					x += swagWidth * 0;
					animation.play('purpleScroll');
				case 1:
					x += swagWidth * 1;
					animation.play('blueScroll');
				case 2:
					x += swagWidth * 2;
					animation.play('greenScroll');
				case 3:
					x += swagWidth * 3;
					animation.play('redScroll');
			}
	}
		// trace(prevNote);

		// we make sure its downscroll and its a SUSTAIN NOTE (aka a trail, not a note)
		// and flip it so it doesn't look weird.
		// THIS DOESN'T FUCKING FLIP THE NOTE, CONTRIBUTERS DON'T JUST COMMENT THIS OUT JESUS
		if (FlxG.save.data.downscroll && sustainNote) 
			flipY = true;

		if (isSustainNote && prevNote != null)
		{
			noteScore * 0.2;
			alpha = 0.6;

			x += width / 2;
			if (PlayState.SONG.song.toLowerCase() == 'triple-trouble')
			{
				switch (noteData)
				{
					case 2:
						animation.play('goldholdend');
					case 3:
						animation.play('greenholdend');
					case 4:
						animation.play('redholdend');
					case 1:
						animation.play('blueholdend');
					case 0:
						animation.play('purpleholdend');
				}
			}
			else
			{
				switch (noteData)
				{
					case 2:
						animation.play('greenholdend');
					case 3:
						animation.play('redholdend');
					case 1:
						animation.play('blueholdend');
					case 0:
						animation.play('purpleholdend');
				}
			}

			updateHitbox();

			x -= width / 2;

			if (PlayState.curStage.startsWith('school'))
				x += 30;

			if (prevNote.isSustainNote)
			{
				if (PlayState.SONG.song.toLowerCase() == 'triple-trouble')
				{
					switch (prevNote.noteData)
					{
						case 0:
							prevNote.animation.play('purplehold');
						case 1:
							prevNote.animation.play('bluehold');
						case 2:
							prevNote.animation.play('goldhold');
						case 3:
							prevNote.animation.play('greenhold');
						case 4:
							prevNote.animation.play('redhold');
					}
				}
				else
				{
					switch (prevNote.noteData)
					{
						case 0:
							prevNote.animation.play('purplehold');
						case 1:
							prevNote.animation.play('bluehold');
						case 2:
							prevNote.animation.play('greenhold');
						case 3:
							prevNote.animation.play('redhold');
					}
				}


				if(FlxG.save.data.scrollSpeed != 1)
					prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * FlxG.save.data.scrollSpeed;
				else
					prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * PlayState.SONG.speed;
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}
		}
		x -= 165;
		if (PlayState.curStage != 'spamton')
		{
			if (burning)
				x -= 165;
			if (burning2)
				x -= 165;
			if (burning3)
				x -= 165;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		

		if (mustPress)
		{
			// The * 0.5 is so that it's easier to hit them too late, instead of too early
			if (!burning && !burning2 && !burning3)
			{
				if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset
					&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.5))
					canBeHit = true;
				else
					canBeHit = false;
			}
			else
			{
				if (PlayState.curStage == 'auditorHell') // these though, REALLY hard to hit.
				{
					if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * 0.3)
						&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.2)) // also they're almost impossible to hit late!
						canBeHit = true;
					else
						canBeHit = false;
				}
				else
				{
					// make burning notes a lot harder to accidently hit because they're weirdchamp!
					if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * 0.6)
						&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.4)) // also they're almost impossible to hit late!
						canBeHit = true;
					else
						canBeHit = false;
				}
			}
			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset && !wasGoodHit)
				tooLate = true;
		}
		else
		{
			canBeHit = false;

			if (strumTime <= Conductor.songPosition)
				wasGoodHit = true;
		}

		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}
}