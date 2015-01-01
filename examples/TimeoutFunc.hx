package examples;

import com.gingee.gTween.GTween;

class TimeoutFunc
{
	/*
	* this examples shows how to use timeoutInvoke to invoke a function after a certain delay
	* In this example the "complete" funtion is invoked with 2 parameters passed : 15 and "username". It is invoked after 3 seconds.
	*/
	public function new()
	{
		// *** UNCOMMENT IF ANIMATOR HAS NOT BEEN INITIATED:
		// Animator.init(this.stage);
		GTween.timeoutInvoke(complete, 3, [13, "username"]);
	}

	private function complete(i, name):Void
	{
		trace("Complete callback!", i, name);
	}
}