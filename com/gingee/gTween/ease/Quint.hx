package com.gingee.gTween.ease;
	
class Quint
{
	public function new() {}
	public static var power:Int = 4;
	
	public static function easeIn (t:Float, b:Float, c:Float, d:Float):Float 
	{
		return c*(t/=d)*t*t*t*t + b;
	}

	public static function easeOut (t:Float, b:Float, c:Float, d:Float):Float 
	{
		return c*((t=t/d-1)*t*t*t*t + 1) + b;
	}

	public static function easeInOut (t:Float, b:Float, c:Float, d:Float):Float 
	{
		if (hx.GUtil.boolean((t/=d*0.5) < 1)) return c*0.5*t*t*t*t*t + b;
		return c*0.5*((t-=2)*t*t*t*t + 2) + b;
	}
}