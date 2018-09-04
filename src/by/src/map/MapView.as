package by.src.map
{
	import by.framework.Builder;
	import by.src.App;
	import by.src.Main;
	import by.src.Universe;
	import by.src.balloons.Balloon;
	import by.src.constants.Map;
	import by.src.data.ChangeDepthOfBalloonData;
	import by.src.events.Events;
	import by.src.events.EventsDispatcher;

	import flash.geom.Point;

	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class MapView extends Sprite
	{
		private static var _instance: MapView;

		private var _dispatcher: EventsDispatcher = EventsDispatcher.getInstance();
		private var _layerWay: Sprite;
		private var _layerBalloons: Sprite;

		public function MapView()
		{
			if (_instance != null)
			{
				throw("Error: Class уже существует. Используйте ClassName.getInstance();");
			}
			_instance = this;

			_layerWay = new Sprite();
			addChild(_layerWay);

			_layerBalloons = new Sprite();
			addChild(_layerBalloons);

			const q: Quad = new Quad(Map.RANGE, 2);
			q.alignPivot();
			_layerWay.addChild(q);

			const q2: Quad = new Quad(Map.RANGE, 2, 0xff0000);
			q2.alignPivot(HAlign.CENTER, VAlign.BOTTOM);
			q2.y = -Map.HEIGHT_MIN;
			q2.height = Map.HEIGHT_MAX;
			q2.alpha = .01;
			_layerWay.addChild(q2);

			Builder.createImage("checkPoint", _layerWay).x = q.width / -2;
			Builder.createImage("checkPoint", _layerWay).x = q.width / 2;

			var pointPosition: Point = new Point(0, App.SCR_H - 25);
			Main.getCorrectPosition(pointPosition);

			x = App.SCR_W_HALF;
			y = pointPosition.y;
			Universe.getInstance().layerMain.addChild(this);

			_dispatcher.addEventListener(Events.ADD_BALLOON_ON_MAP, onAddBalloonOnMap);
			_dispatcher.addEventListener(Events.REMOVE_BALLOON_ON_MAP, onRemoveBalloonOnMap);
			_dispatcher.addEventListener(Events.CHANGE_DEPTH_OF_BALLOON, onChangeDepthOfBalloon);

			_layerWay.alpha = 0;
		}

		private function changeVisibilityMap():void
		{
			if (_layerBalloons.numChildren > 0)
			{
				if (_layerWay.alpha < 1) Builder.addTweenAlpha(_layerWay);
			}
			else
			{
				if (_layerWay.alpha > 0) Builder.addTweenAlpha(_layerWay, 0);
			}
		}

		private function onChangeDepthOfBalloon(event: Event): void
		{
			const changeDepthOfBalloonData: ChangeDepthOfBalloonData = event.data as ChangeDepthOfBalloonData;
			const oldIndex: int = _layerBalloons.getChildIndex(changeDepthOfBalloonData.balloon);
			_layerBalloons.swapChildrenAt(oldIndex, changeDepthOfBalloonData.depthIndex);
		}

		private function onAddBalloonOnMap(event: Event): void
		{
			const balloon: Balloon = event.data as Balloon;
			_layerBalloons.addChild(balloon);

			changeVisibilityMap();
		}

		private function onRemoveBalloonOnMap(event: Event): void
		{
			changeVisibilityMap();
		}

		public static function getInstance(): MapView
		{
			return (_instance == null) ? new MapView() : _instance;
		}

		public function get layerBalloons():Sprite
		{
			return _layerBalloons;
		}
	}
}
