package;
import flixel.addons.ui.FlxUIState;
import flixel.FlxG;
#if windows
import Sys;
import sys.FileSystem;
#end

class CheckState extends FlxUIState
{
	override function create()
	{
		var theJ = sys.FileSystem.exists('assets/data/V1 included.txt');
		trace(theJ);
		super.create();
		if (theJ)
			FlxG.switchState(new TitleState());
		else
			FlxG.switchState(new MissingVersionState());
	}

	override function update(elapsed:Float)
	{
	}
}
