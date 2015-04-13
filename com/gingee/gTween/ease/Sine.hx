package com.gingee.gTween.ease;

class Sine
{
	public function new() {}
	private static var HALF_PI:Float = Math.PI * 0.5;
	
	public static function easeIn (t:Float, b:Float, c:Float, d:Float):Float 
	{
		return -c * Math.cos(t/d * HALF_PI) + c + b;
	}

	public static function easeOut (t:Float, b:Float, c:Float, d:Float):Float 
	{
		return c * Math.sin(t/d * HALF_PI) + b;
	}

	public static function easeInOut (t:Float, b:Float, c:Float, d:Float):Float 
	{
		return -c*0.5 * (Math.cos(Math.PI*t/d) - 1) + b;
	}
}