package examples.particles;

import openfl.display.Sprite;
import examples.particles.Particle;

// a particle-system that handles its particles movement
class ParticleSystem extends Sprite
{
	private static var xRange:Float = 300; // x movement max range
	private static var yRange:Float = 250; // y movement max height

	private static var tMinRange:Float = 2; // min movement time
	private static var tMaxRange:Float = 3; // max movement time
	private static var dRange = tMinRange; // movement start delay range (0 until this value)

	public function new(w:Float = 400, h:Float = 300, pool:Int = 40):Void
	{
		super();

		var pr:Particle = new Particle(resetParticle);
		
		// use first particle to position this particle system in center
		this.x = w/2 - pr.width/2;
		xRange = w/2;
		yRange = h - pr.height;

		for(j in 0...pool)
		{
			if(j != 0) pr = new Particle(resetParticle);
			resetParticle(pr);
			addChild(pr);
		}
	}

	private static function resetParticle(p:Particle):Void
	{
		var xx = xRange * (1-Math.random()*2);
		var t = (tMaxRange - tMinRange) * Math.random() + tMinRange;
		var delay = Math.random()*dRange;

		p.reset( xx, yRange, t, delay);
	}
}