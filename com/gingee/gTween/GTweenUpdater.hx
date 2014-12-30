package com.gingee.gTween;

import com.gingee.gTween.interfaces.IAdvanceable;

class GTweenUpdater implements IAdvanceable
{
	public function new(){}

	public function advance():Bool
	{
		GTween.updateTweens(null);
		return !GTween.noTweensLeft();
	}
}