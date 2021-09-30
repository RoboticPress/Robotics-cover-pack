package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxStringUtil;
import lime.app.Application;

using StringTools;

class ThanksSubState extends MusicBeatState
{
	public static var leftState:Bool = false;

	public static var needVer:String = "IDFK LOL";

	override function create()
	{
		super.create();
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('commoonity', 'shared'));
		add(bg);
		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			"A couple notes"
			+ "\n\n- Big thanks to everyone who supports me and my covers I can't express enough but it's really appreciated!"
			+ "\n\n- Thanks also to the youtubers who showcased my mod, Especially CommunityGame! It's really nice seeing my covers reach more and more people!"
			+ "\n\n- Although for said youtubers, please don't copy my video description credits without reading them, like seriously I saw SOME of you copied the part where I said my voice was included and when you copied it, it appeared as if it was YOURS, please give more attention to this stuff (still thanks for showcasing-). Also if you showcase *MULTIPLE* covers don't credit the mod by the name of the latest cover's name, It's called Robotic's cover pack, although if you showcase one cover it's fine to credit it by the name of the cover"
			+ "\n\n- And to end it off, a message to the websites that take my mod and upload it every update. at this point by the number of websites that do this and the mods taken on said websites I accepted it's innevitable. Just for any website that didn't credit me for the mod already. P l e a s e   c r e d i t"
			+ "\n\nThat's all! Press Any key to continue",
			32);
		txt.setFormat("VCR OSD Mono", 26, FlxColor.WHITE, CENTER);
		txt.screenCenter();
		add(txt);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ANY)
		{
			FlxG.switchState(new MainMenuState());
		}
		super.update(elapsed);
	}
}
