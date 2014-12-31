package examples.particles;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.Assets;

class Flake extends Sprite
{
	//private static var flakes:Array<String> = ["img/flake.png"];

	public function new()
	{
		super();
		//var n:String = flakes[0];
		//addChild(new Bitmap(Assets.getBitmapData(n)));
		this.graphics.beginFill(0xbeeb2d, 1);
		this.graphics.drawCircle(10, 10, 10);
		this.graphics.endFill();
	}
}