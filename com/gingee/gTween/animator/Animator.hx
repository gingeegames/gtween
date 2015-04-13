package com.gingee.gTween.animator;

import com.gingee.gTween.animator.events.AnimatorEvent;
import com.gingee.gTween.interfaces.IAdvanceable;
import com.gingee.utils.TimerUtils;
import openfl.display.Stage;
import openfl.events.Event;
import openfl.events.EventDispatcher;


/*
* Animator is a IAdvanceable manager. it prevents the usage of multiple ENTER_FRAME event listeners and thus increases performances, order and stability.
*/
class Animator
{	
	public function new() {}
	private static var _eventHolder:Stage = null;
	//private static var myAnimations:GObjectMap = new GObjectMap();
	private static var myAnimations:Array<IAdvanceable> = [];

	/**
	* Submit an IAdvanceable item to add to animation pool. 
	*/
	public static function submitAnimation(animation:IAdvanceable):Void
	{
		if (animation == null) return;
		if(myAnimations.indexOf(animation)==-1) myAnimations.push(animation);
		ignite();
	}
	
	/**
	* Remove an IAdvanceable item from animation pool. 
	*/
	public static function removeAnimation(animation:IAdvanceable):Bool
	{
		if (animation == null) return false;
		var index:Int = myAnimations.indexOf(animation);
		if (index == -1) return false;
		
		myAnimations.splice(index, 1);
		dispatchEvent(AnimatorEvent.REMOVED_FROM_ANIMATOR, animation);
		return true;
	}
	
	/*
	* Returns amount of active IAdvanceable items.
	*/
	public static function countKeys():Int 
	{
		return myAnimations.length;
	}

	/*
	* Returns true if Animator has one or more active IAdvanceable items
	*/
	private static function animationsLeft():Bool
	{
		return myAnimations.length > 0;
	}
	
	/*
	* Prints current status to trace.
	*/
	//public static function stats():Void
	//{
		//var ids:String = "";
		//for(key in Reflect.fields(myAnimations))
		//{
			//if(hx.GUtil.boolean(Reflect.hasField(key, "ID")))
				//ids += Reflect.field(key, "ID") + "\n";
		//}
		//
		//trace("Number of active animations: " + countKeys() + ".\n Names of identifiable:\n" + ids);
	//}

	// ............................. PRIVATE ............................................

	private static function dispatchEvent(e:String, animation:IAdvanceable):Void
	{
		if(!Std.is(animation, EventDispatcher))
			return;

		var dispatcher:EventDispatcher = cast animation;
		if(dispatcher != null)
		{
			if(dispatcher.hasEventListener(e))
				dispatcher.dispatchEvent(new AnimatorEvent(e, animation));
		}
	}
	
	private static function ignite():Void
	{
		if(_eventHolder != null)
			return;
		
			
		_eventHolder = openfl.Lib.current.stage;
		_eventHolder.addEventListener(Event.ENTER_FRAME, advanceAll);
	}
	
	private static var _fps:Float = Math.NaN;
	private static var devider:Float = Math.NaN;
	private static var use_devider:Bool = false;
	private static var counter:Int = 0;
	
	public static var fps(null, set):Float;
	private static function set_fps(v:Float):Float
	{
		_fps = v;
		TimerUtils.setTimeOut(recalculate, 50);
		return v;
	}
	
	private static function recalculate():Void
	{
		devider = Math.round(RealFPS.FPS() / _fps);
		if ( devider > 1)
			use_devider = true;
			
		TimerUtils.setTimeOut(recalculate, 5000);
	}
	
	private static function advanceAll(e:Event):Void
	{
		if (use_devider)
		{
			counter++;
			if (counter >= devider)
				counter = 0;
			else
				return;
		}
		
		for(key in myAnimations)
		{
			if(key != null  && !cast(key, IAdvanceable).advance())
				removeAnimation(key);
		}
		
		if(!animationsLeft())
		{
			_eventHolder.removeEventListener(Event.ENTER_FRAME, advanceAll);
			_eventHolder = null;
		}
	}
}