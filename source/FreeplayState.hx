package;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;


#if windows
import Discord.DiscordClient;
#end

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];

	var selector:FlxText;
	var curSelected:Int = 0;
	var curDifficulty:Int = 1;

	var scoreText:FlxText;
	var comboText:FlxText;
	var thefunny:FlxText;
	var gf:Character;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var intendedScore:Int = 0;
	var combo:String = '';

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var songBeforeGospelSong:Alphabet;
	private var songBeforePraySong:Alphabet;
	private var theV1:FlxSprite;
	private var theV2:FlxSprite;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	override function create()
	{
		var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));

		for (i in 0...initSonglist.length)
		{
			var data:Array<String> = initSonglist[i].split(':');
			songs.push(new SongMetadata(data[0], Std.parseInt(data[2]), data[1]));
		}

		/* 
			if (FlxG.sound.music != null)
			{
				if (!FlxG.sound.music.playing)
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
			}
		 */

		 #if windows
		 // Updating Discord Rich Presence
		 DiscordClient.changePresence("In the Freeplay Menu", null);
		 #end

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end

		// LOAD MUSIC

		// LOAD CHARACTERS

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
		add(bg);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].songName, true, false, true);
			songText.isMenuItem = true;
			var theJ = 0;
			songText.ID = i;
			if (songText.ID > 9)
				theJ = 2;
			if (songText.ID == 0)
				songBeforeGospelSong = songText;
			if (songText.ID == 9)
				songBeforePraySong = songText;
			songText.targetY = i + theJ;
			grpSongs.add(songText);

			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}
		theV1 = new FlxSprite().loadGraphic(Paths.image('v1'));
		add(theV1);
		theV2 = new FlxSprite().loadGraphic(Paths.image('v2'));
		add(theV2);

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		// scoreText.autoSize = false;
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);
		// scoreText.alignment = RIGHT;

		var scoreBG:FlxSprite = new FlxSprite(scoreText.x - 6, 0).makeGraphic(Std.int(FlxG.width * 0.35), 150, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);

		diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
		add(diffText);

		thefunny = new FlxText(scoreText.x, scoreText.y + 36 * 2, 0, "", 16);
		thefunny.font = scoreText.font;
		add(thefunny);

		comboText = new FlxText(diffText.x + 100, diffText.y, 0, "", 24);
		comboText.font = diffText.font;
		add(comboText);

		add(scoreText);
		gf = new Character(700, 250, 'robo-gf');
		gf.setGraphicSize(Std.int(gf.width * 0.4));
		gf.updateHitbox();

		for (anim in gf.animOffsets.keys())
		{
			trace(gf.animOffsets.keys());
			gf.animOffsets[anim] = [gf.animOffsets[anim][0]*0.4,gf.animOffsets[anim][1]*0.4];
		}
		gf.dance();
		add(gf);

		changeSelection();
		changeDiff();

		// FlxG.sound.playMusic(Paths.music('title'), 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);
		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		super.create();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter));
	}

	public function addWeek(songs:Array<String>, weekNum:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['dad'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num]);

			if (songCharacters.length != 1)
				num++;
		}
	}

	override function update(elapsed:Float)
	{
		theV1.y = songBeforeGospelSong.y + 200;
		theV2.y = songBeforePraySong.y + 350;
		if (gf.animation.curAnim.finished)
		{
			if (gf.animation.curAnim.name == 'cheer') gf.playAnim('cheer', true); else gf.dance();
		}
		super.update(elapsed);

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.4));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;

		scoreText.text = "PERSONAL BEST:" + lerpScore;
		switch (songs[curSelected].songName)
		{
			case 'Tutorial':
				thefunny.text = "COVER TYPE:\nNOT EVEN A COVER";
			case 'Gospel':
				thefunny.text = "COVER TYPE:\nNORMAL COVER";
			case 'Expurgation':
				thefunny.text = "COVER TYPE:\nNORMAL COVER\nDEATH NOTES\nHEALTH DRAIN";
			case 'Headache':
				thefunny.text = "COVER TYPE:\nBETADCIU";
			case 'Release':
				thefunny.text = "COVER TYPE:\nNOT NORMAL BUT COOL AF";
			case 'Glitcher':
				thefunny.text = "COVER TYPE:\nNORMAL COVER\nSAWBLADES";
			case 'Endless':
				thefunny.text = "COVER TYPE:\nBETADCIU\nINFINITE";
			case 'Ejected':
				thefunny.text = "COVER TYPE:\nBETADCIU\nCOPYRIGHTED AT ROSE AND ROBO'S PART ONLY\nSUS";
			case 'The Sunday Revolving':
				thefunny.text = "COVER TYPE:\nNORMAL COVER\nCOPYRIGHTED\nCHAOTIC";
			case 'Big Piece':
				thefunny.text = "COVER TYPE:\nNORMAL COVER\nCOPYRIGHTED\nBIG";
			case 'Pray':
				thefunny.text = "COVER TYPE:\nBETADCIU\nHEALTH DRAIN\nWelcome to V2!";
			case 'Milk':
				thefunny.text = "COVER TYPE:\nNORMAL COVER\nEXCLUSIVE APPEARANCE\nSee you in V2!";
			case 'Cycles':
				thefunny.text = "COVER TYPE:\nBETADDIU\nEXE SPRITES I GUESS?";
		}
		comboText.text = combo + '\n';

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.LEFT_P)
			changeDiff(-1);
		if (controls.RIGHT_P)
			changeDiff(1);

		if (controls.BACK)
		{
			FlxG.switchState(new MainMenuState());
		}

		if (accepted)
		{
			// adjusting the song name to be compatible
			var songFormat = StringTools.replace(songs[curSelected].songName, " ", "-");
			switch (songFormat) {
				case 'Dad-Battle': songFormat = 'Dadbattle';
				case 'Philly-Nice': songFormat = 'Philly';
			}
			
			trace(songs[curSelected].songName);

			var poop:String = Highscore.formatSong(songFormat, curDifficulty);

			trace(poop);
			
			PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName);
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = curDifficulty;
			PlayState.storyWeek = songs[curSelected].week;
			trace('CUR WEEK' + PlayState.storyWeek);
			LoadingState.loadAndSwitchState(new OutdatedSubState());
		}
	}

	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		trace(songs[curSelected].songName);
		trace(curDifficulty);

		if (songs[curSelected].songName == 'Gospel')
		{
			if (curDifficulty < 2)
				curDifficulty = 5;
			if (curDifficulty > 5)
				curDifficulty = 2;
		}
		else if (songs[curSelected].songName == 'Expurgation')
		{
			curDifficulty = 6;
		}
		else if (songs[curSelected].songName == 'Endless')
		{
			curDifficulty = 9;
		}
		else if (songs[curSelected].songName == 'The Sunday Revolving')
		{
			curDifficulty = 7;
		}
		else if (songs[curSelected].songName == 'Big Piece')
		{
			curDifficulty = 8;
		}
		else if (songs[curSelected].songName == 'Pray')
		{
			curDifficulty = 10;
		}
		else if (songs[curSelected].songName == 'Milk')
		{
			curDifficulty = 11;
		}
		else if (songs[curSelected].songName == 'Cycles')
		{
			curDifficulty = 12;
		}
		else
		{
			if (curDifficulty < 0)
				curDifficulty = 2;
			if (curDifficulty > 2)
				curDifficulty = 0;
		}
		trace(curDifficulty);

		// adjusting the highscore song name to be compatible (changeDiff)
		var songHighscore = StringTools.replace(songs[curSelected].songName, " ", "-");
		switch (songHighscore) {
			case 'Dad-Battle': songHighscore = 'Dadbattle';
			case 'Philly-Nice': songHighscore = 'Philly';
		}
		
		#if !switch
		intendedScore = Highscore.getScore(songHighscore, curDifficulty);
		combo = Highscore.getCombo(songHighscore, curDifficulty);
		#end

		switch (curDifficulty)
		{
			case 0:
				diffText.text = "EASY";
			case 1:
				diffText.text = 'NORMAL';
			case 2:
				diffText.text = "HARD";
			case 3:
				diffText.text = "ALT";
			case 4:
				diffText.text = "HARD-a";
			case 5:
				diffText.text = "ALT-a";
			case 6:
				diffText.text = "UNFAIR";
			case 7:
				diffText.text = "CHAOS";
			case 8:
				diffText.text = "NEO";
			case 9:
				diffText.text = "FUN";
			case 10:
				diffText.text = "YOU WILL MEET GOD";
			case 11:
				diffText.text = "MERG";
			case 12:
				diffText.text = "X";
		}
	}

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent('Fresh');
		#end

		// NGio.logEvent('Fresh');
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;
		
		// adjusting the highscore song name to be compatible (changeSelection)
		// would read original scores if we didn't change packages
		var songHighscore = StringTools.replace(songs[curSelected].songName, " ", "-");
		switch (songHighscore) {
			case 'Dad-Battle': songHighscore = 'Dadbattle';
			case 'Philly-Nice': songHighscore = 'Philly';
		}

		#if !switch
		intendedScore = Highscore.getScore(songHighscore, curDifficulty);
		combo = Highscore.getCombo(songHighscore, curDifficulty);
		// lerpScore = 0;
		#end

		#if PRELOAD_ALL
		FlxG.sound.playMusic(Paths.inst(songs[curSelected].songName), 0);
		#end

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			var theJ = 0;
			if (item.ID > 0)
				theJ += 2;
			if (item.ID > 10)
				theJ += 2;
			item.targetY = bullShit - curSelected + theJ;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0 + theJ)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
			if (curSelected > 0)
				item.targetY = item.targetY - 2;
			if (curSelected > 10)
				item.targetY = item.targetY - 2;
		}
		changeDiff();
		
		switch (songs[curSelected].songName.toLowerCase())
		{
			case 'tutorial':
				if (FlxG.save.data.completedTutorial == true) gf.playAnim('cheer', true); else gf.dance();
			case 'gospel':
				if (FlxG.save.data.completedGospel == true) gf.playAnim('cheer', true); else gf.dance();
			case 'expurgation':
				if (FlxG.save.data.completedExpurgation == true) gf.playAnim('cheer', true); else gf.dance();
			case 'headache':
				if (FlxG.save.data.completedHeadache == true) gf.playAnim('cheer', true); else gf.dance();
			case 'release':
				if (FlxG.save.data.completedRelease == true) gf.playAnim('cheer', true); else gf.dance();
			case 'glitcher':
				if (FlxG.save.data.completedGlitcher == true) gf.playAnim('cheer', true); else gf.dance();
			case 'endless':
				if (FlxG.save.data.completedEndless == true) gf.playAnim('cheer', true); else gf.dance();
			case 'ejected':
				if (FlxG.save.data.completedEjected == true) gf.playAnim('cheer', true); else gf.dance();
			case 'the sunday revolving':
				if (FlxG.save.data.completedRevolving == true) gf.playAnim('cheer', true); else gf.dance();
			case 'big piece':
				if (FlxG.save.data.completedBig == true) gf.playAnim('cheer', true); else gf.dance();
			case 'pray':
				if (FlxG.save.data.completedPray == true) gf.playAnim('cheer', true); else gf.dance();
			case 'milk':
				if (FlxG.save.data.completedMilk == true) gf.playAnim('cheer', true); else gf.dance();
			case 'cycles':
				if (FlxG.save.data.completedCycles == true) gf.playAnim('cheer', true); else gf.dance();
			
		}
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";

	public function new(song:String, week:Int, songCharacter:String)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
	}
}
