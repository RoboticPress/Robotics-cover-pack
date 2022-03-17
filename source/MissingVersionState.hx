package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxStringUtil;
import lime.app.Application;
import flash.system.System;

using StringTools;

class MissingVersionState extends MusicBeatState
{
	public static var leftState:Bool = false;

	public static var needVer:String = "IDFK LOL";

	public static var creditsthingy:Array<String> = ['lol', 'even more lol'];

	override function create()
	{
		super.create();
		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);
		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			"IT SEEMS YOU'RE MISSING V1 OF THE MOD!\nGo download it from the Gamebanana page and extract this version of the mod over it and enjoy!\n\nPress any button to exit and open the GB page",
			32);
		txt.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, CENTER);
		txt.screenCenter();
		add(txt);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ANY)
		{
			FlxG.openURL('https://gamebanana.com/mods/303138');
			System.exit(0);
		}
		super.update(elapsed);
	}
}
