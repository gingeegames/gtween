package examples;

import com.gingee.gTween.GTween;
import com.gingee.gTween.ease.Bounce;
import openfl.display.Sprite;

class GTweenTest extends Sprite
{
	public function new()
	{
		super();
		var s:Sprite = new Sprite();
		s.graphics.beginFill(0xff0000, 1);
		s.graphics.drawCircle(100, 100, 100);
		s.graphics.endFill();

		addChild(s);
		GTween.tweenTo(s, .5, {x:500, loop:GTween.OSCILLATE, ease:Bounce.easeIn, onStart:onStart, onComplete:onComplete, delay:.1, onCompleteParams:[1, 15], numLoops:3});
	}

	private function onComplete(i, j):Void
	{
		trace("complete", j, i);
	}

	private function onStart():Void
	{
		trace("starting");
	}
}