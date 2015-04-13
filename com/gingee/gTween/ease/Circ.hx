package com.gingee.gTween.ease;

class Circ
{
	public function new() {}
	public static function easeIn (t:Float, b:Float, c:Float, d:Float):Float 
	{
		return -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b;
	}

	public static function easeOut (t:Float, b:Float, c:Float, d:Float):Float 
	{
		return c * Math.sqrt(1 - (t=t/d-1)*t) + b;
	}

	public static function easeInOut (t:Float, b:Float, c:Float, d:Float):Float 
	{
		if (hx.GUtil.boolean((t/=d*0.5) < 1)) return -c*0.5 * (Math.sqrt(1 - t*t) - 1) + b;
		return c*0.5 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;
	}
}