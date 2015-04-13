package com.gingee.gTween.ease;

/**
 * ...
 * @author Moshe Maman
 */
class None
{

	public function new(){}
	public static function easeNone (t:Float, b:Float, c:Float, d:Float):Float 
	{
		return c*t/d + b;
	}
	
}