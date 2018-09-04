package by.src.balloons.controllers
{
	import by.framework.ComponentPool;
	import by.src.balloons.Balloon;
	import by.src.balloons.managers.FlightManager;
	import by.src.balloons.models.FlightModel;
	import by.src.balloons.models.PointsModel;
	import by.src.balloons.views.Crown;
	import by.src.data.ChangeDepthOfBalloonData;
	import by.src.data.DelBalloonData;
	import by.src.data.ParticleData;
	import by.src.data.PlayerData;
	import by.src.data.PointsAddedData;
	import by.src.data.WayPointData;
	import by.src.events.Events;
	import by.src.events.EventsDispatcher;
	import by.src.menu.actions.ShowMessageBoxAddPointsAction;
	import by.src.menu.actions.ShowMessageBoxDelBalloonAction;
	import by.src.menu.commands.ConcreteCommand;
	import by.src.utils.ColorUtils;

	import starling.events.Event;

	public class BalloonsController
	{
		private var _dispatcher: EventsDispatcher = EventsDispatcher.getInstance();

		private var _vBalloons: Vector.<Balloon>;
		private var _vPlayerData: Vector.<PlayerData>;
		private var _countPlayer: int;

		private var _pointsModel: PointsModel;
		private var _flightModel: FlightModel;

		public function BalloonsController()
		{
			_vBalloons = new Vector.<Balloon>();
			_vPlayerData = new Vector.<PlayerData>();

			_pointsModel = new PointsModel();
			_flightModel = FlightModel.getInstance();

			_dispatcher.addEventListener(Events.ADD_NEW_PLAYER, onAddNewPlayer);
			_dispatcher.addEventListener(Events.SET_WAY_POINT, onSetWayPoint);
			_dispatcher.addEventListener(Events.ADD_POINTS_REQUEST, onAddPointsRequest);
			_dispatcher.addEventListener(Events.DEL_BALLOON_REQUEST, onDelBalloonRequest);
			_dispatcher.addEventListener(Events.CHANGE_VISIBILITY_DEL_BUTTON_BALLONS, onChangeVisibilityDelButtons);
			_dispatcher.addEventListener(Events.GAME_TO_MIN_OR_MAX_CHANGED, onGameModeChanged);

			new FlightManager(_vPlayerData);
		}

		private function onChangeVisibilityDelButtons(event: Event): void
		{
			const isVisible: Boolean = event.data as Boolean;

			for (var i: int = 0; i < _countPlayer; i++)
			{
				const balloon: Balloon = _vBalloons[i];
				balloon.changeVisibilityDelButton(isVisible);
			}
		}

		private function onAddPointsRequest(event: Event): void
		{
			const balloon: Balloon = event.data as Balloon;
			const indexBalloon: int = _vBalloons.indexOf(balloon);
			const playerData: PlayerData = _vPlayerData[indexBalloon];

			new ConcreteCommand(new ShowMessageBoxAddPointsAction(playerData)).execute();

			_dispatcher.removeEventListener(Events.ADD_POINTS_COMPLETE, onAddPointsComplete);
			_dispatcher.addEventListener(Events.ADD_POINTS_COMPLETE, onAddPointsComplete);
		}

		private function onDelBalloonRequest(event: Event): void
		{
			const balloon: Balloon = event.data as Balloon;
			const indexBalloon: int = _vBalloons.indexOf(balloon);
			const playerData: PlayerData = _vPlayerData[indexBalloon];

			new ConcreteCommand(new ShowMessageBoxDelBalloonAction(playerData)).execute();

			_dispatcher.removeEventListener(Events.DEL_BALLOON_COMPLETE, onDelBalloonComplete);
			_dispatcher.addEventListener(Events.DEL_BALLOON_COMPLETE, onDelBalloonComplete);
		}

		private function onAddPointsComplete(event: Event): void
		{
			const pointsAddedData: PointsAddedData = event.data as PointsAddedData;

			for (var i: int = 0; i < _countPlayer; i++)
			{
				const playerData: PlayerData = _vPlayerData[i];

				if (playerData.playerName == pointsAddedData.playerName)
				{
					playerData.addPoints(pointsAddedData.points);
					_vBalloons[i].addPoints(playerData.pointsCurrent);

					_pointsModel.step = playerData.pointSteps;
				}
			}
			_dispatcher.removeEventListener(Events.ADD_POINTS_COMPLETE, onAddPointsComplete);
			_dispatcher.dispatchEventWith(Events.CHANGE_POSITION_BALLOONS);

			addAlarmBalloonsWithCheck();
			transferCrown();
		}

		private function onGameModeChanged(event: Event): void
		{
			transferCrown();
		}

		private function transferCrown(): void
		{
			var vChampions: Vector.<Balloon> = new Vector.<Balloon>();
			const max: Number = (_flightModel.isGameMax) ? _flightModel.maxScore : _flightModel.minScore;

			for (var i: int = 0; i < _countPlayer; i++)
			{
				if (_vPlayerData[i].pointsCurrent === max)
				{
					vChampions.push(_vBalloons[i]);
				}
			}

			if (vChampions.length === 1)
			{
				vChampions[0].addCrown();
			} else {
				Crown.free();
			}
		}

		private function addAlarmBalloonsWithCheck(): void
		{
			for (var i: int = 0; i < _countPlayer; i++)
			{
				const playerData: PlayerData = _vPlayerData[i];
				const balloon: Balloon = _vBalloons[i];

				if (playerData.pointSteps < _pointsModel.step)
				{
					balloon.alarmInit();
				}
				else
				{
					balloon.alarmFree();
				}
			}
		}

		private function onDelBalloonComplete(event: Event): void
		{
			const delBalloonData: DelBalloonData = event.data as DelBalloonData;

			for (var i: int = 0; i < _countPlayer; i++)
			{
				const playerData: PlayerData = _vPlayerData[i];

				if (playerData.playerName == delBalloonData.playerName)
				{
					const balloon: Balloon = _vBalloons[i];

					const particleData: ParticleData = new ParticleData();
					particleData.posX = balloon.x;
					particleData.posY = balloon.y;
					particleData.vColors.push(playerData.colorMain);
					particleData.vColors.push(playerData.colorMinor);

					balloon.free();
					_vPlayerData.splice(i, 1);
					_vBalloons.splice(i, 1);
					_countPlayer = _vPlayerData.length;

					_dispatcher.dispatchEventWith(Events.ADD_PARTICLES, false, particleData);

					break;
				}
			}
			_dispatcher.removeEventListener(Events.DEL_BALLOON_COMPLETE, onDelBalloonComplete);
			_dispatcher.dispatchEventWith(Events.CHANGE_POSITION_BALLOONS);
			_dispatcher.dispatchEventWith(Events.REMOVE_BALLOON_ON_MAP);
		}

		private function onAddNewPlayer(event: Event): void
		{
			const playerData: PlayerData = event.data as PlayerData;

			playerData.playerName = PlayerData.id + "_" + playerData.playerName;
			playerData.pointsCurrent = 0;
			playerData.colorMain = ColorUtils.getRandomColor();
			playerData.colorMinor = ColorUtils.getRandomColor();

			_vPlayerData.push(playerData);
			_countPlayer = _vPlayerData.length;

			createBalloon(playerData);
			addAlarmBalloonsWithCheck();
		}

		private function createBalloon(playerData: PlayerData): void
		{
			const balloon: Balloon = ComponentPool.get(Balloon);
			balloon.init(playerData.playerName, playerData.colorMain, playerData.colorMinor);

			_vBalloons.push(balloon);

			_dispatcher.dispatchEventWith(Events.ADD_BALLOON_ON_MAP, false, balloon);
		}

		private function onSetWayPoint(event: Event): void
		{
			const wayPointData: WayPointData = event.data as WayPointData;
			const playerName: String = wayPointData.playerName;

			for (var indexData: int = 0; indexData < _countPlayer; indexData++)
			{
				if (_vPlayerData[indexData].playerName === playerName)
				{
					break;
				}
			}

			const balloon: Balloon = _vBalloons[indexData];
			balloon.setWayPoint(wayPointData.wayPoint);

			const changeDepthOfBalloonData: ChangeDepthOfBalloonData = new ChangeDepthOfBalloonData();
			changeDepthOfBalloonData.balloon = balloon;
			changeDepthOfBalloonData.depthIndex = wayPointData.indexOfDepth;

			_dispatcher.dispatchEventWith(Events.CHANGE_DEPTH_OF_BALLOON, false, changeDepthOfBalloonData);
		}
	}
}
