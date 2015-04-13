package com.gingee.gTween.animator;

import haxe.Timer;
import openfl.events.Event;
import openfl.Lib;

/**
 * ...
 * @author Moshe Maman
 */
class RealFPS
{
	private static var cacheCount:Int;
	private static var init:Bool = false;
	private static var currentFPS:Int;
	private static var times:Array <Float> = [];
	
	public function new() {}
	
	public static function initialize():Void
	{
		if (init) return;
		init = true;
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	public static function FPS():Int
	{
		initialize();
		return currentFPS;
	}
	
	private static function onEnterFrame(e:Event):Void 
	{		
		var currentTime = Timer.stamp();
		times.push (currentTime);
		
		while (times[0] < currentTime - 1)
			times.shift ();
		
		var currentCount = times.length;
		currentFPS = Math.round ((currentCount + cacheCount) / 2);		
		cacheCount = currentCount;
	}
}