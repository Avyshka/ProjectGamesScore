package by.src.balloons.managers
{
	import by.src.balloons.models.FlightModel;
	import by.src.constants.Map;
	import by.src.data.PlayerData;
	import by.src.data.WayPointData;
	import by.src.events.Events;
	import by.src.events.EventsDispatcher;

	import flash.geom.Point;

	import starling.events.Event;

	public class FlightManager
	{
		private var _dispatcher: EventsDispatcher = EventsDispatcher.getInstance();

		private var _vPlayerData: Vector.<PlayerData>;
		private var _flightModel: FlightModel;

		private var _rangeBetweenBalloons: Number;

		public function FlightManager(vPlayerData: Vector.<PlayerData>)
		{
			_vPlayerData = vPlayerData;
			_flightModel = FlightModel.getInstance();

			_dispatcher.addEventListener(Events.ADD_BALLOON_ON_MAP, onAddBalloonOnMap);
			_dispatcher.addEventListener(Events.CHANGE_POSITION_BALLOONS, onChangePositionBalloons);
			_dispatcher.addEventListener(Events.CHANGE_GAME_TO_MIN_OR_MAX, onChangeGameToMinToMax);
		}

		private function onChangeGameToMinToMax(event: Event): void
		{
			_flightModel.isGameMax = event.data;
			startMovingBalloons();
		}

		private function onAddBalloonOnMap(event: Event): void
		{
			startMovingBalloons();
		}

		private function onChangePositionBalloons(event: Event): void
		{
			startMovingBalloons();
		}

		private function startMovingBalloons():void
		{
			calcRangeBetweenBalloons();
			prepareMoveBalloons();
		}

		private function calcRangeBetweenBalloons(): void
		{
			var countBalloons: int = _vPlayerData.length - 1;
			if (countBalloons == 0)
			{
				countBalloons = 1;
			}
			_rangeBetweenBalloons = Map.HEIGHT_MAX / countBalloons ;
		}

		private function prepareMoveBalloons(): void
		{
			_flightModel.parseData(_vPlayerData);

			const wayPointData: WayPointData = new WayPointData();
			const countBalloons: int = _vPlayerData.length;
			var percent: Number;
			var checkPointX: Number;
			var checkPointY: Number;

			for (var indexBalloon: int = 0; indexBalloon < countBalloons; indexBalloon++)
			{
				percent = (_vPlayerData[indexBalloon].pointsCurrent - _flightModel.minScore) / _flightModel.rangeScores;
				checkPointX = Map.RANGE * percent - Map.RANGE_HALF;

				checkPointY = -(_flightModel.getIndexHeight(indexBalloon) * _rangeBetweenBalloons + Map.HEIGHT_MIN);

				wayPointData.playerName = _vPlayerData[indexBalloon].playerName;
				wayPointData.wayPoint = new Point(checkPointX, checkPointY);
				wayPointData.indexOfDepth = countBalloons - _flightModel.getIndexHeight(indexBalloon) - 1;

				_dispatcher.dispatchEventWith(Events.SET_WAY_POINT, false, wayPointData);
			}
		}
	}
}
