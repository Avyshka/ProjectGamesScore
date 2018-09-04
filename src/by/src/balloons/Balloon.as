package by.src.balloons
{
	import by.framework.AMath;
	import by.framework.Builder;
	import by.framework.ComponentPool;
	import by.framework.artist.Artist;
	import by.framework.particles.Particle;
	import by.framework.textFields.TextShadow;
	import by.src.App;
	import by.src.balloons.views.Alarm;
	import by.src.balloons.views.Ball;
	import by.src.balloons.views.Crown;
	import by.src.balloons.views.PlayerNameBox;
	import by.src.constants.Map;
	import by.src.menu.commands.AddPointsRequestCommand;
	import by.src.menu.commands.DelBalloonRequestCommand;

	import flash.geom.Point;

	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class Balloon extends Sprite
	{
//		private static var _dispatcher: EventsDispatcher = EventsDispatcher.getInstance();

		private var _ball: Ball;
		private var _shadow: Image;
		private var _tfCounter: TextShadow;
		private var _playerNameBox: PlayerNameBox;
		private var _alarm: Alarm;

		private var _btnAddPoints: Button;
		private var _btnDelete: Button;
		private var _commandAddPointsRequest: AddPointsRequestCommand;
		private var _commandDelBalloonRequest: DelBalloonRequestCommand;

		private var _shadowHeight: Number;

		public function Balloon()
		{
			_shadow = Builder.createImage("balloonShadow", this);
			_shadowHeight = _shadow.height;
			_shadow.height = 0;
			_shadow.alignPivot(HAlign.CENTER, VAlign.TOP);

			_ball = new Ball();
			addChild(_ball);

			_tfCounter = new TextShadow(_ball.width, _ball.height, 36, 0, _ball.height / -5 * 3, 0xFFFFFF);
			addChild(_tfCounter);

			_playerNameBox = new PlayerNameBox();
			addChild(_playerNameBox);

			_btnAddPoints = new Button(Texture.empty(_ball.width, _ball.height));
			_btnAddPoints.alignPivot(HAlign.CENTER, VAlign.BOTTOM);
			addChild(_btnAddPoints);

			_btnDelete = new Button(Artist.getTexture("btnDel"));
			_btnDelete.alignPivot(HAlign.CENTER, VAlign.BOTTOM);
			_btnDelete.y = _ball.y - _ball.height - 10;

			_commandAddPointsRequest = new AddPointsRequestCommand(this);
			_commandDelBalloonRequest = new DelBalloonRequestCommand(this);

			_alarm = new Alarm();
			_alarm.x = _ball.width / 2;
			_alarm.y = -_ball.height;
			addChild(_alarm);
		}

		public function init(playerName: String, colorMain: uint, colorMinor: uint): void
		{
			x = 0;
			y = 0;

			_tfCounter.text = "0";

			_ball.init(colorMain, colorMinor);
			_playerNameBox.init(playerName);
			_playerNameBox.alignPivot(HAlign.CENTER, VAlign.TOP);

			addListenerForAddPoints();
		}

		public function free(): void
		{
			hideBtnDel();
			removeFromParent();
			ComponentPool.dispose(this);
		}

		public function alarmInit(): void
		{
			_alarm.init();
		}

		public function alarmFree(): void
		{
			_alarm.free();
		}

		private function addListenerForAddPoints(): void
		{
			_btnAddPoints.addEventListener(Event.TRIGGERED, onClickButton);
		}

		private function removeListenerForAddPoints(): void
		{
			_btnAddPoints.removeEventListener(Event.TRIGGERED, onClickButton);
		}

		public function changeVisibilityDelButton(isVisible: Boolean): void
		{
			if (isVisible)
			{
				showBtnDel();
				removeListenerForAddPoints();
			}
			else
			{
				hideBtnDel();
				addListenerForAddPoints();
			}
		}

		private function showBtnDel(): void
		{
			addChild(_btnDelete);
			_btnDelete.addEventListener(Event.TRIGGERED, onDeleteBalloon);
		}

		private function hideBtnDel(): void
		{
			if (_btnDelete.hasEventListener(Event.TRIGGERED))
			{
				_btnDelete.removeEventListener(Event.TRIGGERED, onDeleteBalloon);
			}
			if(contains(_btnDelete))
			{
				removeChild(_btnDelete);
			}
		}

		private function onDeleteBalloon(event: Event): void
		{
			_commandDelBalloonRequest.execute();
		}

		private function onClickButton(event: Event): void
		{
			_commandAddPointsRequest.execute();
		}

		public function setWayPoint(wayPoint: Point): void
		{
			Builder.addTween(this, wayPoint.x, wayPoint.y, 0, 1, 1, 5);
			Builder.addTweenScaleY(this._shadow, Math.abs(wayPoint.y / _shadowHeight), 5);
		}

		public function addPoints(points: int): void
		{
			_tfCounter.text = points.toString();
		}

		public function addCrown(): void
		{
			const crown: Crown = Crown.getInstance();
			crown.y = 20;
			Crown.init(this);
			addChildAt(crown, 0);
		}
	}
}
