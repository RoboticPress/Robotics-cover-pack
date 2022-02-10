import flixel.FlxG;
import flixel.input.FlxInput;
import flixel.input.actions.FlxAction;
import flixel.input.actions.FlxActionInput;
import flixel.input.actions.FlxActionInputDigital;
import flixel.input.actions.FlxActionManager;
import flixel.input.actions.FlxActionSet;
import flixel.input.gamepad.FlxGamepadButton;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

class KeyBinds
{

    public static var gamepad:Bool = false;

    public static function resetBinds():Void{

        FlxG.save.data.upBind = "W";
        FlxG.save.data.downBind = "S";
        FlxG.save.data.middleBind = "SPACE";
        FlxG.save.data.leftBind = "A";
        FlxG.save.data.rightBind = "D";
        FlxG.save.data.dodgeBind = "SPACE";
        FlxG.save.data.killBind = "R";
        FlxG.save.data.gpupBind = "DPAD_UP";
        FlxG.save.data.gpdownBind = "DPAD_DOWN";
        FlxG.save.data.gpmiddleBind = "A";
        FlxG.save.data.gpleftBind = "DPAD_LEFT";
        FlxG.save.data.gprightBind = "DPAD_RIGHT";
        FlxG.save.data.gpdodgeBind = "A";
        PlayerSettings.player1.controls.loadKeyBinds();

	}

    public static function keyCheck():Void
    {
        if(FlxG.save.data.upBind == null){
            FlxG.save.data.upBind = "W";
            trace("No UP");
        }
        if (StringTools.contains(FlxG.save.data.upBind,"NUMPAD"))
            FlxG.save.data.upBind = "W";
        if(FlxG.save.data.downBind == null){
            FlxG.save.data.downBind = "S";
            trace("No DOWN");
        }
        if (StringTools.contains(FlxG.save.data.downBind,"NUMPAD"))
            FlxG.save.data.downBind = "S";
        if(FlxG.save.data.leftBind == null){
            FlxG.save.data.leftBind = "A";
            trace("No LEFT");
        }
        if (StringTools.contains(FlxG.save.data.leftBind,"NUMPAD"))
            FlxG.save.data.leftBind = "A";
        if(FlxG.save.data.rightBind == null){
            FlxG.save.data.rightBind = "D";
            trace("No RIGHT");
        }
        if(FlxG.save.data.killBind == null){
            FlxG.save.data.killBind = "R";
            trace("No KILL");
        }
        if (StringTools.contains(FlxG.save.data.rightBind,"NUMPAD"))
            FlxG.save.data.rightBind = "D";
        if(FlxG.save.data.middleBind == null){
            FlxG.save.data.middleBind = "SPACE";
            trace("No MIDDLE");
        }
        if (StringTools.contains(FlxG.save.data.middleBind,"NUMPAD"))
            FlxG.save.data.middleBind = "SPACE";
        if(FlxG.save.data.dodgeBind == null){
            FlxG.save.data.dodgeBind = "SPACE";
            trace("No MIDDLE");
        }
        if (StringTools.contains(FlxG.save.data.dodgeBind,"NUMPAD"))
            FlxG.save.data.middleBind = "SPACE";
        
        if(FlxG.save.data.gpupBind == null){
            FlxG.save.data.gpupBind = "DPAD_UP";
            trace("No GUP");
        }
        if(FlxG.save.data.gpdownBind == null){
            FlxG.save.data.gpdownBind = "DPAD_DOWN";
            trace("No GDOWN");
        }
        if(FlxG.save.data.gpmiddleBind == null){
            FlxG.save.data.gpmiddleBind = "A";
            trace("No GMIDDLE");
        }
        if(FlxG.save.data.gpdodgeBind == null){
            FlxG.save.data.gpdodgeBind = "A";
            trace("No GDODGE");
        }
        if(FlxG.save.data.gpleftBind == null){
            FlxG.save.data.gpleftBind = "DPAD_LEFT";
            trace("No GLEFT");
        }
        if(FlxG.save.data.gprightBind == null){
            FlxG.save.data.gprightBind = "DPAD_RIGHT";
            trace("No GRIGHT");
        }

        trace('${FlxG.save.data.leftBind}-${FlxG.save.data.downBind}-${FlxG.save.data.upBind}-${FlxG.save.data.rightBind}');
    }

}