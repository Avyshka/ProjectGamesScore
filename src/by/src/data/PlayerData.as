package by.src.data
{
	public class PlayerData
	{
		private static var _id: int;
		public var playerName: String;
		public var pointsCurrent: uint;
		public var pointsHistory: Vector.<uint>;
		public var pointSteps: uint;
		public var colorMain: uint;
		public var colorMinor: uint;

		public function PlayerData()
		{
			pointsHistory = new Vector.<uint>();
			pointSteps = 0;
			pointsCurrent = 0;

			PlayerData._id++;
		}

		public function addPoints(points: uint): void
		{
			pointsHistory.push(points);
			pointSteps = pointsHistory.length;
			pointsCurrent = countTotalPoints(pointsHistory);
		}

		private function countTotalPoints(args: Vector.<uint>): uint
		{
			var points: uint = 0;

			for (var i: int = 0; i < pointSteps; i++)
			{
				points += args[i];
			}
			return points;
		}

		public static function get id(): int { return PlayerData._id; }
	}
}
