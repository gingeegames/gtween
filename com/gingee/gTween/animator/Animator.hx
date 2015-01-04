package com.gingee.gTween.animator;

import com.gingee.gTween.animator.events.AnimatorEvent;
import com.gingee.gTween.interfaces.IAdvanceable;

import openfl.display.Stage;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import haxe.ds.ObjectMap;

/*
* Animator is a IAdvanceable manager. it prevents the usage of multiple ENTER_FRAME event listeners and thus increases performances, order and stability.
*/
class Animator
{
	private static var _eventHolder:Stage;
	private static var myAnimations:ObjectMap<IAdvanceable, IAdvanceable> = new ObjectMap<IAdvanceable, IAdvanceable>();

	/**
	* Submit an IAdvanceable item to add to animation pool. 
	*/
	public static function submitAnimation(animation:IAdvanceable):Void
	{
		myAnimations.set(animation, animation);
		ignite();
	}
	
	/**
	* Remove an IAdvanceable item from animation pool. 
	*/
	public static function removeAnimation(animation:IAdvanceable):Bool
	{
		if(myAnimations.get(animation) == null)
			return false;
		
		dispatchEvent(AnimatorEvent.REMOVED_FROM_ANIMATOR, animation);
		myAnimations.remove(animation);
		return true;
	}
	
	/*
	* Returns amount of active IAdvanceable items.
	*/
	public static function countKeys():Int 
	{
		var ii:Int = 0;
		for(key in myAnimations.keys())
			ii++;

		return ii;
		// return Reflect.fields(myAnimations).length;
	}

	/*
	* Returns true if Animator has one or more active IAdvanceable items
	*/
	private static function animationsLeft():Bool
	{
		for(key in myAnimations.keys())
			return true;

		return false;
	}
	
	/*
	* Prints current status to trace.
	*/
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
	
	private static function advanceAll(e:Event):Void
	{
		for(key in myAnimations.keys())
		{
			if(key != null && !key.advance())
				removeAnimation(key);
		}
		
		if(!animationsLeft())
		{
			_eventHolder.removeEventListener(Event.ENTER_FRAME, advanceAll);
			_eventHolder = null;
		}
	}
}