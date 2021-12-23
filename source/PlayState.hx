package;

import webm.WebmPlayer;
import flixel.input.keyboard.FlxKey;
import haxe.Exception;
import openfl.geom.Matrix;
import openfl.display.BitmapData;
import openfl.utils.AssetType;
import lime.graphics.Image;
import flixel.graphics.FlxGraphic;
import openfl.utils.AssetManifest;
import openfl.utils.AssetLibrary;
import flixel.system.FlxAssets;

import lime.app.Application;
import lime.media.AudioContext;
import lime.media.AudioManager;
import openfl.Lib;
import Section.SwagSection;
import Song.SwagSong;
import WiggleEffect.WiggleEffectType;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.addons.text.FlxTypeText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;
import flixel.addons.display.FlxBackdrop;
import flash.system.System;

#if windows
import Discord.DiscordClient;
#end
#if windows
import Sys;
import sys.FileSystem;
#end

using StringTools;

class PlayState extends MusicBeatState
{
	public static var instance:PlayState = null;

	public static var curStage:String = '';
	public static var SONG:SwagSong;
	public static var isStoryMode:Bool = false;
	public static var storyWeek:Int = 0;
	public static var storyPlaylist:Array<String> = [];
	public static var storyDifficulty:Int = 1;
	public static var weekSong:Int = 0;
	public static var weekScore:Int = 0;
	public static var shits:Int = 0;
	public static var bads:Int = 0;
	public static var goods:Int = 0;
	public static var sicks:Int = 0;

	public static var songPosBG:FlxSprite;
	public static var songPosBar:FlxBar;

	public static var rep:Replay;
	public static var loadRep:Bool = false;

	public static var noteBools:Array<Bool> = [false, false, false, false];

	var halloweenLevel:Bool = false;

	var songLength:Float = 0;
	var kadeEngineWatermark:FlxText;
	
	#if windows
	// Discord RPC variables
	var storyDifficultyText:String = "";
	var iconRPC:String = "";
	var detailsText:String = "";
	var detailsPausedText:String = "";
	#end

	private var vocals:FlxSound;

	public var originalX:Float;

	public static var dad:Character;
	public static var dadAgain:Character;
	public static var dadAgain2:Character;
	public static var dadAgain3:Character;
	public static var hatkid:Character;
	public static var lol86:Character;
	public static var gf:Character;
	public static var boyfriend:Boyfriend;
	public static var boyfriendAgain:Boyfriend;

	public var notes:FlxTypedGroup<Note>;
	private var unspawnNotes:Array<Note> = [];

	public var strumLine:FlxSprite;
	private var curSection:Int = 0;

	private var camFollow:FlxObject;

	private static var prevCamFollow:FlxObject;

	public static var strumLineNotes:FlxTypedGroup<FlxSprite> = null;
	public static var playerStrums:FlxTypedGroup<FlxSprite> = null;
	public static var cpuStrums:FlxTypedGroup<FlxSprite> = null;
	private var projectiles:FlxTypedGroup<Projectile>;

	private var camZooming:Bool = false;
	private var curSong:String = "";

	private var gfSpeed:Int = 1;
	public var health:Float = 1; //making public because sethealth doesnt work without it
	private var combo:Int = 0;
	public static var misses:Int = 0;
	public static var campaignMisses:Int = 0;
	public var accuracy:Float = 0.00;
	private var accuracyDefault:Float = 0.00;
	private var totalNotesHit:Float = 0;
	private var totalNotesHitDefault:Float = 0;
	private var totalPlayed:Int = 0;
	private var ss:Bool = false;


	private var healthBarBG:FlxSprite;
	private var healthBar:FlxBar;
	private var songPositionBar:Float = 0;
	
	private var generatedMusic:Bool = false;
	private var startingSong:Bool = false;

	public var iconP1:HealthIcon; //making these public again because i may be stupid
	public var iconP2:HealthIcon; //what could go wrong?
	public var camHUDier:FlxCamera;
	public var camHUD:FlxCamera;
	private var camGame:FlxCamera;

	public static var offsetTesting:Bool = false;

	var notesHitArray:Array<Date> = [];
	var currentFrames:Int = 0;

	public var dialogue:Array<String> = ['dad:blah blah blah', 'bf:coolswag'];

	var halloweenBG:FlxSprite;
	var isHalloween:Bool = false;

	var phillyCityLights:FlxTypedGroup<FlxSprite>;
	var phillyTrain:FlxSprite;
	var trainSound:FlxSound;

	var limo:FlxSprite;
	var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;
	var fastCar:FlxSprite;
	var songName:FlxText;
	var upperBoppers:FlxSprite;
	var bottomBoppers:FlxSprite;
	var santa:FlxSprite;

	var fc:Bool = true;
	var dumbasstext:FlxText;
	var dumbasstext2:FlxText;
	var dumbasstext3:FlxText;
	var dumbasstext4:FlxTypeText;

	var bgGirls:BackgroundGirls;
	var wiggleShit:WiggleEffect = new WiggleEffect();

	var talking:Bool = true;
	public var songScore:Int = 0;
	var songScoreDef:Int = 0;
	var scoreTxt:FlxText;
	var replayTxt:FlxText;

	public static var campaignScore:Int = 0;

	var defaultCamZoom:Float = 1.05;

	public static var daPixelZoom:Float = 6;

	public static var theFunne:Bool = true;
	var funneEffect:FlxSprite;
	var inCutscene:Bool = false;
	public static var repPresses:Int = 0;
	public static var repReleases:Int = 0;

	public static var timeCurrently:Float = 0;
	public static var timeCurrentlyR:Float = 0;
	
	// Will fire once to prevent debug spam messages and broken animations
	private var triggeredAlready:Bool = false;
	
	// Will decide if she's even allowed to headbang at all depending on the song
	private var allowedToHeadbang:Bool = false;
	// Per song additive offset
	public static var songOffset:Float = 0;
	// BotPlay text
	private var botPlayState:FlxText;
	// Replay shit
	private var saveNotes:Array<Dynamic> = [];

	public static var highestCombo:Int = 0;

	private var executeModchart = false;

	// API stuff
	
	public function addObject(object:FlxBasic) { add(object); }
	public function removeObject(object:FlxBasic) { remove(object); }
	var circ1:FlxSprite;
	var circ2:FlxSprite;
	var mic:FlxSprite;
	var spamtonCart:FlxSprite;
	var spamtonCartThing:FlxSprite;
	var spamtonCart2:FlxSprite;
	var spamtonCartThing2:FlxSprite;
	var spamtonCart3:FlxSprite;
	var spamtonCartThing3:FlxSprite;
	var blueSpamton1:FlxSprite;
	var blueSpamton2:FlxSprite;
	var heartSheild:FlxSprite;
	var heartThing:FlxSprite;
	var spamtonLarg:FlxSprite;
	var spamtonLargJaw:FlxSprite;
	var spamtonLargHead:FlxSprite;
	public static var susie:FlxSprite;
	var kris:FlxSprite;
	var ralsei:FlxSprite;
	var circSelever:FlxSprite;
	var blackFuck:FlxSprite;
	var blackSelever:FlxSprite;
	var startCircle:FlxSprite;
	var startText:FlxSprite;
	var qt_tv01:FlxSprite;
	var kb_attack_alert:FlxSprite;
	var kb_attack_saw:FlxSprite;
	public static var deathBySawBlade:Bool = false;
	var bfDodging:Bool = false;
	var bfCanDodge:Bool = true;
	var beatOfFuck:Int = 0;
	var interupt = false;
	var shouldBeDead:Bool = false;
	var boyfriendSinging:Bool = true;
	var boyfriendAgainSinging:Bool = false;
	var dadAgainSinging:Bool = false;
	var dadAnimNoInterupt:Bool = false;
	var dadSinging:Bool = true;
	var totalDamageTaken:Float = 0;
	var dialogueBoxDelta:FlxSprite;
	var removal:Float = 0;
	var addition:Float = 0;

	var amogos:FlxSprite;

	var BG2:FlxSprite;
	var BG3:FlxSprite;
	var BG4:FlxSprite;
	var FG1:FlxSprite;
	var FG2:FlxSprite;
	var FG3:FlxSprite;
	var FG4:FlxSprite;
	var railRoad:FlxSprite;
	var railRoad2:FlxSprite;
	var railRoad3:FlxSprite;
	var string1:FlxSprite;
	var string2:FlxSprite;
	var string3:FlxSprite;
	var string4:FlxSprite;
	var string5:FlxSprite;

	private var floatshit:Float = 0;

	var cloudScroll:FlxTypedGroup<FlxSprite>;
	var farClouds:FlxTypedGroup<FlxSprite>;
	var middleBuildings:Array<FlxSprite>;
	var rightBuildings:Array<FlxSprite>;
	var leftBuildings:Array<FlxSprite>;
	var fgCloud:FlxSprite;
	var speedLines:FlxBackdrop;
	var speedPass:Array<Float> = [11000, 11000, 11000, 11000];
	var farSpeedPass:Array<Float> = [11000, 11000, 11000, 11000, 11000, 11000, 11000];

	function doGremlin(hpToTake:Int, duration:Int, persist:Bool = false)
	{
		interupt = false;

		grabbed = true;

		totalDamageTaken = 0;

		var gramlan:FlxSprite = new FlxSprite(0, 0);

		gramlan.frames = Paths.getSparrowAtlas('fourth/mech/HP GREMLIN', 'shared');

		gramlan.setGraphicSize(Std.int(gramlan.width * 2));
		gramlan.updateHitbox();
		gramlan.setGraphicSize(Std.int(gramlan.width * 0.76));

		gramlan.cameras = [camHUD];

		gramlan.x = iconP1.x;
		gramlan.y = healthBarBG.y - 325;

		gramlan.animation.addByIndices('come', 'HP Gremlin ANIMATION', [0, 1], "", 24, false);
		gramlan.animation.addByIndices('grab', 'HP Gremlin ANIMATION', [
			2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24
		], "", 24, false);
		gramlan.animation.addByIndices('hold', 'HP Gremlin ANIMATION', [25, 26, 27, 28], "", 24);
		gramlan.animation.addByIndices('release', 'HP Gremlin ANIMATION', [29, 30, 31, 32, 33], "", 24, false);

		gramlan.antialiasing = true;

		add(gramlan);

		if (FlxG.save.data.downscroll)
		{
			gramlan.flipY = true;
			gramlan.y -= 150;
		}

		// over use of flxtween :)

		var startHealth = health;
		var toHealth = (hpToTake / 100) * startHealth; // simple math, convert it to a percentage then get the percentage of the health

		var perct = toHealth / 2 * 100;

		trace('start: $startHealth\nto: $toHealth\nwhich is prect: $perct');

		var onc:Bool = false;

		FlxG.sound.play(Paths.sound('fourth/GremlinWoosh', 'shared'));

		gramlan.animation.play('come');
		var tempTimer = new FlxTimer();
		tempTimer.start(0.14, function(tmr:FlxTimer)
		{
			gramlan.animation.play('grab');
			FlxTween.tween(gramlan, {x: iconP1.x - 140}, 1, {
				ease: FlxEase.elasticIn,
				onComplete: function(tween:FlxTween)
				{
					trace('I got em');
					gramlan.animation.play('hold');
					FlxTween.tween(gramlan, {
						x: (healthBar.x + (healthBar.width * (FlxMath.remapToRange(perct, 0, 100, 100, 0) * 0.01) - 26)) - 75
					}, duration, {
						onUpdate: function(tween:FlxTween)
						{
							// lerp the health so it looks pog
							if (interupt && !onc && !persist)
							{
								onc = true;
								trace('oh shit');
								gramlan.animation.play('release');
								gramlan.animation.finishCallback = function(pog:String)
								{
									gramlan.alpha = 0;
								}
							}
							else if (!interupt || persist)
							{
								var pp = FlxMath.lerp(startHealth, toHealth, tween.percent);
								if (pp <= 0)
									pp = 0.1;
								health = pp;
							}

							if (shouldBeDead)
								health = 0;
						},
						onComplete: function(tween:FlxTween)
						{
							if (interupt && !persist)
							{
								remove(gramlan);
								grabbed = false;
							}
							else
							{
								trace('oh shit');
								gramlan.animation.play('release');
								if (persist && totalDamageTaken >= 0.7)
									health -= totalDamageTaken; // just a simple if you take a lot of damage wtih this, you'll loose probably.
								gramlan.animation.finishCallback = function(pog:String)
								{
									remove(gramlan);
								}
								grabbed = false;
							}
						}
					});
				}
			});
			FlxDestroyUtil.destroy(tempTimer);
		});
	}

	var cloneOne:FlxSprite;
	var cloneTwo:FlxSprite;
	var exSpikes:FlxSprite;
	var hatSpikes:FlxSprite;
	var gremlinTimer = new FlxTimer();
	var spookyRendered:Bool = false;
	var tikturn:Bool = false;
	var hatturn:Bool = false;
	public static var roboturn:Bool = false;
	public static var roseturn:Bool = false;
	var roboasbf = false;
	var spookySteps:Int = 0;
	var tstatic:FlxSprite;
	var tStaticSound:FlxSound;
	public var ExTrickyLinesSing:Array<String> = [
		"YOU AREN'T HANK",
		"WHERE IS HANK",
		"HANK???",
		"WHO ARE YOU",
		"WHERE AM I",
		"THIS ISN'T RIGHT",
		"MIDGET",
		"SYSTEM UNRESPONSIVE",
		"WHY CAN'T I KILL?????"
	];
	public var HatKidLinesSing:Array<String> = [
		"YOU AREN'T MUSTACHE GIRL",
		"WHERE IS MUSTACHE GIRL",
		"MUSTACHE GIRL???",
		"BOOP",
		"CAT CRIME",
		"WHICH CHAPTER IS THIS",
		"IS THIS DEATHWISH???",
		"PECK",
		"I NEED TIMEPIECES",
		"WHY CAN'T I MYERDER?????"
	];
	var spinArray:Array<Int>;
	var daSection:Int = 1;
	var noDeathMode:Bool = false;

	function doClone(side:Int)
	{
		switch (side)
		{
			case 0:
				if (cloneOne.alpha == 1)
					return;
				cloneOne.x = dad.x - 20 - 250;
				cloneOne.y = dad.y + 140 - 100;
				cloneOne.alpha = 1;

				cloneOne.animation.play('clone');
				cloneOne.animation.finishCallback = function(pog:String)
				{
					cloneOne.alpha = 0;
				}
			case 1:
				if (cloneTwo.alpha == 1)
					return;
				cloneTwo.x = dad.x + 390 - 250;
				cloneTwo.y = dad.y + 140 - 100;
				cloneTwo.alpha = 1;

				cloneTwo.animation.play('clone');
				cloneTwo.animation.finishCallback = function(pog:String)
				{
					cloneTwo.alpha = 0;
				}
		}
	}


	override public function create()
	{

		projectiles = new FlxTypedGroup<Projectile>();
		boyfriendSinging = true;
		boyfriendAgainSinging = false;
		dadAgainSinging = false;
		dadSinging = true;
		dadAnimNoInterupt = false;
		tikturn = false;
		hatturn = false;
		roboturn = false;
		roboasbf = false;
		roseturn = false;
		if (SONG.song.toLowerCase() == 'endless')
			blackFuck = new FlxSprite().makeGraphic(1280,720, FlxColor.BLACK);
		else
			blackFuck = new FlxSprite().makeGraphic(1280,720, FlxColor.WHITE);
		var dumb = CoolUtil.coolTextFile(Paths.txt('dumb'));
		blackSelever = new FlxSprite(-4500, -2900).makeGraphic(10000, 10000, FlxColor.BLACK);

		startCircle = new FlxSprite();
		startText = new FlxSprite();

		if (SONG.song.toLowerCase() == 'endless') SONG.noteStyle = 'normal';
		spinArray = [272, 276, 336, 340, 400, 404, 464, 468, 528, 532, 592, 596, 656, 660, 720, 724, 789, 793, 863, 867, 937, 941, 1012, 1016, 1086, 1090, 1160, 1164, 1531, 1535, 1607, 1611, 1681, 1685, 1754, 1758];
		tstatic = new FlxSprite(0, 0).loadGraphic(Paths.image('TrickyStatic', 'shared'), true, 320, 180);
		tStaticSound = new FlxSound().loadEmbedded(Paths.sound("staticSound", "shared"));

		instance = this;
		
		if (FlxG.save.data.fpsCap > 290)
			(cast (Lib.current.getChildAt(0), Main)).setFPSCap(800);
		
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		if (!isStoryMode)
		{
			sicks = 0;
			bads = 0;
			shits = 0;
			goods = 0;

			resetSpookyText = true;
		}
		misses = 0;

		repPresses = 0;
		repReleases = 0;


		PlayStateChangeables.useDownscroll = FlxG.save.data.downscroll;
		PlayStateChangeables.safeFrames = FlxG.save.data.frames;
		PlayStateChangeables.scrollSpeed = FlxG.save.data.scrollSpeed;
		PlayStateChangeables.botPlay = FlxG.save.data.botplay;

		ExTrickyLinesSing = CoolUtil.coolTextFile(Paths.txt('trickyExSingStrings'));
		HatKidLinesSing = CoolUtil.coolTextFile(Paths.txt('HatKidSingStrings'));

		// pre lowercasing the song name (create)
		var songLowercase = StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase();
		switch (songLowercase) {
			case 'dad-battle': songLowercase = 'dadbattle';
			case 'philly-nice': songLowercase = 'philly';
		}
		
		removedVideo = false;

		#if windows
		executeModchart = FileSystem.exists(Paths.lua(songLowercase  + "/modchart"));
		#end
		#if !cpp
		executeModchart = false; // FORCE disable for non cpp targets
		#end

		trace('Mod chart: ' + executeModchart + " - " + Paths.lua(songLowercase + "/modchart"));

		#if windows
		// Making difficulty text for Discord Rich Presence.
		trace(storyDifficulty);
		switch (storyDifficulty)
		{
			case 0:
				storyDifficultyText = "Easy";
			case 1:
				storyDifficultyText = "Normal";
			case 2:
				storyDifficultyText = "Hard";
			case 3:
				storyDifficultyText = "Alt";
			case 4:
				storyDifficultyText = "Hard-alpha";
			case 5:
				storyDifficultyText = "Alt-alpha";
			case 6:
				storyDifficultyText = "Unfair";
			case 7:
				storyDifficultyText = "CHAOS";
			case 8:
				storyDifficultyText = "NEO";
		}

		iconRPC = SONG.player2;

		// To avoid having duplicate images in Discord assets
		switch (iconRPC)
		{
			case 'senpai-angry':
				iconRPC = 'senpai';
			case 'monster-christmas':
				iconRPC = 'monster';
			case 'mom-car':
				iconRPC = 'mom';
		}

		// String that contains the mode defined here so it isn't necessary to call changePresence for each mode
		if (isStoryMode)
		{
			detailsText = "Story Mode: Week " + storyWeek;
		}
		else
		{
			detailsText = "Freeplay";
		}

		// String for when the game is paused
		detailsPausedText = "Paused - " + detailsText;

		// Updating Discord Rich Presence.
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
		#end


		// var gameCam:FlxCamera = FlxG.camera;
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camHUDier = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		camHUDier.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD);
		FlxG.cameras.add(camHUDier);

		FlxCamera.defaultCameras = [camGame];

		persistentUpdate = true;
		persistentDraw = true;

		if (SONG == null)
			SONG = Song.loadFromJson('tutorial', 'tutorial');

		Conductor.mapBPMChanges(SONG);
		Conductor.changeBPM(SONG.bpm);

		trace('INFORMATION ABOUT WHAT U PLAYIN WIT:\nFRAMES: ' + PlayStateChangeables.safeFrames + '\nZONE: ' + Conductor.safeZoneOffset + '\nTS: ' + Conductor.timeScale + '\nBotPlay : ' + PlayStateChangeables.botPlay);
	
		//dialogue shit
		switch (songLowercase)
		{
			case 'tutorial':
				dialogue = ["Hey you're pretty cute.", 'Use the arrow keys to keep up \nwith me singing.'];
			case 'bopeebo':
				dialogue = [
					'HEY!',
					"You think you can just sing\nwith my daughter like that?",
					"If you want to date her...",
					"You're going to have to go \nthrough ME first!"
				];
			case 'fresh':
				dialogue = ["Not too shabby boy.", ""];
			case 'dadbattle':
				dialogue = [
					"gah you think you're hot stuff?",
					"If you can beat me here...",
					"Only then I will even CONSIDER letting you\ndate my daughter!"
				];
			case 'senpai':
				dialogue = CoolUtil.coolTextFile(Paths.txt('senpai/senpaiDialogue'));
			case 'roses':
				dialogue = CoolUtil.coolTextFile(Paths.txt('roses/rosesDialogue'));
			case 'thorns':
				dialogue = CoolUtil.coolTextFile(Paths.txt('thorns/thornsDialogue'));
			case 'gospel':
				dialogue = CoolUtil.coolTextFile(Paths.txt('gospel/gospelDialogue'));
			case 'expurgation':
				dialogue = CoolUtil.coolTextFile(Paths.txt('expurgation/expurgationDialogue'));
			case 'headache':
				dialogue = CoolUtil.coolTextFile(Paths.txt('headache/headacheDialogue'));
			case 'release':
				dialogue = CoolUtil.coolTextFile(Paths.txt('release/releasecoverdialogue'));
			case 'glitcher':
				dialogue = CoolUtil.coolTextFile(Paths.txt('glitcher/glitcherDialogue'));
			case 'endless':
				dialogue = CoolUtil.coolTextFile(Paths.txt('endless/endlessDialogue'));
			case 'ejected':
				dialogue = CoolUtil.coolTextFile(Paths.txt('ejected/ejectedDialogue'));
			case 'the-sunday-revolving':
				dialogue = CoolUtil.coolTextFile(Paths.txt('the-sunday-revolving/the-sunday-revolvingDialogue'));
			case 'big-piece':
				dialogue = CoolUtil.coolTextFile(Paths.txt('big-piece/big-pieceDialogue'));
		}

		//defaults if no stage was found in chart
		var stageCheck:String = 'stage';
		
		var cover:FlxSprite;
		var hole:FlxSprite;
		var converHole:FlxSprite;
		cover = new FlxSprite(-180, 755).loadGraphic(Paths.image('fourth/cover', 'shared'));
		hole = new FlxSprite(50, 530).loadGraphic(Paths.image('fourth/Spawnhole_Ground_BACK', 'shared'));
		converHole = new FlxSprite(7, 578).loadGraphic(Paths.image('fourth/Spawnhole_Ground_COVER', 'shared'));

		if (SONG.stage == null) {
			switch(storyWeek)
			{
				case 2: stageCheck = 'halloween';
				case 3: stageCheck = 'philly';
				case 4: stageCheck = 'limo';
				case 5: if (songLowercase == 'winter-horrorland') {stageCheck = 'mallEvil';} else {stageCheck = 'mall';}
				case 6: if (songLowercase == 'thorns') {stageCheck = 'schoolEvil';} else {stageCheck = 'school';}
				//i should check if its stage (but this is when none is found in chart anyway)
			}
		} else {stageCheck = SONG.stage;}

		if (stageCheck != 'spamton')
		{
			dad = new Character(100, 100, SONG.player2);
		}
		else
		{
			dad = new Character(500, 30, SONG.player2);
		}
		dadAgain = new Character(100, 100, SONG.player2);
		dadAgain2 = new Character(100, 100, SONG.player2);
		dadAgain3 = new Character(100, 100, SONG.player2);
		hatkid = new Character(100, 100, 'hat-kid');
		lol86 = new Character(100, 100, '86lol');

		//defaults if no gf was found in chart
		var gfCheck:String = 'gf';
		
		if (SONG.gfVersion == null) {
			switch(storyWeek)
			{
				case 4: gfCheck = 'gf-car';
				case 5: gfCheck = 'gf-christmas';
				case 6: gfCheck = 'gf-pixel';
			}
		} else {gfCheck = SONG.gfVersion;}

		var curGf:String = '';
		switch (gfCheck)
		{
			case 'gf-car':
				curGf = 'gf-car';
			case 'gf-christmas':
				curGf = 'gf-christmas';
			case 'gf-pixel':
				curGf = 'gf-pixel';
			case 'robo-gf':
				curGf = 'robo-gf';
			case 'robo-gf-no-speakers':
				curGf = 'robo-gf-no-speakers';
			case 'ROBO-TIKY':
				curGf = 'ROBO-TIKY';
			case 'robo-gf-night':
				curGf = 'robo-gf-night';
			case 'robo-gf-404':
				curGf = 'robo-gf-404';
			case 'roboparachute':
				curGf = 'roboparachute';
			default:
				curGf = 'gf';
		}

		gf = new Character(400, 130, curGf);

		if (curSong == 'Ejected')
		{
			gf.scrollFactor.set(0.7, 0.7);
		}
		else
			gf.scrollFactor.set(0.95, 0.95);

		if (stageCheck != 'spamton')
		{
			boyfriend = new Boyfriend(770, 450, SONG.player1);
		}
		else
		{
			boyfriend = new Boyfriend(-300, 170, SONG.player1);
		}
		boyfriendAgain = new Boyfriend(770, 450, SONG.player1);

		switch(stageCheck)
		{
			case 'halloween': 
			{
				curStage = 'spooky';
				halloweenLevel = true;

				var hallowTex = Paths.getSparrowAtlas('halloween_bg','week2');

				halloweenBG = new FlxSprite(-200, -100);
				halloweenBG.frames = hallowTex;
				halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
				halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
				halloweenBG.animation.play('idle');
				halloweenBG.antialiasing = true;
				add(halloweenBG);

				isHalloween = true;
			}
			case 'philly': 
			{
				curStage = 'philly';

				var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('philly/sky', 'week3'));
				bg.scrollFactor.set(0.1, 0.1);
				add(bg);

				var city:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('philly/city', 'week3'));
				city.scrollFactor.set(0.3, 0.3);
				city.setGraphicSize(Std.int(city.width * 0.85));
				city.updateHitbox();
				add(city);

				phillyCityLights = new FlxTypedGroup<FlxSprite>();
				if(FlxG.save.data.distractions){
					add(phillyCityLights);
				}

				for (i in 0...5)
				{
						var light:FlxSprite = new FlxSprite(city.x).loadGraphic(Paths.image('philly/win' + i, 'week3'));
						light.scrollFactor.set(0.3, 0.3);
						light.visible = false;
						light.setGraphicSize(Std.int(light.width * 0.85));
						light.updateHitbox();
						light.antialiasing = true;
						phillyCityLights.add(light);
				}

