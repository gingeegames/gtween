package com.gingee.gTween.animator.events;

import com.gingee.gTween.interfaces.IAdvanceable;
import openfl.events.Event;

class AnimatorEvent extends Event
{
	public var animation:IAdvanceable;
	
	public function new(type:String, anim:IAdvanceable)
	{
		super(type, bubbles, cancelable);
		this.animation = anim;
	}
	
	public static var ADDED_TO_ANIMATOR:String = "ADDED_TO_ANIMATOR";
	public static var REMOVED_FROM_ANIMATOR:String = "REMOVED_FROM_ANIMATOR";
}
