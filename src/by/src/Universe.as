package by.src
{
	import by.src.balloons.controllers.BalloonsController;
	import by.src.balloons.managers.ParticleManager;
	import by.src.data.PlayerData;
	import by.src.events.Events;
	import by.src.events.EventsDispatcher;
	import by.src.map.MapView;
	import by.src.menu.TopLeftMenu;
	import by.src.menu.TopRightMenu;
	import by.src.messageBox.managers.MessageBoxManager;
	import by.src.scores.Scores;

	import starling.display.Sprite;
	import starling.events.*;

	public class Universe extends Sprite
	{
		// ссылка на мир
		private static var _instance: Universe;
		
		private var _isGameover: Boolean;

		// главный игровой слой
		private var _layerMain: Sprite;
		// слой для элементов пользовательского интерфеса
		private var _layerUI: Sprite;

		private var _map: MapView;

		private var _dispatcher: EventsDispatcher = EventsDispatcher.getInstance();

		public function Universe()
		{
			super();
			
			if(_instance != null){
				throw("Error: Class уже существует. Используйте ClassName.getInstance();");
			}
			_instance = this;

			(stage == null) ? addEventListener(Event.ADDED_TO_STAGE, init) : init(null);			
		}
		
		private function init(evt:Event):void
		{
			if (evt != null)
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}

			_layerMain = new Sprite();
			addChild(_layerMain);
			
			_layerUI = new Sprite();
			addChild(_layerUI);

			_isGameover = true;

			const topLeftMenu: TopLeftMenu = new TopLeftMenu();
			topLeftMenu.init();
			_layerUI.addChild(topLeftMenu);

			const topRightMenu: TopRightMenu = new TopRightMenu();
			topRightMenu.init();
			_layerUI.addChild(topRightMenu);

			_map = MapView.getInstance();

			new MessageBoxManager();
			new BalloonsController();
			new ParticleManager();

			_dispatcher.addEventListener(Events.GAME_OVER, onEndGameHandler);
		}

		private function onEndGameHandler(event: Event): void
		{
			const vPlayerData: Vector.<PlayerData> = event.data as Vector.<PlayerData>;
			endGame(vPlayerData);
		}

		/**
		 * начало новой игры
		 */
		public function newGame():void
		{
			_isGameover = false;
		}
		
		/**
		 * конец игры
		 */
		public function endGame(vPlayerData: Vector.<PlayerData>):void
		{
			_isGameover = true;

			var s: Scores = new Scores();
			s.init(vPlayerData);
			addChild(s);
		}
		
		/**
		 * ссылка на класс
		 */
		public static function getInstance(): Universe
		{
			return (_instance == null) ? new Universe() : _instance;
		}
		
		public function get isGameover(): Boolean { return _isGameover; }
		public function set isGameover(value: Boolean): void { _isGameover = value; }
		
		public function get layerMain(): Sprite { return _layerMain; }
		public function get layerUI(): Sprite { return _layerUI; }
	}

}