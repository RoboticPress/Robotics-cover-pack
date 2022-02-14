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
				creditsthingy = ['Sarvente\'s Mid-Fight Masses', 'Vs. Lav: Frostbite Frenzy\n- Robotic Press for the cover (check me out on YouTube aaaaaa)\n- GenoX for Sarv UTAU voicebank used'];
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
				+ '\n- literally every fnf mod ever (Vs Bob Week)'
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
				+ '\n- GenoX for UTAU voicebanks used'
				];
			case 'release':
				creditsthingy = ['Smoke em Out Struggle', 'literally every fnf mod ever (Vs Bob Week)\n- Robotic Press for the cover (check me out on YouTube aaaaaa)\n- LadMcLad for the idea of the cover, the heaven BG, and ghost ron sprites (i exist ig)'];
			case 'glitcher':
				creditsthingy = ['QT Mod', 'VS Hex Mod\n- Robotic Press for the cover (check me out on YouTube aaaaaa)\n- GenoX for BF soft UTAU voicebanks used'];
			case 'endless':
				creditsthingy = ['Robotic Press for the cover (check me out on YouTube aaaaaa)', 'Sonic.exe mod'
				+ '\n- Sarvente\'s Mid-Fight Masses [FULL WEEK+]'
				+ '\n- Friday Night Fever'
				+ '\n- Playable Tankman'
				+ '\n- Neonight'
				+ '\n- Lylace'
				+ '\n- Vs Annie'
				+ '\n- Smoke em Out Struggle'
				+ '\n- V.S. TABI Ex Boyfriend'
				+ '\n- Ex-GF Over Mom'
				+ '\n- Friday Night Shootin\''
				+ '\n- VS Cassandra'
				+ '\n- Whitty full week'
				+ '\n- Hellchart Carol'
				+ '\n- Hat Kid - A Hat In Time BF + Week 1 Replacements'
				+ '\n- The Full-Ass Tricky Mod'
				+ '\n- HD Monika over Dad'
				+ '\n- Vs Nonsense [Full Week]'
				+ '\n- Salty\'s Sunday Night'
				+ '\n- literally every fnf mod ever (Vs Bob Week)'
				+ '\n- QT Mod'
				+ '\n- HD Senpai over Dad'
				+ '\n- Vs Matt'
				+ '\n- Deep-Sea Date'
				+ '\n- GenoX for UTAU voicebanks used'
				+ '\n- Blantados for UTAU voicebanks used'
				];
			case 'ejected':
				creditsthingy = ['Robotic Press for the cover (check me out on YouTube aaaaaa)', 'Vs Imposter V2'
				+ '\n- Vs Arch'
				+ '\n- VS Sunday [Remastered]'
				+ '\n- Carol V2'
				+ '\n- Friday Night Funkin\' Soft'
				+ '\n- Ex-GF Over Mom'
				+ '\n- literally every fnf mod ever (Vs Bob Week)'
				+ '\n- Lylace'
				+ '\n- VS Hex Mod'
				+ '\n- Whitty full week'
				+ '\n- Liz Week'
				+ '\n- vs. NEON (Full Week)'
				+ '\n- Lila over Daddy Dearest'
				+ '\n- Shaggy X Matt - Full Week'
				+ '\n- Salty\'s Sunday Night'
				+ '\n- V.S SAYORI'
				+ '\n- HD Monika over Dad'
				+ '\n- V.S Zardy - Foolhardy'
				+ '\n- Zardy Foolhardy Reanimated'
				+ '\n- Starving Artist'
				+ '\n- Vs Henry Stickmin 3.0 DEMO'
				+ '\n- Vs Annie'
				+ '\n- Smoke em Out Struggle'
				+ '\n- FNF: Space Journey [Full Week Beta]'
				+ '\n- Blantados Sprites Remake by MadBitch'
				+ '\n- V.S. Chara'
				+ '\n- Playable Sans! (w/ Vocals)'
				+ '\n- Friday Night Funkin\' CG5'
				+ '\n- Sarvente\'s Mid-Fight Masses [FULL WEEK+]'
				+ '\n- Mii Funkin: Vs. eteled [FULL WEEK]'
				+ '\n- Hat Kid - A Hat In Time BF + Week 1 Replacements'
				+ '\n- V.S. Spinel'
				+ '\n- Starlight Mayhem [Full Week] Vs CJ'
				+ '\n- The86thPlayer for making the character "rose"'
				+ '\n- Vs. Lav: Frostbite Frenzy'
				+ '\n- LadMcLad for the ghost ron sprites (i exist ig)'
				+ '\n- "Cheesed Bread" on the Robotic Hat discord server for making the featured meme in the cover'
				+ '\n- GenoX for UTAU voicebanks used'
				+ '\n- Blantados for UTAU voicebanks used'
			];
			case 'the sunday revolving':
				creditsthingy = ['Deltarune', 'VS Sunday [Remastered]\n- Robotic Press for the cover (check me out on YouTube aaaaaa)\n- The86thPlayer for charting the main vocals (discord: the86thplayer#4426)'];
			case 'big piece':
				creditsthingy = ['Deltarune', 'VS Sunday [Remastered]\n- VS Hatsune Miku\n- VS Carol V2\n- Robotic Press for the cover (check me out on YouTube aaaaaa)\n- The86thPlayer for charting the main vocals (discord: the86thplayer#4426)'];
			case 'milk':
				creditsthingy = ['Sonic.exe mod', 'Merg the chad cherry for providing his voice samples for the cover\n- Robotic Press for the cover (check me out on YouTube aaaaaa)\n- LadMcLad for the Merg sprites (i exist ig)'];
			case 'pray':
				creditsthingy = ['Robotic Press for the cover (check me out on YouTube aaaaaa)', 'Friday Night Fever'
				+ '\n- WassabiSoja for creating the song Pray and doing his own sprites (check him out btw-)'
				+ '\n- Froglet8 for the chart'
				+ '\n- Sonic.exe mod'
				+ '\n- Friday Night Funkin\': Doki Doki Takeover!'
				+ '\n- Vs Nonsense [Full Week]'
				+ '\n- Cyber Sensation'
				+ '\n- Muted Melodies Vs. Tactical Cupcakes/T.C.'
				+ '\n- @Cordium_ for Splite\'s icons and zhen for his sprites'
				+ '\n- Hat Kid - A Hat In Time BF + Week 1 Replacements'
				+ '\n- Sarvente\'s Mid-Fight Masses [FULL WEEK+]'
				+ '\n- VS Sunday [Remastered]'
				+ '\n- Lylace'
				+ '\n- Neonight'
				+ '\n- Hellchart Carol'
				+ '\n- Whitty full week'
				+ '\n- literally every fnf mod ever (Vs Bob Week)'
				+ '\n- LadMcLad for the ghost ron sprites (i exist ig)'
				+ '\n- Vs Imposter V2'
				+ '\n- V.S Zardy - Foolhardy'
				+ '\n- Friday Night Funkin Lullaby Mod'
				+ '\n- Technado for side facing gold and his own sprites'
				+ '\n- V.S. AGOTI Full Week'
				+ '\n- Cosmo Calamity (VS. Yukichi)'
				+ '\n- Blantados Sprites Remake by MadBitch'
				+ '\n- FNF: Cliff Clash'
				+ '\n- Vs. Beepie BF Lover - Friday Night Funkin\''
				+ '\n- Kimakurus Music for Beepie chromatic scale'
				+ '\n- Vs Arch'
				+ '\n- FNF DOXXIE'
				+ '\n- VS Hex Mod'
				+ '\n- Friday Night Funkin\' VS Cyrix - Full Week'
				];

		}
		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			"YO! It'd be great if you credit these mods\\people if you showcase this cover:\n"
			+ '- ${creditsthingy[0]}\n'
			+ '- ${creditsthingy[1]}\n'
			+ "- MythicSpeed for the Robo sprites\n"
			+ "- And of course this mod!\n"
			+ "\n\nPress Any key to continue",
			32);
		txt.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, CENTER);
		txt.screenCenter();
		add(txt);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ANY)
		{
			leftState = true;
			switch (PlayState.SONG.song.toLowerCase())
			{
				case 'release':
					FlxG.switchState(new VideoState('assets/videos/ronlease/mmcutscene.webm', new PlayState()));
				default:
					FlxG.switchState(new PlayState());
			}
		}
		super.update(elapsed);
	}
}
