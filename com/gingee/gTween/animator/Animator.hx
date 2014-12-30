package com.gingee.gTween.animator;

import com.gingee.gTween.animator.events.AnimatorEvent;
import com.gingee.gTween.interfaces.IAdvanceable;

import openfl.display.Stage;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import haxe.ds.ObjectMap;

class Animator
{
	private static var _eventHolder:Stage;
	private static var _stage:Stage;
	private static var myAnimations:ObjectMap<IAdvanceable, IAdvanceable> = new ObjectMap<IAdvanceable, IAdvanceable>();
	
	public static function init(stage:Stage):Void
	{
		_stage = stage;
	}

	public static function submitAnimation(animation:IAdvanceable):Void
	{
		myAnimations.set(animation, animation);
		ignite();
	}
	
	public static function removeAnimation(animation:IAdvanceable):Bool
	{
		if(myAnimations.get(animation) == null)
			return false;
		
		dispatchEvent(AnimatorEvent.REMOVED_FROM_ANIMATOR, animation);
		myAnimations.remove(animation);
		return true;
	}
	
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
		
		if(_stage == null)
			return;

		_eventHolder = _stage;
		_eventHolder.addEventListener(Event.ENTER_FRAME, advanceAll);
	}
	
	private static function advanceAll(e:Event):Void
	{
		for(key in myAnimations.keys())
		{
			if(key != null && !key.advance())
				removeAnimation(key);
		}
		
		if(countKeys() == 0)
		{
			_eventHolder.removeEventListener(Event.ENTER_FRAME, advanceAll);
			_eventHolder = null;
		}
	}
	
	public static function countKeys():Int 
	{
		var ii:Int = 0;
		for(key in myAnimations.keys())
			ii++;

		return ii;
		// return Reflect.fields(myAnimations).length;
	}
	
	public static function stats():Void
	{
		var ids:String = "";
		for(key in Reflect.fields(myAnimations))
		{
			if(Reflect.hasField(key, "ID"))
				ids += Reflect.field(key, "ID") + "\n";
		}
		
		trace("Number of active animations: " + countKeys() + ".\n Names of identifiable:\n" + ids);
	}
}