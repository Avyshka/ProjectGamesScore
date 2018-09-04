package by.src.balloons.views
{
	import by.framework.Builder;

	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Sprite;

	public class Alarm extends Sprite implements IAnimatable
	{
		private static const SPEED_BLINK: int = 4;

		private var _timer: Number;

		public function Alarm()
		{
			Builder.createImage("warningIcon", this);
			Builder.createTextField(20, 20, "!", 20, 0xFF6600, 0, 0, this);

			alpha = 0;

			touchable = touchGroup = false;
		}

		public function init(): void
		{
			_timer = 0;
			Starling.juggler.add(this);
		}

		public function free(): void
		{
			alpha = 0;
			Starling.juggler.remove(this);
		}

		public function advanceTime(time: Number): void
		{
			_timer += SPEED_BLINK * time;

			alpha = Math.sin(_timer);

			if (_timer > 100)
			{
				_timer %= 100;
			}
		}
	}
}
