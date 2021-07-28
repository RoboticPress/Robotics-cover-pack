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
		var songthingy:String = PlayState.SONG.song.toLowerCase();
		if (songthingy.startsWith('tutorial'))
			creditsthingy = ['wait...', 'this is normal fnf'];
		if (songthingy.startsWith('gospel'))
			creditsthingy = ['Sarvente\'s Mid-Fight Masses', 'Vs. Lav: Frostbite Frenzy\n- Robotic Press for the cover (check me out on YouTube aaaaaa)'];
		if (songthingy.startsWith('expurgation'))
			creditsthingy = ['The Full-Ass Tricky Mod', 'Hat Kid - A Hat In Time BF + Week 1 Replacements\n- Robotic Press for the cover (check me out on YouTube aaaaaa)\n- The86thPlayer for fixing the cover being offkey (discord: the86thplayer#4426)'];
		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			"YO! It'd be great if you credit these mods\\people if you showcase this cover:\n"
			+ '- ${creditsthingy[0]}\n'
			+ '- ${creditsthingy[1]}\n'
			+ "- And of course this mod!\n"
			+ "\n\nPress Any key to continue",
			32);
		txt.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
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
