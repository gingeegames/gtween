package com.gingee.gTween.adapters.flTween ;
import openfl.events.EventDispatcher;

import com.gingee.gTween.GTween;
class Tween extends EventDispatcher
{
	private var _tween:GTween = null;
	
	private var _obj:Dynamic = null;
	private var _parameter:String = "";
	private var _ease:Float->Float->Float->Float->Float;
	private var _start:Float = 0;
	private var _end:Float = 0;
	private var _time:Float = 0;
	private var _useSeconds:Bool = false;
	private var _onComplete:Bool = false;
	private var _onStart:Bool = false;
	private var _onUpdates:Bool = false;
	
	public function new(o:Dynamic, parameter:String, ease:Float->Float->Float->Float->Float, start:Float, end:Float, time:Float, useSeconds:Bool = true)
	{
		super();
		_useSeconds = useSeconds;
		_end = end;
		_start = start;
		_ease = ease;
		_parameter = parameter;
		_obj = o;	
		_time = time;
	}
	
	public function continueTo(strt:Float, tme:Float):Void
	{
		stop();
		_time = tme;
		_start = strt;
		start();
	}
	
	public function fforward():Void
	{
		_tween.completeAllMovements();
		destroy();
	}
	
	override public function addEventListener(name:String, func:Dynamic->Void, useCaptare:Bool = false, priority:Int = 0, useWeakReference:Bool = false):Void
	{
		super.addEventListener(name, func, useCaptare, priority, useWeakReference);
		if(name == TweenEvent.MOTION_START)
			_onStart = true;
		else if(name == TweenEvent.MOTION_FINISH)
			_onComplete = true;
		else if(name == TweenEvent.MOTION_CHANGE)
			_onUpdates = true;
		else
			throw 'Cant resolve tween event: "' + name + '"';
	}
	
	public function start():Void
	{
		var vars:Dynamic = {};
		Reflect.setField(vars, _parameter, _end);
		Reflect.setField(_obj, _parameter, _start);
		if(_onComplete) Reflect.setField(vars, "onComplete", onComplete);
		if(_onStart) Reflect.setField(vars, "onStart", onStart);
		if(_onUpdates) Reflect.setField(vars, "onUpdate", onUpdate);
		
		var time:Float = _time * (_useSeconds ? 1 : .001);
		_tween = GTween.tweenTo(_obj, time, vars);
	}
	
	private function onUpdate():Void
	{
		if (_onUpdates)
		{
			var e:TweenEvent = new TweenEvent(TweenEvent.MOTION_CHANGE);
			e.position = _tween.duration;
			dispatchEvent(e);
		}
	}
	
	private function onStart():Void
	{
		if (_onStart)
		{
			var e:TweenEvent = new TweenEvent(TweenEvent.MOTION_START);
			e.position = _tween.duration;
			dispatchEvent(e);
		}
	}
	
	private function onComplete():Void
	{
		if (_onComplete)
		{
			var e:TweenEvent = new TweenEvent(TweenEvent.MOTION_FINISH);
			e.position = _tween.duration;
			dispatchEvent(e);
		}
	}
		
	public function stop():Void
	{
		if (_tween == null) return;
		_tween.pause();
		_tween.destroy();
		destroy();
	}
	
	private function destroy():Void
	{
		_ease = null;
		_onUpdates = null;
		_onStart = null;
		_onComplete = null;
		_obj = null;
		_tween = null;
	}
	
	public var isPlaying(get, null):Bool;
	public function get_isPlaying():Bool
	{
		return !_tween.paused;
	}
	
	public var time(get, null):Float;
	public function get_time():Float
	{
		return _tween.precent * _tween.duration;
	}
	
	public var duration(get, null):Float;
	public function get_duration():Float
	{
		return _tween.duration;
	}
}