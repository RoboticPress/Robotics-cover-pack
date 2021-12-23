package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var hasFail:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;
		trace(curCharacter);

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');


			case 'robo-gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/ROBO_assets');
				trace(tex);
				frames = tex;
				animation.addByPrefix('singLEFT', 'robo left', 24, false);
				animation.addByPrefix('singRIGHT', 'robo right', 24, false);
				animation.addByPrefix('singUP', 'robo up', 24, false);
				animation.addByPrefix('singDOWN', 'robo down', 24, false);
				animation.addByIndices('danceLeft', 'robo Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'robo Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('sad', 'robo sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);

				animation.addByIndices('help', 'robo help', [0], "", 24, false);
				animation.addByIndices('please help', 'robo help', [0, 1, 1, 2, 3, 3, 3, 4, 4, 4, 2, 4, 4, 5, 5, 5, 3, 3, 2, 2, 1, 1, 6, 6, 6, 6, 6, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 20, 20], "", 24, false);

				animation.addByIndices('OI', 'robo saw come', [0], "", 30, false);
				animation.addByPrefix('come saw', 'robo saw come', 30, false);
				animation.addByPrefix('GET THE BITCH', 'robo GET THE BITCH', 30, false);
				// animation.addByPrefix('go saw', 'robo go saw', 30, false);

				addOffset('singLEFT', 0, 0);
				addOffset('singRIGHT', 0, 0);
				addOffset('singUP', 0, 14);
				addOffset('singDOWN', 0, -9);
				addOffset('danceLeft', 0, -10);
				addOffset('danceRight', 0, -8);
				addOffset('sad', -2, -11);

				addOffset('help', -2, 0);
				addOffset('please help', -2, -1);

				addOffset('OI', -2, -1);
				addOffset('come saw', -2, -1);
				addOffset('GET THE BITCH', -2, 0);
				// addOffset('go saw', 0, 0);

				playAnim('danceRight');

			case 'robo-gf-no-speakers':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/ROBO_assets_no_speakers');
				trace(tex);
				frames = tex;
				animation.addByPrefix('singLEFT', 'robo left', 24, false);
				animation.addByPrefix('singRIGHT', 'robo right', 24, false);
				animation.addByPrefix('singUP', 'robo up', 24, false);
				animation.addByPrefix('singDOWN', 'robo down', 24, false);
				animation.addByIndices('danceLeft', 'robo Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'robo Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('sad', 'robo sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);

				animation.addByIndices('help', 'robo help', [0], "", 24, false);
				animation.addByIndices('please help', 'robo help', [0, 1, 1, 2, 3, 3, 3, 4, 4, 4, 2, 4, 4, 5, 5, 5, 3, 3, 2, 2, 1, 1, 6, 6, 6, 6, 6, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 20, 20], "", 24, false);

				animation.addByIndices('OI', 'robo saw come', [0], "", 30, false);
				animation.addByPrefix('come saw', 'robo saw come', 30, false);
				animation.addByPrefix('GET THE BITCH', 'robo GET THE BITCH', 30, false);
				// animation.addByPrefix('go saw', 'robo go saw', 30, false);

				addOffset('singLEFT', 27, -11);
				addOffset('singRIGHT', -1, -10);
				addOffset('singUP', 2, 9);
				addOffset('singDOWN', 0, -14);
				addOffset('danceLeft', 0, -8);
				addOffset('danceRight', 0, -8);
				addOffset('sad', -2, -11);

				addOffset('help', 215, -9);
				addOffset('please help', 216, -3);

				addOffset('OI', 0, -9);
				addOffset('come saw', 0, -6);
				addOffset('GET THE BITCH', 0, -8);
				// addOffset('go saw', 0, 0);

				playAnim('danceRight');

			case 'robo-gf-night':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/ROBO_assets-night');
				trace(tex);
				frames = tex;
				animation.addByPrefix('singLEFT', 'robo left', 24, false);
				animation.addByPrefix('singRIGHT', 'robo right', 24, false);
				animation.addByPrefix('singUP', 'robo up', 24, false);
				animation.addByPrefix('singDOWN', 'robo down', 24, false);
				animation.addByIndices('danceLeft', 'robo Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'robo Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('sad', 'robo sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);

				animation.addByIndices('help', 'robo help', [0], "", 24, false);
				animation.addByIndices('please help', 'robo help', [0, 1, 1, 2, 3, 3, 3, 4, 4, 4, 2, 4, 4, 5, 5, 5, 3, 3, 2, 2, 1, 1, 6, 6, 6, 6, 6, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 20, 20], "", 24, false);

				animation.addByIndices('OI', 'robo saw come', [0], "", 30, false);
				animation.addByPrefix('come saw', 'robo saw come', 30, false);
				animation.addByPrefix('GET THE BITCH', 'robo GET THE BITCH', 30, false);
				// animation.addByPrefix('go saw', 'robo go saw', 30, false);

				addOffset('singLEFT', 0, 0);
				addOffset('singRIGHT', 0, 0);
				addOffset('singUP', 0, 14);
				addOffset('singDOWN', 0, -9);
				addOffset('danceLeft', 0, -10);
				addOffset('danceRight', 0, -8);
				addOffset('sad', -2, -11);

				addOffset('help', -2, 0);
				addOffset('please help', -2, -1);

				addOffset('OI', -2, -1);
				addOffset('come saw', -2, -1);
				addOffset('GET THE BITCH', -2, 0);
				// addOffset('go saw', 0, 0);

				playAnim('danceRight');

			case 'robo-gf-404':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/ROBO_assets-404');
				trace(tex);
				frames = tex;
				animation.addByPrefix('singLEFT', 'robo left', 24, false);
				animation.addByPrefix('singRIGHT', 'robo right', 24, false);
				animation.addByPrefix('singUP', 'robo up', 24, false);
				animation.addByPrefix('singDOWN', 'robo down', 24, false);
				animation.addByIndices('danceLeft', 'robo Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'robo Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('sad', 'robo sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);

				animation.addByIndices('help', 'robo help', [0], "", 24, false);
				animation.addByIndices('please help', 'robo help', [0, 1, 1, 2, 3, 3, 3, 4, 4, 4, 2, 4, 4, 5, 5, 5, 3, 3, 2, 2, 1, 1, 6, 6, 6, 6, 6, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 20, 20], "", 24, false);

				animation.addByIndices('OI', 'robo saw come', [0], "", 30, false);
				animation.addByPrefix('come saw', 'robo saw come', 30, false);
				animation.addByPrefix('GET THE BITCH', 'robo GET THE BITCH', 30, false);
				// animation.addByPrefix('go saw', 'robo go saw', 30, false);

				addOffset('singLEFT', 0, 0);
				addOffset('singRIGHT', 0, 0);
				addOffset('singUP', 0, 14);
				addOffset('singDOWN', 0, -9);
				addOffset('danceLeft', 0, -10);
				addOffset('danceRight', 0, -8);
				addOffset('sad', -2, -11);

				addOffset('help', -2, 0);
				addOffset('please help', -2, -1);

				addOffset('OI', -2, -1);
				addOffset('come saw', -2, -1);
				addOffset('GET THE BITCH', -2, 0);
				// addOffset('go saw', 0, 0);

				playAnim('danceRight');

			case 'ROBO-TIKY':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/ROBO-TIKY');
				trace(tex);
				frames = tex;
				animation.addByIndices('danceLeft', 'robo Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'robo Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0, 0);
				addOffset('danceRight', 0, 0);
				playAnim('danceRight');

			case 'roboparachute':
				tex = Paths.getSparrowAtlas('characters/robo_parachute');
				frames = tex;
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByPrefix('singLEFT', 'GF LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'GF RIGHT', 24, false);
				animation.addByPrefix('singUP', 'GF UP', 24, false);
				animation.addByPrefix('singDOWN', 'GF DOWN', 24, false);


				addOffset('sad', 0, -20);
				addOffset('danceLeft', 0, 0);
				addOffset('danceRight', 0, 0);
				addOffset('singLEFT', 0, -10);
				addOffset('singRIGHT', 0, -8);
				addOffset('singUP', 0, 14);
				addOffset('singDOWN', 0, -8);

		
				playAnim('danceRight');

			case 'rosefall':
				tex = Paths.getSparrowAtlas('characters/roseFall');
				frames = tex;
				animation.addByPrefix('idle', 'GF Dancing Beat', 24, false);
				animation.addByPrefix('singLEFT', 'GF LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'GF RIGHT', 24, false);
				animation.addByPrefix('singUP', 'GF UP', 24, false);
				animation.addByPrefix('singDOWN', 'GF DOWN', 24, false);

				addOffset('idle', 0, -9);
				addOffset('singLEFT', 0, 0);
				addOffset('singRIGHT', 0, 0);
				addOffset('singUP', 0, 0);
				addOffset('singDOWN', 0, 0);

		
				playAnim('idle');

			case '86lol':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/rose');
				trace(tex);
				frames = tex;
				animation.addByIndices('danceLeft', 'rose Dancing Beat', [0, 1, 2, 3, 4, 5, 6, 7, 8], "", 12, false);
				animation.addByIndices('danceRight', 'rose Dancing Beat', [9, 10, 11, 12, 13, 14, 15], "", 12, false);

				addOffset('danceLeft', 0, 0);
				addOffset('danceRight', 0, 0);

				setGraphicSize(Std.int(width * 2));
				playAnim('danceRight');
			case 'robo-dog':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/robo dog');
				trace(tex);
				frames = tex;
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [0], "", 12, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [1], "", 12, false);

				addOffset('danceLeft', 0, 0);
				addOffset('danceRight', 0, 0);

				setGraphicSize(Std.int(width * 4));
				playAnim('danceRight');

				antialiasing = false;

			case 'gf-christmas':
				tex = Paths.getSparrowAtlas('characters/gfChristmas');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-car':
				tex = Paths.getSparrowAtlas('characters/gfCar');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

			case 'gf-pixel':
				tex = Paths.getSparrowAtlas('characters/gfPixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/DADDY_DEAREST', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');

			case 'carol':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/CAROL', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');

			case 'HD_senpai':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/HD_SENPAI', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');

			case 'HD_monika':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/HD_MONIKA', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');

			case 'hex':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/HEX', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');

			case 'garcello':
				// GARCELLO ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/garcello_assets');
				frames = tex;
				animation.addByPrefix('idle', 'garcello idle dance', 24);
				animation.addByPrefix('singUP', 'garcello Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'garcello Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'garcello Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'garcello Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", 0, 0);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 0, 0);
				addOffset("singDOWN", 0, 0);

				playAnim('idle');

			case 'zardy':
				// GARCELLO ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/Zardy');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24);

				addOffset('idle');
				addOffset("singUP", 20, -10);
				addOffset("singRIGHT", 5, 5);
				addOffset("singLEFT", 210, 25);
				addOffset("singDOWN", 8, -45);

				playAnim('idle');

			case 'sarvente-lucifer':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/smokinhotbabe', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'LuciferSarvIdle', 24);
				animation.addByPrefix('singUP', 'LuciferSarvUp', 24);
				animation.addByPrefix('singRIGHT', 'LuciferSarvRight', 24);
				animation.addByPrefix('singDOWN', 'LuciferSarvDown', 24);
				animation.addByPrefix('singLEFT', 'LuciferSarvLeft', 24);

				addOffset('idle');
				addOffset("singUP", 0, 0);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 0, 0);
				addOffset("singDOWN", 0, 0);

				playAnim('idle');
				
			case 'lavfinal':
				frames = Paths.getSparrowAtlas('characters/LavPhase3');
				animation.addByPrefix('idle', "Lav Idle", 6, false);
				animation.addByPrefix('singUP', "Lav Up", 12, false);
				animation.addByPrefix('singDOWN', "LavDown",  12, false);
				animation.addByPrefix('singLEFT', "Lav Left", 12, false);
				animation.addByPrefix('singRIGHT', "Lav Right", 12, false);
				
				addOffset('idle', 0, 100);
				addOffset("singUP", 0, 0);
				addOffset("singRIGHT", 360, -150);
				addOffset("singLEFT", 100, -150);
				addOffset("singDOWN", -33, 100);
				
				playAnim('idle');

			case 'spooky':
				tex = Paths.getSparrowAtlas('characters/spooky_kids_assets');
				frames = tex;
				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

				addOffset('danceLeft');
				addOffset('danceRight');

				addOffset("singUP", -20, 26);
				addOffset("singRIGHT", -130, -14);
				addOffset("singLEFT", 130, -10);
				addOffset("singDOWN", -50, -130);

				playAnim('danceRight');
			case 'mom':
				tex = Paths.getSparrowAtlas('characters/Mom_Assets');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				playAnim('idle');

			case 'mom-car':
				tex = Paths.getSparrowAtlas('characters/momCar');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');

			case 'exGf':
				tex = Paths.getSparrowAtlas('characters/exGf');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');

			case 'exGf-playable':
				tex = Paths.getSparrowAtlas('characters/exGf');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle', 600, 0);
				addOffset("singUP", 625, 39);
				addOffset("singRIGHT", -80, -27);
				addOffset("singLEFT", 753, -26);
				addOffset("singDOWN", 90 ,-140);

				playAnim('idle');

			case 'monster':
				tex = Paths.getSparrowAtlas('characters/Monster_Assets');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -30, -40);
				playAnim('idle');

			case 'monster-christmas':
				tex = Paths.getSparrowAtlas('characters/monsterChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -40, -94);
				playAnim('idle');

			case 'monster-annie':
				tex = Paths.getSparrowAtlas('characters/monsterAnnie');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -40, -94);
				playAnim('idle');

			case 'pico':
				hasFail = true;
				tex = Paths.getSparrowAtlas('characters/Pico_FNF_assetss');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				if (isPlayer)
				{
					animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
				}
				else
				{
					// Need to be flipped! REDO THIS LATER!
					animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				}

				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

				addOffset('idle');
				addOffset("singUP", -19, 27);
				addOffset("singRIGHT", 72, -7);
				addOffset("singLEFT", -55, 9);
				addOffset("singDOWN", 60, -70);
				addOffset("singUPmiss", 11, 77);
				addOffset("singRIGHTmiss", 60, 41);
				addOffset("singLEFTmiss", -58, 54);
				addOffset("singDOWNmiss", 80, -33);

				playAnim('idle');

				flipX = true;

			case 'nene':
				tex = Paths.getSparrowAtlas('characters/nene');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				if (isPlayer)
				{
					animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
				}
				else
				{
					// Need to be flipped! REDO THIS LATER!
					animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
				}

				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

				addOffset('idle');
				addOffset("singUP", 80, 30);
				addOffset("singRIGHT", 106, -10);
				addOffset("singLEFT", 10, 4);
				addOffset("singDOWN", 150, -80);

				playAnim('idle');

				flipX = true;

			case 'annie':
				tex = Paths.getSparrowAtlas('characters/annie');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				playAnim('idle');

				flipX = true;

			case 'bf':
				hasFail = true;
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'bf-flipped':
				hasFail = true;
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 17);
				addOffset("singLEFT", 32, -7);
				addOffset("singRIGHT", -28, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", 1, 17);
				addOffset("singLEFTmiss", 40, 21);
				addOffset("singRIGHTmiss", -28, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", -2, 5);
				addOffset('firstDeath', 7, 11);
				addOffset('deathLoop', 7, -5);
				addOffset('deathConfirm', 7, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'bf404':
				hasFail = true;
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND_404', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				animation.addByPrefix('dodge','boyfriend dodge', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'bf-night':
				hasFail = true;
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND-night', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				animation.addByPrefix('dodge','boyfriend dodge', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'bf-fall':
				var tex = Paths.getSparrowAtlas('characters/bfFly', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'fall !idle', 24, false);
				animation.addByPrefix('singUP', 'fall 2up', 24, false);
				animation.addByPrefix('singLEFT', 'fall 0left', 24, false);
				animation.addByPrefix('singRIGHT', 'fall 3right', 24, false);
				animation.addByPrefix('singDOWN', 'fall 1down', 24, false);
				animation.addByPrefix('singUPmiss', 'MISS 2up', 24, false);
				animation.addByPrefix('singLEFTmiss', 'MISS 0left', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'MISS 3right', 24, false);
				animation.addByPrefix('singDOWNmiss', 'MISS 1down', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "dead 0START", 24, false);
				animation.addByPrefix('deathLoop', "dead 1MID", 24, true);
				animation.addByPrefix('deathConfirm', "dead 2END", 24, false);



				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset('firstDeath', 459, 399);
				addOffset('deathLoop', 459, -189);
				addOffset('deathConfirm', 459, -137);

				playAnim('idle');

				flipX = true;

			case 'whitty':
				hasFail = true;
				var tex = Paths.getSparrowAtlas('characters/WHITTY', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'kapi':
				hasFail = true;
				var tex = Paths.getSparrowAtlas('characters/KAPI', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'tankman-playable':
				hasFail = true;
				var tex = Paths.getSparrowAtlas('characters/TANKMAN', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'tankman':
				hasFail = true;
				var tex = Paths.getSparrowAtlas('characters/TANKMAN', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'tricky':
				tex = Paths.getSparrowAtlas('characters/tricky');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24); 
				
				addOffset("idle", 0, -75);
				addOffset("singUP", 93, -76);
				addOffset("singRIGHT", 16, -176);
				addOffset("singLEFT", 103, -72);
				addOffset("singDOWN", 6, -84);

				playAnim('idle');

			case 'rebecca4':
				// REBECCA ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/rebecca_asset4');
				frames = tex;
				animation.addByPrefix('idle', 'rebecca idle dance', 24);
				animation.addByPrefix('singUP', 'rebecca Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'rebecca Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'rebecca Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'rebecca Sing Note LEFT', 24);
				animation.addByPrefix('fall', "rebecca fall over", 24, false);
	
				addOffset('idle', 50, -158);
				addOffset("singUP", 50, -126);
				addOffset("singRIGHT", 50, -163);
				addOffset("singLEFT", 50, -157);
				addOffset("singDOWN", 50, -158);
				addOffset("fall", 50, -158);
	
				playAnim('idle');

			case 'cass-playable':
				tex = Paths.getSparrowAtlas('characters/cass');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 5);
				addOffset("singRIGHT", 100, -70);
				addOffset("singLEFT", -40, -28);
				addOffset("singDOWN", 90, -160);

				playAnim('idle');

			case 'cass':
				tex = Paths.getSparrowAtlas('characters/cass');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');

			case 'tabi':
				frames = Paths.getSparrowAtlas('characters/TABI');
				animation.addByPrefix('idle', 'Dad idle dance', 24, false);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24, false);

				addOffset('idle');

				addOffset("singUP", 44, 50);
				addOffset("singRIGHT", -15, 11);
				addOffset("singLEFT", 104, -28);
				addOffset("singDOWN", -5, -108);

				playAnim('idle');

			case 'agoti':
				frames = Paths.getSparrowAtlas('characters/AGOTI');
				animation.addByPrefix('idle', 'Agoti_Idle', 24, false);
				animation.addByPrefix('singUP', 'Agoti_Up', 24, false);
				animation.addByPrefix('singDOWN', 'Agoti_Down', 24, false);
				animation.addByPrefix('singLEFT', 'Agoti_Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Agoti_Right', 24, false);

				addOffset('idle');

				addOffset("singUP", 10, 70);
				addOffset("singRIGHT", 70, -40);
				addOffset("singLEFT", 70, 40);
				addOffset("singDOWN", 0, -180);

				playAnim('idle');

			case 'bf-christmas':
				var tex = Paths.getSparrowAtlas('characters/bfChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);

				playAnim('idle');

				flipX = true;
			case 'bf-car':
				var tex = Paths.getSparrowAtlas('characters/bfCar');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				playAnim('idle');

				flipX = true;
			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('characters/bfPixel');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('characters/bfPixelsDEAD');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop', -37);
				addOffset('deathConfirm', -37);
				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;

			case 'senpai':
				frames = Paths.getSparrowAtlas('characters/senpai');
				animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'senpai-angry':
				frames = Paths.getSparrowAtlas('characters/senpai');
				animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'spirit':
				frames = Paths.getPackerAtlas('characters/spirit');
				animation.addByPrefix('idle', "idle spirit_", 24, false);
				animation.addByPrefix('singUP', "up_", 24, false);
				animation.addByPrefix('singRIGHT', "right_", 24, false);
				animation.addByPrefix('singLEFT', "left_", 24, false);
				animation.addByPrefix('singDOWN', "spirit down_", 24, false);

				addOffset('idle', -220, -280);
				addOffset('singUP', -220, -240);
				addOffset("singRIGHT", -220, -280);
				addOffset("singLEFT", -200, -280);
				addOffset("singDOWN", 170, 110);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;

			case 'parents-christmas':
				frames = Paths.getSparrowAtlas('characters/mom_dad_christmas_assets');
				animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
				animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
				animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
				animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);

				animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);

				animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);

				addOffset('idle');
				addOffset("singUP", -47, 24);
				addOffset("singRIGHT", -1, -23);
				addOffset("singLEFT", -30, 16);
				addOffset("singDOWN", -31, -29);
				addOffset("singUP-alt", -47, 24);
				addOffset("singRIGHT-alt", -1, -24);
				addOffset("singLEFT-alt", -30, 15);
				addOffset("singDOWN-alt", -30, -27);

				playAnim('idle');
			
			case 'exTricky':
				frames = Paths.getSparrowAtlas('fourth/EXTRICKY','shared');
				setGraphicSize(Std.int(width * 2));
				updateHitbox();

				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('Hank', 'Hank', 24, true);

				addOffset('idle');
				addOffset('Hank');
				addOffset("singUP", 0, 100);
				addOffset("singRIGHT", -209,-29);
				addOffset("singLEFT",127,20);
				addOffset("singDOWN",-100,-340);

				playAnim('idle');

			case 'hat-kid-hatted':
				hasFail = true;
				var tex = Paths.getSparrowAtlas('characters/HATKID_HATTED');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('peck', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'hat-kid-unhatted':
				hasFail = true;
				var tex = Paths.getSparrowAtlas('characters/HATKID');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('peck', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;

			case 'ron':
				tex = Paths.getSparrowAtlas('characters/RON');
				frames = tex;
				animation.addByPrefix('idle', "Idle", 24);
				animation.addByPrefix('singUP', 'Sing Up', 24, false);
				animation.addByPrefix('singDOWN', 'Sing Down', 24, false);
				animation.addByPrefix('singLEFT', 'Sing Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24, false);
				animation.addByPrefix('cheer', 'Ugh', 24, false);
				addOffset('idle');
				addOffset("singUP", 42, 38);
				addOffset("singLEFT", 98, -27);
				addOffset("singRIGHT", -89, -51);
				addOffset("singDOWN", 40, -120);
				addOffset("Ugh", 71, -40);

			case 'tord':
				tex = Paths.getSparrowAtlas('characters/tord_assets');
				frames = tex;

				trace("got texture");
				animation.addByPrefix('idle', "tord idle", 24, false);
				animation.addByPrefix('singUP', "tord up", 24, false);
				animation.addByPrefix('singDOWN', "tord down", 24, false);
				animation.addByPrefix('singLEFT', 'tord left', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'tord right', 24, false);

				trace("got anims");
				addOffset('idle');
				addOffset("singDOWN",-4,-21);
				addOffset("singRIGHT",-30,-13);
				addOffset("singUP",9,21);
				addOffset("singLEFT",20,-17);

				playAnim('idle');
				
			case 'not-sky-mad':
				tex = Paths.getSparrowAtlas('characters/sunday_assets');
				frames = tex;
				animation.addByPrefix('idle-alt', 'sunday alt idle', 24, true);
				animation.addByPrefix('idle', 'sunday idle', 24, true);
				animation.addByPrefix('singUP', 'sunday up', 24, false);
				animation.addByPrefix('singUP-alt', 'sunday alt up', 24, false);
				animation.addByPrefix('singDOWN', 'sunday down', 24, false);
				animation.addByPrefix('singLEFT', 'sunday left', 24, false);
				animation.addByPrefix('singRIGHT', 'sunday right', 24, false);

				addOffset('idle',1,1);
				addOffset('idle-alt',1,1);
				addOffset("singDOWN", 157, -27);
				addOffset("singRIGHT", -71,-10);
				addOffset("singUP", 137, 147);
				addOffset("singUP-alt", 137, 147);
				addOffset("singLEFT", 39,-1);
			
			case 'lav':
				frames = Paths.getSparrowAtlas('characters/LavPhase1');
				animation.addByPrefix('idle', "LavR Legs instance", 24, false);
				animation.addByPrefix('singUP', "LavUp instance", 24, false);
				animation.addByPrefix('singDOWN', "LavDown instance",  24, false);
				animation.addByPrefix('singLEFT', "Lav Left instance", 24, false);
				animation.addByPrefix('singRIGHT', "Lav Right instance", 24, false);
				
				addOffset('idle');
				addOffset("singUP", 0, 15);
				addOffset("singRIGHT", 15, 0);
				addOffset("singLEFT", 80, 0);
				addOffset("singDOWN", 0, -25);
				
				playAnim('idle');

			case 'hat-kid':
				var tex = Paths.getSparrowAtlas('HATKID_HATTED');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('peck', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -4, 5);
				addOffset("singUP", 191, 17);
				addOffset("singRIGHT", 45, 1);
				addOffset("singLEFT", 4, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", 194, 17);
				addOffset("singRIGHTmiss", 50, 11);
				addOffset("singLEFTmiss", 12, 16);
				addOffset("singDOWNmiss", -15, -10);
				addOffset("peck", 1, 6);
				addOffset('firstDeath', 29, 11);
				addOffset('deathLoop', 29, 11);
				addOffset('deathConfirm', 29, 70);
				addOffset('scared', 16, 1);

				playAnim('idle');

				flipX = true;

			case 'bob':
				tex = Paths.getSparrowAtlas('characters/bob_asset');
				frames = tex;
				animation.addByPrefix('idle', "bob_idle", 24, false);
				animation.addByPrefix('singUP', 'bob_UP', 24, false);
				animation.addByPrefix('singDOWN', 'bob_DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'bob_LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'bob_RIGHT', 24, false);

				addOffset('idle');

				flipX = true;

			case 'opheebop':
				tex = Paths.getSparrowAtlas('characters/OPHEEBOP');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -30, -40);
				playAnim('idle');

			case 'sarv':
				tex = Paths.getSparrowAtlas('characters/sarvente_sheet');
				frames = tex;
				animation.addByPrefix('idle', 'SarventeIdle', 24, false);
				animation.addByPrefix('singUP', 'SarventeUp', 24, false);
				animation.addByPrefix('singDOWN', 'SarventeDown', 24, false);
				animation.addByPrefix('singLEFT', 'SarventeLeft', 24, false);
				animation.addByPrefix('singRIGHT', 'SarventeRight', 24, false);

				addOffset('idle');
				addOffset("singUP", 0, 0);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 0, 0);
				addOffset("singDOWN", 0, 0);
				playAnim('idle');

			case 'ruv':
				tex = Paths.getSparrowAtlas('characters/ruv_sheet');
				frames = tex;
				animation.addByPrefix('idle', 'RuvIdle', 24, false);
				animation.addByPrefix('singUP', 'RuvUp', 24, false);
				animation.addByPrefix('singDOWN', 'RuvDown', 24, false);
				animation.addByPrefix('singLEFT', 'RuvLeft', 24, false);
				animation.addByPrefix('singRIGHT', 'RuvRight', 24, false);

				addOffset('idle');
				addOffset("singUP", 0, 0);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 0, 0);
				addOffset("singDOWN", 0, 0);
				playAnim('idle');

			case 'selever':
				tex = Paths.getSparrowAtlas('characters/fuckboi_sheet');
				frames = tex;
				animation.addByPrefix('idle', 'SelIdle', 24, false);
				animation.addByPrefix('singUP', 'SelUp', 24, false);
				animation.addByPrefix('singDOWN', 'SelDown', 24, false);
				animation.addByPrefix('singLEFT', 'SelLeft', 24, false);
				animation.addByPrefix('singRIGHT', 'SelRight', 24, false);
				animation.addByPrefix('hey', 'SelHey', 24, false);

				addOffset('idle');
				addOffset("singUP", 0, 0);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 0, 0);
				addOffset("singDOWN", 0, 0);
				addOffset("hey", 0, 0);
				playAnim('idle');

			case 'qt-kb':

				tex = Paths.getSparrowAtlas('characters/qt-kb');
				frames = tex;


				animation.addByPrefix('danceRight', "danceRightNormal", 26, false);
				animation.addByPrefix('danceLeft', "danceLeftNormal", 26, false);

				//kb
				animation.addByPrefix('danceRight-kb', "danceRightKB", 26, false);
				animation.addByPrefix('danceLeft-kb', "danceLeftKB", 26, false);
				animation.addByPrefix('singUP-kb', 'singUpKB', 24, false);
				animation.addByPrefix('singDOWN-kb', 'singDownKB', 24, false);
				animation.addByPrefix('singLEFT-kb', 'singLeftKB', 24, false);
				animation.addByPrefix('singRIGHT-kb', 'singRightKB', 24, false);
				//qt + kb PLACEHOLDER
				animation.addByPrefix('singUP', "singUpTogether", 24, false);
				animation.addByPrefix('singDOWN', "singDownTogether", 24, false);
				animation.addByPrefix('singLEFT', 'singLeftTogether', 24, false);
				animation.addByPrefix('singRIGHT', 'singRightTogether', 24, false);
				//qt
				animation.addByPrefix('singUP-alt', 'singUpQT', 24, false);
				animation.addByPrefix('singDOWN-alt', 'singDownQT', 24, false);
				animation.addByPrefix('singLEFT-alt', 'singLeftQT', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'singRightQT', 24, false);

				//Positive = goes to left / Up. -Haz
				//Negative = goes to right / Down. -Haz

				addOffset('danceRight-kb',67,-115);
				addOffset('danceLeft-kb',108,-123);
				addOffset("singUP-kb", 115, 38);
				addOffset("singDOWN-kb", 138, -194);
				addOffset("singLEFT-kb", 214, 23);
				addOffset("singRIGHT-kb", -158, -178);	

				addOffset('danceRight',120,-101);
				addOffset('danceLeft',160,-110);

				addOffset("singUP", 151, 52);
				addOffset("singDOWN", 140, -196);
				addOffset("singLEFT", 213, 21);	
				addOffset("singRIGHT", -163, -172);	
				
				addOffset("singUP-alt", 164, -68);
				addOffset("singDOWN-alt", 99, -168);
				addOffset("singLEFT-alt", 133, -75);
				addOffset("singRIGHT-alt", 16, -135);

			case 'qt-kb-night':

				tex = Paths.getSparrowAtlas('characters/qt-kb-night');
				frames = tex;


				animation.addByPrefix('danceRight', "danceRightNormal", 26, false);
				animation.addByPrefix('danceLeft', "danceLeftNormal", 26, false);

				//kb
				animation.addByPrefix('danceRight-kb', "danceRightKB", 26, false);
				animation.addByPrefix('danceLeft-kb', "danceLeftKB", 26, false);
				animation.addByPrefix('singUP-kb', 'singUpKB', 24, false);
				animation.addByPrefix('singDOWN-kb', 'singDownKB', 24, false);
				animation.addByPrefix('singLEFT-kb', 'singLeftKB', 24, false);
				animation.addByPrefix('singRIGHT-kb', 'singRightKB', 24, false);
				//qt + kb PLACEHOLDER
				animation.addByPrefix('singUP', "singUpTogether", 24, false);
				animation.addByPrefix('singDOWN', "singDownTogether", 24, false);
				animation.addByPrefix('singLEFT', 'singLeftTogether', 24, false);
				animation.addByPrefix('singRIGHT', 'singRightTogether', 24, false);
				//qt
				animation.addByPrefix('singUP-alt', 'singUpQT', 24, false);
				animation.addByPrefix('singDOWN-alt', 'singDownQT', 24, false);
				animation.addByPrefix('singLEFT-alt', 'singLeftQT', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'singRightQT', 24, false);

				//Positive = goes to left / Up. -Haz
				//Negative = goes to right / Down. -Haz

				addOffset('danceRight-kb',67,-115);
				addOffset('danceLeft-kb',108,-123);
				addOffset("singUP-kb", 115, 38);
				addOffset("singDOWN-kb", 138, -194);
				addOffset("singLEFT-kb", 214, 23);
				addOffset("singRIGHT-kb", -158, -178);	

				addOffset('danceRight',120,-101);
				addOffset('danceLeft',160,-110);

				addOffset("singUP", 151, 52);
				addOffset("singDOWN", 140, -196);
				addOffset("singLEFT", 213, 21);	
				addOffset("singRIGHT", -163, -172);	
				
				addOffset("singUP-alt", 164, -68);
				addOffset("singDOWN-alt", 99, -168);
				addOffset("singLEFT-alt", 133, -75);
				addOffset("singRIGHT-alt", 16, -135);

			case 'qt-kb-404':

				tex = Paths.getSparrowAtlas('characters/qt-kb-404');
				frames = tex;


				animation.addByPrefix('danceRight', "danceRightNormal", 26, false);
				animation.addByPrefix('danceLeft', "danceLeftNormal", 26, false);

				//kb
				animation.addByPrefix('danceRight-kb', "danceRightKB", 26, false);
				animation.addByPrefix('danceLeft-kb', "danceLeftKB", 26, false);
				animation.addByPrefix('singUP-kb', 'singUpKB', 24, false);
				animation.addByPrefix('singDOWN-kb', 'singDownKB', 24, false);
				animation.addByPrefix('singLEFT-kb', 'singLeftKB', 24, false);
				animation.addByPrefix('singRIGHT-kb', 'singRightKB', 24, false);
				//qt + kb PLACEHOLDER
				animation.addByPrefix('singUP', "singUpTogether", 24, false);
				animation.addByPrefix('singDOWN', "singDownTogether", 24, false);
				animation.addByPrefix('singLEFT', 'singLeftTogether', 24, false);
				animation.addByPrefix('singRIGHT', 'singRightTogether', 24, false);
				//qt
				animation.addByPrefix('singUP-alt', 'singUpQT', 24, false);
				animation.addByPrefix('singDOWN-alt', 'singDownQT', 24, false);
				animation.addByPrefix('singLEFT-alt', 'singLeftQT', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'singRightQT', 24, false);

				//Positive = goes to left / Up. -Haz
				//Negative = goes to right / Down. -Haz

				addOffset('danceRight-kb',67,-115);
				addOffset('danceLeft-kb',108,-123);
				addOffset("singUP-kb", 115, 38);
				addOffset("singDOWN-kb", 138, -194);
				addOffset("singLEFT-kb", 214, 23);
				addOffset("singRIGHT-kb", -158, -178);	

				addOffset('danceRight',120,-101);
				addOffset('danceLeft',160,-110);

				addOffset("singUP", 151, 52);
				addOffset("singDOWN", 140, -196);
				addOffset("singLEFT", 213, 21);	
				addOffset("singRIGHT", -163, -172);	
				
				addOffset("singUP-alt", 164, -68);
				addOffset("singDOWN-alt", 99, -168);
				addOffset("singLEFT-alt", 133, -75);
				addOffset("singRIGHT-alt", 16, -135);

			case 'ded-ron':
				// Ded admtion looding cod
				// *anmtion
				hasFail = true;
				tex = Paths.getSparrowAtlas('characters/mmdedron', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'mmdedron Idle', 24, false);
				animation.addByPrefix('dedlol', 'mmdedron Idle', 24, true);
				animation.addByPrefix('singUP', 'mmdedron Up', 24, false);
				animation.addByPrefix('singLEFT', 'mmdedron Left', 24, false);
				animation.addByPrefix('singDOWN', 'mmdedron Down', 24, false);
				animation.addByPrefix('singRIGHT', 'mmdedron Right', 24, false);

				animation.addByPrefix('singUPmiss', 'mmdedron Miss Up', 24, false);
				animation.addByPrefix('singLEFTmiss', 'mmdedron Miss Left', 24, false);
				animation.addByPrefix('singDOWNmiss', 'mmdedron Miss Down', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'mmdedron Miss Right', 24, false);

				addOffset('idle');
				addOffset("singUP", 0, 0);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 0, 0);
				addOffset("singDOWN", 0, 0);

				addOffset("singUPmiss", 0, 0);
				addOffset("singRIGHTmiss", 0, 0);
				addOffset("singLEFTmiss", 0, 0);
				addOffset("singDOWNmiss", 0, 0);

				playAnim('idle');

				flipX = true;


			case 'pizza':
				tex = Paths.getSparrowAtlas('characters/PizzaMan');
				frames = tex;
				animation.addByPrefix('idle', "PizzasHere", 29);
				animation.addByPrefix('fall', "PizzasHere", 29);
				animation.addByPrefix('singUP', 'Up', 29, false);
				animation.addByPrefix('singDOWN', 'Down', 29, false);
				animation.addByPrefix('singLEFT', 'Left', 29, false);
				animation.addByPrefix('singRIGHT', 'Right', 29, false);
				addOffset('idle');

			case 'garcellodead':
				// GARCELLO DEAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/garcellodead_assets');
				frames = tex;
				animation.addByPrefix('idle', 'garcello idle dance', 24);
				animation.addByPrefix('singUP', 'garcello Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'garcello Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'garcello Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'garcello Sing Note LEFT', 24);

				animation.addByPrefix('garTightBars', 'garcello coolguy', 15);

				addOffset('idle');
				addOffset("singUP", 0, 0);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 0, 0);
				addOffset("singDOWN", 0, 0);
				addOffset("garTightBars", 0, 0);

				playAnim('idle');

			case 'sonicfun':

				tex = Paths.getSparrowAtlas('characters/SonicFunAssets');
				frames = tex;
				animation.addByPrefix('idle', 'SONICFUNIDLE', 24);
				animation.addByPrefix('singUP', 'SONICFUNUP', 24);
				animation.addByPrefix('singRIGHT', 'SONICFUNRIGHT', 24);
				animation.addByPrefix('singDOWN', 'SONICFUNDOWN', 24);
				animation.addByPrefix('singLEFT', 'SONICFUNLEFT', 24);
	
				addOffset('idle', -21, 189);
				addOffset("singUP", 22, 126);
				addOffset("singRIGHT", -80, 43);
				addOffset("singLEFT", 393, -60);
				addOffset("singDOWN", 15, -67);
					
	
				playAnim('idle');

			case 'taki': // TAKI
				tex = Paths.getSparrowAtlas('characters/taki');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -30, -40);

				playAnim('idle');

			case 'cesar':
				var tex = Paths.getSparrowAtlas('characters/cesar', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
				animation.addByPrefix('transition', 'BF Transition', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -28, 13);
				addOffset("singRIGHT", -55, -9);
				addOffset("singLEFT", 14, -2);
				addOffset("singDOWN", -29, -75);
				addOffset("singUPmiss", -56, 10);
				addOffset("singRIGHTmiss", -48, -15);
				addOffset("singLEFTmiss", 21, -3);
				addOffset("singDOWNmiss", -33, -75);
				addOffset("hey", -10, 3);
				addOffset("transition", -10, 3);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -26, -9);

				playAnim('idle');

				flipX = true;

			case 'worriedbob':
				hasFail = true;
				frames = Paths.getSparrowAtlas('characters/Worriedbob', 'shared');

				animation.addByPrefix('idle', 'BOB idle dance', 24, false);
				animation.addByPrefix('singUP', 'BOB Sing Note UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BOB Sing Note LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BOB Sing Note RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BOB Sing Note DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'Bob Miss up', 24, false);
				animation.addByPrefix('singLEFTmiss', 'Bob Miss left', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'Bob Miss right', 24, false);
				animation.addByPrefix('singDOWNmiss', 'Bob Miss down', 24, false);

				animation.addByPrefix('firstDeath', "bob fucking dies0", 24, false);
				animation.addByPrefix('deathLoop', "bob fucking dies loop", 24, true);
				animation.addByPrefix('deathConfirm', "bob fucking dies confirm", 24, false);

				addOffset('idle');
				addOffset("singUP", 17, 26);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 94, 3);
				addOffset("singDOWN", -11, -61);
				addOffset("singUPmiss", 31, 24);
				addOffset("singRIGHTmiss", -40, -7);
				addOffset("singLEFTmiss", 102, -2);
				addOffset("singDOWNmiss", -7, -61);
				addOffset('firstDeath', 116, -60);
				addOffset('deathLoop', 115, -62);
				addOffset('deathConfirm', 115, -51);

				playAnim('idle');

				flipX = true;

			case 'bosip':
				frames = Paths.getSparrowAtlas('characters/bosip_assets', 'shared');
				animation.addByPrefix('idle', 'Bosip idle dance', 24, false);
				animation.addByPrefix('singUP', 'Bosip Sing Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'Bosip Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Bosip Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Bosip Sing Note RIGHT', 24, false);

				addOffset('idle');
				addOffset("singUP", 23, 24);
				addOffset("singRIGHT", -6, -18);
				addOffset("singLEFT", 64, 7);
				addOffset("singDOWN", 22, -18);

				playAnim('idle');

			case 'HCcarol':
				frames = Paths.getSparrowAtlas('characters/HCcarol_assets');
				animation.addByPrefix('idle', 'carol idle', 24, false);
				animation.addByPrefix('singUP', 'carol up', 24, false);
				animation.addByPrefix('singDOWN', 'carol down', 24, false);
				animation.addByPrefix('singLEFT', 'carol left', 24, false);
				animation.addByPrefix('singRIGHT', 'carol right', 24, false);
				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				/*
				animation.addByPrefix('idle-alt', 'carol alt idle', 24, false);
				animation.addByPrefix('singUP-alt', 'carol alt up', 24, false);
				animation.addByPrefix('singDOWN-alt', 'carol alt down', 24, false);
				animation.addByPrefix('singLEFT-alt', 'carol alt left', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'carol alt right', 24, false);
				addOffset('idle-alt');
				addOffset("singUP-alt");
				addOffset("singRIGHT-alt");
				addOffset("singLEFT-alt");
				addOffset("singDOWN-alt");
				*/

				playAnim('idle');

			case 'WhittyCrazy':
				frames = Paths.getSparrowAtlas('characters/WhittyCrazy');
				animation.addByPrefix('idle', 'Whitty idle dance', 24, false);
				animation.addByPrefix('singUP', 'Whitty Sing Note UP', 24, false);
				animation.addByPrefix('singDOWN', 'Whitty Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Whitty Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'whitty sing note right', 24, false);
				addOffset('idle');
				addOffset("singUP", 14, 100);
				addOffset("singRIGHT", 20, 17);
				addOffset("singLEFT", 150, -90);
				addOffset("singDOWN", 20, -135);

				playAnim('idle');

			case 'nonsense-god':
				frames = Paths.getSparrowAtlas('characters/Nonsense_God');
				animation.addByPrefix('idle', 'idle god', 24, false);
				animation.addByPrefix('singUP', 'god right', 24, false);
				animation.addByPrefix('singLEFT', 'left god', 24, false);
				animation.addByPrefix('singRIGHT', 'god right', 24, false);
				animation.addByPrefix('singDOWN', 'God down', 24, false);
				animation.addByPrefix('die', 'die god', 24, false);
				animation.addByIndices('singUP-alt', 'god up long note', [0, 2, 3, 4, 5, 6, 7], "", 24, false);
				animation.addByPrefix('singDOWN-alt', 'God down', 24, false);
				animation.addByPrefix('singLEFT-alt', 'left god', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'god right', 24, false);
				addOffset('idle', 1, 1);
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("die", 718, 302);
				addOffset("singUP-alt", 0, 6);
				addOffset("singRIGHT-alt");
				addOffset("singLEFT-alt");
				addOffset("singDOWN-alt");
				
				playAnim('idle');

			case 'glitched-bob':
				tex = Paths.getSparrowAtlas('characters/ScaryBobAaaaah');
				frames = tex;
				animation.addByPrefix('idle', "idle???-", 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);

				addOffset('idle');

			case 'HD_spirit':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/HD_SPIRIT', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');

			case 'matt':
				tex = Paths.getSparrowAtlas('characters/matt_assets','shared');
				frames = tex;
				animation.addByPrefix('idle', "matt idle", 24);
				animation.addByPrefix('singUP', 'matt up note', 24, false);
				animation.addByPrefix('singDOWN', 'matt down note', 24, false);
				animation.addByPrefix('singLEFT', 'matt left note', 24, false);
				animation.addByPrefix('singRIGHT', 'matt right note', 24, false);
				addOffset("singUP", 0, 20);
				addOffset("singRIGHT", -15, -20);
				addOffset("singLEFT", 30, -40);
				addOffset("singDOWN", 0, -20);
				playAnim('idle');

			case 'anchor':
				tex = Paths.getSparrowAtlas('characters/anchorAssets','shared');
				frames = tex;
				animation.addByPrefix('idle', "anchor Idle", 24);
				animation.addByPrefix('singUP', 'anchor Up Pose', 24, false);
				animation.addByPrefix('singDOWN', 'anchor DOWN POSE', 24, false);
				animation.addByPrefix('singLEFT', 'anchor Pose Left', 24, false);
				animation.addByPrefix('singRIGHT', 'anchor Left Pose', 24, false);
				addOffset("idle", 0, 0);
				addOffset("singUP", -90, 48);
				addOffset("singLEFT", 163, -51);
				addOffset("singRIGHT", -112, -8);
				addOffset("singDOWN", -8, -200);
				playAnim('idle');

			case 'roro':
				tex = Paths.getSparrowAtlas('characters/roroAssets','shared');
				frames = tex;
				animation.addByPrefix('idle', "roro Idle", 24);
				animation.addByPrefix('singUP', 'roro Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'roro Down Note', 24, false);
				animation.addByPrefix('singLEFT', 'roro Left Note', 24, false);
				animation.addByPrefix('singRIGHT', 'roro Right Note', 24, false);
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				playAnim('idle');

			case 'parasite':
				tex = Paths.getSparrowAtlas('characters/parasite', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'mungus idle', 24, true);
				animation.addByPrefix('singUP', 'parasite up new', 24, false);
				animation.addByPrefix('singRIGHT', 'parasite right', 24, false);
				animation.addByPrefix('singDOWN', 'paracite down', 24, false);
				animation.addByPrefix('singLEFT', 'parasite left', 24, false);

				addOffset('idle');
				addOffset("singUP", -10, 196);
				addOffset("singRIGHT", 30, 16);
				addOffset("singLEFT", 50, 49);
				addOffset("singDOWN", -18, -111);

				setGraphicSize(Std.int(width * 2));

				playAnim('idle');

			case 'arch':
				tex = Paths.getSparrowAtlas('characters/arch','shared');
				frames = tex;
				animation.addByIndices('idle', 'arch', [0], "", 24, false);
				animation.addByIndices('singRIGHT', 'arch', [1], "", 24, false);
				animation.addByIndices('singUP', 'arch', [2], "", 24, false);
				animation.addByIndices('singLEFT', 'arch', [3], "", 24, false);
				animation.addByIndices('singDOWN', 'arch', [4], "", 24, false);
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				playAnim('idle');

			case 'bbpanzu':
				tex = Paths.getSparrowAtlas('characters/bb', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'bb idle', 24, true);
				animation.addByPrefix('singUP', 'bb up', 24, false);
				animation.addByPrefix('singRIGHT', 'bb right', 24, false);
				animation.addByPrefix('singDOWN', 'bb down', 24, false);
				animation.addByPrefix('singLEFT', 'bb left', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				playAnim('idle');

				flipX = true;

			case 'softie':
				var tex = Paths.getSparrowAtlas('characters/softie', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", 0, 10);
				addOffset("singRIGHT", -43, -7);
				addOffset("singLEFT", 19, -9);
				addOffset("singDOWN", 1, -53);
				addOffset("singUPmiss", -12, 9);
				addOffset("singRIGHTmiss", -53, -8);
				addOffset("singLEFTmiss", 20, -8);
				addOffset("singDOWNmiss", 0, -53);
				addOffset("hey", 3, -2);
				addOffset('firstDeath', 37, 5);
				addOffset('deathLoop', 37, -4);
				addOffset('deathConfirm', 37, 41);
				addOffset('scared', -8, -5);

				playAnim('idle');

				flipX = true;

			case 'monster-soft':
				tex = Paths.getSparrowAtlas('characters/Monster_Assets_Soft');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster left note', 24, false);
				animation.addByPrefix('singLEFT', 'Monster Right note', 24, false);
				setGraphicSize(Std.int(width * 1.15));

				addOffset('idle');
				addOffset("singUP", 175, 86);
				addOffset("singLEFT", 214, 5);
				addOffset("singRIGHT", 106, -75);
				addOffset("singDOWN", 181, -63);

				playAnim('idle');

			case 'liz':
				tex = Paths.getSparrowAtlas('characters/liz_assets', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'liz idle', 24, true);
				animation.addByPrefix('singUP', 'liz up pose', 24, false);
				animation.addByPrefix('singRIGHT', 'liz right pose', 24, false);
				animation.addByPrefix('singDOWN', 'liz down pose', 24, false);
				animation.addByPrefix('singLEFT', 'liz left pose', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				playAnim('idle');

			case 'neon':
				frames = Paths.getSparrowAtlas('characters/NEON');
				animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'lila':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/lila', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');

			case 'matt-shaggy':
				// DAD ANIMATION LOADING CODE
				hasFail = true;
				tex = Paths.getSparrowAtlas('characters/matt', 'shared');
				frames = tex;
				animation.addByPrefix('idle', "matt idle", 20, false);
				animation.addByPrefix('singUP', "matt up note", 24, false);
				animation.addByPrefix('singDOWN', "matt down note", 24, false);
				animation.addByPrefix('singLEFT', 'matt left note', 24, false);
				animation.addByPrefix('singRIGHT', 'matt right note', 24, false);
				animation.addByPrefix('singUPmiss', "miss up", 24, false);
				animation.addByPrefix('singDOWNmiss', "miss down", 24, false);
				animation.addByPrefix('singLEFTmiss', 'miss left', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'miss right', 24, false);

				addOffset('idle');
				addOffset("singUP", -21, 21);
				addOffset("singRIGHT", -40, -14);
				addOffset("singLEFT", 63, -24);
				addOffset("singDOWN", -30, -19);
				addOffset("singUPmiss", -21, 21);
				addOffset("singRIGHTmiss", -40, -14);
				addOffset("singLEFTmiss", 63, -24);
				addOffset("singDOWNmiss", -15, -28);

				playAnim('idle');

			case 'shaggy-shaggy':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/shaggy', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'shaggy_idle', 24);
				animation.addByPrefix('idle2', 'shaggy_idle2', 24);
				animation.addByPrefix('singUP', 'shaggy_up', 20);
				animation.addByPrefix('singRIGHT', 'shaggy_right', 20);
				animation.addByPrefix('singDOWN', 'shaggy_down', 24);
				animation.addByPrefix('singLEFT', 'shaggy_left', 24);
				animation.addByPrefix('catch', 'shaggy_catch', 30);
				animation.addByPrefix('hold', 'shaggy_hold', 30);
				animation.addByPrefix('h_half', 'shaggy_h_half', 30);
				animation.addByPrefix('fall', 'shaggy_fall', 30);
				animation.addByPrefix('kneel', 'shaggy_half_ground', 30);

				animation.addByPrefix('power', 'shaggy_powerup', 30);
				animation.addByPrefix('idle_s', 'shaggy_super_idle', 24);
				animation.addByPrefix('singUP_s', 'shaggy_sup2', 20);
				animation.addByPrefix('singRIGHT_s', 'shaggy_sright', 20);
				animation.addByPrefix('singDOWN_s', 'shaggy_sdown', 24);
				animation.addByPrefix('singLEFT_s', 'shaggy_sleft', 24);

				addOffset('idle');
				addOffset('idle2');
				addOffset("singUP", -6, 0);
				addOffset("singRIGHT", -20, -40);
				addOffset("singLEFT", 100, -120);
				addOffset("singDOWN", 0, -170);
				addOffset("catch", 140, 90);
				addOffset("hold", 90, 100);
				addOffset("h_half", 90, 0);
				addOffset("fall", 130, 0);
				addOffset("kneel", 110, -123);

				addOffset('idle_s');
				addOffset('power', 10, 0);
				addOffset("singUP_s", -6, 0);
				addOffset("singRIGHT_s", -20, -40);
				addOffset("singLEFT_s", 100, -120);
				addOffset("singDOWN_s", 0, -170);

				playAnim('idle');

			case 'little-man':
				tex = Paths.getSparrowAtlas('characters/Small_Guy');
				frames = tex;
				animation.addByPrefix('idle', "idle", 24);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				addOffset('idle');
				addOffset("singUP", -10, 8);
				addOffset("singLEFT", -8, 0);
				addOffset("singRIGHT", 0, 2);
				addOffset("singDOWN", 0, -10);

			case 'sayori':
				tex = Paths.getSparrowAtlas('characters/sayori','shared');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);

				addOffset('idle');
				addOffset("singUP", 52, 67);
				addOffset("singLEFT", 54, 72);
				addOffset("singRIGHT", 50, 144);
				addOffset("singDOWN", 8, 125);

				setGraphicSize(Std.int(width * 1.1));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

			case 'cableCrowPog':
				tex = Paths.getSparrowAtlas('characters/Cablecrow');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 14);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24);

				addOffset('idle');
				addOffset("singUP", 0, 4);
				addOffset("singLEFT", 335, -17);
				addOffset("singRIGHT", 31, 0);
				addOffset("singDOWN", 11, 2);

				playAnim('idle');

			case 'henry':
				tex = Paths.getSparrowAtlas('characters/henry');
				frames = tex;
				animation.addByPrefix('idle', 'spooky dance idle', 24, false);
				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
				animation.addByPrefix('singUPmiss', 'spooky UPNOTE MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'note singleft MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'spooky singright MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'spooky DOWNnote MISS', 24, false);

				addOffset('idle');
				addOffset("singUP", -50, 26);
				addOffset("singRIGHT", -70, -10);
				addOffset("singLEFT", 80, -10);
				addOffset("singDOWN", -18, -140);
				addOffset("singUPmiss", -50, 26);
				addOffset("singRIGHTmiss", -70, -10);
				addOffset("singLEFTmiss", 80, -10);
				addOffset("singDOWNmiss", -18, -140);

				playAnim('idle');

			case 'rebecca':
				// REBECCA ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/rebecca_asset');
				frames = tex;
				animation.addByPrefix('idle', 'rebecca idle dance', 24);
				animation.addByPrefix('singUP', 'rebecca Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'rebecca Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'rebecca Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'rebecca Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -26, 31);
				addOffset("singRIGHT", -75, -116);
				addOffset("singLEFT", 183, -146);
				addOffset("singDOWN", -5, -309);

				playAnim('idle');

			case 'astro':
				tex = Paths.getSparrowAtlas('characters/astro');
				frames = tex;
				animation.addByPrefix('idle', 'Astro idle', 24);
				animation.addByPrefix('singUP', 'Astro UP', 24);
				animation.addByPrefix('singRIGHT', 'Astro right', 24);
				animation.addByPrefix('singDOWN', 'Astro down', 24);
				animation.addByPrefix('singLEFT', 'Astro left', 24);

				addOffset('idle', 0, 0);
				addOffset("singUP", 47, -3);
				addOffset("singRIGHT", 5, 0);
				addOffset("singLEFT", 16, -21);
				addOffset("singDOWN", 0, 0);

				playAnim('idle');

			case 'blantados':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/BLANTADOS', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", 31, 16);
				addOffset("singRIGHT", 77, -5);
				addOffset("singLEFT", 40, 0);
				addOffset("singDOWN", 38, -14);

				playAnim('idle');

			case 'chara':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/chara', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'chara0', 24);
				animation.addByPrefix('singUP', 'chara up', 24);
				animation.addByPrefix('singRIGHT', 'chara right', 24);
				animation.addByPrefix('singDOWN', 'chara down', 24);
				animation.addByPrefix('singLEFT', 'chara left', 24);
				animation.addByPrefix('YOU', 'chara zrick', 24);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("YOU");

				playAnim('idle');

			case 'sans':
				hasFail = true;
				var tex = Paths.getSparrowAtlas('characters/sans', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', 0, 0);
				addOffset("singUP", -29, -3);
				addOffset("singRIGHT", -33, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -48);
				addOffset("singUPmiss", -49, 12);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 22, 14);
				addOffset("singDOWNmiss", -15, -19);
				addOffset("hey", 2, 5);
				addOffset('firstDeath', 26, 8);
				addOffset('deathLoop', 47, -15);
				addOffset('deathConfirm', 26, 66);
				addOffset('scared', 41, -18);

				playAnim('idle');

				flipX = true;

			case 'CG5':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/CG5');
				frames = tex;
				animation.addByPrefix('yeah', 'csmuge', 24);
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset('yeah');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');

			case 'eteled2':
				tex = Paths.getSparrowAtlas('characters/eteled2_assets','shared');
				frames = tex;
				animation.addByPrefix('idle', 'eteled idle dance', 24);
				animation.addByPrefix('singUP', 'eteled Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'eteled Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'eteled Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'eteled Sing Note LEFT', 24);
				animation.addByPrefix('scream', 'eteled SCREAM', 24);

				addOffset('idle');
				addOffset("singUP", -18, 66);
				addOffset("singRIGHT", -21, -62);
				addOffset("singDOWN", -6, -98);
				addOffset("singLEFT", 243, 19);
				addOffset('scream', 142, 151);

				playAnim('idle');

			case 'spinel-angy':
				tex = Paths.getSparrowAtlas('characters/SPINEL_FALLING_SPRITE', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'IDLEMOVE', 24);
				animation.addByPrefix('singUP', 'SPINELUP', 24, false);
				animation.addByPrefix('singRIGHT', 'SPINELRIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'SPINELDOWN', 24, false);
				animation.addByPrefix('singLEFT', 'SPINELLEFT', 24, false);

				addOffset('idle', 0, 190);
				addOffset("singUP", 84, 341);
				addOffset("singRIGHT", -140, -59);
				addOffset("singLEFT", 35, 113);
				addOffset("singDOWN", 11, -341);

				playAnim('idle');

			case 'cj':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/cj_assets','shared');
				frames = tex;
				animation.addByPrefix('idle', 'cj idle dance', 24, false);
				animation.addByPrefix('singUP', 'cj Sing Note UP0', 24, false);
				animation.addByPrefix('singLEFT', 'cj Sing Note LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'cj Sing Note RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'cj Sing Note DOWN0', 24, false);
				animation.addByPrefix('ha', 'cj singleha0', 24, false);
				animation.addByPrefix('haha', 'cj doubleha0', 24, false);
				animation.addByPrefix('intro', 'cj intro0', 24, false);

				addOffset('idle');
				addOffset('intro', 590, 232);
				addOffset("singUP", -46, 28);
				addOffset("singRIGHT", -20, 37);
				addOffset("singLEFT", -2, 3);
				addOffset("singDOWN", -20, -20);
				addOffset('ha', -46, 28);
				addOffset('haha', -46, 28);

				playAnim('idle');

			case 'ruby':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/ruby_assets','shared');
				frames = tex;
				//animation.addByIndices('idle', 'ruby idle dance', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], "", 24, false);
				animation.addByPrefix('idle', 'ruby idle dance', 24, true);
				animation.addByPrefix('singUP', 'ruby Sing Note UP0', 24, false);
				animation.addByPrefix('singLEFT', 'ruby Sing Note LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'ruby Sing Note RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'ruby Sing Note DOWN0', 24, false);

				addOffset('idle');
				addOffset("singUP", -18, 42);
				addOffset("singRIGHT", -17, 19);
				addOffset("singLEFT", -22, 0);
				addOffset("singDOWN", -23, -38);

				playAnim('idle');

			case 'cream-dead':
				tex = Paths.getSparrowAtlas('characters/amorButFUNNY');
				frames = tex;

				animation.addByPrefix('idle', "puddle", 24, false);
				animation.addByPrefix('singUP', "up puddle", 24, false);
				animation.addByPrefix('singDOWN', "down puddle", 24, false);
				animation.addByPrefix('singLEFT', 'left puddle', 24, false);
				animation.addByPrefix('singRIGHT', 'right puddle', 24, false);

				
				/*since characters arent preloaded in this version i had to
				 * use alt anims cuz it lags the game a lot when it switches between em
				 * caused it doesnt cache it loading the character in :wah:*/

				//update: problem is it doesnt preload the characters lmao
				//but its fine i got the drop animation to work well with messing
				//with the dance function B)
				animation.addByPrefix('singUP-alt', 'Amor Sing Note UP', 24, false);

				animation.addByPrefix('singDOWN-alt', 'Amor Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Amor Sing Note LEFT', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Amor Sing Note RIGHT', 24, false);

				animation.addByPrefix('drop', 'Amor drop', 24, false);
				animation.addByPrefix('wws', 'Amor wws', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUP-alt", 5, 41);
				addOffset("singRIGHT-alt", -11, 2);
				addOffset("singLEFT-alt", 25, 1);
				addOffset("singDOWN-alt", -23, -16);
				addOffset("drop", 42, 221);
				addOffset("wws", 42, 221);

				playAnim('idle');

				flipY = true;

			case 'jevil-sunday':
				tex = Paths.getSparrowAtlas('characters/CHAOS_sunday');
				frames = tex;
				animation.addByPrefix('idle-alt', 'sunday alt idle', 24, true);
				animation.addByPrefix('idle', 'sunday idle', 24, true);
				animation.addByPrefix('singUP', 'sunday up', 24, false);
				animation.addByPrefix('singUP-alt', 'sunday alt up', 24, false);
				animation.addByPrefix('singDOWN', 'sunday down', 24, false);
				animation.addByPrefix('singLEFT', 'sunday left', 24, false);
				animation.addByPrefix('singRIGHT', 'sunday right', 24, false);

				addOffset('idle',1,1);
				addOffset('idle-alt',1,1);
				addOffset("singDOWN", 82, -23);
				addOffset("singRIGHT", -126,-3);
				addOffset("singUP", 60, 86);
				addOffset("singUP-alt", 60, 86);
				addOffset("singLEFT", 27,3);
			
			case 'jevil-sunday-flipped':
				tex = Paths.getSparrowAtlas('characters/CHAOS_sunday');
				frames = tex;
				animation.addByPrefix('idle-alt', 'sunday alt idle', 24, true);
				animation.addByPrefix('idle', 'sunday idle', 24, true);
				animation.addByPrefix('singUP', 'sunday up', 24, false);
				animation.addByPrefix('singUP-alt', 'sunday alt up', 24, false);
				animation.addByPrefix('singDOWN', 'sunday down', 24, false);
				animation.addByPrefix('singRIGHT', 'sunday left', 24, false);
				animation.addByPrefix('singLEFT', 'sunday right', 24, false);

				addOffset('idle',1,1);
				addOffset('idle-alt',1,1);
				addOffset("singDOWN", 72, -23);
				addOffset("singLEFT", 174,-3);
				addOffset("singUP", 430, 86);
				addOffset("singUP-alt", 430, 86);
				addOffset("singRIGHT", -33,3);
			
			case 'hat-kid-spamton':
				var tex = Paths.getSparrowAtlas('characters/Hatkid_spamton', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -14, -11);
				addOffset("singRIGHT", -36, -2);
				addOffset("singLEFT", 12, -8);
				addOffset("singDOWN", -12, -29);

				playAnim('idle');

				flipX = true;

			case 'MTTcarol':
				frames = Paths.getSparrowAtlas('characters/MTTcarol_assets');
				animation.addByPrefix('idle', 'carol idle', 24, false);
				animation.addByPrefix('singUP', 'carol up', 24, false);
				animation.addByPrefix('singDOWN', 'carol down', 24, false);
				animation.addByPrefix('singLEFT', 'carol right', 24, false);
				animation.addByPrefix('singRIGHT', 'carol left', 24, false);
				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				/*
				animation.addByPrefix('idle-alt', 'carol alt idle', 24, false);
				animation.addByPrefix('singUP-alt', 'carol alt up', 24, false);
				animation.addByPrefix('singDOWN-alt', 'carol alt down', 24, false);
				animation.addByPrefix('singLEFT-alt', 'carol alt left', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'carol alt right', 24, false);
				addOffset('idle-alt');
				addOffset("singUP-alt");
				addOffset("singRIGHT-alt");
				addOffset("singLEFT-alt");
				addOffset("singDOWN-alt");
				*/

				playAnim('idle');

			case 'DUMMYmiku':
				frames = Paths.getSparrowAtlas('characters/dummy_miku_assets','shared');
				
				animation.addByIndices('danceLeft','Miku idle dance',[31,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14], '', 24, false);
				animation.addByIndices('danceRight','Miku idle dance',[15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30], '', 24, false);
				animation.addByPrefix('singUP', 'Miku Sing Note UP0', 24, false);
				animation.addByPrefix('singDOWN', 'Miku Sing Note DOWN0', 24, false);
				animation.addByPrefix('singRIGHT', 'Miku Sing Note LEFT0', 24, false);
				animation.addByPrefix('singLEFT', 'Miku Sing Note RIGHT0', 24, false);
				addOffset('danceLeft');
				addOffset('danceRight');
				addOffset("singUP", 19, 51);
				addOffset("singDOWN", 11, 0);
				addOffset("singRIGHT", -51, 1);
				addOffset("singLEFT", 41, -1);

				playAnim('danceLeft');

		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf') &&
				!curCharacter.startsWith('hat-kid') &&
				!curCharacter.startsWith('tankman-playable') &&
				!curCharacter.startsWith('kapi') &&
				!curCharacter.startsWith('pico') &&
				!curCharacter.startsWith('cass-playable') &&
				!curCharacter.startsWith('whitty') &&
				!curCharacter.startsWith('ded-ron') &&
				!curCharacter.startsWith('cesar') &&
				!curCharacter.startsWith('annie') &&
				!curCharacter.startsWith('worriedbob') &&
				!curCharacter.startsWith('anchor') &&
				!curCharacter.startsWith('bbpanzu') &&
				!curCharacter.startsWith('softie'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf') &&
			!curCharacter.startsWith('lav') &&
			!curCharacter.startsWith('hat-kid') &&
			!curCharacter.startsWith('tord') &&
			!curCharacter.startsWith('monster-annie') &&
			!curCharacter.startsWith('tankman-playable') &&
			!curCharacter.startsWith('lav') &&
			!curCharacter.startsWith('kapi') &&
			!curCharacter.startsWith('HD_senpai') &&
			!curCharacter.startsWith('HD_spirit') &&
			!curCharacter.startsWith('HD_monika') &&
			!curCharacter.startsWith('sarv') &&
			!curCharacter.startsWith('ruv') &&
			!curCharacter.startsWith('pico') &&
			!curCharacter.startsWith('cass-playable') &&
			!curCharacter.startsWith('whitty') &&
			!curCharacter.startsWith('carol') &&
			!curCharacter.startsWith('ded-ron') &&
			!curCharacter.startsWith('cesar') &&
			!curCharacter.startsWith('annie') &&
			!curCharacter.startsWith('worriedbob') &&
			!curCharacter.startsWith('exGf-playable') &&
			!curCharacter.startsWith('nene') &&
			!curCharacter.startsWith('anchor') &&
			!curCharacter.startsWith('WhittyCrazy') &&
			!curCharacter.startsWith('bbpanzu') &&
			!curCharacter.startsWith('softie') &&
			!curCharacter.startsWith('liz') &&
			!curCharacter.startsWith('neon') &&
			!curCharacter.startsWith('shaggy') &&
			!curCharacter.startsWith('blantados') &&
			!curCharacter.startsWith('sans'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				if (!PlayState.roboturn)
				{
					trace('dance');
					dance();
					holdTimer = 0;
				}
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance(useAltAnimation:Bool=false)
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf' | 'DUMMYmiku':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'robo-gf' | 'robo-gf-night' | 'robo-gf-404' | 'roboparachute' | 'robo-dog' | 'robo-gf-no-speakers':
					if (!animation.curAnim.name.startsWith('OI') && !animation.curAnim.name.startsWith('come saw') && !animation.curAnim.name.startsWith('GET THE BITCH') && !animation.curAnim.name.startsWith('go saw'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'ROBO-TIKY':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case '86lol':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'qt-kb':
					danced = !danced;

					if(useAltAnimation){
						if (danced)
							playAnim('danceRight-kb');
						else
							playAnim('danceLeft-kb');
					}else{
						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'qt-kb-night' | 'qt-kb-404':
					danced = !danced;

					if(useAltAnimation){
						if (danced)
							playAnim('danceRight-kb');
						else
							playAnim('danceLeft-kb');
					}else{
						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf' || curCharacter == 'robo-gf' || curCharacter == 'robo-gf-no-speakers')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
