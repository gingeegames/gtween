package com.gingee.gTween.ease;

class Elastic 
{
	public function new() {}
	private static var PI2:Float = Math.PI * 2;
	
	public static function easeIn (t:Float, b:Float, c:Float, d:Float, a:Float = 0, p:Float = 0):Float 
	{
		var s:Float = 0;
		if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!hx.GUtil.boolean(p)) p=d*.3;
		if (!a || (c > 0 && a < c) || (c < 0 && a < -c)) { a=c; s = p/4; }
		else s = p/PI2 * Math.asin (c/a);
		return -(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*PI2/p )) + b;
	}

	public static function easeOut (t:Float, b:Float, c:Float, d:Float, a:Float = 0, p:Float = 0):Float 
	{
		var s:Float = 0;
		if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!hx.GUtil.boolean(p)) p=d*.3;
		if (!a || (c > 0 && a < c) || (c < 0 && a < -c)) { a=c; s = p/4; }
		else s = p/PI2 * Math.asin (c/a);
		return (a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*PI2/p ) + c + b);
	}

	public static function easeInOut (t:Float, b:Float, c:Float, d:Float, a:Float = 0, p:Float = 0):Float 
	{
		var s:Float = 0;
		if (t==0) return b;  if ((t/=d*0.5)==2) return b+c;  if (!hx.GUtil.boolean(p)) p=d*(.3*1.5);
		if (!a || (c > 0 && a < c) || (c < 0 && a < -c)) { a=c; s = p/4; }
		else s = p/PI2 * Math.asin (c/a);
		if (hx.GUtil.boolean(t < 1)) return -.5*(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*PI2/p )) + b;
		return a*Math.pow(2,-10*(t-=1)) * Math.sin( (t*d-s)*PI2/p )*.5 + c + b;
	}
}