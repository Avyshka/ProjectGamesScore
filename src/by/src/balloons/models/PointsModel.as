package by.src.balloons.models
{
	public class PointsModel
	{
		private var _step: uint;

		public function PointsModel()
		{
			reset();
		}

		private function reset(): void
		{
			_step = 0;
		}

		public function get step(): uint
		{
			return _step;
		}

		public function set step(value: uint): void
		{
			if (value > _step)
			{
				_step = value;
			}
		}
	}
}
