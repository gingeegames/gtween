package com.gingee.gTween.ease;

class Back
{
	public static function easeIn (t:Float, b:Float, c:Float, d:Float, s:Float = 1.70158):Float 
	{
		return c*(t/=d)*t*((s+1)*t - s) + b;
	}

	public static function easeOut (t:Float, b:Float, c:Float, d:Float, s:Float = 1.70158):Float 
	{
		return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
	}

	public static function easeInOut (t:Float, b:Float, c:Float, d:Float, s:Float = 1.70158):Float 
	{
		if ((t/=d*0.5) < 1) return c*0.5*(t*t*(((s*=(1.525))+1)*t - s)) + b;
		return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
	}
}

