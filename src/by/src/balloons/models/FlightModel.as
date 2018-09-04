package by.src.balloons.models
{
	import by.framework.AMath;
	import by.src.data.PlayerData;
	import by.src.menu.actions.ChangeGameToMaxMinAction;

	public class FlightModel
	{
		private var _minScore: Number;
		private var _maxScore: Number;
		private var _rangeScores: Number;
		private var _arrOrderIndicesScores: Array;
		private var _isGameMax: Boolean;

		private var _changeGameToMaxMinAction: ChangeGameToMaxMinAction;

		private static var _instance: FlightModel;

		public function FlightModel()
		{
			if (_instance != null)
			{
				throw("Error: FlightModel уже существует. Используйте FlightModel.getInstance();");
			}
			_instance = this;

			_changeGameToMaxMinAction = new ChangeGameToMaxMinAction();
		}

		public static function getInstance(): FlightModel
		{
			return (_instance == null) ? new FlightModel() : _instance;
		}

		public function parseData(vPlayerData: Vector.<PlayerData>): void
		{
			const arrScores: Array = [];
			const countScores: int = vPlayerData.length;

			for (var indexData: int = 0; indexData < countScores; indexData++)
			{
				arrScores.push(vPlayerData[indexData].pointsCurrent);
			}

			if (_isGameMax)
			{
				_arrOrderIndicesScores = arrScores.sort(Array.NUMERIC | Array.RETURNINDEXEDARRAY);
			}
			else
			{
				_arrOrderIndicesScores = arrScores.sort(Array.NUMERIC | Array.DESCENDING | Array.RETURNINDEXEDARRAY);
			}
			_minScore = AMath.min(arrScores);
			_maxScore = AMath.max(arrScores);
			_rangeScores = _maxScore - _minScore;

			if (_rangeScores == 0)
			{
				_rangeScores = 1;
			}
		}

		public function getIndexHeight(indexBalloon: int): int
		{
			return _arrOrderIndicesScores.indexOf(indexBalloon);
		}

		public function get rangeScores(): Number { return _rangeScores; }
		public function get minScore(): Number { return _minScore; }
		public function get maxScore(): Number { return _maxScore; }

		public function set isGameMax(value: Boolean): void {
			_isGameMax = value;
			_changeGameToMaxMinAction.run();
		}
		public function get isGameMax(): Boolean {return  _isGameMax; }
	}
}