				var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('philly/behindTrain','week3'));
				add(streetBehind);

				phillyTrain = new FlxSprite(2000, 360).loadGraphic(Paths.image('philly/train','week3'));
				if(FlxG.save.data.distractions){
					add(phillyTrain);
				}

				trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes','week3'));
				FlxG.sound.list.add(trainSound);

				// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);

				var street:FlxSprite = new FlxSprite(-40, streetBehind.y).loadGraphic(Paths.image('philly/street','week3'));
				add(street);
			}
			case 'limo':
			{
					curStage = 'limo';
					defaultCamZoom = 0.90;

					var skyBG:FlxSprite = new FlxSprite(-120, -50).loadGraphic(Paths.image('limo/limoSunset','week4'));
					skyBG.scrollFactor.set(0.1, 0.1);
					add(skyBG);

					var bgLimo:FlxSprite = new FlxSprite(-200, 480);
					bgLimo.frames = Paths.getSparrowAtlas('limo/bgLimo','week4');
					bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
					bgLimo.animation.play('drive');
					bgLimo.scrollFactor.set(0.4, 0.4);
					add(bgLimo);
					if(FlxG.save.data.distractions){
						grpLimoDancers = new FlxTypedGroup<BackgroundDancer>();
						add(grpLimoDancers);
	
						for (i in 0...5)
						{
								var dancer:BackgroundDancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
								dancer.scrollFactor.set(0.4, 0.4);
								grpLimoDancers.add(dancer);
						}
					}

					var overlayShit:FlxSprite = new FlxSprite(-500, -600).loadGraphic(Paths.image('limo/limoOverlay','week4'));
					overlayShit.alpha = 0.5;
					// add(overlayShit);

					// var shaderBullshit = new BlendModeEffect(new OverlayShader(), FlxColor.RED);

					// FlxG.camera.setFilters([new ShaderFilter(cast shaderBullshit.shader)]);

					// overlayShit.shader = shaderBullshit;

					var limoTex = Paths.getSparrowAtlas('limo/limoDrive','week4');

					limo = new FlxSprite(-120, 550);
					limo.frames = limoTex;
					limo.animation.addByPrefix('drive', "Limo stage", 24);
					limo.animation.play('drive');
					limo.antialiasing = true;

					fastCar = new FlxSprite(-300, 160).loadGraphic(Paths.image('limo/fastCarLol','week4'));
					// add(limo);
			}
			case 'mall':
			{
					curStage = 'mall';

					defaultCamZoom = 0.80;

					var bg:FlxSprite = new FlxSprite(-1000, -500).loadGraphic(Paths.image('christmas/bgWalls','week5'));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.2, 0.2);
					bg.active = false;
					bg.setGraphicSize(Std.int(bg.width * 0.8));
					bg.updateHitbox();
					add(bg);

					upperBoppers = new FlxSprite(-240, -90);
					upperBoppers.frames = Paths.getSparrowAtlas('christmas/upperBop','week5');
					upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
					upperBoppers.antialiasing = true;
					upperBoppers.scrollFactor.set(0.33, 0.33);
					upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 0.85));
					upperBoppers.updateHitbox();
					if(FlxG.save.data.distractions){
						add(upperBoppers);
					}


					var bgEscalator:FlxSprite = new FlxSprite(-1100, -600).loadGraphic(Paths.image('christmas/bgEscalator','week5'));
					bgEscalator.antialiasing = true;
					bgEscalator.scrollFactor.set(0.3, 0.3);
					bgEscalator.active = false;
					bgEscalator.setGraphicSize(Std.int(bgEscalator.width * 0.9));
					bgEscalator.updateHitbox();
					add(bgEscalator);

					var tree:FlxSprite = new FlxSprite(370, -250).loadGraphic(Paths.image('christmas/christmasTree','week5'));
					tree.antialiasing = true;
					tree.scrollFactor.set(0.40, 0.40);
					add(tree);

					bottomBoppers = new FlxSprite(-300, 140);
					bottomBoppers.frames = Paths.getSparrowAtlas('christmas/bottomBop','week5');
					bottomBoppers.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
					bottomBoppers.antialiasing = true;
					bottomBoppers.scrollFactor.set(0.9, 0.9);
					bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
					bottomBoppers.updateHitbox();
					if(FlxG.save.data.distractions){
						add(bottomBoppers);
					}


					var fgSnow:FlxSprite = new FlxSprite(-600, 700).loadGraphic(Paths.image('christmas/fgSnow','week5'));
					fgSnow.active = false;
					fgSnow.antialiasing = true;
					add(fgSnow);

					santa = new FlxSprite(-840, 150);
					santa.frames = Paths.getSparrowAtlas('christmas/santa','week5');
					santa.animation.addByPrefix('idle', 'santa idle in fear', 24, false);
					santa.antialiasing = true;
					if(FlxG.save.data.distractions){
						add(santa);
					}
			}
			case 'mallEvil':
			{
					curStage = 'mallEvil';
					var bg:FlxSprite = new FlxSprite(-400, -500).loadGraphic(Paths.image('christmas/evilBG','week5'));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.2, 0.2);
					bg.active = false;
					bg.setGraphicSize(Std.int(bg.width * 0.8));
					bg.updateHitbox();
					add(bg);

					var evilTree:FlxSprite = new FlxSprite(300, -300).loadGraphic(Paths.image('christmas/evilTree','week5'));
					evilTree.antialiasing = true;
					evilTree.scrollFactor.set(0.2, 0.2);
					add(evilTree);

					var evilSnow:FlxSprite = new FlxSprite(-200, 700).loadGraphic(Paths.image("christmas/evilSnow",'week5'));
						evilSnow.antialiasing = true;
					add(evilSnow);
					}
			case 'school':
			{
					curStage = 'school';

					// defaultCamZoom = 0.9;

					var bgSky = new FlxSprite().loadGraphic(Paths.image('weeb/weebSky','week6'));
					bgSky.scrollFactor.set(0.1, 0.1);
					add(bgSky);

					var repositionShit = -200;

					var bgSchool:FlxSprite = new FlxSprite(repositionShit, 0).loadGraphic(Paths.image('weeb/weebSchool','week6'));
					bgSchool.scrollFactor.set(0.6, 0.90);
					add(bgSchool);

					var bgStreet:FlxSprite = new FlxSprite(repositionShit).loadGraphic(Paths.image('weeb/weebStreet','week6'));
					bgStreet.scrollFactor.set(0.95, 0.95);
					add(bgStreet);

					var fgTrees:FlxSprite = new FlxSprite(repositionShit + 170, 130).loadGraphic(Paths.image('weeb/weebTreesBack','week6'));
					fgTrees.scrollFactor.set(0.9, 0.9);
					add(fgTrees);

					var bgTrees:FlxSprite = new FlxSprite(repositionShit - 380, -800);
					var treetex = Paths.getPackerAtlas('weeb/weebTrees','week6');
					bgTrees.frames = treetex;
					bgTrees.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
					bgTrees.animation.play('treeLoop');
					bgTrees.scrollFactor.set(0.85, 0.85);
					add(bgTrees);

					var treeLeaves:FlxSprite = new FlxSprite(repositionShit, -40);
					treeLeaves.frames = Paths.getSparrowAtlas('weeb/petals','week6');
					treeLeaves.animation.addByPrefix('leaves', 'PETALS ALL', 24, true);
					treeLeaves.animation.play('leaves');
					treeLeaves.scrollFactor.set(0.85, 0.85);
					add(treeLeaves);

					var widShit = Std.int(bgSky.width * 6);

					bgSky.setGraphicSize(widShit);
					bgSchool.setGraphicSize(widShit);
					bgStreet.setGraphicSize(widShit);
					bgTrees.setGraphicSize(Std.int(widShit * 1.4));
					fgTrees.setGraphicSize(Std.int(widShit * 0.8));
					treeLeaves.setGraphicSize(widShit);

					fgTrees.updateHitbox();
					bgSky.updateHitbox();
					bgSchool.updateHitbox();
					bgStreet.updateHitbox();
					bgTrees.updateHitbox();
					treeLeaves.updateHitbox();

					bgGirls = new BackgroundGirls(-100, 190);
					bgGirls.scrollFactor.set(0.9, 0.9);

					if (songLowercase == 'roses')
						{
							if(FlxG.save.data.distractions){
								bgGirls.getScared();
							}
						}

					bgGirls.setGraphicSize(Std.int(bgGirls.width * daPixelZoom));
					bgGirls.updateHitbox();
					if(FlxG.save.data.distractions){
						add(bgGirls);
					}
			}
			case 'schoolEvil':
			{
					curStage = 'schoolEvil';

					var waveEffectBG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 3, 2);
					var waveEffectFG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 5, 2);

					var posX = 400;
					var posY = 200;

					var bg:FlxSprite = new FlxSprite(posX, posY);
					bg.frames = Paths.getSparrowAtlas('weeb/animatedEvilSchool','week6');
					bg.animation.addByPrefix('idle', 'background 2', 24);
					bg.animation.play('idle');
					bg.scrollFactor.set(0.8, 0.9);
					bg.scale.set(6, 6);
					add(bg);

					/* 
							var bg:FlxSprite = new FlxSprite(posX, posY).loadGraphic(Paths.image('weeb/evilSchoolBG'));
							bg.scale.set(6, 6);
							// bg.setGraphicSize(Std.int(bg.width * 6));
							// bg.updateHitbox();
							add(bg);
							var fg:FlxSprite = new FlxSprite(posX, posY).loadGraphic(Paths.image('weeb/evilSchoolFG'));
							fg.scale.set(6, 6);
							// fg.setGraphicSize(Std.int(fg.width * 6));
							// fg.updateHitbox();
							add(fg);
							wiggleShit.effectType = WiggleEffectType.DREAMY;
							wiggleShit.waveAmplitude = 0.01;
							wiggleShit.waveFrequency = 60;
							wiggleShit.waveSpeed = 0.8;
						*/

					// bg.shader = wiggleShit.shader;
					// fg.shader = wiggleShit.shader;

					/* 
								var waveSprite = new FlxEffectSprite(bg, [waveEffectBG]);
								var waveSpriteFG = new FlxEffectSprite(fg, [waveEffectFG]);
								// Using scale since setGraphicSize() doesnt work???
								waveSprite.scale.set(6, 6);
								waveSpriteFG.scale.set(6, 6);
								waveSprite.setPosition(posX, posY);
								waveSpriteFG.setPosition(posX, posY);
								waveSprite.scrollFactor.set(0.7, 0.8);
								waveSpriteFG.scrollFactor.set(0.9, 0.8);
								// waveSprite.setGraphicSize(Std.int(waveSprite.width * 6));
								// waveSprite.updateHitbox();
								// waveSpriteFG.setGraphicSize(Std.int(fg.width * 6));
								// waveSpriteFG.updateHitbox();
								add(waveSprite);
								add(waveSpriteFG);
						*/
			}
			case 'stage':
				{
						defaultCamZoom = 0.9;
						curStage = 'stage';
						var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
						bg.antialiasing = true;
						bg.scrollFactor.set(0.9, 0.9);
						bg.active = false;
						add(bg);
	
						var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
						stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
						stageFront.updateHitbox();
						stageFront.antialiasing = true;
						stageFront.scrollFactor.set(0.9, 0.9);
						stageFront.active = false;
						add(stageFront);
	
						var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
						stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
						stageCurtains.updateHitbox();
						stageCurtains.antialiasing = true;
						stageCurtains.scrollFactor.set(1.3, 1.3);
						stageCurtains.active = false;
	
						add(stageCurtains);
				}
			case 'pegmeplease':
			{
					defaultCamZoom = 0.9;
					curStage = 'pegmeplease';

					var stageFront:FlxSprite = new FlxSprite(-400, 0).loadGraphic(Paths.image('church/floor'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.2));
					stageFront.updateHitbox();
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(1, 1);
					stageFront.active = false;
					add(stageFront);

					var bg:FlxSprite = new FlxSprite(-400, -200).loadGraphic(Paths.image('church/bg'));
					bg.setGraphicSize(Std.int(stageFront.width * 1.2));
					bg.updateHitbox();
					bg.antialiasing = true;
					bg.scrollFactor.set(0.9, 1);
					bg.active = false;
					add(bg);

					var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('church/pillars'));
					stageCurtains.setGraphicSize(Std.int(stageFront.width * 1.2));
					stageCurtains.updateHitbox();
					stageCurtains.antialiasing = true;
					stageCurtains.scrollFactor.set(0.9, 1);
					stageCurtains.active = false;
					add(stageCurtains);

					var circ0:FlxSprite = new FlxSprite(-400, -300).loadGraphic(Paths.image('church/circ0'));
					circ0.setGraphicSize(Std.int(stageFront.width * 1.2));
					circ0.updateHitbox();
					circ0.antialiasing = true;
					circ0.scrollFactor.set(0.9, 1);
					circ0.active = false;
					add(circ0);

					circ2 = new FlxSprite(-400, -375).loadGraphic(Paths.image('church/circ1'));
					circ2.setGraphicSize(Std.int(stageFront.width * 1.2));
					circ2.updateHitbox();
					circ2.origin.set(989,659);
					circ2.antialiasing = true;
					circ2.scrollFactor.set(0.9, 1);
					circ2.active = false;
					add(circ2);

					circ1 = new FlxSprite(-400, -375).loadGraphic(Paths.image('church/circ2'));
					circ1.setGraphicSize(Std.int(stageFront.width * 1.2));
					circ1.updateHitbox();
					circ1.origin.set(989,659);
					circ1.antialiasing = true;
					circ1.scrollFactor.set(0.9, 1);
					circ1.active = false;
					add(circ1);
			}
			case 'auditorHell':
			{
				defaultCamZoom = 0.55;
				curStage = 'auditorHell';
	
				tstatic.scrollFactor.set(0, 0);
				tstatic.setGraphicSize(Std.int(tstatic.width * 8.3));
				tstatic.animation.add('static', [0, 1, 2], 24, true);
				tstatic.animation.play('static');
	
				tstatic.alpha = 0;
	
				var bg:FlxSprite = new FlxSprite(-10, -10).loadGraphic(Paths.image('fourth/bg', 'shared'));
				bg.antialiasing = true;
				bg.scrollFactor.set(0.9, 0.9);
				bg.active = false;
				bg.setGraphicSize(Std.int(bg.width * 2));
				bg.updateHitbox();
				bg.setGraphicSize(Std.int(bg.width * 4));
				bg.graphic.dump();
				add(bg);
	
				hole.scrollFactor.set(0.9, 0.9);
				hole.setGraphicSize(Std.int(hole.width * 2));
				hole.updateHitbox();
				hole.graphic.dump();
	
				converHole.scrollFactor.set(0.9, 0.9);
				converHole.setGraphicSize(Std.int(converHole.width * 2));
				converHole.updateHitbox();
				converHole.setGraphicSize(Std.int(converHole.width * 1.3));
				hole.setGraphicSize(Std.int(hole.width * 1.55));
				converHole.graphic.dump();
	
				cover.scrollFactor.set(0.9, 0.9);
				cover.setGraphicSize(Std.int(cover.width * 2));
				cover.updateHitbox();
				cover.setGraphicSize(Std.int(cover.width * 1.55));
				cover.graphic.dump();
	
				var energyWall:FlxSprite = new FlxSprite(1350, -690).loadGraphic(Paths.image("fourth/Energywall", "shared"));
				energyWall.setGraphicSize(Std.int(energyWall.width * 2));
				energyWall.updateHitbox();
				energyWall.scrollFactor.set(0.9, 0.9);
				energyWall.graphic.dump();
				add(energyWall);
	
				var stageFront:FlxSprite = new FlxSprite(-350, -355).loadGraphic(Paths.image('fourth/daBackground', 'shared'));
				stageFront.scrollFactor.set(0.9, 0.9);
				stageFront.setGraphicSize(Std.int(stageFront.width * 2));
				stageFront.updateHitbox();
				stageFront.setGraphicSize(Std.int(stageFront.width * 1.55));
				stageFront.graphic.dump();
				add(stageFront);
				add(hole);
				// Clown init
				cloneOne = new FlxSprite(0, 0);
				cloneTwo = new FlxSprite(0, 0);
				var cloneframes = Paths.getSparrowAtlas('fourth/Clone', 'shared');
				cloneOne.frames = cloneframes;
				cloneTwo.frames = cloneframes;
				cloneOne.setGraphicSize(Std.int(cloneOne.width * 2));
				cloneOne.updateHitbox();
				cloneTwo.setGraphicSize(Std.int(cloneTwo.width * 2));
				cloneTwo.updateHitbox();
				cloneOne.alpha = 0;
				cloneTwo.alpha = 0;
				cloneOne.animation.addByPrefix('clone', 'Clone', 24, false);
				cloneTwo.animation.addByPrefix('clone', 'Clone', 24, false);
				add(hatkid);
				add(gf);
				add(lol86);
				add(dad);
				hatkid.y = dad.y;
				hatkid.x = dad.x + 600;
				// cover crap
				add(cloneOne);
				cloneOne.graphic.dump();
				add(cloneTwo);
				cloneTwo.graphic.dump();
				
				exSpikes = new FlxSprite(dad.x - 350,dad.y - 170);
				exSpikes.frames = Paths.getSparrowAtlas('fourth/FloorSpikes','shared');
				exSpikes.visible = false;
				exSpikes.setGraphicSize(Std.int(exSpikes.width * 2));
				exSpikes.updateHitbox();

				exSpikes.animation.addByPrefix('spike','Floor Spikes', 24, false);
				add(exSpikes);
				hatSpikes = new FlxSprite(hatkid.x - 130, hatkid.y - 200);
				hatSpikes.frames = Paths.getSparrowAtlas('fourth/Floor','shared');
				hatSpikes.visible = false;
				hatSpikes.updateHitbox();

				hatSpikes.animation.addByPrefix('spike','Floor Spikes', 24, false);
				add(hatSpikes);
				add(cover);
				add(converHole);
				add(boyfriend);
				tstatic.alpha = 0.1;
				tstatic.setGraphicSize(Std.int(tstatic.width * 12));
				tstatic.x += 600;
			}
			case 'garAlley':
			{
				defaultCamZoom = 0.9;
				curStage = 'garAlley';

				var images = ['Zardy', 'HATKID_HATTED', 'HEX', 'tord_assets', 'RON', 'sunday_assets', 'monsterAnnie', 'TANKMAN', 'tricky', 'LavPhase1', 'spooky_kids_assets', 'KAPI', 'rebecca_asset4', 'Pico_FNF_assetss', 'cass', 'TABI', 'AGOTI', 'HD_SENPAI', 'HD_MONIKA', 'bob_asset', 'OPHEEBOP', 'sarvente_sheet', 'ruv_sheet', 'qt-kb', 'WHITTY', 'CAROL'];
		
				trace("caching images...");
		
				for (i in images)
				{
					FlxG.bitmap.add(Paths.image("characters/" + i,"shared"));
					trace("cached " + i);
				}

				var bg:FlxSprite = new FlxSprite(-500, -170).loadGraphic(Paths.image('garStagebg'));
				bg.antialiasing = true;
				bg.scrollFactor.set(0.7, 0.7);
				bg.active = false;
				add(bg);

				var bgAlley:FlxSprite = new FlxSprite(-500, -200).loadGraphic(Paths.image('garStage'));
				bgAlley.antialiasing = true;
				bgAlley.scrollFactor.set(0.9, 0.9);
				bgAlley.active = false;
				add(bgAlley);

				/*var dadarray = ['zardy', 'hat-kid-hatted', 'hex', 'tord', 'ron', 'sky-mad', 'monster-annie', 'tankman', 'tricky', 'lav', 'spooky', 'kapi', 'rebecca4', 'pico', 'cass', 'tabi', 'agoti', 'HD_senpai', 'HD_monika', 'bob', 'opheebop', 'sarv', 'ruv', 'qt-kb', 'whitty', 'carol'];
				for (i in dadarray)
				{
					var dadder = new Character(100, 100, i);
					add(dadder);
					trace("added " + i);
				}*/
			}
			case 'heaven':
				{
					FlxG.bitmap.add(Paths.image("characters/PizzaMan"));
					defaultCamZoom = 0.9;
					curStage = 'heaven';

					var bg:FlxSprite = new FlxSprite(-250, -300).loadGraphic(Paths.image('heaven'));
					bg.antialiasing = true;
					bg.setGraphicSize(Std.int(bg.width * 1.2));
					bg.updateHitbox();
					bg.scrollFactor.set(0.7, 0.7);
					bg.active = false;
					add(bg);

					amogos = new FlxSprite(-250, -300).loadGraphic(Paths.image('amogos'));
					amogos.antialiasing = true;
					amogos.setGraphicSize(Std.int(amogos.width * 1.2));
					amogos.updateHitbox();
					amogos.scrollFactor.set(0.7, 0.7);
					amogos.alpha = 0;
					add(amogos);

			  }
			case 'hex-night':
			{
					defaultCamZoom = 0.8;
					curStage = 'hex-night';
					FlxG.bitmap.add(Paths.image("hex/streetError"));
					FlxG.bitmap.add(Paths.image("hex/stagefrontError"));
					FlxG.bitmap.add(Paths.image("characters/qt-kb-404"));
					FlxG.bitmap.add(Paths.image("characters/BOYFRIEND_404"));
					FlxG.bitmap.add(Paths.image("characters/ROBO_assets-404"));

					BG2 = new FlxSprite(-600, -200).loadGraphic(Paths.image('hex/stageback'));
					BG2.antialiasing = true;
					BG2.scrollFactor.set(0.9, 0.9);
					BG2.active = false;
					add(BG2);

					var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('hex/stagefrontError'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
					stageFront.updateHitbox();
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.active = false;
					add(stageFront);

					BG3 = new FlxSprite(-650, 600).loadGraphic(Paths.image('hex/stagefront'));
					BG3.setGraphicSize(Std.int(BG3.width * 1.1));
					BG3.updateHitbox();
					BG3.antialiasing = true;
					BG3.scrollFactor.set(0.9, 0.9);
					BG3.active = false;
					add(BG3);

					qt_tv01 = new FlxSprite();
					qt_tv01.frames = Paths.getSparrowAtlas('hex/TV_V4');
					qt_tv01.animation.addByPrefix('idle', 'TV_Idle', 24, true);
					qt_tv01.animation.addByPrefix('error', 'TV_Error', 24, true);
					qt_tv01.animation.addByPrefix('idle', 'TV_Idle', 24, true);
					qt_tv01.animation.addByPrefix('eye', 'TV_eyes', 24, true);
					qt_tv01.animation.addByPrefix('eyeRight', 'TV_eyeRight', 24, true);
					qt_tv01.animation.addByPrefix('eyeLeft', 'TV_eyeLeft', 24, true);
					qt_tv01.animation.addByPrefix('error', 'TV_Error', 24, true);	
					qt_tv01.animation.addByPrefix('404', 'TV_Bluescreen', 24, true);		
					qt_tv01.animation.addByPrefix('alert', 'TV_Attention', 36, false);		
					qt_tv01.animation.addByPrefix('watch', 'TV_Watchout', 24, true);
					qt_tv01.animation.addByPrefix('drop', 'TV_Drop', 24, true);
					qt_tv01.animation.addByPrefix('sus', 'TV_sus', 24, true);
					qt_tv01.animation.addByPrefix('instructions', 'TV_Instructions', 24, true);
					qt_tv01.animation.addByPrefix('gl', 'TV_GoodLuck', 24, true);
					qt_tv01.animation.addByPrefix('heart', 'TV_End', 24, false);
						
					qt_tv01.setPosition(-62, 540);
					qt_tv01.setGraphicSize(Std.int(qt_tv01.width * 1.2));
					qt_tv01.updateHitbox();
					qt_tv01.antialiasing = true;
					qt_tv01.scrollFactor.set(0.89, 0.89);
					add(qt_tv01);
					
					qt_tv01.animation.play('idle');

					kb_attack_alert = new FlxSprite();
					kb_attack_alert.frames = Paths.getSparrowAtlas('hex/attack_alert');
					kb_attack_alert.animation.addByPrefix('alert', 'kb_attack_animation_alert', 24, false);	
					kb_attack_alert.antialiasing = true;
					kb_attack_alert.setGraphicSize(Std.int(kb_attack_alert.width * 1.5));
					kb_attack_alert.cameras = [camHUD];
					kb_attack_alert.x = FlxG.width - 700;
					kb_attack_alert.y = 205; //Placeholder, change this to start already hidden or whatever.
					kb_attack_alert.animation.play("alert");
					kb_attack_alert.screenCenter();
	
					//Saw that one coming!
					kb_attack_saw = new FlxSprite();
					kb_attack_saw.frames = Paths.getSparrowAtlas('hex/attackv6');
					kb_attack_saw.animation.addByPrefix('fire', 'kb_attack_animation_fire', 24, false);	
					kb_attack_saw.animation.addByPrefix('prepare', 'kb_attack_animation_prepare', 24, false);	
					kb_attack_saw.setGraphicSize(Std.int(kb_attack_saw.width * 1.15));
					kb_attack_saw.antialiasing = true;
					kb_attack_saw.setPosition(2000, -1150);
					kb_attack_saw.angle += 135;
			}

			case 'sonicfunStage':
			{
					defaultCamZoom = 0.9;

					var images = ['sarvente_sheet', 'ruv_sheet', 'taki', 'cesar', 'TANKMAN', 'Worriedbob', 'bosip_assets', 'annie', 'garcello_assets', 'TABI', 'exGf', 'cass', 'nene', 'HCcarol_assets', 'WhittyCrazy', 'HATKID_HATTED', 'HD_MONIKA', 'Nonsense_God', 'qt-kb', 'OPHEEBOP', 'bob_asset', 'matt_assets', 'HD_SPIRIT', 'anchorAssets', 'roroAssets'];
			
					trace("caching images...");
			
					for (i in images)
					{
						FlxG.bitmap.add(Paths.image("characters/" + i,"shared"));
						trace("cached " + i);
					}
					FlxG.bitmap.add(Paths.image('fourth/EXTRICKY','shared'));
					trace("cached EXTRICKY");

					curStage = 'sonicFUNSTAGE';

					var funsky:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('FunInfiniteStage/sonicFUNsky'));
					funsky.setGraphicSize(Std.int(funsky.width * 0.9));
					funsky.antialiasing = true;
					funsky.scrollFactor.set(0.3, 0.3);
					funsky.active = false;
					add(funsky);

					var funfloor:FlxSprite = new FlxSprite(-600, -400).loadGraphic(Paths.image('FunInfiniteStage/sonicFUNfloor'));
					funfloor.setGraphicSize(Std.int(funfloor.width * 0.9), Std.int(funfloor.height * 1.2));
					funfloor.antialiasing = true;
					funfloor.scrollFactor.set(0.5, 0.5);
					funfloor.active = false;
					add(funfloor);

					var funpillars3:FlxSprite = new FlxSprite(-600, -0).loadGraphic(Paths.image('FunInfiniteStage/sonicFUNpillars3'));
					funpillars3.setGraphicSize(Std.int(funpillars3.width * 0.7));
					funpillars3.antialiasing = true;
					funpillars3.scrollFactor.set(0.6, 0.7);
					funpillars3.active = false;
					add(funpillars3);

					var funpillars2:FlxSprite = new FlxSprite(-600, -0).loadGraphic(Paths.image('FunInfiniteStage/sonicFUNpillars2'));
					funpillars2.setGraphicSize(Std.int(funpillars2.width * 0.7));
					funpillars2.antialiasing = true;
					funpillars2.scrollFactor.set(0.7, 0.7);
					funpillars2.active = false;
					add(funpillars2);

					var funpillarts1ANIM:FlxSprite = new FlxSprite(-400, 0);
					funpillarts1ANIM.frames = Paths.getSparrowAtlas('FunInfiniteStage/FII_BG');
					funpillarts1ANIM.animation.addByPrefix('bumpypillar', 'sonicboppers', 24);
					funpillarts1ANIM.setGraphicSize(Std.int(funpillarts1ANIM.width * 0.7));
					funpillarts1ANIM.antialiasing = true;
					funpillarts1ANIM.scrollFactor.set(0.82, 0.82);
					add(funpillarts1ANIM);
					funpillarts1ANIM.animation.play('bumpypillar', true);
				
			}
			case 'ejected':
			{
				defaultCamZoom = 0.45;

				var images = ['bb', 'arch', 'sunday_assets', 'CAROL', 'softie', 'Monster_Assets_Soft', 'exGf', 'momCar', 'Worriedbob', 'bob_asset', 'HEX', 'WHITTY', 'liz_assets', 'NEON', 'spooky_kids_assets', 'lila', 'shaggy', 'matt', 'OPHEEBOP', 'Small_Guy', 'sayori', 'HD_MONIKA', 'Zardy', 'Cablecrow', 'henry', 'rebecca_asset', 'garcello_assets', 'annie', 'astro', 'BLANTADOS', 'chara', 'sans', 'CG5', 'sarvente_sheet', 'ruv_sheet', 'eteled2_assets', 'HATKID', 'SPINEL_FALLING_SPRITE', 'fuckboi_sheet', 'cj_assets', 'smokinhotbabe', 'ruby_assets', 'LavPhase3', 'RON', 'amorButFUNNY'];
		
				trace("caching images...");
		
				for (i in images)
				{
					FlxG.bitmap.add(Paths.image("characters/" + i,"shared"));
					trace("cached " + i);
				}

				curStage = 'ejected';
				lol86 = new Character(200, 100, 'rosefall');
				cloudScroll = new FlxTypedGroup<FlxSprite>();
				farClouds = new FlxTypedGroup<FlxSprite>();
				var sky:FlxSprite = new FlxSprite(-2372.25, -4181.7).loadGraphic(Paths.image('ejected/sky', 'shared'));
				sky.antialiasing = true;
				sky.updateHitbox();
				sky.scrollFactor.set(0, 0);			
				add(sky);

				fgCloud = new FlxSprite(-2660.4, -402).loadGraphic(Paths.image('ejected/fgClouds', 'shared'));
				fgCloud.antialiasing = true;
				fgCloud.updateHitbox();
				fgCloud.scrollFactor.set(0.2, 0.2);
				add(fgCloud);
				
				amogos = new FlxSprite(1500, 3000).loadGraphic(Paths.image('funnikid'));
				amogos.antialiasing = true;
				amogos.setGraphicSize(Std.int(amogos.width * 0.2));
				amogos.updateHitbox();
				amogos.scrollFactor.set(0.5, 0.5);
				add(amogos);

				for(i in 0...farClouds.members.length) {
					add(farClouds.members[i]);
				}
				add(farClouds);

				rightBuildings = [];
				leftBuildings = [];
				middleBuildings = [];
				for(i in 0...2) {
					var rightBuilding = new FlxSprite(1022.3, -390.45);
					rightBuilding.frames = Paths.getSparrowAtlas('ejected/buildingSheet', 'shared');
					rightBuilding.animation.addByPrefix('1', 'BuildingB1', 24, false);
					rightBuilding.animation.addByPrefix('2', 'BuildingB2', 24, false);
					rightBuilding.animation.play('1');
					rightBuilding.antialiasing = true;
					rightBuilding.updateHitbox();
					rightBuilding.scrollFactor.set(0.5, 0.5);
					add(rightBuilding);
					rightBuildings.push(rightBuilding);
				}
				
				for(i in 0...2) {
					var middleBuilding = new FlxSprite(-76.15, 1398.5);
					middleBuilding.frames = Paths.getSparrowAtlas('ejected/buildingSheet', 'shared');
					middleBuilding.animation.addByPrefix('1', 'BuildingA1', 24, false);
					middleBuilding.animation.addByPrefix('2', 'BuildingA2', 24, false);
					middleBuilding.animation.play('1');
					middleBuilding.antialiasing = true;
					middleBuilding.updateHitbox();
					middleBuilding.scrollFactor.set(0.5, 0.5);
					add(middleBuilding);
					middleBuildings.push(middleBuilding);
				}
				
				for(i in 0...2) {
					var leftBuilding = new FlxSprite(-1099.3, 7286.55);
					leftBuilding.frames = Paths.getSparrowAtlas('ejected/buildingSheet', 'shared');
					leftBuilding.animation.addByPrefix('1', 'BuildingB1', 24, false);
					leftBuilding.animation.addByPrefix('2', 'BuildingB2', 24, false);
					leftBuilding.animation.play('1');
					leftBuilding.antialiasing = true;
					leftBuilding.updateHitbox();
					leftBuilding.scrollFactor.set(0.5, 0.5);
					add(leftBuilding);
					leftBuildings.push(leftBuilding);
				}

				rightBuildings[0].y = 6803.1;
				middleBuildings[0].y = 8570.5;
				leftBuildings[0].y = 14050.2;

				for(i in 0...3) {
					//now i could add the clouds manually
					//but i wont!!! trolled
					var newCloud:FlxSprite = new FlxSprite();
					newCloud.frames = Paths.getSparrowAtlas('ejected/scrollingClouds', 'shared');
					newCloud.animation.addByPrefix('idle', 'Cloud' + i, 24, false);
					newCloud.animation.play('idle');
					newCloud.updateHitbox();
					newCloud.alpha = 1;
					
					switch(i) {
						case 0:
							newCloud.setPosition(-9.65, -224.35);
							newCloud.scrollFactor.set(0.8, 0.8);
						case 1:
							newCloud.setPosition(-1342.85, -350.45);
							newCloud.scrollFactor.set(0.6, 0.6);
						case 2:
							newCloud.setPosition(1784.65, -957.05);
							newCloud.scrollFactor.set(1.3, 1.3);
						case 3:
							newCloud.setPosition(-2217.45, -1377.65);
							newCloud.scrollFactor.set(1, 1);
					}
					cloudScroll.add(newCloud);								
				}

				for(i in 0...7) {
					var newCloud:FlxSprite = new FlxSprite();
					newCloud.frames = Paths.getSparrowAtlas('ejected/scrollingClouds', 'shared');
					newCloud.animation.addByPrefix('idle', 'Cloud' + i, 24, false);
					newCloud.animation.play('idle');
					newCloud.updateHitbox();
					newCloud.alpha = 0.5;
					
					switch(i) {
						case 0:
							newCloud.setPosition(-1308, -1039.9);
						case 1:
							newCloud.setPosition(464.3, -890.5);
						case 2:
							newCloud.setPosition(2458.45, -1085.85);
						case 3:
							newCloud.setPosition(-666.95, -172.05);
						case 4:
							newCloud.setPosition(-1616.6, 1016.95);
						case 5:
							newCloud.setPosition(1714.25, 200.45);
						case 6:
							newCloud.setPosition(-167.05, 710.25);
					}
					farClouds.add(newCloud);								
				}

				speedLines = new FlxBackdrop(Paths.image('ejected/speedLines', 'shared'), 1, 1, true, true);
				speedLines.antialiasing = true;
				speedLines.updateHitbox();
				speedLines.scrollFactor.set(1.3, 1.3);
				speedLines.alpha = 0.3;
				circSelever = new FlxSprite(-400, -375).loadGraphic(Paths.image('circ'));
				add(blackSelever);
				add(circSelever);
				blackSelever.alpha = 0;
				circSelever.alpha = 0;
				
				/*amogos = new FlxSprite(Std.parseInt(dumb[0]), Std.parseInt(dumb[1])).loadGraphic(Paths.image('amogos'));
				amogos.antialiasing = true;
				amogos.setGraphicSize(Std.int(amogos.width * 1.2));
				amogos.updateHitbox();
				amogos.scrollFactor.set(0.7, 1);
				//add(amogos);*/
			}

			case 'jevil':
			{
					defaultCamZoom = 0.9;
					curStage = 'jevil';
					BG2 = new FlxSprite(0, -100);
					BG2.frames = Paths.getSparrowAtlas('the sunday revolving/bg', 'shared');
					BG2.animation.addByPrefix('idle', 'idle', 24, true);
					BG2.animation.play('idle');
					add(BG2);
					BG2.visible = false;
					dialogueBoxDelta = new FlxSprite();
					mic = new FlxSprite();
					susie = new FlxSprite();
					ralsei = new FlxSprite();
					kris = new FlxSprite();
			}
			case 'spamton':
			{
				FlxG.bitmap.add(Paths.image("the sunday revolving/bg"));
				FlxG.bitmap.add(Paths.image("characters/MTTcarol_assets"));
				FlxG.bitmap.add(Paths.image("characters/dummy_miku_assets"));
				FlxG.bitmap.add(Paths.image("characters/CHAOS_sunday"));
				FlxG.bitmap.add(Paths.image('the sunday revolving/DELTARUNE DIALOGUE BOX AND ROBO'));
				FlxG.bitmap.add(Paths.image("characters/ROBO_assets"));
				spamtonLarg = new FlxSprite(1200 , 50); // go to 600 170
				spamtonLargJaw = new FlxSprite(-140 , 200 + 140);
				spamtonLargHead = new FlxSprite(-140 , 200 + 140);
				defaultCamZoom = 0.9;
				BG2 = new FlxSprite(50, 40).loadGraphic(Paths.image('spamton/Background'));
				BG2.setGraphicSize(Std.int(BG2.width * 4));
				BG2.antialiasing = false;
				BG2.scrollFactor.set(1, 1);
				BG2.active = false;
				add(BG2);
				BG3 = new FlxSprite(BG2.x + BG2.width, 40).loadGraphic(Paths.image('spamton/Background'));
				BG3.setGraphicSize(Std.int(BG2.width * 4));
				BG3.antialiasing = false;
				BG3.scrollFactor.set(1, 1);
				BG3.active = false;
				add(BG3);
				BG4 = new FlxSprite(-387, -100);
				BG4.frames = Paths.getSparrowAtlas('the sunday revolving/bg', 'shared');
				BG4.animation.addByPrefix('idle', 'idle', 24, true);
				BG4.animation.play('idle');
				add(BG4);
				BG4.visible = false;
				FG1 = new FlxSprite(50, 40).loadGraphic(Paths.image('spamton/Foreground'));
				FG1.setGraphicSize(Std.int(BG2.width * 4));
				FG1.antialiasing = false;
				FG1.scrollFactor.set(1, 1);
				FG1.active = false;
				add(FG1);
				FG2 = new FlxSprite(BG2.x + BG2.width, 40).loadGraphic(Paths.image('spamton/Foreground'));
				FG2.setGraphicSize(Std.int(BG2.width * 4));
				FG2.antialiasing = false;
				FG2.scrollFactor.set(1, 1);
				FG2.active = false;
				add(FG2);
				FG3 = new FlxSprite(50, 40).loadGraphic(Paths.image('spamton/Foreground 2'));
				FG3.setGraphicSize(Std.int(BG2.width * 4));
				FG3.antialiasing = false;
				FG3.scrollFactor.set(1, 1);
				FG3.active = false;
				add(FG3);
				FG4 = new FlxSprite(BG2.x + BG2.width, 40).loadGraphic(Paths.image('spamton/Foreground 2'));
				FG4.setGraphicSize(Std.int(BG2.width * 4));
				FG4.antialiasing = false;
				FG4.scrollFactor.set(1, 1);
				FG4.active = false;
				add(FG4);
				curStage = 'spamton';
				var rail = Paths.getSparrowAtlas('spamton/rail');
				railRoad = new FlxSprite(320 , 200);
				railRoad.frames = rail;
				railRoad.animation.addByPrefix('idle', 'rail idle', 24);
				railRoad.animation.play('idle');
				railRoad.antialiasing = false;
				railRoad.setGraphicSize(Std.int(railRoad.width * 3));
				add(railRoad);
				railRoad2 = new FlxSprite(320 , 200 + 140);
				railRoad2.frames = rail;
				railRoad2.animation.addByPrefix('idle', 'rail idle', 24);
				railRoad2.animation.play('idle');
				railRoad2.antialiasing = false;
				railRoad2.setGraphicSize(Std.int(railRoad2.width * 3));
				add(railRoad2);
				railRoad3 = new FlxSprite(320 , 200 + 280);
				railRoad3.frames = rail;
				railRoad3.animation.addByPrefix('idle', 'rail idle', 24);
				railRoad3.animation.play('idle');
				railRoad3.antialiasing = false;
				railRoad3.setGraphicSize(Std.int(railRoad3.width * 3));
				add(railRoad3);
				spamtonCartThing = new FlxSprite(-175 , 200 + 140).loadGraphic(Paths.image('spamton/cart 2'));
				spamtonCartThing.setGraphicSize(Std.int(spamtonCartThing.width * 4));
				add(spamtonCartThing);
				spamtonCartThing2 = new FlxSprite(-175 , 200 + 280).loadGraphic(Paths.image('spamton/cart 2'));
				spamtonCartThing2.setGraphicSize(Std.int(spamtonCartThing2.width * 4));
				add(spamtonCartThing2);
				spamtonCart2 = new FlxSprite(-140 , 200 + 280).loadGraphic(Paths.image('spamton/cart 1'));
				spamtonCart2.setGraphicSize(Std.int(spamtonCart2.width * 4));
				add(spamtonCart2);
				spamtonCartThing3 = new FlxSprite(-15 , 200).loadGraphic(Paths.image('spamton/cart 4'));
				spamtonCartThing3.setGraphicSize(Std.int(spamtonCartThing3.width * 4));
				add(spamtonCartThing3);
				mic = new FlxSprite();
				var bluefaceTex = Paths.getSparrowAtlas('spamton/blueface');
				var dumb = CoolUtil.coolTextFile(Paths.txt('dumb'));
				string1 = new FlxSprite(dad.x + 180,dad.y - 125).makeGraphic(3, 500, FlxColor.GREEN);
				add(string1);
				string2 = new FlxSprite(dad.x + 180,dad.y - 125).makeGraphic(3, 500, FlxColor.GREEN);
				add(string2);
				string3 = new FlxSprite(dad.x + 180,dad.y - 125).makeGraphic(3, 500, FlxColor.GREEN);
				add(string3);
				string4 = new FlxSprite(dad.x + 180,dad.y - 125).makeGraphic(3, 500, FlxColor.GREEN);
				add(string4);
				string5 = new FlxSprite(dad.x + 180,dad.y - 125).makeGraphic(3, 500, FlxColor.GREEN);
				add(string5);
				blueSpamton1 = new FlxSprite();
				blueSpamton1.frames = bluefaceTex;
				blueSpamton1.animation.addByPrefix('idle', 'blueface idle0000', 24);
				blueSpamton1.animation.addByPrefix('shoot', 'blueface idle', 12, false);
				blueSpamton1.animation.play('idle');
				blueSpamton1.antialiasing = false;
				blueSpamton1.setGraphicSize(Std.int(blueSpamton1.width * 2));
				blueSpamton2 = new FlxSprite();
				blueSpamton2.frames = bluefaceTex;
				blueSpamton2.animation.addByPrefix('idle', 'blueface idle0000', 24);
				blueSpamton2.animation.addByPrefix('shoot', 'blueface idle', 12, false);
				blueSpamton2.animation.play('idle');
				blueSpamton2.antialiasing = false;
				blueSpamton2.setGraphicSize(Std.int(blueSpamton2.width * 2));
				susie = new FlxSprite();
				ralsei = new FlxSprite();
				kris = new FlxSprite();
			}
			default:
			{
					defaultCamZoom = 0.9;
					curStage = 'stage';
					var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
					bg.antialiasing = true;
					bg.scrollFactor.set(0.9, 0.9);
					bg.active = false;
					add(bg);

					var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
					stageFront.updateHitbox();
					stageFront.antialiasing = true;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.active = false;
					add(stageFront);

					var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
					stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
					stageCurtains.updateHitbox();
					stageCurtains.antialiasing = true;
					stageCurtains.scrollFactor.set(1.3, 1.3);
					stageCurtains.active = false;

					add(stageCurtains);
			}
		}

		var camPos:FlxPoint = new FlxPoint(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);

		switch (SONG.player2)
		{
			case 'gf':
				dad.setPosition(gf.x, gf.y);
				gf.visible = false;
				if (isStoryMode)
				{
					camPos.x += 600;
					tweenCamIn();
				}

			case "spooky":
				dad.y += 200;
			case "monster":
				dad.y += 100;
			case 'monster-christmas':
				dad.y += 130;
			case 'dad':
				camPos.x += 400;
			case 'pico':
				camPos.x += 600;
				dad.y += 300;
			case 'parents-christmas':
				dad.x -= 500;
			case 'senpai':
				dad.x += 150;
				dad.y += 360;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'senpai-angry':
				dad.x += 150;
				dad.y += 360;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'spirit':
				dad.x -= 150;
				dad.y += 100;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'exTricky':
				// dad.x -= 250;
				dad.y -= 365 - 100;
				gf.x += 345 + 100;
				gf.y -= 25 - 75;
			case 'qt-kb-night':
				// dad.x -= 250;
				dad.x -= 100;
				boyfriend.y += 30;
		}

		switch (SONG.player1)
		{
			case 'ded-ron':
				boyfriend.y -= 200;
		}

		// REPOSITIONING PER STAGE
		switch (curStage)
		{
			case 'limo':
				boyfriend.y -= 220;
				boyfriend.x += 260;
				if(FlxG.save.data.distractions){
					resetFastCar();
					add(fastCar);
				}

			case 'mall':
				boyfriend.x += 200;
			case 'pegmeplease':
				boyfriend.y += 900;
				boyfriend.x += 300;
				gf.y += 700;

			case 'mallEvil':
				boyfriend.x += 320;
				dad.y -= 80;
			case 'school':
				boyfriend.x += 200;
				boyfriend.y += 220;
				gf.x += 180;
				gf.y += 300;
			case 'schoolEvil':
				if(FlxG.save.data.distractions){
				// trailArea.scrollFactor.set();
				var evilTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069);
				// evilTrail.changeValuesEnabled(false, false, false, false);
				// evilTrail.changeGraphic()
				add(evilTrail);
				// evilTrail.scrollFactor.set(1.1, 1.1);
				}


				boyfriend.x += 200;
				boyfriend.y += 220;
				gf.x += 180;
				gf.y += 300;
			case 'auditorHell':
				boyfriend.y -= 380;
				boyfriend.x += 500;
				gf.y -= 700;
				gf.x -= 300;
				lol86.x = gf.x - 80;
				lol86.y = gf.y - 385;
			case 'garAlley':
				boyfriend.x += 50;
			case 'sonicFUNSTAGE':
				boyfriend.y += 340;
				boyfriend.x += 80;
				dad.y += 450;
				gf.y += 300;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y - 200);
			case 'ejected':
				boyfriend.setPosition(1008.6, 504);
				dad.setPosition(-775.75, 274.3);
				gf.setPosition(114.4, 78.45);
			case 'jevil':
				dad.y = 275;
			case 'spamton':
				dad.x = 500;
				dad.y = 30;
				boyfriend.x = -370;
				boyfriend.y = 95;
				gf.x = -270;
				gf.y = 220;
				dad.x = 500;
		}


		// Shitty layering but whatev it works LOL
		if (curStage == 'limo')
			add(limo);

		if (!curStage.startsWith('auditorHell'))
		{
			if (curStage != 'spamton')
				add(gf);
			if(curStage == "ejected")
			{
				gf.scrollFactor.set(0.95, 0.95);
				add(lol86);
			}
			add(dad);
			if (curStage != 'spamton')
				add(boyfriend);
			if(curStage == "ejected")
			{
				for(i in 0...cloudScroll.members.length) {
					add(cloudScroll.members[i]);
				}
				add(cloudScroll);
				add(speedLines);
			}
		}

		if (curStage == 'auditorHell')
			add(tstatic);
		if (loadRep)
		{
			FlxG.watch.addQuick('rep rpesses',repPresses);
			FlxG.watch.addQuick('rep releases',repReleases);
			// FlxG.watch.addQuick('Queued',inputsQueued);

			PlayStateChangeables.useDownscroll = rep.replay.isDownscroll;
			PlayStateChangeables.safeFrames = rep.replay.sf;
			PlayStateChangeables.botPlay = true;
		}

		trace('uh ' + PlayStateChangeables.safeFrames);

		trace("SF CALC: " + Math.floor((PlayStateChangeables.safeFrames / 60) * 1000));

		var doof:DialogueBox = new DialogueBox(false, dialogue);
		var doofus:DialogueBoxNormal = new DialogueBoxNormal(false, dialogue);
		// doof.x += 70;
		// doof.y = FlxG.height * 0.5;
		doof.scrollFactor.set();
		doof.finishThing = startCountdown;
		doofus.scrollFactor.set();
		doofus.finishThing = startCountdown;

		Conductor.songPosition = -5000;
		
		strumLine = new FlxSprite(0, 50).makeGraphic(FlxG.width, 10);
		strumLine.scrollFactor.set();
		
		if (PlayStateChangeables.useDownscroll)
			strumLine.y = FlxG.height - 165;

		strumLineNotes = new FlxTypedGroup<FlxSprite>();
		add(strumLineNotes);

		playerStrums = new FlxTypedGroup<FlxSprite>();
		cpuStrums = new FlxTypedGroup<FlxSprite>();

		// startCountdown();

		if (SONG.song == null)
			trace('song is null???');
		else
			trace('song looks gucci');

		generateSong(SONG.song);

		trace('generated');

		// add(strumLine);

		camFollow = new FlxObject(0, 0, 1, 1);

		camFollow.setPosition(camPos.x, camPos.y);

		if (prevCamFollow != null)
		{
			camFollow = prevCamFollow;
			prevCamFollow = null;
		}

		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0.04 * (30 / (cast (Lib.current.getChildAt(0), Main)).getFPS()));
		// FlxG.camera.setScrollBounds(0, FlxG.width, 0, FlxG.height);
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.focusOn(camFollow.getPosition());

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		FlxG.fixedTimestep = false;

		if (FlxG.save.data.songPosition) // I dont wanna talk about this code :(
			{
				songPosBG = new FlxSprite(0, 10).loadGraphic(Paths.image('healthBar'));
				if (PlayStateChangeables.useDownscroll)
					songPosBG.y = FlxG.height * 0.9 + 45; 
				songPosBG.screenCenter(X);
				songPosBG.scrollFactor.set();
				add(songPosBG);
				
				songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this,
					'songPositionBar', 0, 90000);
				songPosBar.scrollFactor.set();
				songPosBar.createFilledBar(FlxColor.GRAY, FlxColor.LIME);
				add(songPosBar);
	
				var songName = new FlxText(songPosBG.x + (songPosBG.width / 2) - 20,songPosBG.y,0,SONG.song, 16);
				if (PlayStateChangeables.useDownscroll)
					songName.y -= 3;
				songName.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
				songName.scrollFactor.set();
				add(songName);
				songName.cameras = [camHUD];
			}

		healthBarBG = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(Paths.image('healthBar'));
		if (PlayStateChangeables.useDownscroll)
			healthBarBG.y = 50;
		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();
		add(healthBarBG);

		if (curStage == 'jevil' || curStage == 'spamton')
		{
			dialogueBoxDelta = new FlxSprite(0, 532).loadGraphic(Paths.image('the sunday revolving/DELTARUNE DIALOGUE BOX'));
			add(dialogueBoxDelta);
			remove(dialogueBoxDelta);
			mic = new FlxSprite(0, 532).loadGraphic(Paths.image('the sunday revolving/mic'));
			add(mic);
			remove(mic);
			if (curStage == 'spamton')
				mic.y = -1500;
		}

		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
			'health', 0, 2);
		healthBar.scrollFactor.set();
		switch (curStage)
		{
			case 'garAlley' | 'heaven':
				healthBar.createFilledBar(0xFF8E40A5, 0xFF66FF33);
			case 'sonicFUNSTAGE':
				healthBar.createFilledBar(FlxColor.fromRGB(60, 0, 138), 0xFF66FF33);//FlxColor.fromRGB(60, 0, 138)
			default:
				healthBar.createFilledBar(0xFFFF0000, 0xFF66FF33);
		}
		// healthBar
		add(healthBar);

		// Add Kade Engine watermark
		kadeEngineWatermark = new FlxText(4,healthBarBG.y + 50,0,SONG.song + " " + (storyDifficulty == 8 ? "NEO" : storyDifficulty == 7 ? "CHAOS" : storyDifficulty == 6 ? "Unfair" : storyDifficulty == 5 ? "Alt-alpha" : storyDifficulty == 4 ? "Hard-alpha" : storyDifficulty == 3 ? "Alt" : storyDifficulty == 2 ? "Hard" : storyDifficulty == 1 ? "Normal" : "Easy") + (Main.watermarks ? " - KE " + MainMenuState.kadeEngineVer : ""), 16);
		kadeEngineWatermark.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		kadeEngineWatermark.scrollFactor.set();
		add(kadeEngineWatermark);

		if (PlayStateChangeables.useDownscroll)
			kadeEngineWatermark.y = FlxG.height * 0.9 + 45;

		scoreTxt = new FlxText(FlxG.width / 2 - 235, healthBarBG.y + 50, 0, "", 20);

		scoreTxt.screenCenter(X);

		originalX = scoreTxt.x;


		scoreTxt.scrollFactor.set();
		
		scoreTxt.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);

		dumbasstext = new FlxText(0, 0, 0, "Yo I love this", 40);
		dumbasstext.setFormat(Paths.font("vcr.ttf"), 40, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		dumbasstext.alignment = "center";
		var dumb = CoolUtil.coolTextFile(Paths.txt('dumb'));
		dumbasstext2 = new FlxText(-1600, 1000, 0, "THANKS THE86THPLAYER FOR FIXING THE COVER BEING OFFKEY", 160);
		dumbasstext2.setFormat(Paths.font("vcr.ttf"), 160, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		dumbasstext2.alignment = "center";
		dumbasstext3 = new FlxText(-1600, 1000, 0, "THANKS THE86THPLAYER FOR FIXING THE COVER BEING OFFKEY", 160);
		dumbasstext3.setFormat(Paths.font("vcr.ttf"), 160, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		dumbasstext3.alignment = "left";

		add(scoreTxt);
		add(dumbasstext);
		if (curStage == 'auditorHell')
			add(dumbasstext2);
		if (curStage == 'jevil' || curStage == 'spamton')
		{
			dumbasstext2.text = '2000';
			dumbasstext2.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
			dumbasstext2.cameras = [camHUDier];
			dumbasstext3.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
			dumbasstext3.cameras = [camHUDier];
		}

		replayTxt = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 75, healthBarBG.y + (PlayStateChangeables.useDownscroll ? 100 : -100), 0, "REPLAY", 20);
		replayTxt.setFormat(Paths.font("vcr.ttf"), 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		replayTxt.borderSize = 4;
		replayTxt.borderQuality = 2;
		replayTxt.scrollFactor.set();
		if (loadRep)
		{
			add(replayTxt);
		}
		// Literally copy-paste of the above, fu
		botPlayState = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 75, healthBarBG.y + (PlayStateChangeables.useDownscroll ? 100 : -100), 0, "BOTPLAY", 20);
		botPlayState.setFormat(Paths.font("vcr.ttf"), 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		botPlayState.scrollFactor.set();
		botPlayState.borderSize = 4;
		botPlayState.borderQuality = 2;
		if(PlayStateChangeables.botPlay && !loadRep) add(botPlayState);

		iconP1 = new HealthIcon(SONG.player1, true);
		iconP1.y = healthBar.y - (iconP1.height / 2);
		add(iconP1);

		iconP2 = new HealthIcon(SONG.player2, false);
		iconP2.y = healthBar.y - (iconP2.height / 2);
		add(iconP2);
		if (curStage == 'auditorHell' && SONG.player2 == 'exTricky')
			iconP2.animation.play('exTricky-hat-kid');

		strumLineNotes.cameras = [camHUD];
		notes.cameras = [camHUD];
		healthBar.cameras = [camHUD];
		healthBarBG.cameras = [camHUD];
		iconP1.cameras = [camHUD];
		iconP2.cameras = [camHUD];
		scoreTxt.cameras = [camHUD];
		doof.cameras = [camHUD];
		doofus.cameras = [camHUD];
		startCircle.cameras = [camHUD];
		startText.cameras = [camHUD];
		blackFuck.cameras = [camHUD];
		if (curStage == 'jevil' || curStage == 'spamton')
		{
			dialogueBoxDelta.cameras = [camHUD];
			mic.cameras = [camHUDier];
			if (curStage == 'spamton')
				doofus.cameras = [camHUDier];
		}
		if (FlxG.save.data.songPosition)
		{
			songPosBG.cameras = [camHUD];
			songPosBar.cameras = [camHUD];
		}
		kadeEngineWatermark.cameras = [camHUD];
		if (loadRep)
			replayTxt.cameras = [camHUD];

		// if (SONG.song == 'South')
		// FlxG.camera.alpha = 0.7;
		// UI_camera.zoom = 1;

		// cameras = [FlxG.cameras.list[1]];
		startingSong = true;
		
		trace('starting');

		if (isStoryMode)
		{
			switch (StringTools.replace(curSong," ", "-").toLowerCase())
			{
				case "winter-horrorland":
					var blackScreen:FlxSprite = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
					add(blackScreen);
					blackScreen.scrollFactor.set();
					camHUD.visible = false;

					new FlxTimer().start(0.1, function(tmr:FlxTimer)
					{
						remove(blackScreen);
						FlxG.sound.play(Paths.sound('Lights_Turn_On'));
						camFollow.y = -2050;
						camFollow.x += 200;
						FlxG.camera.focusOn(camFollow.getPosition());
						FlxG.camera.zoom = 1.5;

						new FlxTimer().start(0.8, function(tmr:FlxTimer)
						{
							camHUD.visible = true;
							remove(blackScreen);
							FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 2.5, {
								ease: FlxEase.quadInOut,
								onComplete: function(twn:FlxTween)
								{
									startCountdown();
								}
							});
						});
					});
				case 'senpai':
					schoolIntro(doof);
				case 'roses':
					FlxG.sound.play(Paths.sound('ANGRY'));
					schoolIntro(doof);
				case 'thorns':
					schoolIntro(doof);
				case 'gospel':
					add(doofus);
				case 'expurgation':
					add(doofus);
				case 'headache':
					add(doofus);
				case 'release':
					add(doofus);
				case 'glitcher':
					add(doofus);
				case 'endless':
					add(doofus);
				case 'ejected':
					add(doofus);
				case 'the sunday revolving':
					add(doofus);
				case 'big piece':
					add(doofus);
				default:
					startCountdown();
			}
		}
		else
		{
			switch (curSong.toLowerCase())
			{
				case 'gospel':
					add(doofus);
				case 'expurgation':
					add(doofus);
				case 'headache':
					add(doofus);
				case 'release':
					add(doofus);
				case 'glitcher':
					add(doofus);
				case 'endless':
					add(doofus);
				case 'ejected':
					add(doofus);
				case 'the sunday revolving':
					add(doofus);
				case 'big piece':
					add(doofus);
				default:
					startCountdown();
			}
		}

		if (!loadRep)
			rep = new Replay("na");

		deathBySawBlade = false; //Some reason, it keeps it's value after death, so this forces itself to reset to false.
		trace('camera COORDS: '+ camFollow.x + ' , ' + camFollow.y);

		if (curStage == 'spamton')
		{
			FlxG.mouse.visible = false;
			add(dialogueBoxDelta);
			dadAgain = new Character(500, 220, 'DUMMYmiku');
			changeBf('bf-flipped');
			dadAgain2 = new Character(dadAgain.x - 100, dadAgain.y, 'jevil-sunday-flipped');
			add(dadAgain2);
			dadAgain3 = new Character(dadAgain.x + 100, dadAgain.y, 'MTTcarol');
			add(dadAgain3);
			add(dadAgain);

			gf.setGraphicSize(Std.int(gf.width * 0.4));
			gf.updateHitbox();

			for (anim in gf.animOffsets.keys())
			{
				trace(gf.animOffsets.keys());
				gf.animOffsets[anim] = [gf.animOffsets[anim][0]*0.4,gf.animOffsets[anim][1]*0.4];
			}

			dad.setGraphicSize(Std.int(dad.width * 0.6));
			dad.updateHitbox();

			for (anim in dad.animOffsets.keys())
			{
				trace(dad.animOffsets.keys());
				dad.animOffsets[anim] = [dad.animOffsets[anim][0]*0.6,dad.animOffsets[anim][1]*0.6];
			}

			dadAgain.setGraphicSize(Std.int(dadAgain.width * 0.4));
			dadAgain.updateHitbox();

			for (anim in dadAgain.animOffsets.keys())
			{
				trace(dadAgain.animOffsets.keys());
				dadAgain.animOffsets[anim] = [dadAgain.animOffsets[anim][0]*0.4,dadAgain.animOffsets[anim][1]*0.4];
			}

			dadAgain.playAnim('idle');

			dadAgain2.setGraphicSize(Std.int(dadAgain2.width * 0.4));
			dadAgain2.updateHitbox();

			for (anim in dadAgain2.animOffsets.keys())
			{
				trace(dadAgain2.animOffsets.keys());
				dadAgain2.animOffsets[anim] = [dadAgain2.animOffsets[anim][0]*0.4,dadAgain2.animOffsets[anim][1]*0.4];
			}

			dadAgain2.playAnim('idle');

			dadAgain3.setGraphicSize(Std.int(dadAgain3.width * 0.4));
			dadAgain3.updateHitbox();

			for (anim in dadAgain3.animOffsets.keys())
			{
				trace(dadAgain3.animOffsets.keys());
				dadAgain3.animOffsets[anim] = [dadAgain3.animOffsets[anim][0]*0.4,dadAgain3.animOffsets[anim][1]*0.4];
			}

			dadAgain3.playAnim('idle');

			dadAgain.flipX = !dadAgain.flipX;
			dadAgain2.flipX = !dadAgain2.flipX;
			dadAgain3.flipX = !dadAgain3.flipX;
			dad.flipX = !dad.flipX;
			boyfriend.flipX = !boyfriend.flipX;

			dad.x = 500;
			dad.y = 30;
			gf.x = -270;
			gf.y = 220;
			boyfriend.x = -370;
			boyfriend.y = 95;
			spamtonCart = new FlxSprite(-140 , 200 + 140).loadGraphic(Paths.image('spamton/cart 1'));
			spamtonCart.setGraphicSize(Std.int(spamtonCart.width * 4));
			add(spamtonCart);
			spamtonCart3 = new FlxSprite(20 , 200).loadGraphic(Paths.image('spamton/cart 3'));
			spamtonCart3.setGraphicSize(Std.int(spamtonCart3.width * 4));
			add(spamtonCart3);
			add(mic);
			add(gf);
			add(boyfriend);

			boyfriend.setGraphicSize(Std.int(boyfriend.width * 0.3));
			boyfriend.updateHitbox();

			for (anim in boyfriend.animOffsets.keys())
			{
				boyfriend.animOffsets[anim] = [boyfriend.animOffsets[anim][0]*0.3,boyfriend.animOffsets[anim][1]*0.3];
			}
			dadAgain.visible = false;
			dadAgain2.visible = false;
			dadAgain3.visible = false;
			iconP1.visible = false;
			iconP2.visible = false;
			remove(healthBar);
			healthBar = new FlxBar(806, 570, LEFT_TO_RIGHT, 129, 15, this,
			'health', 0, 2);
			add(healthBar);
			healthBar.cameras = [camHUDier];
			healthBar.createFilledBar(0xFF7F0B00, 0xFF00D0E7);
			healthBarBG.visible = false;
			scoreTxt.cameras = [camHUDier];
			kadeEngineWatermark.cameras = [camHUDier];
			boyfriend.dance();
			dad.dance();
			gf.dance();
			add(dumbasstext2);
			add(dumbasstext3);
			removal = 0;
			addition = 0;
			susie = new FlxSprite(-120 , 120);
			susie.frames = Paths.getSparrowAtlas('spamton/susie');
			susie.animation.addByPrefix('idle', 'susie idle', 6);
			susie.animation.addByPrefix('snap', 'susie snap', 12, false);
			susie.animation.play('idle');
			susie.setGraphicSize(Std.int(susie.width * 3));
			susie.antialiasing = false;
			add(susie);
			ralsei = new FlxSprite(60 , 120);
			ralsei.frames = Paths.getSparrowAtlas('spamton/ralsei');
			ralsei.animation.addByPrefix('idle', 'ralsei idle', 6);
			ralsei.animation.addByPrefix('snap', 'ralsei snap', 12, false);
			ralsei.animation.play('idle');
			ralsei.setGraphicSize(Std.int(ralsei.width * 3));
			ralsei.antialiasing = false;
			add(ralsei);
			kris = new FlxSprite(140 , 140);
			kris.frames = Paths.getSparrowAtlas('spamton/kris');
			kris.animation.addByPrefix('idle', 'kris idle', 6);
			kris.animation.addByPrefix('snap', 'kris snap', 12, false);
			kris.animation.play('idle');
			kris.setGraphicSize(Std.int(kris.width * 3));
			kris.antialiasing = false;
			add(kris);
			heartThing = new FlxSprite(-140 , 200 + 140).loadGraphic(Paths.image('spamton/heart'));
			heartSheild = new FlxSprite(-140 , 200 + 140).loadGraphic(Paths.image('spamton/heartCircle'));
			add(blueSpamton1);
			add(blueSpamton2);
			add(projectiles);
			add(heartSheild);
			add(heartThing);
		}
		super.create();
	}

	function schoolIntro(?dialogueBox:DialogueBox):Void
	{
		var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		black.scrollFactor.set();
		add(black);

		var red:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, 0xFFff1b31);
		red.scrollFactor.set();

		var senpaiEvil:FlxSprite = new FlxSprite();
		senpaiEvil.frames = Paths.getSparrowAtlas('weeb/senpaiCrazy');
		senpaiEvil.animation.addByPrefix('idle', 'Senpai Pre Explosion', 24, false);
		senpaiEvil.setGraphicSize(Std.int(senpaiEvil.width * 6));
		senpaiEvil.scrollFactor.set();
		senpaiEvil.updateHitbox();
		senpaiEvil.screenCenter();

		if (StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase() == 'roses' || StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase() == 'thorns')
		{
			remove(black);

			if (StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase() == 'thorns')
			{
				add(red);
			}
		}

		new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{
			black.alpha -= 0.15;

			if (black.alpha > 0)
			{
				tmr.reset(0.3);
			}
			else
			{
				if (dialogueBox != null)
				{
					inCutscene = true;

					if (StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase() == 'thorns')
					{
						add(senpaiEvil);
						senpaiEvil.alpha = 0;
						new FlxTimer().start(0.3, function(swagTimer:FlxTimer)
						{
							senpaiEvil.alpha += 0.15;
							if (senpaiEvil.alpha < 1)
							{
								swagTimer.reset();
							}
							else
							{
								senpaiEvil.animation.play('idle');
								FlxG.sound.play(Paths.sound('Senpai_Dies'), 1, false, null, true, function()
								{
									remove(senpaiEvil);
									remove(red);
									FlxG.camera.fade(FlxColor.WHITE, 0.01, true, function()
									{
										add(dialogueBox);
									}, true);
								});
								new FlxTimer().start(3.2, function(deadTime:FlxTimer)
								{
									FlxG.camera.fade(FlxColor.WHITE, 1.6, false);
								});
							}
						});
					}
					else
					{
						add(dialogueBox);
					}
				}
				else
					startCountdown();

				remove(black);
			}
		});
	}

	var startTimer:FlxTimer;
	var perfectMode:Bool = false;

	var luaWiggles:Array<WiggleEffect> = [];

	#if windows
	public static var luaModchart:ModchartState = null;
	#end

	function three():Void
	{
		var three:FlxSprite = new FlxSprite().loadGraphic(Paths.image('three', 'shared'));
		three.scrollFactor.set();
		three.updateHitbox();
		three.screenCenter();
		three.y -= 100;
		three.alpha = 0.5;
				add(three);
				FlxTween.tween(three, {y: three.y += 100, alpha: 0}, Conductor.crochet / 1000, {
					ease: FlxEase.cubeInOut,
					onComplete: function(twn:FlxTween)
					{
						three.destroy();
					}
				});
	}

	function two():Void
	{
		var two:FlxSprite = new FlxSprite().loadGraphic(Paths.image('two', 'shared'));
		two.scrollFactor.set();
		two.screenCenter();
		two.y -= 100;
		two.alpha = 0.5;
				add(two);
				FlxTween.tween(two, {y: two.y += 100, alpha: 0}, Conductor.crochet / 1000, {
					ease: FlxEase.cubeInOut,
					onComplete: function(twn:FlxTween)
					{
						two.destroy();
					}
				});
				
	}

	function one():Void
	{
		var one:FlxSprite = new FlxSprite().loadGraphic(Paths.image('one', 'shared'));
		one.scrollFactor.set();
		one.screenCenter();
		one.y -= 100;
		one.alpha = 0.5;

				add(one);
				FlxTween.tween(one, {y: one.y += 100, alpha: 0}, Conductor.crochet / 1000, {
					ease: FlxEase.cubeInOut,
					onComplete: function(twn:FlxTween)
					{
						one.destroy();
					}
				});
				
	}
	
	function gofun():Void
	{
		var gofun:FlxSprite = new FlxSprite().loadGraphic(Paths.image('gofun', 'shared'));
		gofun.scrollFactor.set();

		gofun.updateHitbox();

		gofun.screenCenter();
		gofun.y -= 100;
		gofun.alpha = 0.5;

				add(gofun);
				FlxTween.tween(gofun, {y: gofun.y += 100, alpha: 0}, Conductor.crochet / 1000, {
					ease: FlxEase.cubeInOut,
					onComplete: function(twn:FlxTween)
					{
						gofun.destroy();
					}
				});
	}

	function startCountdown():Void
	{
		if (SONG.song.toLowerCase() == 'endless')
		{
			SONG.noteStyle = 'normal';

			FlxG.sound.play(Paths.sound('Lights_Shut_off'));
			add(blackFuck);
			startCircle.loadGraphic(Paths.image('StartScreens/CircleMajin', 'shared'));
			startCircle.x += 777;
			add(startCircle);
			startText.loadGraphic(Paths.image('StartScreens/TextMajin', 'shared'));
			startText.x -= 1200;
			add(startText);
			
			new FlxTimer().start(0.6, function(tmr:FlxTimer)
			{
				FlxTween.tween(startCircle, {x: 0}, 0.5);
				FlxTween.tween(startText, {x: 0}, 0.5);
			});
			
			new FlxTimer().start(1.9, function(tmr:FlxTimer)
				{
				FlxTween.tween(startCircle, {alpha: 0}, 1, {
					onComplete: function(twn:FlxTween)
					{
						startCircle.destroy();
					}
				});
				FlxTween.tween(startText, {alpha: 0}, 1, {
					onComplete: function(twn:FlxTween)
					{
						startText.destroy();
					}
				});
				FlxTween.tween(blackFuck, {alpha: 0}, 1, {
					onComplete: function(twn:FlxTween)
					{
						blackFuck.destroy();
					}
				});
			});
		}
		inCutscene = false;

		generateStaticArrows(0);
		generateStaticArrows(1);


		#if windows
		// pre lowercasing the song name (startCountdown)
		var songLowercase = StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase();
		switch (songLowercase) {
			case 'dad-battle': songLowercase = 'dadbattle';
			case 'philly-nice': songLowercase = 'philly';
		}
		if (executeModchart)
		{
			luaModchart = ModchartState.createModchartState();
			luaModchart.executeState('start',[songLowercase]);
		}
		#end

		talking = false;
		startedCountdown = true;
		Conductor.songPosition = 0;
		Conductor.songPosition -= Conductor.crochet * 5;

		var swagCounter:Int = 0;

		startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer)
		{
			if (!dadAnimNoInterupt)
				dad.dance();
			hatkid.dance();
			gf.dance();
			if (curStage == 'auditorHell' || (SONG.song.toLowerCase() == 'ejected' && !roseturn))
				lol86.dance();
			boyfriend.playAnim('idle');

			var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
			introAssets.set('default', ['ready', "set", "go"]);
			introAssets.set('school', [
				'weeb/pixelUI/ready-pixel',
				'weeb/pixelUI/set-pixel',
				'weeb/pixelUI/date-pixel'
			]);
			introAssets.set('schoolEvil', [
				'weeb/pixelUI/ready-pixel',
				'weeb/pixelUI/set-pixel',
				'weeb/pixelUI/date-pixel'
			]);

			var introAlts:Array<String> = introAssets.get('default');
			var altSuffix:String = "";

			for (value in introAssets.keys())
			{
				if (value == curStage)
				{
					introAlts = introAssets.get(value);
					altSuffix = '-pixel';
				}
			}

			switch (swagCounter)

			{
				case 0:
					FlxG.sound.play(Paths.sound('intro3' + altSuffix), 0.6);
				case 1:
					var ready:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[0]));
					ready.scrollFactor.set();
					ready.updateHitbox();

					if (curStage.startsWith('school'))
						ready.setGraphicSize(Std.int(ready.width * daPixelZoom));

					ready.screenCenter();
					add(ready);
					FlxTween.tween(ready, {y: ready.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							ready.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('intro2' + altSuffix), 0.6);
				case 2:
					var set:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[1]));
					set.scrollFactor.set();

					if (curStage.startsWith('school'))
						set.setGraphicSize(Std.int(set.width * daPixelZoom));

					set.screenCenter();
					add(set);
					FlxTween.tween(set, {y: set.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							set.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('intro1' + altSuffix), 0.6);
				case 3:
					var go:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[2]));
					go.scrollFactor.set();

					if (curStage.startsWith('school'))
						go.setGraphicSize(Std.int(go.width * daPixelZoom));

					go.updateHitbox();

					go.screenCenter();
					add(go);
					FlxTween.tween(go, {y: go.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							go.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('introGo' + altSuffix), 0.6);
				case 4:
			}

			swagCounter += 1;
			// generateSong('fresh');
		}, 5);

		if (SONG.song.toLowerCase() == 'expurgation') // start the grem time
		{
			gremlinTimer.start(25, function(tmr:FlxTimer)
			{
				if (curStep < 2400)
				{
					if (canPause && !paused && health >= 1.5 && !grabbed)
						doGremlin(40, 3);
					trace('checka ' + health);
					tmr.reset(25);
				}
			});
		}
	}

	var grabbed = false;

	var previousFrameTime:Int = 0;
	var lastReportedPlayheadPosition:Int = 0;
	var songTime:Float = 0;


	var songStarted = false;
	var songEnded = false;

	function startSong():Void
	{
		startingSong = false;
		songStarted = true;
		songEnded = false;
		previousFrameTime = FlxG.game.ticks;
		lastReportedPlayheadPosition = 0;

		if (!paused)
		{
			FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 1, false);
		}
		if (curStage != 'jevil' && curStage != 'spamton')
			FlxG.sound.music.onComplete = endSong;
		else
			FlxG.sound.music.onComplete = funnifunction;
		vocals.play();

		bfCanDodge = true;

		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;

		if (FlxG.save.data.songPosition)
		{
			remove(songPosBG);
			remove(songPosBar);
			remove(songName);

			songPosBG = new FlxSprite(0, 10).loadGraphic(Paths.image('healthBar'));
			if (PlayStateChangeables.useDownscroll)
				songPosBG.y = FlxG.height * 0.9 + 45; 
			songPosBG.screenCenter(X);
			songPosBG.scrollFactor.set();
			add(songPosBG);

			songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this,
				'songPositionBar', 0, songLength - 1000);
			songPosBar.numDivisions = 1000;
			songPosBar.scrollFactor.set();
			songPosBar.createFilledBar(FlxColor.GRAY, FlxColor.LIME);
			add(songPosBar);

			var songName = new FlxText(songPosBG.x + (songPosBG.width / 2) - 20,songPosBG.y,0,SONG.song, 16);
			if (PlayStateChangeables.useDownscroll)
				songName.y -= 3;
			songName.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
			songName.scrollFactor.set();
			add(songName);

			songPosBG.cameras = [camHUD];
			songPosBar.cameras = [camHUD];
			songName.cameras = [camHUD];
		}
		
		// Song check real quick
		switch(curSong)
		{
			case 'Bopeebo' | 'Philly Nice' | 'Blammed' | 'Cocoa' | 'Eggnog': allowedToHeadbang = true;
			default: allowedToHeadbang = false;
		}

		if (useVideo)
			GlobalVideo.get().resume();
		
		#if windows
		// Updating Discord Rich Presence (with Time Left)
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
		#end
	}

	var debugNum:Int = 0;

	private function generateSong(dataPath:String):Void
	{
		// FlxG.log.add(ChartParser.parse());

		var songData = SONG;
		Conductor.changeBPM(songData.bpm);

		curSong = songData.song;

		if (SONG.needsVoices)
			vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
		else
			vocals = new FlxSound();

		trace('loaded vocals');

		FlxG.sound.list.add(vocals);

		notes = new FlxTypedGroup<Note>();
		add(notes);

		var noteData:Array<SwagSection>;

		// NEW SHIT
		noteData = songData.notes;

		var playerCounter:Int = 0;

		// Per song offset check
		#if windows
			// pre lowercasing the song name (generateSong)
			var songLowercase = StringTools.replace(PlayState.SONG.song, " ", "-").toLowerCase();
				switch (songLowercase) {
					case 'dad-battle': songLowercase = 'dadbattle';
					case 'philly-nice': songLowercase = 'philly';
				}

			var songPath = 'assets/data/' + songLowercase + '/';
			
			for(file in sys.FileSystem.readDirectory(songPath))
			{
				var path = haxe.io.Path.join([songPath, file]);
				if(!sys.FileSystem.isDirectory(path))
				{
					if(path.endsWith('.offset'))
					{
						trace('Found offset file: ' + path);
						songOffset = Std.parseFloat(file.substring(0, file.indexOf('.off')));
						break;
					}else {
						trace('Offset file not found. Creating one @: ' + songPath);
						sys.io.File.saveContent(songPath + songOffset + '.offset', '');
					}
				}
			}
		#end
		var daBeats:Int = 0; // Not exactly representative of 'daBeats' lol, just how much it has looped
		for (section in noteData)
		{
			if (daSection == 58 && curSong.toLowerCase() == 'endless') SONG.noteStyle = 'majinNOTES';
			if (curSong.toLowerCase() == 'ejected') SONG.noteStyle = 'normal';
			var coolSection:Int = Std.int(section.lengthInSteps / 4);

			for (songNotes in section.sectionNotes)
			{
				if (curSong.toLowerCase() == 'ejected') SONG.noteStyle = 'normal';
				var daStrumTime:Float = songNotes[0] + FlxG.save.data.offset + songOffset;
				if (daStrumTime < 0)
					daStrumTime = 0;
				var daNoteData:Int = Std.int(songNotes[1] % 4);
				var burning = (songNotes[1] > 7 && songNotes[1] < 16);
				var burning2 = (songNotes[1] > 15 && songNotes[1] < 24);
				var burning3 = (songNotes[1] > 23);
				var spamton = false;
				if (daSection > 72 && daSection < 82)
					spamton = true;

				var gottaHitNote:Bool = section.mustHitSection;

				if ((songNotes[1] % 8) > 3)
				{
					gottaHitNote = !section.mustHitSection;
				}

				if (!gottaHitNote && daSection > 120 && daSection < 129 && curSong.toLowerCase() == 'ejected') SONG.noteStyle = 'eteled';
				if (!gottaHitNote && daSection > 128 && daSection < 137 && curSong.toLowerCase() == 'ejected') SONG.noteStyle = 'spinel';

				var oldNote:Note;
				if (unspawnNotes.length > 0)
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
				else
					oldNote = null;

				var swagNote:Note = new Note(daStrumTime, daNoteData, oldNote, false, burning, burning2, burning3, gottaHitNote, spamton);
				swagNote.sustainLength = songNotes[2];
				swagNote.scrollFactor.set(0, 0);
				if (curStage == 'jevil' && (burning || burning2))
					swagNote.visible = false;

				var susLength:Float = swagNote.sustainLength;

				susLength = susLength / Conductor.stepCrochet;
				unspawnNotes.push(swagNote);

				for (susNote in 0...Math.floor(susLength))
				{
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];

					var sustainNote:Note = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + Conductor.stepCrochet, daNoteData, oldNote, true, burning, burning2, burning3, gottaHitNote, spamton);
					sustainNote.scrollFactor.set();
					unspawnNotes.push(sustainNote);

					sustainNote.mustPress = gottaHitNote;

					if (sustainNote.mustPress)
					{
						sustainNote.x += FlxG.width / 2; // general offset
					}
				}

				swagNote.mustPress = gottaHitNote;

				if (swagNote.mustPress)
				{
					swagNote.x += FlxG.width / 2; // general offset
				}
				else
				{
				}
			}
			daBeats += 1;
			daSection += 1;
		}

		// trace(unspawnNotes.length);
		// playerCounter += 1;

		unspawnNotes.sort(sortByShit);

		generatedMusic = true;
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	function removeStatics()
	{
		playerStrums.forEach(function(todel:FlxSprite)
			{
				playerStrums.remove(todel);
				todel.destroy();
			});
		cpuStrums.forEach(function(todel:FlxSprite)
		{
			cpuStrums.remove(todel);
			todel.destroy();
		});
		strumLineNotes.forEach(function(todel:FlxSprite)
		{
			strumLineNotes.remove(todel);
			todel.destroy();
		});
	}

	private function generateStaticArrows(player:Int, tweened:Bool = true):Void
	{
		for (i in 0...4)
		{
			// FlxG.log.add(i);
			var babyArrow:FlxSprite = new FlxSprite(0, strumLine.y);

			//defaults if no noteStyle was found in chart
			var noteTypeCheck:String = 'normal';
		
			if (SONG.noteStyle == null) {
				switch(storyWeek) {case 6: noteTypeCheck = 'pixel';}
			} else {noteTypeCheck = SONG.noteStyle;}

			switch (noteTypeCheck)
			{
				case 'pixel':
					babyArrow.loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels'), true, 17, 17);
					babyArrow.animation.add('green', [6]);
					babyArrow.animation.add('red', [7]);
					babyArrow.animation.add('blue', [5]);
					babyArrow.animation.add('purplel', [4]);

					babyArrow.setGraphicSize(Std.int(babyArrow.width * daPixelZoom));
					babyArrow.updateHitbox();
					babyArrow.antialiasing = false;

					switch (Math.abs(i))
					{
						case 2:
							babyArrow.x += Note.swagWidth * 2;
							babyArrow.animation.add('static', [2]);
							babyArrow.animation.add('pressed', [6, 10], 12, false);
							babyArrow.animation.add('confirm', [14, 18], 12, false);
						case 3:
							babyArrow.x += Note.swagWidth * 3;
							babyArrow.animation.add('static', [3]);
							babyArrow.animation.add('pressed', [7, 11], 12, false);
							babyArrow.animation.add('confirm', [15, 19], 24, false);
						case 1:
							babyArrow.x += Note.swagWidth * 1;
							babyArrow.animation.add('static', [1]);
							babyArrow.animation.add('pressed', [5, 9], 12, false);
							babyArrow.animation.add('confirm', [13, 17], 24, false);
						case 0:
							babyArrow.x += Note.swagWidth * 0;
							babyArrow.animation.add('static', [0]);
							babyArrow.animation.add('pressed', [4, 8], 12, false);
							babyArrow.animation.add('confirm', [12, 16], 24, false);
					}
				
					case 'normal':
						babyArrow.frames = Paths.getSparrowAtlas('NOTE_assets');
						babyArrow.animation.addByPrefix('green', 'arrowUP');
						babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
						babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
						babyArrow.animation.addByPrefix('red', 'arrowRIGHT');
		
						babyArrow.antialiasing = true;
						babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));
		
						switch (Math.abs(i))
						{
							case 0:
								babyArrow.x += Note.swagWidth * 0;
								babyArrow.animation.addByPrefix('static', 'arrowLEFT');
								babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
							case 1:
								babyArrow.x += Note.swagWidth * 1;
								babyArrow.animation.addByPrefix('static', 'arrowDOWN');
								babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
							case 2:
								babyArrow.x += Note.swagWidth * 2;
								babyArrow.animation.addByPrefix('static', 'arrowUP');
								babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
							case 3:
								babyArrow.x += Note.swagWidth * 3;
								babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
								babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
							}
				
						case 'cross':
							babyArrow.frames = Paths.getSparrowAtlas('NOTE_assets2');
							babyArrow.animation.addByPrefix('green', 'arrowUP');
							babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
							babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
							babyArrow.animation.addByPrefix('red', 'arrowRIGHT');
			
							babyArrow.antialiasing = true;
							babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));
			
							switch (Math.abs(i))
							{
								case 0:
									babyArrow.x += Note.swagWidth * 0;
									babyArrow.animation.addByPrefix('static', 'arrowLEFT');
									babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
									babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
								case 1:
									babyArrow.x += Note.swagWidth * 1;
									babyArrow.animation.addByPrefix('static', 'arrowDOWN');
									babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
									babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
								case 2:
									babyArrow.x += Note.swagWidth * 2;
									babyArrow.animation.addByPrefix('static', 'arrowUP');
									babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
									babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
								case 3:
									babyArrow.x += Note.swagWidth * 3;
									babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
									babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
									babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
								}
		
	
				case 'majinNOTES':
						babyArrow.frames = Paths.getSparrowAtlas('Majin_Notes');
						babyArrow.animation.addByPrefix('green', 'arrowUP');
						babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
						babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
						babyArrow.animation.addByPrefix('red', 'arrowRIGHT');

						babyArrow.antialiasing = true;
						babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));

						switch (Math.abs(i))
						{
							case 0:
								babyArrow.x += Note.swagWidth * 0;
								babyArrow.animation.addByPrefix('static', 'arrowLEFT');
								babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
							case 1:
								babyArrow.x += Note.swagWidth * 1;
								babyArrow.animation.addByPrefix('static', 'arrowDOWN');
								babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
							case 2:
								babyArrow.x += Note.swagWidth * 2;
								babyArrow.animation.addByPrefix('static', 'arrowUP');
								babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
							case 3:
								babyArrow.x += Note.swagWidth * 3;
								babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
								babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
							}

				case 'eteled':
						babyArrow.frames = Paths.getSparrowAtlas('eteled');
						babyArrow.animation.addByPrefix('green', 'arrowUP');
						babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
						babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
						babyArrow.animation.addByPrefix('red', 'arrowRIGHT');

						babyArrow.antialiasing = true;
						babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));

						switch (Math.abs(i))
						{
							case 0:
								babyArrow.x += Note.swagWidth * 0;
								babyArrow.animation.addByPrefix('static', 'arrowLEFT');
								babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
							case 1:
								babyArrow.x += Note.swagWidth * 1;
								babyArrow.animation.addByPrefix('static', 'arrowDOWN');
								babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
							case 2:
								babyArrow.x += Note.swagWidth * 2;
								babyArrow.animation.addByPrefix('static', 'arrowUP');
								babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
							case 3:
								babyArrow.x += Note.swagWidth * 3;
								babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
								babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
							}
				
				case 'spinel':
						babyArrow.frames = Paths.getSparrowAtlas('spinel');
						babyArrow.animation.addByPrefix('green', 'arrowUP');
						babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
						babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
						babyArrow.animation.addByPrefix('red', 'arrowRIGHT');

						babyArrow.antialiasing = true;
						babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));

						switch (Math.abs(i))
						{
							case 0:
								babyArrow.x += Note.swagWidth * 0;
								babyArrow.animation.addByPrefix('static', 'arrowLEFT');
								babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
							case 1:
								babyArrow.x += Note.swagWidth * 1;
								babyArrow.animation.addByPrefix('static', 'arrowDOWN');
								babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
							case 2:
								babyArrow.x += Note.swagWidth * 2;
								babyArrow.animation.addByPrefix('static', 'arrowUP');
								babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
							case 3:
								babyArrow.x += Note.swagWidth * 3;
								babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
								babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
							}
				
					default:
						babyArrow.frames = Paths.getSparrowAtlas('NOTE_assets');
						babyArrow.animation.addByPrefix('green', 'arrowUP');
						babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
						babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
						babyArrow.animation.addByPrefix('red', 'arrowRIGHT');
	
						babyArrow.antialiasing = true;
						babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));
	
						switch (Math.abs(i))
						{
							case 0:
								babyArrow.x += Note.swagWidth * 0;
								babyArrow.animation.addByPrefix('static', 'arrowLEFT');
								babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
							case 1:
								babyArrow.x += Note.swagWidth * 1;
								babyArrow.animation.addByPrefix('static', 'arrowDOWN');
								babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
							case 2:
								babyArrow.x += Note.swagWidth * 2;
								babyArrow.animation.addByPrefix('static', 'arrowUP');
								babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
							case 3:
								babyArrow.x += Note.swagWidth * 3;
								babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
								babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
						}
			}

			babyArrow.updateHitbox();
			babyArrow.scrollFactor.set();

			if (!isStoryMode && tweened)
			{
				babyArrow.y -= 10;
				babyArrow.alpha = 0;
				FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
			}

			babyArrow.ID = i;

			switch (player)
			{
				case 0:
					cpuStrums.add(babyArrow);
				case 1:
					playerStrums.add(babyArrow);
			}

			babyArrow.animation.play('static');
			babyArrow.x += 50;
			babyArrow.x += ((FlxG.width / 2) * player);
			
			cpuStrums.forEach(function(spr:FlxSprite)
			{					
				spr.centerOffsets(); //CPU arrows start out slightly off-center
			});

			strumLineNotes.add(babyArrow);
		}
	}

	function tweenCamIn():Void
	{
		FlxTween.tween(FlxG.camera, {zoom: 1.3}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut});
	}

	override function openSubState(SubState:FlxSubState)
	{
		if (paused)
		{
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.pause();
				vocals.pause();
			}

			#if windows
			DiscordClient.changePresence("PAUSED on " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "Acc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
			#end
			if (!startTimer.finished)
				startTimer.active = false;
		}

		super.openSubState(SubState);
	}

	override function closeSubState()
	{
		if (paused)
		{
			if (FlxG.sound.music != null && !startingSong)
			{
				resyncVocals();
			}

			if (!startTimer.finished)
				startTimer.active = true;
			paused = false;

			#if windows
			if (startTimer.finished)
			{
				DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses, iconRPC, true, songLength - Conductor.songPosition);
			}
			else
			{
				DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), iconRPC);
			}
			#end
		}

		super.closeSubState();
	}
	

	function resyncVocals():Void
	{
		vocals.pause();

		FlxG.sound.music.play();
		Conductor.songPosition = FlxG.sound.music.time;
		vocals.time = Conductor.songPosition;
		vocals.play();

		#if windows
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
		#end
	}

	private var paused:Bool = false;
	var startedCountdown:Bool = false;
	var canPause:Bool = true;
	var nps:Int = 0;
	var maxNPS:Int = 0;

	public static var songRate = 1.5;
	var rotBeat = 32;
	var rotUpBeat = 36 * 4;
	var rotEndBeat = 100 * 4;
	var rotTime = 0;
	var rotSpd:Float = 1;
	var rotLen = 0.3;
	var rotXLen:Float = 0;

	public var stopUpdate = false;
	public var removedVideo = false;

	override public function update(elapsed:Float)
	{
		#if !debug
		perfectMode = false;
		#end

		if (PlayStateChangeables.botPlay && FlxG.keys.justPressed.ONE)
			camHUD.visible = !camHUD.visible;


		if (useVideo && GlobalVideo.get() != null && !stopUpdate)
			{		
				if (GlobalVideo.get().ended && !removedVideo)
				{
					remove(videoSprite);
					FlxG.stage.window.onFocusOut.remove(focusOut);
					FlxG.stage.window.onFocusIn.remove(focusIn);
					removedVideo = true;
				}
			}


		
		#if windows
		if (executeModchart && luaModchart != null && songStarted && !songEnded)
		{
			luaModchart.setVar('songPos',Conductor.songPosition);
			luaModchart.setVar('hudZoom', camHUD.zoom);
			luaModchart.setVar('cameraZoom',FlxG.camera.zoom);
			luaModchart.executeState('update', [elapsed]);

			for (i in luaWiggles)
			{
				trace('wiggle le gaming');
				i.update(elapsed);
			}

			/*for (i in 0...strumLineNotes.length) {
				var member = strumLineNotes.members[i];
				member.x = luaModchart.getVar("strum" + i + "X", "float");
				member.y = luaModchart.getVar("strum" + i + "Y", "float");
				member.angle = luaModchart.getVar("strum" + i + "Angle", "float");
			}*/

			FlxG.camera.angle = luaModchart.getVar('cameraAngle', 'float');
			camHUD.angle = luaModchart.getVar('camHudAngle','float');

			if (luaModchart.getVar("showOnlyStrums",'bool'))
			{
				healthBarBG.visible = false;
				kadeEngineWatermark.visible = false;
				healthBar.visible = false;
				iconP1.visible = false;
				iconP2.visible = false;
				scoreTxt.visible = false;
			}
			else
			{
				healthBarBG.visible = true;
				kadeEngineWatermark.visible = true;
				healthBar.visible = true;
				iconP1.visible = true;
				iconP2.visible = true;
				scoreTxt.visible = true;
			}

			var p1 = luaModchart.getVar("strumLine1Visible",'bool');
			var p2 = luaModchart.getVar("strumLine2Visible",'bool');

			for (i in 0...4)
			{
				strumLineNotes.members[i].visible = p1;
				if (i <= playerStrums.length)
					playerStrums.members[i].visible = p2;
			}
		}

		#end

		// reverse iterate to remove oldest notes first and not invalidate the iteration
		// stop iteration as soon as a note is not removed
		// all notes should be kept in the correct order and this is optimal, safe to do every frame/update
		{
			var balls = notesHitArray.length-1;
			while (balls >= 0)
			{
				var cock:Date = notesHitArray[balls];
				if (cock != null && cock.getTime() + 1000 < Date.now().getTime())
					notesHitArray.remove(cock);
				else
					balls = 0;
				balls--;
			}
			nps = notesHitArray.length;
			if (nps > maxNPS)
				maxNPS = nps;
		}

		if (FlxG.keys.justPressed.NINE)
		{
			if (iconP1.animation.curAnim.name == 'bf-old')
				iconP1.animation.play(SONG.player1);
			else
				iconP1.animation.play('bf-old');
		}

		switch (curStage)
		{
			case 'philly':
				if (trainMoving)
				{
					trainFrameTiming += elapsed;

					if (trainFrameTiming >= 1 / 24)
					{
						updateTrainPos();
						trainFrameTiming = 0;
					}
				}
				// phillyCityLights.members[curLight].alpha -= (Conductor.crochet / 1000) * FlxG.elapsed;
				
			case 'auditorHell':
				if (curBeat % 8 == 4 && beatOfFuck != curBeat)
				{
					beatOfFuck = curBeat;
					doClone(FlxG.random.int(0, 1));
				}
		}

		dumbasstext.visible = false;
		switch (dad.curCharacter)
		{
			case ('sarvente-lucifer'):
				dad.x = 100 + Math.cos(rotTime / 50 * rotSpd) * 80 * rotXLen;
				dad.y = 300 + Math.sin(rotTime / 40 * rotSpd) * 80 * rotLen;
				rotTime ++;

				if (SONG.song.toLowerCase() == 'gospel')
				{
					if (curBeat < rotBeat)
					{
						defaultCamZoom = 0.8;
					}
					else if (curBeat < rotUpBeat)
					{
						rotLen += (1 - rotLen) / 12;
						defaultCamZoom = 0.75;
						rotSpd = 1.2;
					}
					else if (curBeat < rotEndBeat)
					{
						rotSpd = 1.7;
						rotLen += (0.75 - rotLen) / 12;
						rotXLen += (0.6 - rotXLen) / 12;
						defaultCamZoom = 0.7;
					}
					else
					{
						rotLen += (0.2 - rotLen) / 12;
						rotXLen += (0 - rotXLen) / 12;
						rotSpd = 0.8;
						defaultCamZoom = 0.8;
					}
				}

				switch (SONG.player1)
				{
					case ('lavfinal'):
						boyfriend.x = 1070 - Math.cos(rotTime / 50 * rotSpd) * 80 * rotXLen;
						boyfriend.y = 275 + Math.sin(rotTime / 40 * rotSpd) * 80 * rotLen;
				}
				var gfCheck:String = 'gf';
		
				if (SONG.gfVersion == null) {
					switch(storyWeek)
					{
						case 4: gfCheck = 'gf-car';
						case 5: gfCheck = 'gf-christmas';
						case 6: gfCheck = 'gf-pixel';
					}
				} else {gfCheck = SONG.gfVersion;}

				var curGf:String = '';
				switch (gfCheck)
				{
					case 'gf-car':
						curGf = 'gf-car';
					case 'gf-christmas':
						curGf = 'gf-christmas';
					case 'gf-pixel':
						curGf = 'gf-pixel';
					case 'robo-gf':
						curGf = 'robo-gf';
					case 'robo-gf-night':
						curGf = 'robo-gf-night';
					default:
						curGf = 'gf';
				}

				var dummy = CoolUtil.coolTextFile(Paths.txt('dumb'));
				switch (curGf)
				{
					case ('robo-gf'):
						if ((curBeat < rotEndBeat) && !(curBeat < rotBeat) && !(curBeat < rotUpBeat))
							dumbasstext.visible = true;
						gf.x = 450 - Math.sin(rotTime / 40 * rotSpd) * 80 * rotLen;
						gf.y = 350 + Math.cos(rotTime / 50 * rotSpd) * 80 * rotXLen;
						dumbasstext.x = gf.x + 351.5 - dumbasstext.width/2;
						dumbasstext.y = gf.y - 20;
				}
			case ('exTricky'):
				switch(curStage)
				{
					case 'auditorHell':	
						if (exSpikes.animation.frameIndex >= 3 && dad.animation.curAnim.name == 'singUP')
						{
							trace('paused');
							exSpikes.animation.pause();
						}
				}
		}
		if (curStage == 'auditorHell')
		{
			if (hatSpikes.animation.frameIndex >= 3 && hatkid.animation.curAnim.name == 'singUP')
			{
				trace('paused');
				hatSpikes.animation.pause();
			}
		}

		if(curStage == 'ejected') {
			//make sure that the clouds exist
			if(cloudScroll.members.length == 3) {
				for(i in 0...cloudScroll.members.length) {					
					cloudScroll.members[i].y -= speedPass[i] / (cast(Lib.current.getChildAt(0), Main)).getFPS();
					if(cloudScroll.members[i].y < -1789.65) {
						//im not using flxbackdrops so this is how we're doing things today
						var randomScale = FlxG.random.float(1.5, 2.2);
						var randomScroll = FlxG.random.float(1, 1.3);

						speedPass[i] = FlxG.random.float(9000, 11000);

						cloudScroll.members[i].scale.set(randomScale, randomScale);
						cloudScroll.members[i].scrollFactor.set(randomScroll, randomScroll);
						cloudScroll.members[i].x = FlxG.random.float(-3578.95, 3259.6);
						cloudScroll.members[i].y = 2196.15;
					}
				}
			}
			if(farClouds.members.length == 7) {
				for(i in 0...farClouds.members.length) {					
					farClouds.members[i].y -= farSpeedPass[i] / (cast(Lib.current.getChildAt(0), Main)).getFPS();
					if(farClouds.members[i].y < -1614) {
						var randomScale = FlxG.random.float(0.2, 0.5);
						var randomScroll = FlxG.random.float(0.2, 0.4);

						farSpeedPass[i] = FlxG.random.float(9000, 11000);

						farClouds.members[i].scale.set(randomScale, randomScale);
						farClouds.members[i].scrollFactor.set(randomScroll, randomScroll);
						farClouds.members[i].x = FlxG.random.float(-2737.85, 3485.4);
						farClouds.members[i].y = 1738.6;
					}
				}
			}
			//AAAAAAAAAAAAAAAAAAAA			
			if(leftBuildings.length > 0) {
				for(i in 0...leftBuildings.length) {
					leftBuildings[i].y = middleBuildings[i].y + 5888;
				}
			}
			if(middleBuildings.length > 0) {
				for(i in 0...middleBuildings.length) {
					if(middleBuildings[i].y < -11759.9) {
						middleBuildings[i].y = 3190.5;
						middleBuildings[i].animation.play(FlxG.random.bool(50) ? '1' : '2');
					}			
					middleBuildings[i].y -= 9000 / (cast(Lib.current.getChildAt(0), Main)).getFPS();
				}
			}
			if(rightBuildings.length > 0) {
				for(i in 0...rightBuildings.length) {
					rightBuildings[i].y = leftBuildings[i].y;
				}
			}
			speedLines.y -= 9000 / (cast(Lib.current.getChildAt(0), Main)).getFPS();
			if(fgCloud != null) {
				fgCloud.y -= 0.01;
			}
		}

		super.update(elapsed);

		scoreTxt.text = Ratings.CalculateRanking(songScore,songScoreDef,nps,maxNPS,accuracy);

		var lengthInPx = scoreTxt.textField.length * scoreTxt.frameHeight; // bad way but does more or less a better job

		scoreTxt.x = (originalX - (lengthInPx / 2)) + 335;

		if (FlxG.keys.justPressed.ENTER && startedCountdown && canPause)
		{
			persistentUpdate = false;
			persistentDraw = true;
			paused = true;

			// 1 / 1000 chance for Gitaroo Man easter egg
			if (FlxG.random.bool(0.1))
			{
				trace('GITAROO MAN EASTER EGG');
				FlxG.switchState(new GitarooPause());
			}
			else
				openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		}

		if (FlxG.keys.justPressed.SEVEN)
		{
			if (useVideo)
				{
					GlobalVideo.get().stop();
					remove(videoSprite);
					FlxG.stage.window.onFocusOut.remove(focusOut);
					FlxG.stage.window.onFocusIn.remove(focusIn);
					removedVideo = true;
				}
			#if windows
			DiscordClient.changePresence("Chart Editor", null, null, true);
			#end
			FlxG.switchState(new ChartingState());
			#if windows
			if (luaModchart != null)
			{
				luaModchart.die();
				luaModchart = null;
			}
			#end
		}

		// FlxG.watch.addQuick('VOL', vocals.amplitudeLeft);
		// FlxG.watch.addQuick('VOLRight', vocals.amplitudeRight);

		iconP1.setGraphicSize(Std.int(FlxMath.lerp(150, iconP1.width, 0.50)));
		iconP2.setGraphicSize(Std.int(FlxMath.lerp(150, iconP2.width, 0.50)));

		iconP1.updateHitbox();
		iconP2.updateHitbox();

		switch (SONG.song.toLowerCase())
		{
			case 'release':
				if (curStep == 0 || curStep == 206 || curStep == 318 || curStep == 334 || curStep == 378 || curStep == 382 || curStep == 1040 || curStep == 1120)
				{
					FlxTween.tween(FlxG.camera, {zoom: 1.5}, 0.4, {ease: FlxEase.expoOut,});
				}
				else if (curStep == 592)
					changeBf('pizza');
				else if (curStep == 632)
					changeBf('ded-ron');
				if (dad.curCharacter == 'garcellodead' && curStep == 838)
					dad.playAnim('garTightBars', true);
				if (dad.curCharacter == 'garcellodead' && curStep == 843)
				{
					dad.animation.stop();
					gf.playAnim('help', true);
					amogos.alpha = 1;
					FlxTween.tween(amogos, {alpha: 0}, 4, {
						ease: FlxEase.quadInOut
					});
				}
				if (curStep == 883)
					gf.playAnim('please help', true);
		}

		// robotic screams for help at 884

		var iconOffset:Int = 26;

		iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
		iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);

		if (health > 2)
			health = 2;
		if (healthBar.percent < 20)
			iconP1.animation.curAnim.curFrame = 1;
		else
			iconP1.animation.curAnim.curFrame = 0;

		if (healthBar.percent > 80)
			iconP2.animation.curAnim.curFrame = 1;
		else
			iconP2.animation.curAnim.curFrame = 0;

		/* if (FlxG.keys.justPressed.NINE)
			FlxG.switchState(new Charting()); */

		#if debug
		if (FlxG.keys.justPressed.EIGHT)
		{
			if (useVideo)
				{
					GlobalVideo.get().stop();
					remove(videoSprite);
					FlxG.stage.window.onFocusOut.remove(focusOut);
					FlxG.stage.window.onFocusIn.remove(focusIn);
					removedVideo = true;
				}

			FlxG.switchState(new AnimationDebug(SONG.player2));
			#if windows
			if (luaModchart != null)
			{
				luaModchart.die();
				luaModchart = null;
			}
			#end
		}

		if (FlxG.keys.justPressed.ZERO)
		{
			FlxG.switchState(new AnimationDebug(boyfriend.curCharacter));
			#if windows
			if (luaModchart != null)
			{
				luaModchart.die();
				luaModchart = null;
			}
			#end
		}

		if (FlxG.keys.justPressed.THREE)
		{
			noDeathMode = !noDeathMode;
			FlxG.sound.play(Paths.sound('Lights_Shut_off'));
			FlxG.log.add("Oke now it's " + noDeathMode);
		}

		if (FlxG.keys.justPressed.FOUR)
		{
			health = 2;
			FlxG.sound.play(Paths.sound('Lights_Shut_off'));
		}
		
		if (FlxG.keys.justPressed.G)
		{
			BG2.x = 3000;
		}
		if (FlxG.keys.justPressed.H)
		{
			FlxG.mouse.visible = true;
		}

		if (FlxG.keys.justPressed.P)
			FlxG.sound.music.time += 10000;
		if (FlxG.keys.justPressed.O)
			FlxG.sound.music.time += 1000;
		if (FlxG.keys.justPressed.I)
			FlxG.sound.music.time -= 1000;
		if (FlxG.keys.justPressed.U)
			FlxG.sound.music.time -= 10000;

		#end

		if (startingSong)
		{
			if (startedCountdown)
			{
				Conductor.songPosition += FlxG.elapsed * 1000;
				if (Conductor.songPosition >= 0)
					startSong();
			}
		}
		else
		{
			// Conductor.songPosition = FlxG.sound.music.time;
			Conductor.songPosition += FlxG.elapsed * 1000;
			/*@:privateAccess
			{
				FlxG.sound.music._channel.
			}*/
			songPositionBar = Conductor.songPosition;

			if (!paused)
			{
				songTime += FlxG.game.ticks - previousFrameTime;
				previousFrameTime = FlxG.game.ticks;

				// Interpolation type beat
				if (Conductor.lastSongPos != Conductor.songPosition)
				{
					songTime = (songTime + Conductor.songPosition) / 2;
					Conductor.lastSongPos = Conductor.songPosition;
					// Conductor.songPosition += FlxG.elapsed * 1000;
					// trace('MISSED FRAME');
				}
			}

			// Conductor.lastSongPos = FlxG.sound.music.time;
		}

		if (generatedMusic && PlayState.SONG.notes[Std.int(curStep / 16)] != null)
		{
			// Make sure Girlfriend cheers only for certain songs
			if(allowedToHeadbang)
			{
				// Don't animate GF if something else is already animating her (eg. train passing)
				if(gf.animation.curAnim.name == 'danceLeft' || gf.animation.curAnim.name == 'danceRight' || gf.animation.curAnim.name == 'idle')
				{
					// Per song treatment since some songs will only have the 'Hey' at certain times
					switch(curSong)
					{
						case 'Philly Nice':
						{
							// General duration of the song
							if(curBeat < 250)
							{
								// Beats to skip or to stop GF from cheering
								if(curBeat != 184 && curBeat != 216)
								{
									if(curBeat % 16 == 8)
									{
										// Just a garantee that it'll trigger just once
										if(!triggeredAlready)
										{
											gf.playAnim('cheer');
											triggeredAlready = true;
										}
									}else triggeredAlready = false;
								}
							}
						}
						case 'Bopeebo':
						{
							// Where it starts || where it ends
							if(curBeat > 5 && curBeat < 130)
							{
								if(curBeat % 8 == 7)
								{
									if(!triggeredAlready)
									{
										gf.playAnim('cheer');
										triggeredAlready = true;
									}
								}else triggeredAlready = false;
							}
						}
						case 'Blammed':
						{
							if(curBeat > 30 && curBeat < 190)
							{
								if(curBeat < 90 || curBeat > 128)
								{
									if(curBeat % 4 == 2)
									{
										if(!triggeredAlready)
										{
											gf.playAnim('cheer');
											triggeredAlready = true;
										}
									}else triggeredAlready = false;
								}
							}
						}
						case 'Cocoa':
						{
							if(curBeat < 170)
							{
								if(curBeat < 65 || curBeat > 130 && curBeat < 145)
								{
									if(curBeat % 16 == 15)
									{
										if(!triggeredAlready)
										{
											gf.playAnim('cheer');
											triggeredAlready = true;
										}
									}else triggeredAlready = false;
								}
							}
						}
						case 'Eggnog':
						{
							if(curBeat > 10 && curBeat != 111 && curBeat < 220)
							{
								if(curBeat % 8 == 7)
								{
									if(!triggeredAlready)
									{
										gf.playAnim('cheer');
										triggeredAlready = true;
									}
								}else triggeredAlready = false;
							}
						}
					}
				}
			}
			
			#if windows
			if (luaModchart != null)
				luaModchart.setVar("mustHit",PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection);
			#end

			if (camFollow.x != dad.getMidpoint().x + 150 && !PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection)
			{
				var offsetX = 0;
				var offsetY = 0;
				#if windows
				if (luaModchart != null)
				{
					offsetX = luaModchart.getVar("followXOffset", "float");
					offsetY = luaModchart.getVar("followYOffset", "float");
				}
				#end
				if (hatturn)
					camFollow.setPosition(hatkid.getMidpoint().x - 100 + offsetX, hatkid.getMidpoint().y - 100 + offsetY);
				else if (roboturn)
					camFollow.setPosition(gf.getMidpoint().x + 150 + offsetX, gf.getMidpoint().y - 100 + offsetY);
				else if (roseturn)
					camFollow.setPosition(lol86.getMidpoint().x + 150 + offsetX, lol86.getMidpoint().y - 100 + offsetY);
				else
					camFollow.setPosition(dad.getMidpoint().x + 150 + offsetX, dad.getMidpoint().y - 100 + offsetY);
				#if windows
				if (luaModchart != null)
					luaModchart.executeState('playerTwoTurn', []);
				#end
				// camFollow.setPosition(lucky.getMidpoint().x - 120, lucky.getMidpoint().y + 210);

				switch (dad.curCharacter)
				{
					case 'mom':
						camFollow.y = dad.getMidpoint().y;
					case 'senpai':
						camFollow.y = dad.getMidpoint().y - 430;
						camFollow.x = dad.getMidpoint().x - 100;
					case 'senpai-angry':
						camFollow.y = dad.getMidpoint().y - 430;
						camFollow.x = dad.getMidpoint().x - 100;
					case 'rebecca4':
						camFollow.y = dad.getMidpoint().y + 100;
					case 'qt-kb':
						camFollow.y = dad.getMidpoint().y + 100;
					case 'qt-kb-night' | 'qt-kb-404':
						if (curSong.toLowerCase() == 'glitcher')
							if (curStep > 567 && curStep < 1087)
								camFollow.y = dad.getMidpoint().y;
							else if (curStep > 1342)
								camFollow.y = dad.getMidpoint().y + 50;
							else
								camFollow.y = dad.getMidpoint().y + 100;
					case 'mom-car' | 'cass':
						camFollow.y = dad.getMidpoint().y + 150;
				}
				if (curStage == 'ejected')
					camFollow.y = 454.8;
				if (curStage == 'ejected' && dad.curCharacter == 'chara')
					camFollow.y = 800;

				if (dad.curCharacter == 'mom')
					vocals.volume = 1;
			}

			if (PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection && camFollow.x != boyfriend.getMidpoint().x - 100)
			{
				var offsetX = 0;
				var offsetY = 0;
				#if windows
				if (luaModchart != null)
				{
					offsetX = luaModchart.getVar("followXOffset", "float");
					offsetY = luaModchart.getVar("followYOffset", "float");
				}
				#end
				if (curStage != 'auditorHell')
					camFollow.setPosition(boyfriend.getMidpoint().x - 100 + offsetX, boyfriend.getMidpoint().y - 100 + offsetY);
				else
					camFollow.setPosition(hatkid.getMidpoint().x + 150 + offsetX, hatkid.getMidpoint().y - 100 + offsetY);
				if (roboturn)
					camFollow.setPosition(gf.getMidpoint().x + 150 + offsetX, gf.getMidpoint().y - 100 + offsetY);
				#if windows
				if (luaModchart != null)
					luaModchart.executeState('playerOneTurn', []);
				#end

				switch (curStage)
				{
					case 'limo':
						camFollow.x = boyfriend.getMidpoint().x - 300;
					case 'mall':
						camFollow.y = boyfriend.getMidpoint().y - 200;
					case 'school':
						camFollow.x = boyfriend.getMidpoint().x - 200;
						camFollow.y = boyfriend.getMidpoint().y - 200;
					case 'schoolEvil':
						camFollow.x = boyfriend.getMidpoint().x - 200;
						camFollow.y = boyfriend.getMidpoint().y - 200;
					case 'hex-night':
						camFollow.y = boyfriend.getMidpoint().y - 150;
					case 'ejected':
						if (!roboturn && !roseturn)
							camFollow.y = 648.5;
				}
				switch (boyfriend.curCharacter)
				{
					case 'nene':
						camFollow.x = boyfriend.getMidpoint().x - 250;
				}
			}
		}

		if (camZooming)
		{
			FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, 0.95);
			camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, 0.95);
			camHUDier.zoom = FlxMath.lerp(1, camHUD.zoom, 0.95);
		}

		FlxG.watch.addQuick("beatShit", curBeat);
		FlxG.watch.addQuick("stepShit", curStep);
		FlxG.watch.addQuick("DAD X", dad.x);
		FlxG.watch.addQuick("DAD Y", dad.y);
		FlxG.watch.addQuick("DAD BUT AGAIN X", dadAgain.x);
		FlxG.watch.addQuick("DAD BUT AGAIN Y", dadAgain.y);
		FlxG.watch.addQuick("BF X", boyfriend.x);
		FlxG.watch.addQuick("BF Y", boyfriend.y);
		FlxG.watch.addQuick("BF BUT AGAIN X", boyfriendAgain.x);
		FlxG.watch.addQuick("BF BUT AGAIN Y", boyfriendAgain.y);
		FlxG.watch.addQuick("camFollow X", camFollow.x);
		FlxG.watch.addQuick("camFollow Y", camFollow.y);

		if (curSong == 'Fresh')
		{
			switch (curBeat)
			{
				case 16:
					camZooming = true;
					gfSpeed = 2;
				case 48:
					gfSpeed = 1;
				case 80:
					gfSpeed = 2;
				case 112:
					gfSpeed = 1;
				case 163:
					// FlxG.sound.music.stop();
					// FlxG.switchState(new TitleState());
			}
		}

		if (curSong == 'Bopeebo')
		{
			switch (curBeat)
			{
				case 128, 129, 130:
					vocals.volume = 0;
					// FlxG.sound.music.stop();
					// FlxG.switchState(new PlayState());
			}
		}

		if (health <= 0 && !noDeathMode)
		{
			boyfriend.stunned = true;

			persistentUpdate = false;
			persistentDraw = false;
			paused = true;

			vocals.stop();
			FlxG.sound.music.stop();

			if (curStage == 'auditorHell')
				openSubState(new GameOverSubstateTiky());
			else if (curStage == 'heaven')
				openSubState(new GameOverSubstateRon(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y, boyfriend.animation.name, boyfriend.animation.curAnim.curFrame));
			else if (curStage == 'sonicFUNSTAGE')
				openSubState(new GameOverSubstateSonic(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
			else if (curStage == 'ejected')
				openSubState(new GameOverSubstateEjected(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
			else
				openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
			#if windows
			// Game Over doesn't get his own variable because it's only used here
			DiscordClient.changePresence("GAME OVER -- " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy),"\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
			#end

			// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		}
 		if (FlxG.save.data.resetButton)
		{
			if(FlxG.keys.justPressed.R)
				{
					boyfriend.stunned = true;

					persistentUpdate = false;
					persistentDraw = false;
					paused = true;
		
					vocals.stop();
					FlxG.sound.music.stop();
		
					openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		
					#if windows
					// Game Over doesn't get his own variable because it's only used here
					DiscordClient.changePresence("GAME OVER -- " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy),"\nAcc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
					#end
		
					// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
				}
		}

		if (unspawnNotes[0] != null)
		{
			if (unspawnNotes[0].strumTime - Conductor.songPosition < 3500)
			{
				var dunceNote:Note = unspawnNotes[0];
				notes.add(dunceNote);

				var index:Int = unspawnNotes.indexOf(dunceNote);
				unspawnNotes.splice(index, 1);
			}
		}

		if (spookyRendered) // move shit around all spooky like
		{
			spookyText.angle = FlxG.random.int(-5, 5); // change its angle between -5 and 5 so it starts shaking violently.
			// tstatic.x = tstatic.x + FlxG.random.int(-2,2); // move it back and fourth to repersent shaking.
			if (tstatic.alpha != 0)
				tstatic.alpha = FlxG.random.float(0.1, 0.5); // change le alpha too :)
		}

		if (generatedMusic)
			{
				notes.forEachAlive(function(daNote:Note)
				{	

					// instead of doing stupid y > FlxG.height
					// we be men and actually calculate the time :)
					if (daNote.tooLate)
					{
						daNote.active = false;
						daNote.visible = false;
					}
					else
					{
						if (!daNote.burning && !daNote.burning2 && curStage == 'jevil')
						{
							daNote.visible = true;
							daNote.active = true;
						}
					}
					
					if (!daNote.modifiedByLua)
						{
							if (PlayStateChangeables.useDownscroll)
							{
								if (daNote.mustPress)
									daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData % 4))].y + 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed, 2));
								else
									daNote.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData % 8))].y + 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed, 2));
								if(daNote.isSustainNote)
								{
									// Remember = minus makes notes go up, plus makes them go down
									if(daNote.animation.curAnim.name.endsWith('end') && daNote.prevNote != null)
										daNote.y += daNote.prevNote.height;
									else
										daNote.y += daNote.height / 2;
	
									// If not in botplay, only clip sustain notes when properly hit, botplay gets to clip it everytime
									if(!PlayStateChangeables.botPlay)
									{
										if((!daNote.mustPress || daNote.wasGoodHit || daNote.prevNote.wasGoodHit && !daNote.canBeHit) && daNote.y - daNote.offset.y * daNote.scale.y + daNote.height >= (strumLine.y + Note.swagWidth / 2))
										{
											// Clip to strumline
											var swagRect = new FlxRect(0, 0, daNote.frameWidth * 2, daNote.frameHeight * 2);
											swagRect.height = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData % 8))].y + Note.swagWidth / 2 - daNote.y) / daNote.scale.y;
											swagRect.y = daNote.frameHeight - swagRect.height;
	
											daNote.clipRect = swagRect;
										}
									}else {
										var swagRect = new FlxRect(0, 0, daNote.frameWidth * 2, daNote.frameHeight * 2);
										swagRect.height = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData % 8))].y + Note.swagWidth / 2 - daNote.y) / daNote.scale.y;
										swagRect.y = daNote.frameHeight - swagRect.height;
	
										daNote.clipRect = swagRect;
									}
								}
							}else
							{
								if (daNote.mustPress)
									daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData % 4))].y - 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed, 2));
								else
									daNote.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData % 8))].y - 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(PlayStateChangeables.scrollSpeed == 1 ? SONG.speed : PlayStateChangeables.scrollSpeed, 2));
								if(daNote.isSustainNote)
								{
									daNote.y -= daNote.height / 2;
	
									if(!PlayStateChangeables.botPlay)
									{
										if((!daNote.mustPress || daNote.wasGoodHit || daNote.prevNote.wasGoodHit && !daNote.canBeHit) && daNote.y + daNote.offset.y * daNote.scale.y <= (strumLine.y + Note.swagWidth / 2))
										{
											// Clip to strumline
											var swagRect = new FlxRect(0, 0, daNote.width / daNote.scale.x, daNote.height / daNote.scale.y);
											swagRect.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData % 8))].y + Note.swagWidth / 2 - daNote.y) / daNote.scale.y;
											swagRect.height -= swagRect.y;
	
											daNote.clipRect = swagRect;
										}
									}else {
										var swagRect = new FlxRect(0, 0, daNote.width / daNote.scale.x, daNote.height / daNote.scale.y);
										swagRect.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData % 8))].y + Note.swagWidth / 2 - daNote.y) / daNote.scale.y;
										swagRect.height -= swagRect.y;
	
										daNote.clipRect = swagRect;
									}
								}
							}
						}
		
	
					if (!daNote.mustPress && daNote.wasGoodHit)
					{
						if (SONG.song != 'Tutorial')
							camZooming = true;

						var altAnim:String = "";
	
						if (SONG.notes[Math.floor(curStep / 16)] != null)
						{
							if (SONG.notes[Math.floor(curStep / 16)].altAnim)
								if ((curSong.toLowerCase() == 'glitcher' && curStep > 567 && curStep < 1087) || (curSong.toLowerCase() == 'endless' && curStep > 1597 && curStep < 1672))
									altAnim = '-kb';
								else if (!(curSong.toLowerCase() == 'endless' && curStep > 1627 && curStep < 1680))
									altAnim = '-alt';
						}
						switch (dad.curCharacter)
						{
							case 'exTricky': // 60% chance
								if (FlxG.random.bool(60) && !spookyRendered && !daNote.isSustainNote) // create spooky text :flushed:
								{
									createSpookyText(HatKidLinesSing[FlxG.random.int(0, HatKidLinesSing.length)], ExTrickyLinesSing[FlxG.random.int(0, ExTrickyLinesSing.length)]);
								}
								switch (Math.abs(daNote.noteData))
								{
									case 2:
										if (tikturn)
											if (!(curBeat >= 532 && curBeat <= 536 && curSong.toLowerCase() == "expurgation"))
												dad.playAnim('singUP' + altAnim, true);
										switch(curStage)
										{
											case 'auditorHell':
												if (hatturn)
												{
													hatkid.playAnim('singUP' + altAnim, true);
													hatSpikes.visible = true;
													if (hatSpikes.animation.finished)
														hatSpikes.animation.play('spike');
												}
												trace('spikes');
												if (tikturn)
												{
													exSpikes.visible = true;
													if (exSpikes.animation.finished)
														exSpikes.animation.play('spike');
												}
										}
									case 3:
										if (tikturn)
											if (!(curBeat >= 532 && curBeat <= 536 && curSong.toLowerCase() == "expurgation"))
												dad.playAnim('singRIGHT' + altAnim, true);
										switch(curStage)
										{
											case 'auditorHell':
												if (hatturn)
												{
													hatkid.playAnim('singLEFT' + altAnim, true);
													hatSpikes.animation.resume();
													trace('go back spikes');
													hatSpikes.animation.finishCallback = function(pog:String) {
														trace('finished');
														hatSpikes.visible = false;
														hatSpikes.animation.finishCallback = null;
													}
												}
												
												exSpikes.animation.resume();
												trace('go back spikes');
												exSpikes.animation.finishCallback = function(pog:String) {
													trace('finished');
													exSpikes.visible = false;
													exSpikes.animation.finishCallback = null;
												}
										}
									case 1:
										if (tikturn)
											if (!(curBeat >= 532 && curBeat <= 536 && curSong.toLowerCase() == "expurgation"))
												dad.playAnim('singDOWN' + altAnim, true);
										switch(curStage)
										{
											case 'auditorHell':
												if (hatturn)
												{
													hatkid.playAnim('singDOWN' + altAnim, true);
													hatSpikes.animation.resume();
													trace('go back spikes');
													hatSpikes.animation.finishCallback = function(pog:String) {
														trace('finished');
														hatSpikes.visible = false;
														hatSpikes.animation.finishCallback = null;
													}
												}
												
												exSpikes.animation.resume();
												trace('go back spikes');
												exSpikes.animation.finishCallback = function(pog:String) {
													trace('finished');
													exSpikes.visible = false;
													exSpikes.animation.finishCallback = null;
												}
										}
									case 0:
										if (tikturn)
											if (!(curBeat >= 532 && curBeat <= 536 && curSong.toLowerCase() == "expurgation"))
												dad.playAnim('singLEFT' + altAnim, true);
										switch(curStage)
										{
											case 'auditorHell':
												if (hatturn)
												{
													hatkid.playAnim('singRIGHT' + altAnim, true);
													hatSpikes.animation.resume();
													trace('go back spikes');
													hatSpikes.animation.finishCallback = function(pog:String) {
														trace('finished');
														hatSpikes.visible = false;
														hatSpikes.animation.finishCallback = null;
													}
												}
												
												exSpikes.animation.resume();
												trace('go back spikes');
												exSpikes.animation.finishCallback = function(pog:String) {
													trace('finished');
													exSpikes.visible = false;
													exSpikes.animation.finishCallback = null;
												}
										}
								}
							default:
								if (roboturn && !roboasbf)
								{
									switch (Math.abs(daNote.noteData))
									{
										case 2:
											gf.playAnim('singUP' + altAnim, true);
										case 3:
											gf.playAnim('singRIGHT' + altAnim, true);
										case 1:
											gf.playAnim('singDOWN' + altAnim, true);
										case 0:
											gf.playAnim('singLEFT' + altAnim, true);
									}
								}
								else if (roseturn)
								{
									switch (Math.abs(daNote.noteData))
									{
										case 2:
											lol86.playAnim('singUP' + altAnim, true);
										case 3:
											lol86.playAnim('singRIGHT' + altAnim, true);
										case 1:
											lol86.playAnim('singDOWN' + altAnim, true);
										case 0:
											lol86.playAnim('singLEFT' + altAnim, true);
									}
								}
								else
								{
									switch (Math.abs(daNote.noteData))
									{
										case 2:
											if (curStage != 'spamton')
											{
												if (dadSinging && !((daNote.burning || daNote.burning2) && curStage == 'jevil'))
													dad.playAnim('singUP' + altAnim, true);
												if (dadAgainSinging || (daNote.burning && curStage == 'jevil'))
													dadAgain.playAnim('singUP' + altAnim, true);
												if (dadAgainSinging || (daNote.burning2 && curStage == 'jevil'))
												{
													dadAgain2.playAnim('singUP' + altAnim, true);
													dadAgain3.playAnim('singUP' + altAnim, true);
												}
											}
											else
											{
												if (dadSinging && !(daNote.burning || daNote.burning2 || daNote.burning3))
													dad.playAnim('singUP' + altAnim, true);
												if (dadAgainSinging || daNote.burning)
													dadAgain.playAnim('singUP' + altAnim, true);
												if (dadAgainSinging || daNote.burning2)
													dadAgain2.playAnim('singUP' + altAnim, true);
												if (dadAgainSinging || daNote.burning3)
													dadAgain3.playAnim('singUP' + altAnim, true);
											}
										case 3:
											if (curStage != 'spamton')
											{
												if (dadSinging && !((daNote.burning || daNote.burning2) && curStage == 'jevil'))
													dad.playAnim('singRIGHT' + altAnim, true);
												if (dadAgainSinging || (daNote.burning && curStage == 'jevil'))
													dadAgain.playAnim('singRIGHT' + altAnim, true);
												if (dadAgainSinging || (daNote.burning2 && curStage == 'jevil'))
												{
													dadAgain2.playAnim('singRIGHT' + altAnim, true);
													dadAgain3.playAnim('singRIGHT' + altAnim, true);
												}
											}
											else
											{
												if (dadSinging && !(daNote.burning || daNote.burning2 || daNote.burning3))
													dad.playAnim('singRIGHT' + altAnim, true);
												if (dadAgainSinging || daNote.burning)
													dadAgain.playAnim('singRIGHT' + altAnim, true);
												if (dadAgainSinging || daNote.burning2)
													dadAgain2.playAnim('singRIGHT' + altAnim, true);
												if (dadAgainSinging || daNote.burning3)
													dadAgain3.playAnim('singRIGHT' + altAnim, true);
											}
										case 1:
											if (curStage != 'spamton')
											{
												if (dadSinging && !((daNote.burning || daNote.burning2) && curStage == 'jevil'))
													dad.playAnim('singDOWN' + altAnim, true);
												if (dadAgainSinging || (daNote.burning && curStage == 'jevil'))
													dadAgain.playAnim('singDOWN' + altAnim, true);
												if (dadAgainSinging || (daNote.burning2 && curStage == 'jevil'))
												{
													dadAgain2.playAnim('singDOWN' + altAnim, true);
													dadAgain3.playAnim('singDOWN' + altAnim, true);
												}
											}
											else
											{
												if (dadSinging && !(daNote.burning || daNote.burning2 || daNote.burning3))
													dad.playAnim('singDOWN' + altAnim, true);
												if (dadAgainSinging || daNote.burning)
													dadAgain.playAnim('singDOWN' + altAnim, true);
												if (dadAgainSinging || daNote.burning2)
													dadAgain2.playAnim('singDOWN' + altAnim, true);
												if (dadAgainSinging || daNote.burning3)
													dadAgain3.playAnim('singDOWN' + altAnim, true);
											}
										case 0:
											if (curStage != 'spamton')
											{
												if (dadSinging && !((daNote.burning || daNote.burning2) && curStage == 'jevil'))
													dad.playAnim('singLEFT' + altAnim, true);
												if (dadAgainSinging || (daNote.burning && curStage == 'jevil'))
													dadAgain.playAnim('singLEFT' + altAnim, true);
												if (dadAgainSinging || (daNote.burning2 && curStage == 'jevil'))
												{
													dadAgain2.playAnim('singLEFT' + altAnim, true);
													dadAgain3.playAnim('singLEFT' + altAnim, true);
												}
											}
											else
											{
												if (dadSinging && !(daNote.burning || daNote.burning2 || daNote.burning3))
													dad.playAnim('singLEFT' + altAnim, true);
												if (dadAgainSinging || daNote.burning)
													dadAgain.playAnim('singLEFT' + altAnim, true);
												if (dadAgainSinging || daNote.burning2)
													dadAgain2.playAnim('singLEFT' + altAnim, true);
												if (dadAgainSinging || daNote.burning3)
													dadAgain3.playAnim('singLEFT' + altAnim, true);
											}
									}
									if (dadSinging)
									{
										switch (dad.curCharacter) {
											case 'ruv':
												FlxG.camera.shake(0.03, 0.03);
										}
									}
									if (dadAgainSinging)
									{
										switch (dadAgain.curCharacter) {
											case 'ruv':
												FlxG.camera.shake(0.03, 0.03);
										}
									}
								}
						}
						if (curStage == 'pegmeplease')
						{
							circ2.angle += 5;
							circ1.angle += 5;
						}
						
						if (FlxG.save.data.cpuStrums)
						{
							cpuStrums.forEach(function(spr:FlxSprite)
							{
								if (Math.abs(daNote.noteData) == spr.ID)
								{
									spr.animation.play('confirm', true);
								}
								if (spr.animation.curAnim.name == 'confirm' && !curStage.startsWith('school'))
								{
									spr.centerOffsets();
									spr.offset.x -= 13;
									spr.offset.y -= 13;
								}
								else
									spr.centerOffsets();
							});
						}
	
						#if windows
						if (luaModchart != null)
							luaModchart.executeState('playerTwoSing', [Math.abs(daNote.noteData), Conductor.songPosition]);
						#end

						dad.holdTimer = 0;
	
						if (SONG.needsVoices && !((daNote.burning || daNote.burning2) && curStage == 'jevil'))
							vocals.volume = 1;
	
						daNote.active = false;


						daNote.kill();
						notes.remove(daNote, true);
						daNote.destroy();
					}

					if (daNote.mustPress && !daNote.modifiedByLua)
					{
						if (!daNote.burning && !daNote.burning2 && curStage == 'jevil')
							daNote.visible = playerStrums.members[Math.floor(Math.abs(daNote.noteData % 4))].visible;
						if (!daNote.burning && !daNote.burning2 && !daNote.burning3)
							daNote.x = playerStrums.members[Math.floor(Math.abs(daNote.noteData % 8))].x;
						else if (curStage != 'spamton')
							daNote.x = playerStrums.members[Math.floor(Math.abs(daNote.noteData % 8))].x - 165;
						else
							daNote.x = playerStrums.members[Math.floor(Math.abs(daNote.noteData % 8))].x;
						if (!daNote.isSustainNote)
							daNote.angle = playerStrums.members[Math.floor(Math.abs(daNote.noteData % 4))].angle;
						daNote.alpha = playerStrums.members[Math.floor(Math.abs(daNote.noteData % 4))].alpha;
					}
					else if (!daNote.wasGoodHit && !daNote.modifiedByLua)
					{
						if (!daNote.burning && !daNote.burning2 && curStage == 'jevil') //RESET
							daNote.visible = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData % 8))].visible;
						if (!daNote.burning && !daNote.burning2 && !daNote.burning3)
							daNote.x = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData % 8))].x;
						else if (curStage != 'spamton')
							daNote.x = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData % 8))].x - 165;
						else
							daNote.x = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData % 8))].x;
						if (!daNote.isSustainNote)
							daNote.angle = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData % 8))].angle;
						daNote.alpha = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData % 8))].alpha;
					}
					
					

					if (daNote.isSustainNote)
						daNote.x += daNote.width / 2 + 17;
					

					//trace(daNote.y);
					// WIP interpolation shit? Need to fix the pause issue
					// daNote.y = (strumLine.y - (songTime - daNote.strumTime) * (0.45 * PlayState.SONG.speed));
	
					if ((daNote.mustPress && daNote.tooLate && !PlayStateChangeables.useDownscroll || daNote.mustPress && daNote.tooLate && PlayStateChangeables.useDownscroll) && daNote.mustPress && !(daNote.burning && curStage == 'AuditorHell'))
					{
							if (daNote.isSustainNote && daNote.wasGoodHit)
							{
								daNote.kill();
								notes.remove(daNote, true);
							}
							else
							{
								if (loadRep && daNote.isSustainNote)
								{
									// im tired and lazy this sucks I know i'm dumb
									if (findByTime(daNote.strumTime) != null)
										totalNotesHit += 1;
									else
									{
										health -= 0.075;
										removal += 0.075;
										vocals.volume = 0;
										if (theFunne)
											noteMiss(daNote.noteData, daNote);
									}
								}
								else
								{
									health -= 0.075;
									removal += 0.075;
									vocals.volume = 0;
									if (theFunne)
										noteMiss(daNote.noteData, daNote);
								}
							}
		
							daNote.visible = false;
							daNote.kill();
							notes.remove(daNote, true);
						}
					
				});
			}

		if (FlxG.save.data.cpuStrums)
		{
			cpuStrums.forEach(function(spr:FlxSprite)
			{
				if (spr.animation.finished)
				{
					spr.animation.play('static');
					spr.centerOffsets();
				}
			});
		}

		if (!inCutscene)
			keyShit();

		if (spookyRendered) // move shit around all spooky like
		{
			spookyText.angle = FlxG.random.int(-5, 5); // change its angle between -5 and 5 so it starts shaking violently.
			// tstatic.x = tstatic.x + FlxG.random.int(-2,2); // move it back and fourth to repersent shaking.
			if (tstatic.alpha != 0)
				tstatic.alpha = FlxG.random.float(0.1, 0.5); // change le alpha too :)
		}


		#if debug
		if (FlxG.keys.justPressed.ONE)
			endSong();
		#end
		/*if (camFollow.x < 0 && curStage == 'pegmeplase')
			camFollow.x = 0;
		if (camFollow.y < 0 && curStage == 'pegmeplase')
			camFollow.y = 0;*/
		if (camFollow.x < 530 && curStage == 'pegmeplease')
			camFollow.x = 530;
		if (camFollow.x > 1100 && curStage == 'pegmeplease')
			camFollow.x = 1100;
		if (camFollow.y > 1400 && curStage == 'pegmeplease')
			camFollow.y = 1400;
		if (camFollow.y < 720 && curStage == 'sonicFUNSTAGE')
			camFollow.y = 720;
		
		if (curBeat == 532 && curSong.toLowerCase() == "expurgation")
			dad.playAnim('Hank', true);
		//trace('Camera X: ${camFollow.x}\nCamera Y: ${camFollow.y}');

		if (gf.animation.finished && gf.animation.curAnim.name == 'GET THE BITCH')
		{
			gf.playAnim('danceRight');
		}

		floatshit += 0.1;
		if (dad.curCharacter == "HCcarol"){
			dad.y += Math.sin(floatshit);
		}
		if (boyfriend.curCharacter == "nonsense-god"){
			boyfriend.y += Math.sin(floatshit);
		}
		if (curStage == 'ejected')
		{
			dad.y += Math.sin(floatshit) * 2;
			boyfriend.y += Math.sin(floatshit) * 2;
			dadAgain.y += Math.sin(floatshit) * 2;
			boyfriendAgain.y += Math.sin(floatshit) * 2;
			gf.y += Math.sin(floatshit) * 2;
			lol86.y += Math.sin(floatshit) * 2;
			amogos.angle += 0.5;
			amogos.y += 2.5;
		}
		switch (boyfriend.curCharacter) {
			case 'selever':
				circSelever.y = boyfriend.y;
				circSelever.x = boyfriend.x - 150;
		}
		switch (boyfriendAgain.curCharacter) {
			case 'selever':
				circSelever.y = boyfriendAgain.y;
				circSelever.x = boyfriendAgain.x - 150;
		}
		if (curStage == 'jevil')
		{
			if (curStep > 111 && curStep < 128 && !songEnded)
				FlxG.camera.shake(0.05, 0.07);
			if (curStep > 121)
			{
				camFollow.x = 715;
				camFollow.y = 400;
				camGame.x = 715;
				camGame.y = 400;
				FlxG.camera.x = 0;
				FlxG.camera.y = 0;
				if (curStep > 127)
				{
					dad.y += Math.sin(floatshit);
					defaultCamZoom = 0.95;
				}
				var dumb = CoolUtil.coolTextFile(Paths.txt('dumb'));
				dumbasstext2.x = 890;
				dumbasstext2.y = 542;
				dumbasstext3.x = 800;
				dumbasstext3.y = 542;
				dumbasstext3.text = '${Math.floor(health * 1000)}';
				if (curStep < 630)
					mic.angle += 2;
				else
					mic.angle = 180;
			}
			if (songEnded)
			{
				var dumb = CoolUtil.coolTextFile(Paths.txt('dumb'));
				camFollow.x = 715;
				camFollow.y = 400;
				camGame.x = 715;
				camGame.y = 400;
				FlxG.camera.x = 0;
				FlxG.camera.y = 0;
				susie.x = 450;
				susie.y = 200;
				kris.x = susie.x + 100;
				kris.y = susie.y + 15;
				ralsei.x = susie.x - 100;
				ralsei.y = susie.y + 9;
			}
		}
		if (curStage == 'spamton')
		{
			string1.x = dad.x + 182 - Math.cos(floatshit);
			string2.x = dad.x + 200 + Math.cos(floatshit);
			string3.x = dad.x + 219 - Math.cos(floatshit);
			string4.x = dad.x + 240 + Math.cos(floatshit);
			string5.x = dad.x + 260 - Math.cos(floatshit);
			heartSheild.angle += 1;
			heartSheild.x = (FlxG.mouse.x / camHUDier.zoom) - 32;
			heartSheild.y = (FlxG.mouse.y / camHUDier.zoom) - 32;
			heartThing.x = heartSheild.x;
			heartThing.y = heartSheild.y;
			dumbasstext2.x = 890;
			dumbasstext2.y = 542;
			dumbasstext3.x = 800;
			dumbasstext3.y = 542;
			dumbasstext3.text = '${Math.floor(health * 1000)}';
			dadAgain.y = -70 + Math.sin(floatshit) * 40;
			dadAgain.x = 300 - Math.sin(floatshit * 0.5) * 160;
			blueSpamton1.y = 260 + Math.sin(floatshit * 0.1) * 160;
			blueSpamton2.y = 260 - Math.sin(floatshit * 0.1) * 160;
			blueSpamton1.x = dad.x;
			blueSpamton2.x = dad.x;
			if (curStep > 530 && curStep < 786)
			{
				gf.x = -200;
				gf.y = -100 + Math.sin(floatshit) * 20;
			}
			else
			{
				gf.x = -270;
				gf.y = 220;
			}
			//var dumb = CoolUtil.coolTextFile(Paths.txt('dumb'));
			//spamtonLarg.x = Std.parseFloat(dumb[0]);
			//spamtonLarg.y = Std.parseFloat(dumb[1]);
			if (curStep > 1168 && curStep < 1210)
			{
				spamtonLargJaw.x = spamtonLarg.x;
				spamtonLargJaw.y = spamtonLarg.y - Math.sin(floatshit) * 10;
				spamtonLargHead.x = spamtonLarg.x;
				spamtonLargHead.y = spamtonLarg.y + Math.sin(floatshit) * 10;
			}
			else if (curStep > 1232)
			{
				spamtonLargHead.x = spamtonLarg.x + (Std.random(50) - 25) + 300;
				spamtonLargHead.y = spamtonLarg.y + (Std.random(50) - 25); //100 1100
			}
			else
			{
				spamtonLargJaw.x = spamtonLarg.x;
				spamtonLargJaw.y = spamtonLarg.y;
				spamtonLargHead.x = spamtonLarg.x;
				spamtonLargHead.y = spamtonLarg.y;
			}
			camFollow.x = 320;
			camFollow.y = 387;
			//BACKGROUND
			if (BG2.x < BG3.x)
			{
				BG3.x = BG2.x + BG2.width * 4;
				BG2.x -= 4;
			}
			else
			{
				BG2.x = BG3.x + BG3.width * 4;
				BG3.x -= 4;
			}
			if (BG2.x < -4000)
				BG2.x = BG3.x + BG3.width * 4;
			if (BG3.x < -4000)
				BG3.x = BG2.x + BG2.width * 4;

			//FOREGROUND
			if (FG1.x < FG2.x)
			{
				FG2.x = FG1.x + FG1.width * 4;
				FG1.x -= 5;
			}
			else
			{
				FG1.x = FG2.x + FG2.width * 4;
				FG2.x -= 5;
			}
			if (FG1.x < -4000)
				FG1.x = FG2.x + FG2.width * 4;
			if (FG2.x < -4000)
				FG2.x = FG1.x + FG1.width * 4;

			//FOREGROUND 2
			if (FG3.x < FG4.x)
			{
				FG4.x = FG3.x + FG3.width * 4;
				FG3.x -= 6;
			}
			else
			{
				FG3.x = FG4.x + FG4.width * 4;
				FG4.x -= 6;
			}
			if (FG3.x < -4000)
				FG3.x = FG4.x + FG4.width * 4;
			if (FG4.x < -4000)
				FG4.x = FG3.x + FG3.width * 4;
			mic.angle += 2;
			dadAgain2.y += Math.sin(floatshit);
			dadAgain3.y += Math.sin(floatshit * 0.67);
			if (ralsei.animation.curAnim.name.startsWith('snap') && ralsei.animation.curAnim.finished)
				ralsei.animation.play('idle');
			if (kris.animation.curAnim.name.startsWith('snap') && kris.animation.curAnim.finished)
			{
				kris.x += 9;
				kris.y += 0;
				kris.animation.play('idle');
			}
			if (susie.animation.curAnim.name.startsWith('snap') && susie.animation.curAnim.finished)
			{
				susie.animation.play('idle');
				susie.x = -120;
				susie.y = 120;
			}
		}

		for (proj in projectiles)
		{
			// CHANGE HOW THE CURSOR LOOKS and check if the projectile is IN the mouse
			if (   proj.getMidpoint().x > heartSheild.x
				&& proj.getMidpoint().x < heartSheild.x + heartSheild.width
				&& proj.getMidpoint().y > heartSheild.y
				&& proj.getMidpoint().y < heartSheild.y + heartSheild.height)
			{
				projectiles.remove(proj);
				proj.kill();
				heartSheild.color = FlxColor.YELLOW;
				new FlxTimer().start(0.1, function(tmr:FlxTimer)
				{
					heartSheild.color = FlxColor.WHITE;
					FlxG.sound.play(Paths.sound('deltarune/snd_bell'), 0.2);
				});
			}
			// CHANGE HOW THE CURSOR LOOKS and check if the projectile is IN the mouse
			if (proj.getMidpoint().x < -130)
			{
				projectiles.remove(proj);
				proj.kill();
				health -= 0.1;
				removal += 0.1;
				deltaruneHit();
			}
		}
	}

	function endSong():Void
	{
		if (useVideo)
			{
				GlobalVideo.get().stop();
				FlxG.stage.window.onFocusOut.remove(focusOut);
				FlxG.stage.window.onFocusIn.remove(focusIn);
				PlayState.instance.remove(PlayState.instance.videoSprite);
			}

		if (isStoryMode)
			campaignMisses = misses;

		if (!loadRep)
			rep.SaveReplay(saveNotes);
		else
		{
			PlayStateChangeables.botPlay = false;
			PlayStateChangeables.scrollSpeed = 1;
			PlayStateChangeables.useDownscroll = false;
		}

		if (FlxG.save.data.fpsCap > 290)
			(cast (Lib.current.getChildAt(0), Main)).setFPSCap(290);

		#if windows
		if (luaModchart != null)
		{
			luaModchart.die();
			luaModchart = null;
		}
		#end

		canPause = false;
		FlxG.sound.music.volume = 0;
		vocals.volume = 0;
		FlxG.sound.music.pause();
		vocals.pause();
		if (SONG.validScore)
		{
			// adjusting the highscore song name to be compatible
			// would read original scores if we didn't change packages
			var songHighscore = StringTools.replace(PlayState.SONG.song, " ", "-");
			switch (songHighscore) {
				case 'Dad-Battle': songHighscore = 'Dadbattle';
				case 'Philly-Nice': songHighscore = 'Philly';
			}

			#if !switch
			Highscore.saveScore(songHighscore, Math.round(songScore), storyDifficulty);
			Highscore.saveCombo(songHighscore, Ratings.GenerateLetterRank(accuracy), storyDifficulty);
			#end
		}

		if (offsetTesting)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			offsetTesting = false;
			LoadingState.loadAndSwitchState(new OptionsMenu());
			FlxG.save.data.offset = offsetTest;
		}
		else
		{
			if (isStoryMode)
			{
				campaignScore += Math.round(songScore);

				storyPlaylist.remove(storyPlaylist[0]);

				if (storyPlaylist.length <= 0)
				{
					transIn = FlxTransitionableState.defaultTransIn;
					transOut = FlxTransitionableState.defaultTransOut;

					paused = true;

					FlxG.sound.music.stop();
					vocals.stop();
					if (FlxG.save.data.scoreScreen)
						openSubState(new ResultsScreen());
					else
					{
						FlxG.sound.playMusic(Paths.music('freakyMenu'));
						FlxG.switchState(new MainMenuState());
					}

					#if windows
					if (luaModchart != null)
					{
						luaModchart.die();
						luaModchart = null;
					}
					#end

					// if ()
					StoryMenuState.weekUnlocked[Std.int(Math.min(storyWeek + 1, StoryMenuState.weekUnlocked.length - 1))] = true;

					if (SONG.validScore)
					{
						NGio.unlockMedal(60961);
						Highscore.saveWeekScore(storyWeek, campaignScore, storyDifficulty);
					}

					FlxG.save.data.weekUnlocked = StoryMenuState.weekUnlocked;
					FlxG.save.flush();
				}
				else
				{
					
					// adjusting the song name to be compatible
					var songFormat = StringTools.replace(PlayState.storyPlaylist[0], " ", "-");
					switch (songFormat) {
						case 'Dad-Battle': songFormat = 'Dadbattle';
						case 'Philly-Nice': songFormat = 'Philly';
					}

					var poop:String = Highscore.formatSong(songFormat, storyDifficulty);

					trace('LOADING NEXT SONG');
					trace(poop);

					if (StringTools.replace(PlayState.storyPlaylist[0], " ", "-").toLowerCase() == 'eggnog')
					{
						var blackShit:FlxSprite = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
							-FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
						blackShit.scrollFactor.set();
						add(blackShit);
						camHUD.visible = false;

						FlxG.sound.play(Paths.sound('Lights_Shut_off'));
					}

					FlxTransitionableState.skipNextTransIn = true;
					FlxTransitionableState.skipNextTransOut = true;
					prevCamFollow = camFollow;


					PlayState.SONG = Song.loadFromJson(poop, PlayState.storyPlaylist[0]);
					FlxG.sound.music.stop();

					LoadingState.loadAndSwitchState(new PlayState());
					songEnded = true;
				}
			}
			else
			{
				trace('WENT BACK TO FREEPLAY??');

				paused = true;
				songEnded = true;


				FlxG.sound.music.stop();
				vocals.stop();

				if (FlxG.save.data.scoreScreen)
					openSubState(new ResultsScreen());
				else
					FlxG.switchState(new PlayState());
			}
		}
	}

	function funnifunction():Void
	{
		songEnded = true;
		canPause = false;
		FlxG.sound.music.volume = 0;
		vocals.volume = 0;
		FlxG.sound.music.pause();
		vocals.pause();
	}
	function funnierfunction():Void
	{
		FlxG.sound.play(Paths.sound('deltarune/gun'), 1);
		var timepiece = new FlxSprite().loadGraphic(Paths.image('the sunday revolving/timepiece'));
		timepiece.setGraphicSize(Std.int(mic.width * 3));
		timepiece.screenCenter(X);
		timepiece.y = -1500;
		timepiece.cameras = [camHUDier];
		add(timepiece);
		FlxTween.tween(timepiece, {y: dialogueBoxDelta.y - 300, angle: 360}, 1, {
			onComplete: function(twn:FlxTween)
			{
				FlxG.sound.play(Paths.sound('snd_scytheburst'), 1);
				var BANG:FlxSprite;
				BANG = new FlxSprite().makeGraphic(FlxG.width,720, FlxColor.WHITE);
				BANG.cameras = [camHUDier];
				add(BANG);
				remove(timepiece);
				BG2.visible = false;
				dialogueBoxDelta.visible = false;
				dad.visible = false;
				dadAgain.visible = false;
				dadAgain2.visible = false;
				dadAgain3.visible = false;
				boyfriend.visible = false;
				gf.visible = false;
				dumbasstext2.visible = false;
				dumbasstext3.visible = false;
				dumbasstext4.visible = false;
				healthBar.visible = false;
				susie.visible = false;
				ralsei.visible = false;
				kris.visible = false;
				FlxTween.tween(BANG, {alpha: 0}, 3, {
					onComplete: function(twn:FlxTween)
					{
						FlxG.sound.play(Paths.sound('deltarune/laugh'), 1);
						remove(BANG);
						new FlxTimer().start(3, function(tmr:FlxTimer)
						{
							endSong();
						});
					}
				});
			}
		});
	}
	function funniestfunction():Void
	{
		dumbasstext4.visible = false;
		ralsei.animation.play('snap');
		susie.animation.play('snap');
		kris.animation.play('snap');
		susie.x = -130;
		susie.y = 60;
		kris.x -= 9;
		kris.y -= 0;
		FlxG.sound.play(Paths.sound('deltarune/snd_damage'), 1);
		var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image('snap'));
		comboSpr.screenCenter();
		comboSpr.x = dad.x + 200;
		comboSpr.y = dad.y;
		comboSpr.acceleration.y = 600;
		comboSpr.velocity.y -= 150;
		comboSpr.velocity.x += FlxG.random.int(1, 10);
		comboSpr.cameras = [camHUDier];
		comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.5));
		comboSpr.antialiasing = true;
		add(comboSpr);
		FlxTween.tween(string3, {y: -2000}, 2.5, {
			ease: FlxEase.cubeIn,
		});
		new FlxTimer().start(0.5, function(tmr:FlxTimer)
		{
			System.exit(0);
		});
	}

	var endingSong:Bool = false;

	var hits:Array<Float> = [];
	var offsetTest:Float = 0;

	var timeShown = 0;
	var currentTimingShown:FlxText = null;

	private function popUpScore(daNote:Note):Void
		{
			var noteDiff:Float = -(daNote.strumTime - Conductor.songPosition);
			var wife:Float = EtternaFunctions.wife3(-noteDiff, Conductor.timeScale);
			// boyfriend.playAnim('hey');
			vocals.volume = 1;
			var placement:String = Std.string(combo);
	
			var coolText:FlxText = new FlxText(0, 0, 0, placement, 32);
			coolText.screenCenter();
			coolText.x = FlxG.width * 0.55;
			coolText.y -= 350;
			coolText.cameras = [camHUD];
			//
	
			var rating:FlxSprite = new FlxSprite();
			var score:Float = 350;

			if (FlxG.save.data.accuracyMod == 1)
				totalNotesHit += wife;

			var daRating = daNote.rating;

			switch(daRating)
			{
				case 'shit':
					score = -300;
					combo = 0;
					misses++;
					health -= 0.2;
					removal += 0.2;
					deltaruneHit();
					interupt = true;
					ss = false;
					shits++;
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 0.25;
				case 'bad':
					daRating = 'bad';
					score = 0;
					health -= 0.06;
					removal += 0.06;
					deltaruneHit();
					interupt = true;
					ss = false;
					bads++;
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 0.50;
				case 'good':
					daRating = 'good';
					score = 200;
					ss = false;
					goods++;
					if (health < 2 && !grabbed)
					{
						health += 0.04;
						addition += 0.04;
						deltaruneHeal();
					}
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 0.75;
				case 'sick':
					if (health < 2 && !grabbed)
					{
						health += 0.1;
						addition += 0.1;
						deltaruneHeal();
					}
					if (FlxG.save.data.accuracyMod == 0)
						totalNotesHit += 1;
					sicks++;
			}

			// trace('Wife accuracy loss: ' + wife + ' | Rating: ' + daRating + ' | Score: ' + score + ' | Weight: ' + (1 - wife));

			if (daRating != 'shit' || daRating != 'bad')
				{
	
	
			songScore += Math.round(score);
			songScoreDef += Math.round(ConvertScore.convertScore(noteDiff));
	
			/* if (combo > 60)
					daRating = 'sick';
				else if (combo > 12)
					daRating = 'good'
				else if (combo > 4)
					daRating = 'bad';
			 */
	
			var pixelShitPart1:String = "";
			var pixelShitPart2:String = '';
	
			if (curStage.startsWith('school'))
			{
				pixelShitPart1 = 'weeb/pixelUI/';
				pixelShitPart2 = '-pixel';
			}
	
			rating.loadGraphic(Paths.image(pixelShitPart1 + daRating + pixelShitPart2));
			rating.screenCenter();
			rating.y -= 50;
			rating.x = coolText.x - 125;
			
			if (FlxG.save.data.changedHit)
			{
				rating.x = FlxG.save.data.changedHitX;
				rating.y = FlxG.save.data.changedHitY;
			}
			rating.acceleration.y = 550;
			rating.velocity.y -= FlxG.random.int(140, 175);
			rating.velocity.x -= FlxG.random.int(0, 10);
			
			var msTiming = HelperFunctions.truncateFloat(noteDiff, 3);
			if(PlayStateChangeables.botPlay && !loadRep) msTiming = 0;		
			
			if (loadRep)
				msTiming = HelperFunctions.truncateFloat(findByTime(daNote.strumTime)[3], 3);

			if (currentTimingShown != null)
				remove(currentTimingShown);

			currentTimingShown = new FlxText(0,0,0,"0ms");
			timeShown = 0;
			switch(daRating)
			{
				case 'shit' | 'bad':
					currentTimingShown.color = FlxColor.RED;
				case 'good':
					currentTimingShown.color = FlxColor.GREEN;
				case 'sick':
					currentTimingShown.color = FlxColor.CYAN;
			}
			currentTimingShown.borderStyle = OUTLINE;
			currentTimingShown.borderSize = 1;
			currentTimingShown.borderColor = FlxColor.BLACK;
			currentTimingShown.text = msTiming + "ms";
			currentTimingShown.size = 20;

			if (msTiming >= 0.03 && offsetTesting)
			{
				//Remove Outliers
				hits.shift();
				hits.shift();
				hits.shift();
				hits.pop();
				hits.pop();
				hits.pop();
				hits.push(msTiming);

				var total = 0.0;

				for(i in hits)
					total += i;
				

				
				offsetTest = HelperFunctions.truncateFloat(total / hits.length,2);
			}

			if (currentTimingShown.alpha != 1)
				currentTimingShown.alpha = 1;

			if(!PlayStateChangeables.botPlay || loadRep) add(currentTimingShown);
			
			var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'combo' + pixelShitPart2));
			comboSpr.screenCenter();
			comboSpr.x = rating.x;
			comboSpr.y = rating.y + 100;
			comboSpr.acceleration.y = 600;
			comboSpr.velocity.y -= 150;

			currentTimingShown.screenCenter();
			currentTimingShown.x = comboSpr.x + 100;
			currentTimingShown.y = rating.y + 100;
			currentTimingShown.acceleration.y = 600;
			currentTimingShown.velocity.y -= 150;
	
			comboSpr.velocity.x += FlxG.random.int(1, 10);
			currentTimingShown.velocity.x += comboSpr.velocity.x;
			if(!PlayStateChangeables.botPlay || loadRep) add(rating);
	
			if (!curStage.startsWith('school'))
			{
				rating.setGraphicSize(Std.int(rating.width * 0.7));
				rating.antialiasing = true;
				comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.7));
				comboSpr.antialiasing = true;
			}
			else
			{
				rating.setGraphicSize(Std.int(rating.width * daPixelZoom * 0.7));
				comboSpr.setGraphicSize(Std.int(comboSpr.width * daPixelZoom * 0.7));
			}
	
			currentTimingShown.updateHitbox();
			comboSpr.updateHitbox();
			rating.updateHitbox();
	
			currentTimingShown.cameras = [camHUD];
			comboSpr.cameras = [camHUD];
			rating.cameras = [camHUD];

			var seperatedScore:Array<Int> = [];
	
			var comboSplit:Array<String> = (combo + "").split('');

			if (combo > highestCombo)
				highestCombo = combo;

			// make sure we have 3 digits to display (looks weird otherwise lol)
			if (comboSplit.length == 1)
			{
				seperatedScore.push(0);
				seperatedScore.push(0);
			}
			else if (comboSplit.length == 2)
				seperatedScore.push(0);

			for(i in 0...comboSplit.length)
			{
				var str:String = comboSplit[i];
				seperatedScore.push(Std.parseInt(str));
			}
	
			var daLoop:Int = 0;
			for (i in seperatedScore)
			{
				var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'num' + Std.int(i) + pixelShitPart2));
				numScore.screenCenter();
				numScore.x = rating.x + (43 * daLoop) - 50;
				numScore.y = rating.y + 100;
				numScore.cameras = [camHUD];

				if (!curStage.startsWith('school'))
				{
					numScore.antialiasing = true;
					numScore.setGraphicSize(Std.int(numScore.width * 0.5));
				}
				else
				{
					numScore.setGraphicSize(Std.int(numScore.width * daPixelZoom));
				}
				numScore.updateHitbox();
	
				numScore.acceleration.y = FlxG.random.int(200, 300);
				numScore.velocity.y -= FlxG.random.int(140, 160);
				numScore.velocity.x = FlxG.random.float(-5, 5);
	
				add(numScore);
	
				FlxTween.tween(numScore, {alpha: 0}, 0.2, {
					onComplete: function(tween:FlxTween)
					{
						numScore.destroy();
					},
					startDelay: Conductor.crochet * 0.002
				});
	
				daLoop++;
			}
			/* 
				trace(combo);
				trace(seperatedScore);
			 */
	
			coolText.text = Std.string(seperatedScore);
			// add(coolText);
	
			FlxTween.tween(rating, {alpha: 0}, 0.2, {
				startDelay: Conductor.crochet * 0.001,
				onUpdate: function(tween:FlxTween)
				{
					if (currentTimingShown != null)
						currentTimingShown.alpha -= 0.02;
					timeShown++;
				}
			});

			FlxTween.tween(comboSpr, {alpha: 0}, 0.2, {
				onComplete: function(tween:FlxTween)
				{
					coolText.destroy();
					comboSpr.destroy();
					if (currentTimingShown != null && timeShown >= 20)
					{
						remove(currentTimingShown);
						currentTimingShown = null;
					}
					rating.destroy();
				},
				startDelay: Conductor.crochet * 0.001
			});
	
			curSection += 1;
			}
		}

	public function NearlyEquals(value1:Float, value2:Float, unimportantDifference:Float = 10):Bool
		{
			return Math.abs(FlxMath.roundDecimal(value1, 1) - FlxMath.roundDecimal(value2, 1)) < unimportantDifference;
		}

		var upHold:Bool = false;
		var downHold:Bool = false;
		var rightHold:Bool = false;
		var leftHold:Bool = false;	

		private function keyShit():Void // I've invested in emma stocks
			{

				//Dodge code only works on termination -Haz
				//No u -Robo
				if(SONG.song.toLowerCase() == "glitcher"){
					//Dodge code, yes it's bad but oh well. -Haz
					//var dodgeButton = controls.ACCEPT; //I have no idea how to add custom controls so fuck it. -Haz
		
					if(FlxG.keys.justPressed.SPACE)
						trace('butttonpressed');
		
					if(FlxG.keys.justPressed.SPACE && !bfDodging && bfCanDodge){
						trace('DODGE START!');
						bfDodging = true;
						bfCanDodge = false;
		
						//if(qtIsBlueScreened)
							//boyfriend404.playAnim('dodge');
						//else
							boyfriend.playAnim('dodge');
		
						FlxG.sound.play(Paths.sound('dodge01'));
		
						//Wait, then set bfDodging back to false. -Haz
						new FlxTimer().start(0.225, function(tmr:FlxTimer)
						{
							bfDodging=false;
							trace('DODGE END!');
							//Cooldown timer so you can't keep spamming it.
							new FlxTimer().start(0.1125, function(tmr:FlxTimer)
							{
								bfCanDodge=true;
								trace('DODGE RECHARGED!');
							});
						});
					}
				}

				// control arrays, order L D R U
				var holdArray:Array<Bool> = [controls.LEFT, controls.DOWN, controls.UP, controls.RIGHT];
				var pressArray:Array<Bool> = [
					controls.LEFT_P,
					controls.DOWN_P,
					controls.UP_P,
					controls.RIGHT_P
				];
				var releaseArray:Array<Bool> = [
					controls.LEFT_R,
					controls.DOWN_R,
					controls.UP_R,
					controls.RIGHT_R
				];
				#if windows
				if (luaModchart != null){
				if (controls.LEFT_P){luaModchart.executeState('keyPressed',["left"]);};
				if (controls.DOWN_P){luaModchart.executeState('keyPressed',["down"]);};
				if (controls.UP_P){luaModchart.executeState('keyPressed',["up"]);};
				if (controls.RIGHT_P){luaModchart.executeState('keyPressed',["right"]);};
				};
				#end
		 
				// Prevent player input if botplay is on
				if(PlayStateChangeables.botPlay)
				{
					holdArray = [false, false, false, false];
					pressArray = [false, false, false, false];
					releaseArray = [false, false, false, false];
				} 
				// HOLDS, check for sustain notes
				if (holdArray.contains(true) && /*!boyfriend.stunned && */ generatedMusic)
				{
					notes.forEachAlive(function(daNote:Note)
					{
						if (daNote.isSustainNote && daNote.canBeHit && daNote.mustPress && holdArray[daNote.noteData])
							goodNoteHit(daNote);
					});
				}
		 
				// PRESSES, check for note hits
				if (pressArray.contains(true) && /*!boyfriend.stunned && */ generatedMusic)
				{
					boyfriend.holdTimer = 0;
		 
					var possibleNotes:Array<Note> = []; // notes that can be hit
					var directionList:Array<Int> = []; // directions that can be hit
					var dumbNotes:Array<Note> = []; // notes to kill later
					var directionsAccounted:Array<Bool> = [false,false,false,false]; // we don't want to do judgments for more than one presses
					
					notes.forEachAlive(function(daNote:Note)
					{
						if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit)
						{
							if (!directionsAccounted[daNote.noteData])
							{
								if (directionList.contains(daNote.noteData))
								{
									directionsAccounted[daNote.noteData] = true;
									for (coolNote in possibleNotes)
									{
										if (coolNote.noteData == daNote.noteData && Math.abs(daNote.strumTime - coolNote.strumTime) < 10)
										{ // if it's the same note twice at < 10ms distance, just delete it
											// EXCEPT u cant delete it in this loop cuz it fucks with the collection lol
											dumbNotes.push(daNote);
											break;
										}
										else if (coolNote.noteData == daNote.noteData && daNote.strumTime < coolNote.strumTime)
										{ // if daNote is earlier than existing note (coolNote), replace
											possibleNotes.remove(coolNote);
											possibleNotes.push(daNote);
											break;
										}
									}
								}
								else
								{
									possibleNotes.push(daNote);
									directionList.push(daNote.noteData);
								}
							}
						}
					});

					for (note in dumbNotes)
					{
						FlxG.log.add("killing dumb ass note at " + note.strumTime);
						note.kill();
						notes.remove(note, true);
						note.destroy();
					}
		 
					possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
		 
					var dontCheck = false;

					for (i in 0...pressArray.length)
					{
						if (pressArray[i] && !directionList.contains(i))
							dontCheck = true;
					}

					if (perfectMode)
						goodNoteHit(possibleNotes[0]);
					else if (possibleNotes.length > 0 && !dontCheck)
					{
						if (!FlxG.save.data.ghost)
						{
							for (shit in 0...pressArray.length)
								{ // if a direction is hit that shouldn't be
									if (pressArray[shit] && !directionList.contains(shit))
										noteMiss(shit, null);
								}
						}
						for (coolNote in possibleNotes)
						{
							if (pressArray[coolNote.noteData])
							{
								if (mashViolations != 0)
									mashViolations--;
								scoreTxt.color = FlxColor.WHITE;
								trace(coolNote.burning);
								if (coolNote.burning && curStage == 'auditorHell')
								{
									// lol death
									health = 0;
									shouldBeDead = true;
									FlxG.sound.play(Paths.sound('death', 'shared'));
								}
								else
									goodNoteHit(coolNote);
							}
						}
					}
					else if (!FlxG.save.data.ghost)
						{
							for (shit in 0...pressArray.length)
								if (pressArray[shit])
									noteMiss(shit, null);
						}

					if(dontCheck && possibleNotes.length > 0 && FlxG.save.data.ghost && !PlayStateChangeables.botPlay)
					{
						if (mashViolations > 8)
						{
							trace('mash violations ' + mashViolations);
							scoreTxt.color = FlxColor.RED;
							noteMiss(0,null);
						}
						else
							mashViolations++;
					}

				}
				
				notes.forEachAlive(function(daNote:Note)
				{
					if(PlayStateChangeables.useDownscroll && daNote.y > strumLine.y ||
					!PlayStateChangeables.useDownscroll && daNote.y < strumLine.y)
					{
						// Force good note hit regardless if it's too late to hit it or not as a fail safe
						if(PlayStateChangeables.botPlay && daNote.canBeHit && daNote.mustPress ||
						PlayStateChangeables.botPlay && daNote.tooLate && daNote.mustPress)
						{
							if(loadRep)
							{
								//trace('ReplayNote ' + tmpRepNote.strumtime + ' | ' + tmpRepNote.direction);
								var n = findByTime(daNote.strumTime);
								trace(n);
								if(n != null)
								{
									goodNoteHit(daNote);
									boyfriend.holdTimer = daNote.sustainLength;
								}
							}else {
								goodNoteHit(daNote);
								boyfriend.holdTimer = daNote.sustainLength;
							}
						}
					}
				});
				
				if (boyfriend.holdTimer > Conductor.stepCrochet * 4 * 0.001 && (!holdArray.contains(true) || PlayStateChangeables.botPlay))
				{
					if (boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss') && !bfDodging)
					{
						boyfriend.playAnim('idle');
						boyfriendAgain.playAnim('idle');
					}
				}
		 
				playerStrums.forEach(function(spr:FlxSprite)
				{
					if (pressArray[spr.ID] && spr.animation.curAnim.name != 'confirm')
						spr.animation.play('pressed');
					if (!holdArray[spr.ID])
						spr.animation.play('static');
		 
					if (spr.animation.curAnim.name == 'confirm' && !curStage.startsWith('school'))
					{
						spr.centerOffsets();
						spr.offset.x -= 13;
						spr.offset.y -= 13;
					}
					else
						spr.centerOffsets();
				});
			}

			public function findByTime(time:Float):Array<Dynamic>
				{
					for (i in rep.replay.songNotes)
					{
						//trace('checking ' + Math.round(i[0]) + ' against ' + Math.round(time));
						if (i[0] == time)
							return i;
					}
					return null;
				}

			public var fuckingVolume:Float = 1;
			public var useVideo = false;

			public static var webmHandler:WebmHandler;

			public var playingDathing = false;

			public var videoSprite:FlxSprite;

			public function focusOut() {
				if (paused)
					return;
				persistentUpdate = false;
				persistentDraw = true;
				paused = true;
		
					if (FlxG.sound.music != null)
					{
						FlxG.sound.music.pause();
						vocals.pause();
					}
		
				openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
			}
			public function focusIn() 
			{ 
				// nada 
			}


			public function backgroundVideo(source:String) // for background videos
				{
					useVideo = true;
			
					FlxG.stage.window.onFocusOut.add(focusOut);
					FlxG.stage.window.onFocusIn.add(focusIn);

					var ourSource:String = "assets/videos/daWeirdVid/dontDelete.webm";
					WebmPlayer.SKIP_STEP_LIMIT = 90;
					var str1:String = "WEBM SHIT"; 
					webmHandler = new WebmHandler();
					webmHandler.source(ourSource);
					webmHandler.makePlayer();
					webmHandler.webm.name = str1;
			
					GlobalVideo.setWebm(webmHandler);

					GlobalVideo.get().source(source);
					GlobalVideo.get().clearPause();
					if (GlobalVideo.isWebm)
					{
						GlobalVideo.get().updatePlayer();
					}
					GlobalVideo.get().show();
			
					if (GlobalVideo.isWebm)
					{
						GlobalVideo.get().restart();
					} else {
						GlobalVideo.get().play();
					}
					
					var data = webmHandler.webm.bitmapData;
			
					videoSprite = new FlxSprite(-470,-30).loadGraphic(data);
			
					videoSprite.setGraphicSize(Std.int(videoSprite.width * 1.2));
			
					remove(gf);
					remove(boyfriend);
					remove(dad);
					add(videoSprite);
					add(gf);
					add(boyfriend);
					add(dad);
			
					trace('poggers');
			
					if (!songStarted)
						webmHandler.pause();
					else
						webmHandler.resume();
				}

	function noteMiss(direction:Int = 1, daNote:Note):Void
	{
		if (!boyfriend.stunned)
		{
			health -= 0.04;
			removal += 0.04;
			if (combo > 5 && gf.animOffsets.exists('sad'))
			{
				if (!gf.animation.curAnim.name.startsWith('help') && !gf.animation.curAnim.name.startsWith('please') && !gf.animation.curAnim.name.startsWith('OI') && !gf.animation.curAnim.name.startsWith('come saw') && !gf.animation.curAnim.name.startsWith('GET THE BITCH') && !gf.animation.curAnim.name.startsWith('go saw'))
					gf.playAnim('sad');
			}
			combo = 0;
			interupt = true;
			misses++;

			if (daNote != null)
			{
				if (!loadRep)
					saveNotes.push([daNote.strumTime,0,direction,166 * Math.floor((PlayState.rep.replay.sf / 60) * 1000) / 166]);
			}
			else
				if (!loadRep)
					saveNotes.push([Conductor.songPosition,0,direction,166 * Math.floor((PlayState.rep.replay.sf / 60) * 1000) / 166]);

			//var noteDiff:Float = Math.abs(daNote.strumTime - Conductor.songPosition);
			//var wife:Float = EtternaFunctions.wife3(noteDiff, FlxG.save.data.etternaMode ? 1 : 1.7);

			if (FlxG.save.data.accuracyMod == 1)
				totalNotesHit -= 1;

			songScore -= 10;
			if ((curStage == 'jevil' && curStep > 127) || (curStage == 'spamton' && !daNote.spamton))
			{
				deltaruneHit();
			}
			else
				FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
			// FlxG.sound.play(Paths.sound('missnote1'), 1, false);
			// FlxG.log.add('played imss note');
			if ((roboasbf && roboturn && !daNote.burning && curStage != 'spamton') || (daNote.burning && curStage == 'spamton'))
			{
				gf.playAnim('sad', true);
			}
			if (boyfriend.hasFail && boyfriendSinging)
			{
				switch (direction)
				{
					case 0:
						boyfriend.playAnim('singLEFTmiss', true);
					case 1:
						boyfriend.playAnim('singDOWNmiss', true);
					case 2:
						boyfriend.playAnim('singUPmiss', true);
					case 3:
						boyfriend.playAnim('singRIGHTmiss', true);
				}
			}
			if (boyfriendAgain.hasFail && boyfriendAgainSinging)
			{
				switch (direction)
				{
					case 0:
						boyfriendAgain.playAnim('singLEFTmiss', true);
					case 1:
						boyfriendAgain.playAnim('singDOWNmiss', true);
					case 2:
						boyfriendAgain.playAnim('singUPmiss', true);
					case 3:
						boyfriendAgain.playAnim('singRIGHTmiss', true);
				}
			}

			#if windows
			if (luaModchart != null)
				luaModchart.executeState('playerOneMiss', [direction, Conductor.songPosition]);
			#end


			updateAccuracy();
		}
	}

	/*function badNoteCheck()
		{
			// just double pasting this shit cuz fuk u
			// REDO THIS SYSTEM!
			var upP = controls.UP_P;
			var rightP = controls.RIGHT_P;
			var downP = controls.DOWN_P;
			var leftP = controls.LEFT_P;
	
			if (leftP)
				noteMiss(0);
			if (upP)
				noteMiss(2);
			if (rightP)
				noteMiss(3);
			if (downP)
				noteMiss(1);
			updateAccuracy();
		}
	*/
	function updateAccuracy() 
		{
			totalPlayed += 1;
			accuracy = Math.max(0,totalNotesHit / totalPlayed * 100);
			accuracyDefault = Math.max(0, totalNotesHitDefault / totalPlayed * 100);
		}


	function getKeyPresses(note:Note):Int
	{
		var possibleNotes:Array<Note> = []; // copypasted but you already know that

		notes.forEachAlive(function(daNote:Note)
		{
			if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate)
			{
				possibleNotes.push(daNote);
				possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
			}
		});
		if (possibleNotes.length == 1)
			return possibleNotes.length + 1;
		return possibleNotes.length;
	}
	
	var mashing:Int = 0;
	var mashViolations:Int = 0;

	var etternaModeScore:Int = 0;

	function noteCheck(controlArray:Array<Bool>, note:Note):Void // sorry lol
		{
			var noteDiff:Float = -(note.strumTime - Conductor.songPosition);

			note.rating = Ratings.CalculateRating(noteDiff, Math.floor((PlayStateChangeables.safeFrames / 60) * 1000));

			/* if (loadRep)
			{
				if (controlArray[note.noteData])
					goodNoteHit(note, false);
				else if (rep.replay.keyPresses.length > repPresses && !controlArray[note.noteData])
				{
					if (NearlyEquals(note.strumTime,rep.replay.keyPresses[repPresses].time, 4))
					{
						goodNoteHit(note, false);
					}
				}
			} */
			
			if (controlArray[note.noteData])
			{
				goodNoteHit(note, (mashing > getKeyPresses(note)));
				
				/*if (mashing > getKeyPresses(note) && mashViolations <= 2)
				{
					mashViolations++;

					goodNoteHit(note, (mashing > getKeyPresses(note)));
				}
				else if (mashViolations > 2)
				{
					// this is bad but fuck you
					playerStrums.members[0].animation.play('static');
					playerStrums.members[1].animation.play('static');
					playerStrums.members[2].animation.play('static');
					playerStrums.members[3].animation.play('static');
					health -= 0.4;
					trace('mash ' + mashing);
					if (mashing != 0)
						mashing = 0;
				}
				else
					goodNoteHit(note, false);*/

			}
		}

		function goodNoteHit(note:Note, resetMashViolation = true):Void
			{

				if (mashing != 0)
					mashing = 0;

				var noteDiff:Float = -(note.strumTime - Conductor.songPosition);

				if(loadRep)
					noteDiff = findByTime(note.strumTime)[3];

				note.rating = Ratings.CalculateRating(noteDiff);

				if (note.rating == "miss")
					return;	

				// add newest note to front of notesHitArray
				// the oldest notes are at the end and are removed first
				if (!note.isSustainNote)
					notesHitArray.unshift(Date.now());

				if (!resetMashViolation && mashViolations >= 1)
					mashViolations--;

				if (mashViolations < 0)
					mashViolations = 0;

				if (!note.wasGoodHit)
				{
					if (!note.isSustainNote)
					{
						popUpScore(note);
						combo += 1;
					}
					else
						totalNotesHit += 1;
	

					if (note.spamton && note.burning)
					{
						if (!PlayStateChangeables.botPlay)
						{
							trace('HELLO');
							health -= 0.1;
							removal += 0.1;
							deltaruneHit();
						}
					}
					switch (note.noteData)
					{
						case 2:
							if (boyfriendSinging && !note.burning)
								boyfriend.playAnim('singUP', true);
							if (boyfriendAgainSinging)
								boyfriendAgain.playAnim('singUP', true);
							if ((roboasbf && roboturn && !note.burning && curStage != 'spamton') || (note.burning && curStage == 'spamton'))
							{
								gf.playAnim('singUP', true);
							}
						case 3:
							if (boyfriendSinging && !note.burning)
								boyfriend.playAnim('singRIGHT', true);
							if (boyfriendAgainSinging)
								boyfriendAgain.playAnim('singRIGHT', true);
							if ((roboasbf && roboturn && !note.burning && curStage != 'spamton') || (note.burning && curStage == 'spamton'))
								gf.playAnim('singRIGHT', true);
						case 1:
							if (boyfriendSinging && !note.burning)
								boyfriend.playAnim('singDOWN', true);
							if (boyfriendAgainSinging)
								boyfriendAgain.playAnim('singDOWN', true);
							if ((roboasbf && roboturn && !note.burning && curStage != 'spamton') || (note.burning && curStage == 'spamton'))
								gf.playAnim('singDOWN', true);
						case 0:
							if (boyfriendSinging && !note.burning)
								boyfriend.playAnim('singLEFT', true);
							if (boyfriendAgainSinging)
								boyfriendAgain.playAnim('singLEFT', true);
							if ((roboasbf && roboturn && !note.burning && curStage != 'spamton') || (note.burning && curStage == 'spamton'))
								gf.playAnim('singLEFT', true);
					}
					if (boyfriendSinging && !note.burning)
					{
						switch (boyfriend.curCharacter) {
							case 'ruv':
								FlxG.camera.shake(0.03, 0.03);
						}
					}
					if (boyfriendAgainSinging)
					{
						switch (boyfriendAgain.curCharacter) {
							case 'ruv':
								FlxG.camera.shake(0.03, 0.03);
						}
					}
					if (curStage == 'pegmeplease')
					{
						circ1.angle -= 5;
						circ2.angle -= 5;
					}
		
					#if windows
					if (luaModchart != null)
						luaModchart.executeState('playerOneSing', [note.noteData, Conductor.songPosition]);
					#end


					if(!loadRep && note.mustPress)
					{
						var array = [note.strumTime,note.sustainLength,note.noteData,noteDiff];
						if (note.isSustainNote)
							array[1] = -1;
						trace('pushing ' + array[0]);
						saveNotes.push(array);
					}
					
					playerStrums.forEach(function(spr:FlxSprite)
					{
						if (Math.abs(note.noteData) == spr.ID)
						{
							spr.animation.play('confirm', true);
						}
					});
					
					note.wasGoodHit = true;
					vocals.volume = 1;
		
					note.kill();
					notes.remove(note, true);
					note.destroy();
					
					updateAccuracy();
				}
			}
		

	var fastCarCanDrive:Bool = true;

	function resetFastCar():Void
	{
		if(FlxG.save.data.distractions){
			fastCar.x = -12600;
			fastCar.y = FlxG.random.int(140, 250);
			fastCar.velocity.x = 0;
			fastCarCanDrive = true;
		}
	}

	function fastCarDrive()
	{
		if(FlxG.save.data.distractions){
			FlxG.sound.play(Paths.soundRandom('carPass', 0, 1), 0.7);

			fastCar.velocity.x = (FlxG.random.int(170, 220) / FlxG.elapsed) * 3;
			fastCarCanDrive = false;
			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				resetFastCar();
			});
		}
	}

	var trainMoving:Bool = false;
	var trainFrameTiming:Float = 0;

	var trainCars:Int = 8;
	var trainFinishing:Bool = false;
	var trainCooldown:Int = 0;

	function trainStart():Void
	{
		if(FlxG.save.data.distractions){
			trainMoving = true;
			if (!trainSound.playing)
				trainSound.play(true);
		}
	}

	var startedMoving:Bool = false;

	function updateTrainPos():Void
	{
		if(FlxG.save.data.distractions){
			if (trainSound.time >= 4700)
				{
					startedMoving = true;
					gf.playAnim('hairBlow');
				}
		
				if (startedMoving)
				{
					phillyTrain.x -= 400;
		
					if (phillyTrain.x < -2000 && !trainFinishing)
					{
						phillyTrain.x = -1150;
						trainCars -= 1;
		
						if (trainCars <= 0)
							trainFinishing = true;
					}
		
					if (phillyTrain.x < -4000 && trainFinishing)
						trainReset();
				}
		}

	}

	function trainReset():Void
	{
		if(FlxG.save.data.distractions){
			gf.playAnim('hairFall');
			phillyTrain.x = FlxG.width + 200;
			trainMoving = false;
			// trainSound.stop();
			// trainSound.time = 0;
			trainCars = 8;
			trainFinishing = false;
			startedMoving = false;
		}
	}

	var resetSpookyText:Bool = true;

	function resetSpookyTextManual():Void
	{
		trace('reset spooky');
		spookySteps = curStep;
		spookyRendered = true;
		tstatic.alpha = 0.5;
		FlxG.sound.play(Paths.sound('staticSound', 'shared'));
		resetSpookyText = true;
	}

	function manuallymanuallyresetspookytextmanual()
	{
		remove(spookyText);
		spookyRendered = false;
		tstatic.alpha = 0;
	}

	var spookyText:FlxText;

	function createSpookyText(hattext:String, tiktext:String, x:Float = -1111111111111, y:Float = -1111111111111, fontSize:Int = 128):Void
	{
		var chosentext = '';
		spookySteps = curStep;
		spookyRendered = true;
		tstatic.alpha = 0.5;
		FlxG.sound.play(Paths.sound('staticSound', 'shared'));
		if (hatturn && tikturn)
		{
			if (FlxG.random.int(0, 1) == 1)
			{
				spookyText = new FlxText((x == -1111111111111 ? FlxG.random.float(hatkid.x - 50, hatkid.x + 30) : x),
					(y == -1111111111111 ? FlxG.random.float(hatkid.y + 100, hatkid.y + 200) : y));
				chosentext = hattext;
				spookyText.setFormat("Impact", 128, FlxColor.PURPLE);
				tstatic.loadGraphic(Paths.image('HatStatic', 'shared'), true, 320, 180);
			}
			else
			{
				spookyText = new FlxText((x == -1111111111111 ? FlxG.random.float(dad.x + 40, dad.x + 120) : x),
					(y == -1111111111111 ? FlxG.random.float(dad.y + 200, dad.y + 300) : y));
				chosentext = tiktext;
				spookyText.setFormat("Impact", 128, FlxColor.RED);
				tstatic.loadGraphic(Paths.image('TrickyStatic', 'shared'), true, 320, 180);
			}
		}
		else if (hatturn)
		{
			spookyText = new FlxText((x == -1111111111111 ? FlxG.random.float(hatkid.x - 50, hatkid.x + 30) : x),
				(y == -1111111111111 ? FlxG.random.float(hatkid.y + 100, hatkid.y + 200) : y));
			chosentext = hattext;
			spookyText.setFormat("Impact", 128, FlxColor.PURPLE);
			tstatic.loadGraphic(Paths.image('HatStatic', 'shared'), true, 320, 180);
		}
		else
		{
			spookyText = new FlxText((x == -1111111111111 ? FlxG.random.float(dad.x + 40, dad.x + 120) : x),
				(y == -1111111111111 ? FlxG.random.float(dad.y + 200, dad.y + 300) : y));
			chosentext = tiktext;
			spookyText.setFormat("Impact", 128, FlxColor.RED);
			tstatic.loadGraphic(Paths.image('TrickyStatic', 'shared'), true, 320, 180);
		}
		spookyText.bold = true;
		if (spookyText.text != null && chosentext != null)
			spookyText.text = chosentext;
		add(spookyText);
	}

	function lightningStrikeShit():Void
	{
		FlxG.sound.play(Paths.soundRandom('thunder_', 1, 2));
		halloweenBG.animation.play('lightning');

		lightningStrikeBeat = curBeat;
		lightningOffset = FlxG.random.int(8, 24);

		boyfriend.playAnim('scared', true);
		gf.playAnim('scared', true);
	}

	var danced:Bool = false;

	function doStopSign(sign:Int = 0, fuck:Bool = false)
	{
		trace('sign ' + sign);
		var daSign:FlxSprite = new FlxSprite(0, 0);
		// CachedFrames.cachedInstance.get('sign')

		daSign.frames = Paths.getSparrowAtlas('fourth/mech/Sign_Post_Mechanic','shared');

		daSign.setGraphicSize(Std.int(daSign.width * 4));
		daSign.updateHitbox();
		daSign.setGraphicSize(Std.int(daSign.width * 0.67));

		daSign.cameras = [camHUD];

		switch (sign)
		{
			case 0:
				daSign.animation.addByPrefix('sign', 'Signature Stop Sign 1', 24, false);
				daSign.x = FlxG.width - 650;
				daSign.angle = -90;
				daSign.y = -300;
			case 1:
			/*daSign.animation.addByPrefix('sign','Signature Stop Sign 2',20, false);
				daSign.x = FlxG.width - 670;
				daSign.angle = -90; */ // this one just doesn't work???
			case 2:
				daSign.animation.addByPrefix('sign', 'Signature Stop Sign 3', 24, false);
				daSign.x = FlxG.width - 780;
				daSign.angle = -90;
				if (FlxG.save.data.downscroll)
					daSign.y = -395;
				else
					daSign.y = -980;
			case 3:
				daSign.animation.addByPrefix('sign', 'Signature Stop Sign 4', 24, false);
				daSign.x = FlxG.width - 1070;
				daSign.angle = -90;
				daSign.y = -145;
		}
		add(daSign);
		daSign.flipX = fuck;
		daSign.animation.play('sign');
		daSign.animation.finishCallback = function(pog:String)
		{
			remove(daSign);
			trace('ended sign');
		}
	}

	function changeDaddy(id:String)
	{                
		var olddadx = dad.x;
		var olddady = dad.y;
		remove(dad);
		dad = new Character(olddadx, olddady, id);
		add(dad);
		iconP2.animation.play(id);
	}

	function changeDaddyEjected(id:String, y1, time1, y2, time2)
	{
		FlxTween.tween(dad, {y: y1}, time1, {
			ease: FlxEase.cubeInOut,
			onComplete: function(twn:FlxTween)
			{
				dad.y = -1500;
				var olddadx = dad.x;
				var olddady = dad.y;
				remove(dad);
				dad = new Character(olddadx, olddady, id);
				add(dad);
				iconP2.animation.play(id);
				FlxTween.tween(dad, {y: y2}, time2, {
					ease: FlxEase.cubeInOut
				});
			}
		});
	}

	function changeGf(id:String)
	{                
		var olddadx = gf.x;
		var olddady = gf.y;
		remove(gf);
		gf = new Character(olddadx, olddady, id);
		add(gf);
	}

	function changeOtherDaddy(id:String)
	{                
		var olddadx = dadAgain.x;
		var olddady = dadAgain.y;
		remove(dadAgain);
		dadAgain = new Character(olddadx, olddady, id);
		add(dadAgain);
	}

	function changeOtherDaddyEjected(id:String, y1, time1, y2, time2)
	{
		FlxTween.tween(dadAgain, {y: y1}, time1, {
			ease: FlxEase.cubeInOut,
			onComplete: function(twn:FlxTween)
			{
				dadAgain.y = -1500;
				var olddadx = dadAgain.x;
				var olddady = dadAgain.y;
				remove(dadAgain);
				dadAgain = new Character(olddadx, olddady, id);
				add(dadAgain);
				iconP2.animation.play(id);
				FlxTween.tween(dadAgain, {y: y2}, time2, {
					ease: FlxEase.cubeInOut
				});
			}
		});
	}

	function endOtherDaddyEjected(y1, time1)
	{
		FlxTween.tween(dadAgain, {y: y1}, time1, {
			ease: FlxEase.cubeInOut,
			onComplete: function(twn:FlxTween)
			{
				remove(dadAgain);
			}
		});
	}

	function changeBf(id:String)
	{                
		var olddadx = boyfriend.x;
		var olddady = boyfriend.y;
		remove(boyfriend);
		boyfriend = new Boyfriend(olddadx, olddady, id);
		add(boyfriend);
		iconP1.animation.play(id);
	}

	function changeBfEjected(id:String, y1, time1, y2, time2)
	{
		FlxTween.tween(boyfriend, {y: y1}, time1, {
			ease: FlxEase.cubeInOut,
			onComplete: function(twn:FlxTween)
			{
				if (id == 'selever')
				{
					circSelever.angle = 0;
					FlxTween.tween(circSelever, {angle: 360}, 1.9, {ease: FlxEase.cubeInOut});
					FlxTween.tween(circSelever, {alpha: 1}, 0.7);
					FlxTween.tween(blackSelever, {alpha: 0.8}, 0.7, {
						onComplete: function(twn:FlxTween)
						{
							new FlxTimer().start(0.5, function(tmr:FlxTimer)
							{
								FlxTween.tween(circSelever, {alpha: 0}, 0.7);
								FlxTween.tween(blackSelever, {alpha: 0}, 0.7);
							});
						}
					});
				}
				boyfriend.y = -1500;
				var olddadx = boyfriend.x;
				var olddady = boyfriend.y;
				remove(boyfriend);
				boyfriend = new Boyfriend(olddadx, olddady, id);
				add(boyfriend);
				iconP1.animation.play(id);
				FlxTween.tween(boyfriend, {y: y2, angle: 0}, time2, {
					ease: FlxEase.cubeInOut
				});
			}
		});
	}

	function changeOtherBf(id:String)
	{                
		var olddadx = boyfriendAgain.x;
		var olddady = boyfriendAgain.y;
		remove(boyfriendAgain);
		boyfriendAgain = new Boyfriend(olddadx, olddady, id);
		add(boyfriendAgain);
	}

	function changeOtherBfEjected(id:String, y1, time1, y2, time2)
	{
		FlxTween.tween(boyfriendAgain, {y: y1}, time1, {
			ease: FlxEase.cubeInOut,
			onComplete: function(twn:FlxTween)
			{
				boyfriendAgain.y = -1500;
				var olddadx = boyfriendAgain.x;
				var olddady = boyfriendAgain.y;
				remove(boyfriendAgain);
				boyfriendAgain = new Boyfriend(olddadx, olddady, id);
				add(boyfriendAgain);
				iconP1.animation.play(id);
				FlxTween.tween(boyfriendAgain, {y: y2}, time2, {
					ease: FlxEase.cubeInOut
				});
			}
		});
	}

	function endOtherBfEjected(y1, time1)
	{
		FlxTween.tween(boyfriendAgain, {y: y1}, time1, {
			ease: FlxEase.cubeInOut,
			onComplete: function(twn:FlxTween)
			{
				remove(boyfriendAgain);
			}
		});
	}

	
	function deltaruneHit()
	{
		if ((curStage == 'jevil' && curStep > 127) || curStage == 'spamton')
		{
			FlxG.sound.play(Paths.sound('snd_hurt1'), 1);
			if (!(removal <= 0))
			{
				removal = removal * 1000;
				var seperatedScore:Array<Int> = [];
				var comboSplit:Array<String> = (removal + "").split('');

				// make sure we have 3 digits to display (looks weird otherwise lol)
				if (comboSplit.length == 1)
				{
					seperatedScore.push(0);
					seperatedScore.push(0);
				}

				for(i in 0...comboSplit.length)
				{
					var str:String = comboSplit[i];
					seperatedScore.push(Std.parseInt(str));
				}
		
				var daLoop:Int = 0;
				for (i in seperatedScore)
				{
					var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image('num' + Std.int(i)));
					numScore.screenCenter();
					numScore.x = (FlxG.width/2) + (43 * daLoop) - 50;
					numScore.y = (FlxG.height/2) + 150;
					numScore.cameras = [camHUD];

					if (!curStage.startsWith('school'))
					{
						numScore.antialiasing = true;
						numScore.setGraphicSize(Std.int(numScore.width * 0.5));
					}
					else
					{
						numScore.setGraphicSize(Std.int(numScore.width * daPixelZoom));
					}
					numScore.updateHitbox();
		
					numScore.acceleration.y = FlxG.random.int(200, 300);
					numScore.velocity.y -= FlxG.random.int(140, 160);
					numScore.velocity.x = FlxG.random.float(-5, 5);
		
					add(numScore);
					numScore.color = FlxColor.RED;
		
					FlxTween.tween(numScore, {alpha: 0}, 0.2, {
						onComplete: function(tween:FlxTween)
						{
							numScore.destroy();
						},
						startDelay: Conductor.crochet * 0.002
					});
		
					daLoop++;
				}
			}
			removal = 0;
		}
	}

	function deltaruneHeal()
	{
		
		if ((curStage == 'jevil' && curStep > 127) || curStage == 'spamton')
		{
			if (health >= 2)
			{
				var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image('max'));
				comboSpr.screenCenter();
				comboSpr.x = (FlxG.width/2) - 150;
				comboSpr.y = (FlxG.height/2) + 150;
				comboSpr.acceleration.y = 600;
				comboSpr.velocity.y -= 150;
				comboSpr.velocity.x += FlxG.random.int(1, 10);
				comboSpr.cameras = [camHUDier];
				comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.5));
				comboSpr.antialiasing = true;
				add(comboSpr);
			}
			else if (!(addition <= 0))
			{
				addition = addition * 1000;
				var seperatedScore:Array<Int> = [];
				var comboSplit:Array<String> = (addition + "").split('');

				// make sure we have 3 digits to display (looks weird otherwise lol)
				if (comboSplit.length == 1)
				{
					seperatedScore.push(0);
					seperatedScore.push(0);
				}
				trace(seperatedScore);
				trace(comboSplit);

				for(i in 0...comboSplit.length)
				{
					var str:String = comboSplit[i];
					seperatedScore.push(Std.parseInt(str));
				}
		
				var daLoop:Int = 0;
				for (i in seperatedScore)
				{
					var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image('num' + Std.int(i)));
					numScore.screenCenter();
					numScore.x = (FlxG.width/2) + (43 * daLoop) - 50;
					numScore.y = (FlxG.height/2) + 150;
					numScore.cameras = [camHUD];

					if (!curStage.startsWith('school'))
					{
						numScore.antialiasing = true;
						numScore.setGraphicSize(Std.int(numScore.width * 0.5));
					}
					else
					{
						numScore.setGraphicSize(Std.int(numScore.width * daPixelZoom));
					}
					numScore.updateHitbox();
		
					numScore.acceleration.y = FlxG.random.int(200, 300);
					numScore.velocity.y -= FlxG.random.int(140, 160);
					numScore.velocity.x = FlxG.random.float(-5, 5);
		
					add(numScore);
					numScore.color = 0xFF5BFF00;
		
					FlxTween.tween(numScore, {alpha: 0}, 0.2, {
						onComplete: function(tween:FlxTween)
						{
							numScore.destroy();
						},
						startDelay: Conductor.crochet * 0.002
					});
		
					daLoop++;
				}
			}
			addition = 0;
		}
	}

	var stepOfLast = 0;

	override function stepHit()
	{
		super.stepHit();
		if (FlxG.sound.music.time > Conductor.songPosition + 20 || FlxG.sound.music.time < Conductor.songPosition - 20)
		{
			resyncVocals();
		}
		if (curStage == 'garAlley' && curSong.toLowerCase() == 'headache')
		{
			switch (curStep)
			{
				case 126:
					dad.x = 100;
					dad.y = 100;
					changeDaddy('zardy');
				case 158:
					boyfriend.x = 820;
					boyfriend.y = 450;
					changeBf('hat-kid-hatted');
				case 188:
					dad.x = 100;
					dad.y = 100;
					changeDaddy('hex');
				case 222:
					boyfriend.x = 820;
					boyfriend.y = 200;
					changeBf('tord');
				case 254:
					dad.x = 100;
					dad.y = 400;
					FlxG.bitmap.add(Paths.image("characters/monsterAnnie"));
					changeDaddy('ron');
				case 318:
					FlxTween.tween(FlxG.camera, {zoom: 1.5}, 0.4, {ease: FlxEase.expoOut,});
					dad.playAnim('cheer', true);
				case 320:
					dad.x = 100;
					dad.y = 300;
					changeDaddy('not-sky-mad');
				case 350:
					boyfriend.x = 820;
					boyfriend.y = 200;
					changeBf('monster-annie');
				case 383:
					roboturn = true;
					iconP2.animation.play('robo-gf');
				case 414:
					boyfriend.x = 820;
					boyfriend.y = 450;
					changeBf('tankman-playable');
				case 440:
					roboturn = false;
				case 445:
					dad.x = 100;
					dad.y = 150;
					changeDaddy('tricky');
				case 477:
					boyfriend.x = 920;
					boyfriend.y = 300;
					changeBf('lav');
				case 509:
					dad.x = 100;
					dad.y = 300;
					changeDaddy('spooky');
				case 541:
					boyfriend.x = 820;
					boyfriend.y = 450;
					changeBf('kapi');
				case 637:
					dad.x = 100;
					dad.y = 150;
					changeDaddy('rebecca4');
				case 669: // nice
					changeBf('pico');
					boyfriend.x = 820;
					boyfriend.y = 450;
					FlxG.bitmap.add(Paths.image("characters/cass"));
				case 703:
					changeOtherBf('cass-playable');
					boyfriendAgain.x = 1020;
					boyfriendAgain.y = 180;
					boyfriendAgainSinging = true;
					iconP1.animation.play('pico-cass');
					FlxG.bitmap.add(Paths.image("characters/TABI"));
					FlxG.bitmap.add(Paths.image("characters/AGOTI"));
				case 704:
					dad.playAnim('fall', true);
				case 717:
					changeDaddy('tabi');
					changeOtherDaddy('agoti');
					dad.x = 100;
					dad.y = 150;
					dadAgain.x = -200;
					dadAgain.y = 150;
					dadAgainSinging = true;
					iconP2.animation.play('tabi-agoti');
				case 733:
					changeBf('HD_monika');
					changeOtherBf('HD_senpai');
					boyfriend.x = 1020;
					boyfriend.y = 150;
					boyfriendAgain.x = 1320;
					boyfriendAgain.y = 150;
					boyfriendAgainSinging = true;
					iconP1.animation.play('HD_senpai-HD_monika');
				case 749:
					changeDaddy('bob');
					changeOtherDaddy('opheebop');
					dad.x = 100;
					dad.y = 450;
					dadAgain.x = -200;
					dadAgain.y = 300;
					dadAgainSinging = true;
					iconP2.animation.play('bob-opheebop');
				case 765:
					changeBf('sarv');
					changeOtherBf('ruv');
					boyfriend.x = 1020;
					boyfriend.y = 150;
					boyfriendAgain.x = 1320;
					boyfriendAgain.y = 150;
					boyfriendAgainSinging = true;
					iconP1.animation.play('sarv-ruv');
				case 781:
					remove(dadAgain);
					dadAgainSinging = false;
					changeDaddy('qt-kb');
					dad.x = 100;
					dad.y = 100;
				case 798:
					boyfriend.x = 820;
					boyfriend.y = 450;
					boyfriendAgain.x = 1320;
					boyfriendAgain.y = 150;
					boyfriendAgainSinging = true;
					changeBf('whitty');
					changeOtherBf('carol');
					iconP1.animation.play('whitty-carol');
			}
		}
		if (curStage == 'hex-night' && curSong.toLowerCase() == 'glitcher' && !songEnded)
		{
			if ((curStep > 575 && curStep < 624) || (curStep > 639 && curStep < 688) || (curStep > 1087 && curStep < 1136) || (curStep > 1151 && curStep < 1200))
			{
				defaultCamZoom += 0.01;
				trace(defaultCamZoom);
			}

			switch (curStep)
			{   /// ANIMATIONS
				case 1:
					qt_tv01.animation.play("instructions");
				case 10:
					kb_attack_saw.visible = false;
					kb_attack_alert.visible = false;
				case 20:
					add(kb_attack_saw);
					add(kb_attack_alert);
				case 40:
					kb_attack_saw.visible = true;
					kb_attack_alert.visible = true;
				case 59:
					KBATTACK_ALERT();
					KBATTACK();
					qt_tv01.animation.play("gl");
					gf.animation.play('OI');
				case 65:
					qt_tv01.animation.play('idle');
				case 565 | 1082:
					BG2.loadGraphic(Paths.image('hex/streetBackError'));
					BG3.visible = false;
					FlxG.camera.shake();
					qt_tv01.animation.play("error");
				case 567 | 1087:
					changeBf('bf404');
					changeDaddy('qt-kb-404');
					changeGf('robo-gf-404');
					qt_tv01.animation.play("404");
					BG2.loadGraphic(Paths.image('hex/streetError'));
					BG3.visible = true;
					BG3.loadGraphic(Paths.image('hex/stagefrontError'));
				case 824:
					changeBf('bf-night');
					changeDaddy('qt-kb-night');
					changeGf('robo-gf-night');
					qt_tv01.animation.play('idle');
					BG2.loadGraphic(Paths.image('hex/stageback'));
					BG3.loadGraphic(Paths.image('hex/stagefront'));
				case 850:
					qt_tv01.animation.play('watch');
				case 862:
					qt_tv01.animation.play('idle');
					gf.animation.play('come saw');
					KBATTACK_ALERT();
				case 1339:
					changeBf('bf-night');
					changeDaddy('qt-kb-night');
					changeGf('robo-gf-night');
					qt_tv01.animation.play('eye');
					BG2.loadGraphic(Paths.image('hex/stageback'));
					BG3.loadGraphic(Paths.image('hex/stagefront'));
				case 1470:
					qt_tv01.animation.play('idle');
				case 1854:
					qt_tv01.animation.play('heart');

					/// ATTACKS
				case 860 | 1088 | 1104 | 1120 | 1420| 1436 | 1452:
					KBATTACK_ALERT();
					KBATTACK();
					gf.animation.play('OI');
				//case 61 | 860 | 862 | 1088 | 1092 | 1104 | 1108 | 1120 | 1124 | 1420 | 1422 | 1436 | 1438 | 1452 | 1454:
				case 61 | 1092 | 1108 | 1124 | 1422 | 1438 | 1454:
					KBATTACK_ALERT();
					gf.animation.play('come saw');
				case 63 | 864 | 1096 | 1112 | 1128 | 1424 | 1440 | 1456:
					KBATTACK(true);
					gf.animation.play('GET THE BITCH');

					/// CAMERA
				case 320:
					defaultCamZoom = 0.9;
				case 384:
					defaultCamZoom = 0.95;
				case 448:
					defaultCamZoom = 1;
				case 512:
					defaultCamZoom = 1.05;
				case 544:
					defaultCamZoom = 1.1;
				case 560:
					defaultCamZoom = 1.05;
				case 562:
					defaultCamZoom = 1;
				case 564:
					defaultCamZoom = 0.9;
				case 568:
					defaultCamZoom = 0.8;
				case 624:
					defaultCamZoom = 1.3;
				case 626:
					defaultCamZoom = 1.25;
				case 628:
					defaultCamZoom = 1.2;
				case 630:
					defaultCamZoom = 1.15;
				case 632:
					defaultCamZoom = 1;
				case 636:
					defaultCamZoom = 0.8;
				case 688:
					defaultCamZoom = 1.3;
				case 690:
					defaultCamZoom = 1.25;
				case 692:
					defaultCamZoom = 1.2;
				case 694:
					defaultCamZoom = 1.15;
				case 696:
					defaultCamZoom = 1;
				case 700:
					defaultCamZoom = 0.8;
				case 1136:
					defaultCamZoom = 1.3;
				case 1138:
					defaultCamZoom = 1.25;
				case 1140:
					defaultCamZoom = 1.2;
				case 1142:
					defaultCamZoom = 1.15;
				case 1144:
					defaultCamZoom = 1;
				case 1148:
					defaultCamZoom = 0.8;
				case 1200:
					defaultCamZoom = 1.3;
				case 1202:
					defaultCamZoom = 1.25;
				case 1204:
					defaultCamZoom = 1.2;
				case 1206:
					defaultCamZoom = 1.15;
				case 1208:
					defaultCamZoom = 1;
				case 1212:
					defaultCamZoom = 0.8;
			}
		}
		// EX TRICKY HARD CODED EVENTS
		else if (curStage == 'auditorHell' && curStep != stepOfLast)
		{
			if (curStep > 2128 && curStep < 2656)
				defaultCamZoom += 0.001;
				
			switch (curStep)
			{
				case 384:
					doStopSign(0);
				case 511:
					doStopSign(2);
					doStopSign(0);
				case 610:
					doStopSign(3);
				case 720:
					doStopSign(2);
				case 991:
					doStopSign(3);
				case 1184:
					doStopSign(2);
				case 1218:
					doStopSign(0);
				case 1235:
					doStopSign(0, true);
				case 1200:
					doStopSign(3);
				case 1328:
					doStopSign(0, true);
					doStopSign(2);
				case 1439:
					doStopSign(3, true);
				case 1567:
					doStopSign(0);
				case 1584:
					doStopSign(0, true);
				case 1600:
					doStopSign(2);
				case 1706:
					doStopSign(3);
				case 1917:
					doStopSign(0);
				case 1923:
					doStopSign(0, true);
				case 1927:
					doStopSign(0);
				case 1932:
					doStopSign(0, true);
				case 2032:
					doStopSign(2);
					doStopSign(0);
				case 2036:
					doStopSign(0, true);
				case 2162:
					doStopSign(2);
					doStopSign(3);
				case 2193:
					doStopSign(0);
				case 2202:
					doStopSign(0, true);
				case 2239:
					doStopSign(2, true);
				case 2258:
					doStopSign(0, true);
				case 2304:
					doStopSign(0, true);
					doStopSign(0);
				case 2326:
					doStopSign(0, true);
				case 2336:
					doStopSign(3);
				case 2447:
					doStopSign(2);
					doStopSign(0, true);
					doStopSign(0);
				case 2480:
					doStopSign(0, true);
					doStopSign(0);
				case 2512:
					doStopSign(2);
					doStopSign(0, true);
					doStopSign(0);
				case 2544:
					doStopSign(0, true);
					doStopSign(0);
				case 2575:
					doStopSign(2);
					doStopSign(0, true);
					doStopSign(0);
				case 2608:
					doStopSign(0, true);
					doStopSign(0);
				case 2604:
					doStopSign(0, true);
				case 2655:
					doGremlin(20, 13, true);
			}
			stepOfLast = curStep;
			switch (curStep + 1)
			{
				case 64:
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 128:
					// TRICKY SOLO
					tikturn = true;
					hatturn = false;
				case 192:
					defaultCamZoom = 1.3;
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 256:
					defaultCamZoom = 0.55;
					// TRICKY SOLO
					tikturn = true;
					hatturn = false;
				case 262:
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 268:
					// DUET
					tikturn = true;
					hatturn = true;
				case 448:
					// TRICKY SOLO
					tikturn = true;
					hatturn = false;
				case 576:
					// DUET
					tikturn = true;
					hatturn = true;
				case 608:
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 640:
					// TRICKY SOLO
					tikturn = true;
					hatturn = false;
				case 672:
					// DUET
					tikturn = true;
					hatturn = true;
				case 736:
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 768:
					// DUET
					tikturn = true;
					hatturn = true;
				case 864:
					defaultCamZoom = 1.1;
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 920:
					defaultCamZoom = 0.55;
					// DUET
					tikturn = true;
					hatturn = true;
				case 924:
					// TRICKY SOLO
					tikturn = true;
					hatturn = false;
				case 1120:
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 1248:
					// TRICKY SOLO
					tikturn = true;
					hatturn = false;
				case 1504:
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 1632:
					// DUET
					tikturn = true;
					hatturn = true;
				case 1888:
					// TRICKY SOLO
					tikturn = true;
					hatturn = false;
				case 1892:
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 1896:
					// TRICKY SOLO
					tikturn = true;
					hatturn = false;
				case 1900:
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 1904:
					// DUET
					tikturn = true;
					hatturn = true;
				case 2016:
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 2024:
					// DUET
					tikturn = true;
					hatturn = true;
				case 2084:
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 2056:
					// TRICKY SOLO
					tikturn = true;
					hatturn = false;
				case 2080:
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 2088:
					// TRICKY SOLO
					tikturn = true;
					hatturn = false;
				case 2096:
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 2104:
					// TRICKY SOLO
					tikturn = true;
					hatturn = false;
				case 2112:
					// DUET
					tikturn = true;
					hatturn = true;
				case 2128:
					defaultCamZoom = 0.2;
				case 2144:
					defaultCamZoom = 0.55;
					// TRICKY SOLO
					tikturn = true;
					hatturn = false;
				case 2208:
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 2272:
					// TRICKY SOLO
					tikturn = true;
					hatturn = false;
				case 2336:
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 2400:
					// TRICKY SOLO
					tikturn = true;
					hatturn = false;
				case 2432:
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 2464:
					// TRICKY SOLO
					tikturn = true;
					hatturn = false;
				case 2496:
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 2528:
					// TRICKY SOLO
					tikturn = true;
					hatturn = false;
				case 2560:
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 2592:
					// TRICKY SOLO
					tikturn = true;
					hatturn = false;
				case 2624:
					// HAT KID SOLO
					tikturn = false;
					hatturn = true;
				case 2656:
					defaultCamZoom = 0.55;
					// DUET
					tikturn = true;
					hatturn = true;
			}
		}
		else if (SONG.song.toLowerCase() == 'endless' && curStep != stepOfLast)
		{
			if (spinArray.contains(curStep))
			{
				strumLineNotes.forEach(function(tospin:FlxSprite)
				{
					FlxTween.angle(tospin, 0, 360, 0.2, {ease: FlxEase.quintOut});
				});
			}
			switch (curStep)
			{
				case 10:
					FlxG.sound.play(Paths.sound('laugh1', 'shared'), 0.7);
				case 909:
					camFollow.setPosition(GameDimensions.width / 2 + 200, GameDimensions.height / 4 * 3 + 100);
					FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.3}, 0.7, {ease: FlxEase.cubeInOut});
					three();
				case 914:
					FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.3}, 0.7, {ease: FlxEase.cubeInOut});
					two();
				case 918:
					FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.3}, 0.7, {ease: FlxEase.cubeInOut});
					one();
				case 923:
					FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 0.7, {ease: FlxEase.cubeInOut});
					gofun();
					SONG.noteStyle = 'majinNOTES';
					removeStatics();
					generateStaticArrows(0, false);
					generateStaticArrows(1, false);
			}
			switch (curStep)
			{
				case 262:
					changeDaddy('sarv');
					dad.y = 350;
				case 390:
					changeBf('ruv');
					boyfriend.y = 350;
				case 516:
					dad.y = 400;
					changeDaddy('taki');
				case 582:
					changeBf('cesar');
					boyfriend.y = 740;
				case 630:
					changeDaddy('tankman');
					dad.y = 790;
				case 648:
					changeDaddy('bosip');
					dad.y = 420;
					changeBf('worriedbob');
					boyfriend.y = 480;
				case 780:
					changeDaddy('garcello');
					dad.y = 450;
					changeBf('annie');
					boyfriend.y = 740;
				case 923:
					changeDaddy('tabi');
					dad.y = 450;
					changeBf('exGf-playable');
					boyfriend.y = 450;
				case 1003:
					changeDaddy('cass');
					dad.y = 450;
					changeBf('nene');
					boyfriend.y = 720;
				case 1077:
					changeDaddy('HCcarol');
					dad.y = 100;
					changeBf('WhittyCrazy');
					boyfriend.y = 550;
				case 1151:
					changeBf('hat-kid-hatted');
					boyfriend.y = 790;
					roboturn = true;
					iconP2.animation.play('robo-gf');
				case 1207:
					changeBf('exTricky');
					boyfriend.y = 550;
				case 1224:
					roboturn = false;
					changeDaddy('HD_monika');
					dad.y = 450;
				case 1373:
					changeBf('nonsense-god');
					boyfriend.y = 200;
				case 1521:
					changeDaddy('qt-kb');
					dad.y = 450;
					iconP2.animation.play('QT');
					boyfriend.y = 600;
					changeBf('opheebop');
					changeOtherBf('bob');
					boyfriendAgain.x = 1100;
					boyfriendAgain.y = 750;
				case 1597:
					iconP2.animation.play('KB');
					changeBf('glitched-bob');
					changeOtherBf('opheebop');
					boyfriend.y = 750;
					boyfriendAgain.x = 1300;
					boyfriendAgain.y = 600;
				case 1672:
					remove(boyfriendAgain);
					changeBf('HD_spirit');
					boyfriend.y = 450;
					changeDaddy('matt');
					dad.y = 750;
				case 1746:
					changeBf('anchor');
					boyfriend.y = 350;
					changeDaddy('roro');
					dad.y = 450;
					dad.x = -100;
			}
		}
		else if (SONG.song.toLowerCase() == 'ejected' && curStep != stepOfLast)
		{
			switch (curStep)
			{
				// comes from y -1500
				// Original dad y = 274.3
				// Original bf  y = 504
				case 507:
					changeDaddyEjected('arch', 2000, 0.7, -20, 0.7);
				case 560:
					changeBfEjected('bbpanzu', 2000, 0.7, 430, 0.7);
				case 634:
					changeDaddyEjected('not-sky-mad', 2000, 0.7, 500, 0.7);
				case 698:
					changeBfEjected('carol', 2000, 0.7, 280, 0.7);
				case 764:
					defaultCamZoom = 0.3;
					changeDaddyEjected('monster-soft', 2000, 0.7, 280, 0.7);
					changeBfEjected('softie', 2000, 0.7, 580, 0.7);
				case 884:
					changeDaddyEjected('exGf', 2000, 0.5, 200, 0.7);
				case 892:
					changeBfEjected('mom-car', 2000, 0.5, 200, 0.7);
				case 900:
					dadAgain.x = -1203;
					changeOtherDaddyEjected('bob', 2000, 0.5, 537, 0.7);
				case 908:
					boyfriendAgain.x = 1426;
					changeOtherBfEjected('worriedbob', 2000, 0.5, 306, 0.7);
				case 916:
					changeDaddyEjected('hex', 2000, 0.5, 230, 0.7);
				case 933:
					changeBfEjected('whitty', 2000, 0.5, 534, 0.7);
				case 948:
					changeOtherDaddyEjected('liz', 2000, 0.5, 500, 0.7);
				case 956:
					changeOtherBfEjected('neon', 2000, 0.5, 454, 0.7);
				case 964:
					changeDaddyEjected('spooky', 2000, 0.5, 400, 0.7);
				case 972:
					changeBfEjected('lila', 2000, 0.5, 264, 0.7);
				case 980:
					changeOtherDaddyEjected('shaggy-shaggy', 2000, 0.5, 280, 0.7);
					changeOtherBfEjected('matt-shaggy', 2000, 0.5, 570, 0.7);
				case 1012:
					changeDaddyEjected('opheebop', 2000, 0.5, 364, 0.7);
				case 1028:
					changeBfEjected('little-man', 2000, 0.5, 864, 0.7);
				case 1044:
					changeOtherDaddyEjected('sayori', 2000, 0.5, 367, 0.7);
				case 1052:
					changeOtherBfEjected('HD_monika', 2000, 0.5, 304, 0.7);
				case 1060:
					changeDaddyEjected('zardy', 2000, 0.5, 220, 0.7);
				case 1068:
					changeBfEjected('cableCrowPog', 2000, 0.5, 100, 0.7);
				case 1076:
					changeOtherDaddyEjected('henry', 2000, 0.5, 450, 0.7);
					changeOtherBfEjected('rebecca', 2000, 0.5, 220, 0.7);
				case 1148:
					endOtherDaddyEjected(2000, 0.5);
					endOtherBfEjected(2000, 0.5);
					changeDaddyEjected('garcello', 2000, 0.5, 200, 0.7);
					changeBfEjected('annie', 2000, 0.5, 520, 0.7);
				case 1276:
					changeDaddyEjected('astro', 2000, 0.5, 280, 0.7);
					changeBfEjected('blantados', 2000, 0.5, 300, 0.7);
				case 1404:
					changeDaddyEjected('chara', 2000, 0.5, 600, 0.7);
				case 1532:
					changeBfEjected('sans', 2000, 0.5, 600, 0.7);
				case 1616:
					defaultCamZoom = 0.7;
					dadAnimNoInterupt = true;
					dad.playAnim('YOU', true);
				case 1632:
					defaultCamZoom = 0.3;
					changeDaddyEjected('CG5', 2000, 0.5, 250, 0.7);
				case 1750:
					changeBfEjected('sarv', 2000, 0.5, 2000, 1);
					dadAnimNoInterupt = false;
				case 1784:
					changeBfEjected('ruv', 2000, 0.5, 160, 0.7);
				case 1916:
					changeDaddyEjected('eteled2', 2000, 0.5, 420, 0.7);
					removeStatics();
					SONG.noteStyle = 'eteled';
					generateStaticArrows(0, false);
					SONG.noteStyle = 'normal';
					generateStaticArrows(1, false);
				case 1980:
					changeBfEjected('hat-kid-unhatted', 2000, 0.5, 520, 0.7);
				case 2044:
					removeStatics();
					SONG.noteStyle = 'spinel';
					generateStaticArrows(0, false);
					SONG.noteStyle = 'normal';
					generateStaticArrows(1, false);
					changeDaddyEjected('spinel-angy', 2000, 0.5, 400, 0.7);
				case 2108:
					changeBfEjected('selever', 2000, 0.5, 270, 0.7);
				case 2176:
					removeStatics();
					SONG.noteStyle = 'normal';
					generateStaticArrows(0, false);
					generateStaticArrows(1, false);
				case 2172:
					changeDaddyEjected('cj', 2000, 0.5, 300, 0.7);
				case 2266:
					changeBfEjected('sarvente-lucifer', 2000, 0.5, 2000, 1);
				case 2300:
					changeBfEjected('ruby', 2000, 0.5, 300, 0.7);
				case 2432:
					roseturn = true;
					dadSinging = false;
					defaultCamZoom = 0.5;
					iconP2.animation.play('rosefall');
				case 2559:
					boyfriendSinging = false;
					roboturn = true;
					roboasbf = true;
					roseturn = false;
					iconP1.animation.play('robo-gf');
				case 2693:
					defaultCamZoom = 0.3;
					boyfriendSinging = true;
					dadSinging = true;
					roboturn = false;
					roboasbf = false;
					//changeDaddyEjected('lavfinal', 2000, 0.5, 50, 0.7);
					FlxTween.tween(dad, {y: 2000}, 0.5, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							dad.y = -2000;
							var olddadx = dad.x;
							var olddady = dad.y;
							remove(dad);
							dad = new Character(olddadx, olddady, 'lavfinal');
							add(dad);
							iconP2.animation.play('lavfinal');
							FlxTween.tween(dad, {y: 50}, 0.7, {
								ease: FlxEase.cubeInOut
							});
						}
					});
				case 2821:
					changeBfEjected('ron', 2000, 0.5, 640, 0.7);
				case 2928:
					dadAnimNoInterupt = true;
					FlxTween.tween(dad, {y: 2000}, 0.5, {
						ease: FlxEase.cubeInOut,
					});
				case 2945:
					dad.y = -1500;
					var olddadx = dad.x;
					var olddady = dad.y;
					remove(dad);
					dad = new Character(olddadx, olddady, 'cream-dead');
					add(dad);
					dad.playAnim('wws', true);
					dadSinging = false;
					iconP2.animation.play('cream-dead');
					FlxTween.tween(dad, {y: 2500}, 0.3);

					/// SINGING
				case 913 | 961 | 1057:
					dadSinging = false;
					dadAgainSinging = true;
				case 921 | 969 | 1065: //nice
					boyfriendSinging = false;
					boyfriendAgainSinging = true;
				case 929 | 977 | 1025 | 1073:
					dadSinging = true;
					dadAgainSinging = false;
				case 946 | 985 | 1041 | 1081:
					boyfriendSinging = true;
					boyfriendAgainSinging = false;
				case 994 | 1089:
					dadSinging = false;
					dadAgainSinging = true;
					boyfriendSinging = false;
					boyfriendAgainSinging = true;
				case 1153:
					dadSinging = true;
					dadAgainSinging = false;
					boyfriendSinging = true;
					boyfriendAgainSinging = false;

				// STUFF
				
				case 1990: //1984 before
					amogos.y = -2200;
			}
		}
		else if (SONG.song.toLowerCase() == 'the sunday revolving' && curStep != stepOfLast && !songEnded)
		{
			switch (curStep)
			{
				case 1:
					add(blackFuck);
					blackFuck.alpha = 0;
				case 123: //0.8
					FlxTween.tween(blackFuck, {alpha: 1}, 0.8, {
					onComplete: function(twn:FlxTween)
					{
						add(dialogueBoxDelta);
						add(mic);
						mic.x = FlxG.width*0.7;
						mic.y = -500;
						blackFuck.alpha = 0;
						BG2.visible = true;
						changeGf('robo-dog');
						gf.y += 350;
						gf.antialiasing = false;
						changeBf('bf-flipped');
						changeDaddy('jevil-sunday-flipped');
						changeOtherDaddy('jevil-sunday-flipped');
						dadAgain.x = 800;
						dadAgain.y = 220;
						dadAgain2 = new Character(dadAgain.x - 100, dadAgain.y, 'jevil-sunday-flipped');
						add(dadAgain2);
						dadAgain3 = new Character(dadAgain.x + 100, dadAgain.y, 'jevil-sunday-flipped');
						add(dadAgain3);

						dad.setGraphicSize(Std.int(dad.width * 0.4));
						dad.updateHitbox();

						for (anim in dad.animOffsets.keys())
						{
							trace(dad.animOffsets.keys());
							dad.animOffsets[anim] = [dad.animOffsets[anim][0]*0.4,dad.animOffsets[anim][1]*0.4];
						}

						dadAgain.setGraphicSize(Std.int(dadAgain.width * 0.3));
						dadAgain.updateHitbox();

						for (anim in dadAgain.animOffsets.keys())
						{
							trace(dadAgain.animOffsets.keys());
							dadAgain.animOffsets[anim] = [dadAgain.animOffsets[anim][0]*0.3,dadAgain.animOffsets[anim][1]*0.3];
						}

						dadAgain.playAnim('idle');
						dadAgain.alpha = 0.6;

						dadAgain2.setGraphicSize(Std.int(dadAgain2.width * 0.3));
						dadAgain2.updateHitbox();

						for (anim in dadAgain2.animOffsets.keys())
						{
							trace(dadAgain2.animOffsets.keys());
							dadAgain2.animOffsets[anim] = [dadAgain2.animOffsets[anim][0]*0.3,dadAgain2.animOffsets[anim][1]*0.3];
						}

						dadAgain2.playAnim('idle');
						dadAgain2.alpha = 0.6;

						dadAgain3.setGraphicSize(Std.int(dadAgain3.width * 0.3));
						dadAgain3.updateHitbox();

						for (anim in dadAgain3.animOffsets.keys())
						{
							trace(dadAgain3.animOffsets.keys());
							dadAgain3.animOffsets[anim] = [dadAgain3.animOffsets[anim][0]*0.3,dadAgain3.animOffsets[anim][1]*0.3];
						}

						dadAgain3.playAnim('idle');
						dadAgain3.alpha = 0.6;

						boyfriend.setGraphicSize(Std.int(boyfriend.width * 0.3));
						boyfriend.updateHitbox();

						for (anim in boyfriend.animOffsets.keys())
						{
							boyfriend.animOffsets[anim] = [boyfriend.animOffsets[anim][0]*0.3,boyfriend.animOffsets[anim][1]*0.3];
						}

						dad.flipX = !dad.flipX;
						dadAgain.flipX = !dadAgain.flipX;
						dadAgain2.flipX = !dadAgain2.flipX;
						dadAgain3.flipX = !dadAgain3.flipX;
						boyfriend.flipX = !boyfriend.flipX;

						dad.x = 900;
						dad.y = 30;
						boyfriend.x = 100;
						boyfriend.y = 170;

						playerStrums.forEach(function(todel:FlxSprite)
							{
								todel.x -= (FlxG.width / 2);
							});
						cpuStrums.forEach(function(todel:FlxSprite)
							{
								todel.x += (FlxG.width / 2);
							});
						iconP1.visible = false;
						iconP2.visible = false;
						remove(healthBar);
						healthBar = new FlxBar(806, 570, LEFT_TO_RIGHT, 129, 15, this,
						'health', 0, 2);
						add(healthBar);
						healthBar.cameras = [camHUDier];
						healthBar.createFilledBar(0xFF7F0B00, 0xFF00D0E7);
						healthBarBG.visible = false;
						scoreTxt.cameras = [camHUDier];
						kadeEngineWatermark.cameras = [camHUDier];
						boyfriend.playAnim('hey');
						add(dumbasstext2);
						add(dumbasstext3);
						removal = 0;
						addition = 0;
						FlxG.sound.play(Paths.sound('snd_weaponpull'), 1);

						var dumbasstextS = ['* IT TURNED INTO AN ANNOYING ROBO!',
											'* WHO CHARTED THIS COVER? A CUTE FEMBOY?',
											'* CHAOS CHAOS',
											'* WAIT IT ISN\'T A BETADCIU?',
											'* SCREAMS CHAOTICALY',
											'* BRING BACK THE FLUFFY BOY!',
											'* WHAT GAME IS THIS AGAIN??\n* DELTAFUNK?',
											'* WHERE\'S THE TOILET PAPER POINTS?',
											'* BRO CHAPTER 1 SPOILERS',
											'* SUNDAY WOKE UP AND CHOSE FIGHT',
											'* THERE\'S NO CAROL TO STOP HER NOW',
											'* NOTICE ME BLANTADOS',
											'* WHERE\'RE MY HEALING ITEMS?????'];

						dumbasstext4 = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
						dumbasstext4.setFormat(Paths.font("DeterminationMonoWebRegular.ttf"), 36, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
						dumbasstext4.color = FlxColor.WHITE;
						dumbasstext4.sounds = [FlxG.sound.load(Paths.sound('snd_text'), 1)];	
						dumbasstext4.resetText(dumbasstextS[FlxG.random.int(0, dumbasstextS.length)]);
						dumbasstext4.start(0.03, true);
						dumbasstext4.cameras = [camHUDier];
						add(dumbasstext4);
						dumbasstext4.x = 50;
						dumbasstext4.y = 615;
					}
				});
				case 512:
					FlxTween.tween(BG2, {alpha: 0}, 0.5);
					FlxTween.tween(dialogueBoxDelta, {alpha: 0}, 0.5);
					FlxTween.tween(dad, {alpha: 0}, 0.5);
					FlxTween.tween(dadAgain, {alpha: 0}, 0.5);
					FlxTween.tween(dadAgain2, {alpha: 0}, 0.5);
					FlxTween.tween(dadAgain3, {alpha: 0}, 0.5);
					FlxTween.tween(boyfriend, {alpha: 0}, 0.5);
					FlxTween.tween(gf, {alpha: 0}, 0.5);
					FlxTween.tween(dumbasstext2, {alpha: 0}, 0.5);
					FlxTween.tween(dumbasstext3, {alpha: 0}, 0.5);
					FlxTween.tween(dumbasstext4, {alpha: 0}, 0.5);
					FlxTween.tween(healthBar, {alpha: 0}, 0.5);
				case 524:
					FlxTween.tween(mic, {y: dialogueBoxDelta.y}, 0.63, {
						onComplete: function(twn:FlxTween)
						{
							FlxG.sound.play(Paths.sound('snd_scytheburst'), 1);
							mic.y = -500;
							var BANG:FlxSprite;
							BANG = new FlxSprite(Std.int(FlxG.width/2)).makeGraphic(Std.int(FlxG.width/2),720, FlxColor.WHITE);
							BANG.cameras = [camHUDier];
							add(BANG);
							FlxTween.tween(BANG, {alpha: 0}, 1, {
								onComplete: function(twn:FlxTween)
								{
									remove(BANG);
								}
							});
						}
					});
				case 540 | 556:
					FlxTween.tween(mic, {y: dialogueBoxDelta.y}, 0.63, {
						onComplete: function(twn:FlxTween)
						{
							FlxG.sound.play(Paths.sound('snd_scytheburst'), 1);
							mic.y = -500;
							var BANG:FlxSprite;
							BANG = new FlxSprite(Std.int(FlxG.width/2)).makeGraphic(Std.int(FlxG.width/2),720, FlxColor.WHITE);
							BANG.cameras = [camHUDier];
							add(BANG);
							FlxTween.tween(BANG, {alpha: 0}, 1, {
								onComplete: function(twn:FlxTween)
								{
									remove(BANG);
								}
							});
						}
					});
				case 572 | 588 | 604:
					mic.x = FlxG.width*0.20;
					FlxTween.tween(mic, {y: dialogueBoxDelta.y}, 0.63, {
						onComplete: function(twn:FlxTween)
						{
							FlxG.sound.play(Paths.sound('snd_scytheburst'), 1);
							mic.y = -500;
							var BANG:FlxSprite;
							BANG = new FlxSprite().makeGraphic(Std.int(FlxG.width/2),720, FlxColor.WHITE);
							BANG.cameras = [camHUDier];
							add(BANG);
							FlxTween.tween(BANG, {alpha: 0}, 1, {
								onComplete: function(twn:FlxTween)
								{
									remove(BANG);
								}
							});
						}
					});
				case 620:
					mic.x = FlxG.width*0.20;
					FlxTween.tween(mic, {y: dialogueBoxDelta.y}, 0.63, {
						onComplete: function(twn:FlxTween)
						{
							FlxG.sound.play(Paths.sound('snd_scytheburst'), 1);
							mic.y = -1500;
							var BANG:FlxSprite;
							BANG = new FlxSprite().makeGraphic(Std.int(FlxG.width/2),720, FlxColor.WHITE);
							BANG.cameras = [camHUDier];
							add(BANG);
							FlxTween.tween(BANG, {alpha: 0}, 1, {
								onComplete: function(twn:FlxTween)
								{
									remove(BANG);
								}
							});
						}
					});
				/*case 630:
					FlxTween.tween(BG2, {alpha: 1}, 0.5);
					FlxTween.tween(dialogueBoxDelta, {alpha: 1}, 0.5);
					FlxTween.tween(dad, {alpha: 1}, 0.5);
					FlxTween.tween(dadAgain, {alpha: 1}, 0.5);
					FlxTween.tween(dadAgain2, {alpha: 1}, 0.5);
					FlxTween.tween(dadAgain3, {alpha: 1}, 0.5);
					FlxTween.tween(boyfriend, {alpha: 1}, 0.5);
					FlxTween.tween(gf, {alpha: 1}, 0.5);
					FlxTween.tween(dumbasstext2, {alpha: 1}, 0.5);
					FlxTween.tween(dumbasstext3, {alpha: 1}, 0.5);
					FlxTween.tween(dumbasstext4, {alpha: 1}, 0.5);
					FlxTween.tween(healthBar, {alpha: 1}, 0.5);*/
				case 635:
					mic.setGraphicSize(Std.int(mic.width * 5));
					mic.screenCenter(X);
					FlxTween.tween(mic, {y: dialogueBoxDelta.y- 300}, 0.63, {
						onComplete: function(twn:FlxTween)
						{
							FlxG.sound.play(Paths.sound('snd_scytheburst'), 1);
							mic.y = -1500;
							var BANG:FlxSprite;
							BANG = new FlxSprite().makeGraphic(FlxG.width,720, FlxColor.WHITE);
							BANG.cameras = [camHUDier];
							add(BANG);
							FlxTween.tween(BANG, {alpha: 0}, 3, {
								onComplete: function(twn:FlxTween)
								{
									remove(BANG);
									dialogue = CoolUtil.coolTextFile(Paths.txt('the-sunday-revolving/the-sunday-revolving-EndingDialogue'));
									var doof:DialogueBoxNormal = new DialogueBoxNormal(false, dialogue);
									doof.scrollFactor.set();
									doof.finishThing = funnierfunction;
									doof.cameras = [camHUD];
									add(doof);
								}
							});
							FlxTween.tween(BG2, {alpha: 1}, 0.5);
							FlxTween.tween(dad, {alpha: 1}, 0.5);
							FlxTween.tween(boyfriend, {alpha: 1}, 0.5);
							FlxTween.tween(gf, {alpha: 1}, 0.5);
							susie = new FlxSprite().loadGraphic(Paths.image('the sunday revolving/susie'));
							ralsei = new FlxSprite().loadGraphic(Paths.image('the sunday revolving/ralsei'));
							kris = new FlxSprite().loadGraphic(Paths.image('the sunday revolving/kris'));
							susie.setGraphicSize(Std.int(susie.width * 3));
							susie.antialiasing = false;
							ralsei.setGraphicSize(Std.int(ralsei.width * 3));
							ralsei.antialiasing = false;
							kris.setGraphicSize(Std.int(kris.width * 3));
							kris.antialiasing = false;
							add(susie);
							add(ralsei);
							add(kris);
							playerStrums.forEach(function(todel:FlxSprite)
								{
									todel.visible = false;
								});
							cpuStrums.forEach(function(todel:FlxSprite)
								{
									todel.visible = false;
								});
						}
					});
			}
		}
		else if (SONG.song.toLowerCase() == 'big piece' && curStep != stepOfLast && !songEnded)
		{
			switch (curStep)
			{
				case 1:

					playerStrums.forEach(function(todel:FlxSprite)
						{
							todel.x -= (FlxG.width / 2);
						});
					cpuStrums.forEach(function(todel:FlxSprite)
						{
							todel.x += (FlxG.width / 2);
						});
					var dumbasstextS = ['* OH CRAP NO POWERS FOR ROBO',
										'* WHO CHARTED THIS COVER? A CUTE FEMBOY? AGAIN?????',
										'* DON\'T YOU WANNA BE A BIG SHOT??',
										'* WAIT IT ISN\'T A BETADCIU?',
										'* LAUGHS HESTERICALLY',
										'* IT\'S THE FLUFFY BOY!',
										'* GET US OUTA DELTAFUNK',
										'* WHAT DO YOU MEAN THEY\'RE CALLED TENSION POINTS???',
										'* BRO CHAPTER 2 SPOILERS',
										'* SPAMTON IS A HAT KID NOW LMAOOOOO',
										'* MUSTACHE GIRL WHERE DID YOU GOO',
										'* BLANDADOS NOTICED ME :D',
										'* I WANNA HEAL AAAAAA'];
		
					dumbasstext4 = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
					dumbasstext4.setFormat(Paths.font("DeterminationMonoWebRegular.ttf"), 36, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
					dumbasstext4.color = FlxColor.WHITE;
					dumbasstext4.sounds = [FlxG.sound.load(Paths.sound('snd_text'), 1)];	
					dumbasstext4.resetText(dumbasstextS[FlxG.random.int(0, dumbasstextS.length)]);
					dumbasstext4.start(0.03, true);
					dumbasstext4.cameras = [camHUDier];
					add(dumbasstext4);
					dumbasstext4.x = 50;
					dumbasstext4.y = 615;
				case 127:
					FlxTween.tween(railRoad, {alpha: 0}, 0.2);
					FlxTween.tween(railRoad2, {alpha: 0}, 0.2);
					FlxTween.tween(railRoad3, {alpha: 0}, 0.2);
					FlxTween.tween(spamtonCart, {alpha: 0}, 0.2);
					FlxTween.tween(spamtonCartThing, {alpha: 0}, 0.2);
					FlxTween.tween(spamtonCart2, {alpha: 0}, 0.2);
					FlxTween.tween(spamtonCartThing2, {alpha: 0}, 0.2);
					FlxTween.tween(spamtonCart3, {alpha: 0}, 0.2);
					FlxTween.tween(spamtonCartThing3, {alpha: 0}, 0.2);
					FlxTween.tween(BG2, {alpha: 0}, 0.2);
					FlxTween.tween(BG3, {alpha: 0}, 0.2);
					FlxTween.tween(BG4, {alpha: 0}, 0.2);
					FlxTween.tween(FG1, {alpha: 0}, 0.2);
					FlxTween.tween(FG2, {alpha: 0}, 0.2);
					FlxTween.tween(FG3, {alpha: 0}, 0.2);
					FlxTween.tween(FG4, {alpha: 0}, 0.2);
					FlxTween.tween(camHUD, {alpha: 0}, 0.2);
					FlxTween.tween(dumbasstext2, {alpha: 0}, 0.2);
					FlxTween.tween(dumbasstext3, {alpha: 0}, 0.2);
					FlxTween.tween(dumbasstext4, {alpha: 0}, 0.2);
					FlxTween.tween(healthBar, {alpha: 0}, 0.2);
				case 146:
					railRoad.alpha = 1;
					railRoad2.alpha = 1;
					railRoad3.alpha = 1;
					spamtonCart.alpha = 1;
					spamtonCartThing.alpha = 1;
					spamtonCart2.alpha = 1;
					spamtonCartThing2.alpha = 1;
					spamtonCart3.alpha = 1;
					spamtonCartThing3.alpha = 1;
					BG2.alpha = 1;
					BG3.alpha = 1;
					BG4.alpha = 1;
					FG1.alpha = 1;
					FG2.alpha = 1;
					FG3.alpha = 1;
					FG4.alpha = 1;
					camHUD.alpha = 1;
					dumbasstext2.alpha = 1;
					dumbasstext3.alpha = 1;
					dumbasstext4.alpha = 1;
					healthBar.alpha = 1;
				case 203 | 204 | 205 | 206 | 207 | 208 | 209 | 267 | 268 | 269 | 270 | 271 | 272 | 273 | 434 | 436 | 442 | 445 | 450 | 453 | 456 | 458 | 459 | 460 | 461 | 462 | 846 | 847 | 848 | 917 | 930 | 934 | 946 | 950 | 1026 | 1028 | 1030 | 1032 | 1033 | 1034 | 1035 | 1036 | 1037 | 1038 | 1040:
					var newProj = new Projectile(boyfriend, blueSpamton1.getMidpoint().x - 30, blueSpamton1.getMidpoint().y);
					newProj.loadGraphic(Paths.image('spamton/laser'));
					projectiles.add(newProj);
					blueSpamton1.animation.play('shoot');
					var newProj2 = new Projectile(boyfriend, blueSpamton2.getMidpoint().x - 30, blueSpamton2.getMidpoint().y);
					newProj2.loadGraphic(Paths.image('spamton/laser'));
					projectiles.add(newProj2);
					blueSpamton2.animation.play('shoot');
				case 526:
					mic.setGraphicSize(Std.int(mic.width * 2));
					mic.screenCenter(X);
					FlxTween.tween(mic, {y: dialogueBoxDelta.y- 300}, 0.40, {
						onComplete: function(twn:FlxTween)
						{
							dumbasstext4.resetText('* ROBO JOINS IN!');
							dumbasstext4.start(0.03, true);
							roboturn = true;
							roboasbf = true;
							FlxG.sound.play(Paths.sound('snd_scytheburst'), 1);
							mic.y = -1500;
							var BANG:FlxSprite;
							BANG = new FlxSprite().makeGraphic(FlxG.width,720, FlxColor.WHITE);
							BANG.cameras = [camHUDier];
							add(BANG);
							dadAgain3.visible = true;
							dadAgain2.visible = true;
							dad.visible = false;
							
							railRoad.visible = false;
							railRoad2.visible = false;
							railRoad3.visible = false;

							blueSpamton1.visible = false;
							blueSpamton2.visible = false;
							
							changeGf('robo-gf');

							gf.setGraphicSize(Std.int(gf.width * 0.4));
							gf.updateHitbox();
				
							for (anim in gf.animOffsets.keys())
							{
								trace(gf.animOffsets.keys());
								gf.animOffsets[anim] = [gf.animOffsets[anim][0]*0.4,gf.animOffsets[anim][1]*0.4];
							}
							dialogueBoxDelta.loadGraphic(Paths.image('the sunday revolving/DELTARUNE DIALOGUE BOX AND ROBO'));

							spamtonCart.visible = false;
							spamtonCartThing.visible = false;
							spamtonCart2.visible = false;
							spamtonCartThing2.visible = false;
							spamtonCart3.visible = false;
							spamtonCartThing3.visible = false;
							
							string1.visible = false;
							string2.visible = false;
							string3.visible = false;
							string4.visible = false;
							string5.visible = false;
							
							susie.visible = false;
							ralsei.visible = false;
							kris.visible = false;

							BG2.visible = false;
							BG3.visible = false;

							BG2.visible = false;
							BG3.visible = false;
							BG4.visible = true;
							FG1.visible = false;
							FG2.visible = false;
							FG3.visible = false;
							FG4.visible = false;

							dadAgain2.y -= 130;
							dadAgain3.y -= 180;
							boyfriend.y += 110;
							boyfriend.x += 40;
							FlxTween.tween(BANG, {alpha: 0}, 3, {
								onComplete: function(twn:FlxTween)
								{
									remove(BANG);
								}
							});
						}
					});
				case 780:
					roboturn = false;
					roboasbf = false;
					FlxG.sound.play(Paths.sound('deltarune/gun'), 1);
					var timepiece = new FlxSprite().loadGraphic(Paths.image('the sunday revolving/timepiece'));
					timepiece.setGraphicSize(Std.int(mic.width * 3));
					timepiece.screenCenter(X);
					timepiece.y = -1500;
					timepiece.cameras = [camHUDier];
					add(timepiece);
					FlxTween.tween(timepiece, {y: dialogueBoxDelta.y - 300, angle: 360}, 0.5, {
						onComplete: function(twn:FlxTween)
						{
							dumbasstext4.resetText('* IT\'S A REVOLUTION!');
							dumbasstext4.start(0.03, true);
							FlxG.sound.play(Paths.sound('snd_scytheburst'), 1);
							var BANG:FlxSprite;
							BANG = new FlxSprite().makeGraphic(FlxG.width,720, FlxColor.WHITE);
							BANG.cameras = [camHUDier];
							add(BANG);
							remove(timepiece);
							dadAgain.visible = true;
							FlxTween.tween(BANG, {alpha: 0}, 3, {
								onComplete: function(twn:FlxTween)
								{
									remove(BANG);
								}
							});
							dad.visible = true;
							
							railRoad.visible = true;
							railRoad2.visible = true;
							railRoad3.visible = true;

							blueSpamton1.visible = true;
							blueSpamton2.visible = true;
							changeGf('robo-gf-no-speakers');

							gf.setGraphicSize(Std.int(gf.width * 0.4));
							gf.updateHitbox();
				
							for (anim in gf.animOffsets.keys())
							{
								trace(gf.animOffsets.keys());
								gf.animOffsets[anim] = [gf.animOffsets[anim][0]*0.4,gf.animOffsets[anim][1]*0.4];
							}
		
							spamtonCart.visible = true;
							spamtonCartThing.visible = true;
							spamtonCart2.visible = true;
							spamtonCartThing2.visible = true;
							spamtonCart3.visible = true;
							spamtonCartThing3.visible = true;

							string3.visible = true;
							string5.visible = true;

							susie.visible = true;
							ralsei.visible = true;
							kris.visible = true;
		
							BG2.visible = true;
							BG3.visible = true;
		
							BG2.visible = true;
							BG3.visible = true;
							BG4.visible = false;
							FG1.visible = true;
							FG2.visible = true;
							FG3.visible = true;
							FG4.visible = true;

							boyfriend.y -= 110;
							boyfriend.x -= 40;
							dadAgain2.x -= 70;
							dadAgain2.y -= 30;
							dadAgain3.y -= 30;
						}
					});
				case 850:
					roboturn = true;
					roboasbf = true;
				case 914:
					roboturn = false;
					roboasbf = false;
					var newProj = new Projectile(boyfriend, blueSpamton1.getMidpoint().x - 30, blueSpamton1.getMidpoint().y);
					newProj.loadGraphic(Paths.image('spamton/laser'));
					projectiles.add(newProj);
					blueSpamton1.animation.play('shoot');
					var newProj2 = new Projectile(boyfriend, blueSpamton2.getMidpoint().x - 30, blueSpamton2.getMidpoint().y);
					newProj2.loadGraphic(Paths.image('spamton/laser'));
					projectiles.add(newProj2);
					blueSpamton2.animation.play('shoot');
					ralsei.animation.play('snap');
					susie.animation.play('snap');
					kris.animation.play('snap');
					susie.x = -130;
					susie.y = 60;
					kris.x -= 9;
					kris.y -= 0;
					FlxG.sound.play(Paths.sound('deltarune/snd_damage'), 1);
					var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image('snap'));
					comboSpr.screenCenter();
					comboSpr.x = dad.x + 200;
					comboSpr.y = dad.y;
					comboSpr.acceleration.y = 600;
					comboSpr.velocity.y -= 150;
					comboSpr.velocity.x += FlxG.random.int(1, 10);
					comboSpr.cameras = [camHUDier];
					comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.5));
					comboSpr.antialiasing = true;
					add(comboSpr);
				case 1168:
					FlxTween.tween(railRoad, {alpha: 0}, 0.2);
					FlxTween.tween(railRoad2, {alpha: 0}, 0.2);
					FlxTween.tween(railRoad3, {alpha: 0}, 0.2);
					FlxTween.tween(spamtonCart, {alpha: 0}, 0.2);
					FlxTween.tween(spamtonCartThing, {alpha: 0}, 0.2);
					FlxTween.tween(spamtonCart2, {alpha: 0}, 0.2);
					FlxTween.tween(spamtonCartThing2, {alpha: 0}, 0.2);
					FlxTween.tween(spamtonCart3, {alpha: 0}, 0.2);
					FlxTween.tween(spamtonCartThing3, {alpha: 0}, 0.2);
					FlxTween.tween(BG2, {alpha: 0}, 0.2);
					FlxTween.tween(BG3, {alpha: 0}, 0.2);
					FlxTween.tween(BG4, {alpha: 0}, 0.2);
					FlxTween.tween(FG1, {alpha: 0}, 0.2);
					FlxTween.tween(FG2, {alpha: 0}, 0.2);
					FlxTween.tween(FG3, {alpha: 0}, 0.2);
					FlxTween.tween(FG4, {alpha: 0}, 0.2);
					FlxTween.tween(dumbasstext2, {alpha: 0}, 0.2);
					FlxTween.tween(dumbasstext3, {alpha: 0}, 0.2);
					FlxTween.tween(dumbasstext4, {alpha: 0}, 0.2);
					FlxTween.tween(healthBar, {alpha: 0}, 0.2);
					FlxTween.tween(heartSheild, {alpha: 0}, 0.2);
					FlxTween.tween(heartThing, {alpha: 0}, 0.2);
					FlxTween.tween(dad, {alpha: 0}, 0.2);
					FlxTween.tween(dadAgain, {alpha: 0}, 0.2);
					FlxTween.tween(dadAgain2, {alpha: 0}, 0.2);
					FlxTween.tween(dadAgain3, {alpha: 0}, 0.2);
					FlxTween.tween(boyfriend, {alpha: 0}, 0.2);
					FlxTween.tween(gf, {alpha: 0}, 0.2);
					FlxTween.tween(blueSpamton1, {alpha: 0}, 0.2);
					FlxTween.tween(blueSpamton2, {alpha: 0}, 0.2);
					FlxTween.tween(kris, {alpha: 0}, 0.2);
					FlxTween.tween(susie, {alpha: 0}, 0.2);
					FlxTween.tween(ralsei, {alpha: 0}, 0.2);
					FlxTween.tween(string3, {alpha: 0}, 0.2);
					spamtonLarg.loadGraphic(Paths.image('spamton/haha spamton hat'));
					spamtonLarg.setGraphicSize(Std.int(spamtonLarg.width * 1.5));
					add(spamtonLarg);
					spamtonLargJaw.loadGraphic(Paths.image('spamton/haha spamton hat jaw'));
					spamtonLargJaw.setGraphicSize(Std.int(spamtonLargJaw.width * 1.5));
					add(spamtonLargJaw);
					spamtonLargHead.loadGraphic(Paths.image('spamton/haha spamton hat head'));
					spamtonLargHead.setGraphicSize(Std.int(spamtonLargHead.width * 1.5));
					add(spamtonLargHead);
					cpuStrums.forEach(function(todel:FlxSprite)
						{
							FlxTween.tween(todel, {alpha: 0}, 0.2);
						});
					FlxTween.tween(dialogueBoxDelta, {alpha: 0}, 0.2);
					FlxTween.tween(spamtonLarg, {x: 600, y: 170}, 4.15, {
						ease: FlxEase.quadInOut,
						onComplete: function(twn:FlxTween)
						{
							spamtonLargHead.loadGraphic(Paths.image('spamton/haha spamton hat head no move'));
							spamtonLargHead.setGraphicSize(Std.int(spamtonLargHead.width * 1.5));
							spamtonLargJaw.visible = false;
							FlxTween.tween(spamtonLarg, {x: 1200}, 1, {
								ease: FlxEase.quadIn,
								onComplete: function(twn:FlxTween)
								{
									spamtonLarg.x = 0;
									spamtonLarg.y = 1700;
								}
							});
						}
					});
					
					FlxTween.tween(camHUD, {y: camHUD.y + 240, x: camHUD.x + (FlxG.width / 4) + 60}, 4.15, {
						ease: FlxEase.quadInOut,
					});
				case 1232:
					spamtonLarg.angle = 90;
					spamtonLargHead.angle = 90;
					spamtonLargJaw.visible = false;
					spamtonLargHead.loadGraphic(Paths.image('spamton/haha spamton hat head shoot'));
					spamtonLarg.setGraphicSize(Std.int(spamtonLarg.width * 4));
					spamtonLargHead.setGraphicSize(Std.int(spamtonLargHead.width * 4));
					spamtonLarg.cameras = [camHUDier];
					spamtonLargHead.cameras = [camHUDier];
					FlxTween.tween(spamtonLarg, {y: 1100}, 3, {
						ease: FlxEase.quadInOut,
					});
				case 1280:
					var BANG:FlxSprite;
					BANG = new FlxSprite().makeGraphic(FlxG.width,720, FlxColor.WHITE);
					BANG.cameras = [camHUDier];
					add(BANG);
					BANG.alpha = 0;
					FlxTween.tween(BANG, {alpha: 1}, 1.72, {
						onComplete: function(twn:FlxTween)
						{
							camHUD.y -= 240;
							camHUD.x -= (FlxG.width / 4) + 60;
							cpuStrums.forEach(function(todel:FlxSprite)
								{
									todel.alpha = 1;
								});
							remove(BANG);
							dadAgain.alpha = 1;
							spamtonLargHead.visible = false;
							spamtonLarg.visible = false;
						}
					});
				case 1314:
					FlxTween.tween(boyfriend, {alpha: 1}, 0.2);
				case 202 | 266:
					ralsei.animation.play('snap');
					susie.animation.play('snap');
					kris.animation.play('snap');
					susie.x = -130;
					susie.y = 60;
					kris.x -= 9;
					kris.y -= 0;
					FlxG.sound.play(Paths.sound('deltarune/snd_damage'), 1);
					var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image('snap'));
					comboSpr.screenCenter();
					comboSpr.x = dad.x + 200;
					comboSpr.y = dad.y;
					comboSpr.acceleration.y = 600;
					comboSpr.velocity.y -= 150;
					comboSpr.velocity.x += FlxG.random.int(1, 10);
					comboSpr.cameras = [camHUDier];
					comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.5));
					comboSpr.antialiasing = true;
					add(comboSpr);
					var newProj = new Projectile(boyfriend, blueSpamton1.getMidpoint().x - 30, blueSpamton1.getMidpoint().y);
					newProj.loadGraphic(Paths.image('spamton/laser'));
					projectiles.add(newProj);
					blueSpamton1.animation.play('shoot');
					var newProj2 = new Projectile(boyfriend, blueSpamton2.getMidpoint().x - 30, blueSpamton2.getMidpoint().y);
					newProj2.loadGraphic(Paths.image('spamton/laser'));
					projectiles.add(newProj2);
					blueSpamton2.animation.play('shoot');
				case 402:
					ralsei.animation.play('snap');
					susie.animation.play('snap');
					kris.animation.play('snap');
					susie.x = -130;
					susie.y = 60;
					kris.x -= 9;
					kris.y -= 0;
					FlxG.sound.play(Paths.sound('deltarune/snd_damage'), 1);
					var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image('snap'));
					comboSpr.screenCenter();
					comboSpr.x = dad.x + 200;
					comboSpr.y = dad.y;
					comboSpr.acceleration.y = 600;
					comboSpr.velocity.y -= 150;
					comboSpr.velocity.x += FlxG.random.int(1, 10);
					comboSpr.cameras = [camHUDier];
					comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.5));
					comboSpr.antialiasing = true;
					add(comboSpr);
					FlxTween.tween(string1, {y: -2000}, 2.5, {
						ease: FlxEase.cubeIn,
					});
				case 498 | 978 | 1106 | 1234:
					ralsei.animation.play('snap');
					susie.animation.play('snap');
					kris.animation.play('snap');
					susie.x = -130;
					susie.y = 60;
					kris.x -= 9;
					kris.y -= 0;
					FlxG.sound.play(Paths.sound('deltarune/snd_damage'), 1);
					var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image('snap'));
					comboSpr.screenCenter();
					comboSpr.x = dad.x + 200;
					comboSpr.y = dad.y;
					comboSpr.acceleration.y = 600;
					comboSpr.velocity.y -= 150;
					comboSpr.velocity.x += FlxG.random.int(1, 10);
					comboSpr.cameras = [camHUDier];
					comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.5));
					comboSpr.antialiasing = true;
					add(comboSpr);
				case 1042:
					ralsei.animation.play('snap');
					susie.animation.play('snap');
					kris.animation.play('snap');
					susie.x = -130;
					susie.y = 60;
					kris.x -= 9;
					kris.y -= 0;
					FlxG.sound.play(Paths.sound('deltarune/snd_damage'), 1);
					var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image('snap'));
					comboSpr.screenCenter();
					comboSpr.x = dad.x + 200;
					comboSpr.y = dad.y;
					comboSpr.acceleration.y = 600;
					comboSpr.velocity.y -= 150;
					comboSpr.velocity.x += FlxG.random.int(1, 10);
					comboSpr.cameras = [camHUDier];
					comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.5));
					comboSpr.antialiasing = true;
					add(comboSpr);
					FlxTween.tween(string5, {y: -2000}, 2.5, {
						ease: FlxEase.cubeIn,
					});
				case 1328:
					FlxG.sound.play(Paths.sound('deltarune/gun'), 1);
					var timepiece = new FlxSprite().loadGraphic(Paths.image('the sunday revolving/timepiece'));
					timepiece.setGraphicSize(Std.int(mic.width * 3));
					timepiece.screenCenter(X);
					timepiece.y = -1500;
					timepiece.cameras = [camHUDier];
					add(timepiece);
					FlxTween.tween(timepiece, {y: dialogueBoxDelta.y - 300, angle: 360}, 1, {
						onComplete: function(twn:FlxTween)
						{
							FlxG.sound.play(Paths.sound('snd_scytheburst'), 1);
							var BANG:FlxSprite;
							BANG = new FlxSprite().makeGraphic(FlxG.width,720, FlxColor.WHITE);
							BANG.cameras = [camHUDier];
							add(BANG);
							remove(timepiece);
							dadAgain.alpha = 1;
							FlxTween.tween(BANG, {alpha: 0}, 3, {
								onComplete: function(twn:FlxTween)
								{
									remove(BANG);
									dialogue = CoolUtil.coolTextFile(Paths.txt('big-piece/big-piece-EndingDialogue'));
									var doof:DialogueBoxNormal = new DialogueBoxNormal(false, dialogue);
									doof.scrollFactor.set();
									doof.finishThing = funniestfunction;
									doof.cameras = [camHUD];
									add(doof);
								}
							});
							dad.alpha = 1;
							dadAgain.alpha = 1;
							dadAgain2.alpha = 1;
							dadAgain3.alpha = 1;
							
							railRoad.alpha = 1;
							railRoad2.alpha = 1;
							railRoad3.alpha = 1;

							blueSpamton1.alpha = 1;
							blueSpamton2.alpha = 1;
		
							spamtonCart.alpha = 1;
							spamtonCartThing.alpha = 1;
							spamtonCart2.alpha = 1;
							spamtonCartThing2.alpha = 1;
							spamtonCart3.alpha = 1;
							spamtonCartThing3.alpha = 1;

							string3.alpha = 1;

							susie.alpha = 1;
							ralsei.alpha = 1;
							kris.alpha = 1;
							gf.alpha = 1;
		
							BG2.alpha = 1;
							BG3.alpha = 1;
		
							BG2.alpha = 1;
							BG3.alpha = 1;
							FG1.alpha = 1;
							FG2.alpha = 1;
							FG3.alpha = 1;
							FG4.alpha = 1;
						}
					});
			}
		}

		#if windows
		if (executeModchart && luaModchart != null)
		{
			luaModchart.setVar('curStep',curStep);
			luaModchart.executeState('stepHit',[curStep]);
		}
		#end

		// yes this updates every step.
		// yes this is bad
		// but i'm doing it to update misses and accuracy
		#if windows
		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;

		if (spookyRendered && spookySteps + 3 < curStep)
		{
			if (resetSpookyText)
			{
				remove(spookyText);
				spookyRendered = false;
			}
			tstatic.alpha = 0;
			if (curStage == 'auditorHell')
				tstatic.alpha = 0.1;
		}

		// Updating Discord Rich Presence (with Time Left)
		DiscordClient.changePresence(detailsText + " " + SONG.song + " (" + storyDifficultyText + ") " + Ratings.GenerateLetterRank(accuracy), "Acc: " + HelperFunctions.truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC,true,  songLength - Conductor.songPosition);
		#end

	}

	var lightningStrikeBeat:Int = 0;
	var lightningOffset:Int = 8;

	function KBATTACK_ALERT():Void
	{
		trace("DANGER!!!");
		kb_attack_alert.animation.play('alert', true);
		FlxG.sound.play(Paths.sound('alert'), 1);
	}

	function KBATTACK(state:Bool = false):Void
	{
		trace("HE ATACC!!!!");
		if(state){
			FlxG.sound.play(Paths.sound('attack'),0.75);
			//Play saw attack animation
			kb_attack_saw.animation.play('fire');
			kb_attack_saw.offset.set(1600,0);

			/*kb_attack_saw.animation.finishCallback = function(pog:String){
				if(state) //I don't get it.
					remove(kb_attack_saw);
			}*/

			//Slight delay for animation. Yeah I know I should be doing this using curStep and curBeat and what not, but I'm lazy -Haz
			new FlxTimer().start(0.1, function(tmr:FlxTimer)
			{
				if(!bfDodging){
					//MURDER THE BITCH!
					deathBySawBlade = true;
					health -= 404;
				}
			});
		}else{
			kb_attack_saw.animation.play('prepare');
			kb_attack_saw.offset.set(-333,0);
		}
	}

	override function beatHit()
	{
		super.beatHit();

		if (generatedMusic)
		{
			notes.sort(FlxSort.byY, (PlayStateChangeables.useDownscroll ? FlxSort.ASCENDING : FlxSort.DESCENDING));
		}

		#if windows
		if (executeModchart && luaModchart != null)
		{
			luaModchart.setVar('curBeat',curBeat);
			luaModchart.executeState('beatHit',[curBeat]);
		}
		#end

		if (curSong == 'Tutorial' && dad.curCharacter == 'gf') {
			if (curBeat % 2 == 1 && dad.animOffsets.exists('danceLeft'))
				dad.playAnim('danceLeft');
			if (curBeat % 2 == 0 && dad.animOffsets.exists('danceRight'))
				dad.playAnim('danceRight');
		}

		if (SONG.notes[Math.floor(curStep / 16)] != null)
		{
			if (SONG.notes[Math.floor(curStep / 16)].changeBPM)
			{
				Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm);
				FlxG.log.add('CHANGED BPM!');
			}
			// else
			// Conductor.changeBPM(SONG.bpm);

			// Dad doesnt interupt his own notes
			if (SONG.notes[Math.floor(curStep / 16)].mustHitSection && dad.curCharacter != 'gf' && dad.curCharacter != 'rebecca4') {
				if (((curSong.toLowerCase() == 'glitcher' && curStep > 567 && curStep < 1087) || (curSong.toLowerCase() == 'endless' && curStep > 1597 && curStep < 1672)) && (dad.curCharacter.toLowerCase().startsWith('qt-kb')))
					dad.dance(true);
				else if (!dadAnimNoInterupt)
					dad.dance();
				dadAgain.dance();
				dadAgain2.dance();
				dadAgain3.dance();
				hatkid.dance();
			}
		}
		// FlxG.log.add('change bpm' + SONG.notes[Std.int(curStep / 16)].changeBPM);
		wiggleShit.update(Conductor.crochet);

		if (FlxG.save.data.camzoom)
		{
			// HARDCODING FOR MILF ZOOMS!
			if (curSong.toLowerCase() == 'milf' && curBeat >= 168 && curBeat < 200 && camZooming && FlxG.camera.zoom < 1.35)
			{
				FlxG.camera.zoom += 0.015;
				camHUD.zoom += 0.03;
				camHUDier.zoom += 0.03;
			}
	
			if (camZooming && FlxG.camera.zoom < 1.35 && curBeat % 4 == 0)
			{
				FlxG.camera.zoom += 0.015;
				camHUD.zoom += 0.03;
				camHUDier.zoom += 0.03;
			}
	
		}

		iconP1.setGraphicSize(Std.int(iconP1.width + 30));
		iconP2.setGraphicSize(Std.int(iconP2.width + 30));
			
		iconP1.updateHitbox();
		iconP2.updateHitbox();

		if (curBeat % gfSpeed == 0)
		{
			if (!roboturn && !gf.animation.curAnim.name.startsWith('help') && !gf.animation.curAnim.name.startsWith('please'))
				gf.dance();
			if (curStage == 'auditorHell' || (SONG.song.toLowerCase() == 'ejected' && !roseturn))
				lol86.dance();
		}

		if (!boyfriend.animation.curAnim.name.startsWith("sing") && !bfDodging)
		{
			boyfriend.playAnim('idle');
			boyfriendAgain.playAnim('idle');
		}
		

		if (curBeat % 8 == 7 && curSong == 'Bopeebo')
		{
			boyfriend.playAnim('hey', true);
		}

		if (curBeat % 16 == 15 && SONG.song == 'Tutorial' && dad.curCharacter == 'gf' && curBeat > 16 && curBeat < 48)
			{
				boyfriend.playAnim('hey', true);
				dad.playAnim('cheer', true);
			}

		switch (curStage)
		{
			case 'school':
				if(FlxG.save.data.distractions){
					bgGirls.dance();
				}

			case 'mall':
				if(FlxG.save.data.distractions){
					upperBoppers.animation.play('bop', true);
					bottomBoppers.animation.play('bop', true);
					santa.animation.play('idle', true);
				}

			case 'limo':
				if(FlxG.save.data.distractions){
					grpLimoDancers.forEach(function(dancer:BackgroundDancer)
						{
							dancer.dance();
						});
		
						if (FlxG.random.bool(10) && fastCarCanDrive)
							fastCarDrive();
				}
			case "philly":
				if(FlxG.save.data.distractions){
					if (!trainMoving)
						trainCooldown += 1;
	
					if (curBeat % 4 == 0)
					{
						phillyCityLights.forEach(function(light:FlxSprite)
						{
							light.visible = false;
						});
	
						curLight = FlxG.random.int(0, phillyCityLights.length - 1);
	
						phillyCityLights.members[curLight].visible = true;
						// phillyCityLights.members[curLight].alpha = 1;
				}

				}

				if (curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8)
				{
					if(FlxG.save.data.distractions){
						trainCooldown = FlxG.random.int(-4, 0);
						trainStart();
					}
				}
		}

		if (isHalloween && FlxG.random.bool(10) && curBeat > lightningStrikeBeat + lightningOffset)
		{
			if(FlxG.save.data.distractions){
				lightningStrikeShit();
			}
		}
	}

	var curLight:Int = 0;
}
