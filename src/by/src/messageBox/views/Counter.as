package by.src.messageBox.views
{
	import by.framework.Organizer;

	import flash.geom.Point;

	import starling.display.Sprite;

	public class Counter extends Sprite
	{
		private const COUNT_SCROLLERS: int = 3;

		private var _vNumberScrollers: Vector.<NumberScroller>;

		public function Counter()
		{
			_vNumberScrollers = new Vector.<NumberScroller>();

			var positions: Vector.<Point> = Organizer.line(COUNT_SCROLLERS, new Point(60, 0));

			for (var i: int = 0; i < COUNT_SCROLLERS; i++)
			{
				var numberScroller: NumberScroller = new NumberScroller();
				numberScroller.x = positions[i].x;
				numberScroller.y = positions[i].y;
				addChild(numberScroller);

				_vNumberScrollers.unshift(numberScroller);
			}
		}

		public function init(): void
		{
			for (var i: int = 0; i < COUNT_SCROLLERS; i++)
			{
				_vNumberScrollers[i].init();
			}
		}

		public function free(): void
		{
			for (var i: int = 0; i < COUNT_SCROLLERS; i++)
			{
				_vNumberScrollers[i].free();
			}
		}

		public function getValue(): int
		{
			var value: int = 0;

			for (var i: int = 0; i < COUNT_SCROLLERS; i++)
			{
				value += _vNumberScrollers[i].count * Math.pow(10, i);
			}
			return value;
		}
	}
}
