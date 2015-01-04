package examples;

import openfl.display.Sprite;
import openfl.events.Event;
import com.gingee.gTween.animator.Animator;
import examples.particles.ParticleSystem;
import examples.GTweenTest;

class Main extends Sprite 
{
	public function new () 
	{
		super ();

		if(this.stage != null)
			onAdded(null);
		else
			this.addEventListener(Event.ADDED, onAdded);
	}

	public function onAdded(e:Event)
	{
		addElements();
	}

	private function addElements():Void
	{
		// addChild(new GTweenTest()); // SIMPLE MOVEMENT TEST
		addChild(new ParticleSystem(300, 300, 70)); // PARTICLE SYSTEM WITH WIDTH 300, HEIGHT 300 AND 70 PARTICLES

		// addChild(new openfl.display.FPS(10, 10, 0x0d2c55)); // ADD FPS 
	}
}