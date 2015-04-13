package com.gingee.gTween.ease;

class Bounce 
{
	public function new() {}
	public static function easeOut (t:Float, b:Float, c:Float, d:Float):Float 
	{
		if (hx.GUtil.boolean((t/=d) < (1/2.75))) 
		{
			return c*(7.5625*t*t) + b;
		} 
		else if (hx.GUtil.boolean(t < (2/2.75))) 
		{
			return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
		} 
		else if (hx.GUtil.boolean(t < (2.5/2.75))) 
		{
			return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
		} 
		else
		{
			return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
		}
	}

	public static function easeIn (t:Float, b:Float, c:Float, d:Float):Float 
	{
		return c - easeOut(d-t, 0, c, d) + b;
	}

	public static function easeInOut (t:Float, b:Float, c:Float, d:Float):Float 
	{
		if (hx.GUtil.boolean(t < d*0.5)) return easeIn (t*2, 0, c, d) * .5 + b;
		else return easeOut (t*2-d, 0, c, d) * .5 + c*.5 + b;
	}
}
