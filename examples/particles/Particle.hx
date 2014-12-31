package examples.particles;

import com.gingee.gTween.GTween;
import com.gingee.gTween.ease.Cubic;
import com.gingee.gTween.ease.Linear;
import openfl.display.Sprite;

// an individual particle that handles its own movement
class Particle extends Sprite
{
	private var _xx:Float;
	private var _yy:Float;
	private var _time:Float;
	private var _rot:Float;
	private var _fl:Flake;
	private var _complete:Particle->Void;

	private static var INIT_Y:Int = 80;

	// supply function that will be invoked upon tween completion and return this particle as a parameter
	public function new(complete:Particle->Void)
	{
		super();
		_complete = complete;
		
		_fl = new Flake();
		addChild(_fl);
	}

	// restart movement cycle with new parameters: 
	// xx - final x position
	// yy - final y range
	// time - tween time in seconds (up and down)
	// delay - tween delay time in seconds (time before animation starts)
	public function reset(xx:Float = 200, yy:Float = 200, time:Float = .6, delay:Float = 0):Void
	{
		// set-up initial variables
		_rot = Math.random()*65; // rotation
		_xx = xx; // x position
		_yy = yy; // y position
		_time = time*.5; // animation time
		this.y = _yy; // init y position
		this.alpha = 0; // visible false
		this.x = 0; // x position
		
		_fl.rotation = -_rot;
		
		// tween particle up movement
		GTween.removeTweensOf(this);// clear any remaining tweens
		GTween.tweenTo(this, _time, {y:INIT_Y - INIT_Y*Math.random(), ease:Cubic.easeOut, onComplete:comp, delay:delay, onStart:start});
		GTween.tweenTo(this, _time, {x:_xx/2, ease:Linear.easeNone, delay:delay});
		
		// tween particle rotation
		GTween.removeTweensOf(_fl);// clear any remaining tweens
		GTween.tweenTo(_fl, delay + _time*2, {rotation:_rot});
	}

	// on up movement start
	private function start():Void
	{
		this.alpha = 1; // movement start - set visibility to full.
	}

	// on up movement complete
	private function comp():Void
	{
		// tween particle down movement
		GTween.removeTweensOf(this); // clear any remaining tweens
		GTween.tweenTo(this, _time, {y:_yy, alpha:0, ease:Cubic.easeIn});
		GTween.tweenTo(this, _time, {x:_xx, ease:Linear.easeNone, onComplete:_complete, onCompleteParams:[this]});
	}
}