package com.gingee.gTween.adapters.flTween ;
import openfl.events.Event;

/**
 * ...
 * @author Moshe Maman
 */
class TweenEvent extends Event
{
	public function new(type:String)
	{
		super(type);
	}
	
	private var _duration:Float = 0;
	public var position(get, set):Float;
	public function get_position():Float
	{
		return _duration;
	}
	
	public function set_position(f:Float):Float
	{
		_duration = f;
		return _duration;
	}
	
	public static var MOTION_START:String =  "tweenStart";
	public static var MOTION_FINISH:String =  "tweenEnd";
	public static var MOTION_CHANGE:String =  "tweenUpdate";
	
}