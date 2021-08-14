package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxStringUtil;
import lime.app.Application;

using StringTools;

class OutdatedSubState extends MusicBeatState
{
	public static var leftState:Bool = false;

	public static var needVer:String = "IDFK LOL";

	public static var creditsthingy:Array<String> = ['lol', 'even more lol'];

	override function create()
	{
		super.create();
		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'tutorial':
				creditsthingy = ['wait...', 'this is normal fnf'];
			case 'gospel':
				creditsthingy = ['Sarvente\'s Mid-Fight Masses', 'Vs. Lav: Frostbite Frenzy\n- Robotic Press for the cover (check me out on YouTube aaaaaa)'];
			case 'expurgation':
				creditsthingy = ['The Full-Ass Tricky Mod', 'Hat Kid - A Hat In Time BF + Week 1 Replacements\n- Robotic Press for the cover (check me out on YouTube aaaaaa)\n- The86thPlayer for fixing the cover being offkey (discord: the86thplayer#4426)'];
			case 'headache':
				creditsthingy = ['Robotic Press for the cover (check me out on YouTube aaaaaa)', 'Smoke em Out Struggle'
			+ '\n- V.S Zardy - Foolhardy'
			+ '\n- Zardy Foolhardy Reanimated'
			+ '\n- Hat Kid - A Hat In Time BF + Week 1 Replacements'
			+ '\n- VS Hex Mod'
			+ '\n- Vs Tord'
			+ '\n- Vs. Tord Mod LEGACY EDITION'
			+ '\n- VS Sunday [Remastered]'
			+ '\n- Vs Annie'
			+ '\n- Playable Tankman'
			+ '\n- The Full-Ass Tricky Mod'
			+ '\n- Vs. Lav: Frostbite Frenzy'
			+ '\n- VS. KAPI - Arcade Showdown'
			+ '\n- Playable Kapi+'
			+ '\n- Starving Artist'
			+ '\n- VS Cassandra'
			+ '\n- V.S. TABI Ex Boyfriend'
			+ '\n- V.S. AGOTI Full Week'
			+ '\n- HD Senpai over Dad'
			+ '\n- HD Monika over Dad'
			+ '\n- Salty\'s Sunday Night'
			+ '\n- Sarvente\'s Mid-Fight Masses [FULL WEEK+]'
			+ '\n- QT Mod'
			+ '\n- Whitty full week'
			+ '\n- Carol V2'
		];
		}
		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			"YO! It'd be great if you credit these mods\\people if you showcase this cover:\n"
			+ '- ${creditsthingy[0]}\n'
			+ '- ${creditsthingy[1]}\n'
			+ "- And of course this mod!\n"
			+ "\n\nPress Any key to continue",
			32);
		txt.setFormat("VCR OSD Mono", 26, FlxColor.WHITE, CENTER);
		txt.screenCenter();
		add(txt);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ANY)
		{
			leftState = true;
			FlxG.switchState(new PlayState());
		}
		super.update(elapsed);
	}
}
