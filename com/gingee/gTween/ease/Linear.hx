package com.gingee.gTween.ease;

class Linear
{
	public function new() {}
	public static var power:Int = 0;
	
	public static function easeNone (t:Float, b:Float, c:Float, d:Float):Float 
	{
		return c*t/d + b;
	}

	public static function easeIn (t:Float, b:Float, c:Float, d:Float):Float
	{
		return c*t/d + b;
	}

	public static function easeOut (t:Float, b:Float, c:Float, d:Float):Float 
	{
		return c*t/d + b;
	}

	public static function easeInOut (t:Float, b:Float, c:Float, d:Float):Float 
	{
		return c*t/d + b;
	}
}