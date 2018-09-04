package by.src
{
	import by.framework.Console;
	import by.framework.Language;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;

	import starling.core.Starling;
	import starling.events.ResizeEvent;

	[SWF(width="960", height="540", frameRate="40", backgroundColor="#000000")]
	public class Main extends Sprite
	{
		public static const APP_VERSION: String = "Games score 0.0.1 - June 17, 2018\n";

		public static const DEV: Boolean = true;
		public static const CONSOLE: Boolean = false;

		public static var starling: Starling;

		public static var aWidth: int;
		public static var aHeight: int;

		public static var widthFull: int;
		public static var heightFull: int;
		public static var scaleFactorMax: Number;

		private static var _viewPortFull: Rectangle;

		private var _viewPort: Rectangle;

		private static var _logoAiva: MovieClip;
		private static var _stage: Stage;

		private static var _deltaScaleFactor: Number;
		private static var _deltaScaleX: Number;
		private static var _deltaScaleY: Number;

		//--------------------------------------------------------
		public function Main():void
		{
			trace(APP_VERSION);

			if (stage)
			{
				_stage = stage;
				_logoAiva = new LogoAiva_mc();
				_logoAiva.x = stage.stageWidth / 2;
				_logoAiva.y = stage.stageHeight / 2;
				_stage.addChild(_logoAiva);

				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}//--------------------------------------------------------
		
		private function init(evt:Event = null):void
		{
			if (evt != null)
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}

			aWidth = stage.fullScreenWidth;
			aHeight = stage.fullScreenHeight;

			_viewPort = new Rectangle(0, 0, aWidth, aHeight);

			var stageSize: Point = new Point(App.SCR_W, App.SCR_H);
			var screenSize: Point = new Point(aWidth, aHeight);

			var scScreen: Number = screenSize.x / screenSize.y;
			var scStage: Number = stageSize.x / stageSize.y;
			_deltaScaleFactor = Math.abs(scScreen - scStage);
			_deltaScaleX = aWidth / App.SCR_W;
			_deltaScaleY = aHeight / App.SCR_H;

			starling = new Starling(App, stage, _viewPort);
			starling.start();

			stage.addEventListener(Event.ACTIVATE, fl_Activate);
			stage.addEventListener(Event.DEACTIVATE, fl_Deactivate);

			if (DEV)
			{
				starling.showStats = true;
				starling.showStatsAt("left", "bottom", 1);
				var console: Console = new Console(App.SCR_W);
				if (CONSOLE)
				{
					Starling.current.nativeOverlay.addChildAt(console, 0);
				}
				Console.log("", "_isDev == true   ->   don't foget cancel it\n");
			}
			setLanguage();
			fl_Activate(null);

			starling.stage.addEventListener(ResizeEvent.RESIZE, onResize);

			setFullSizeScreenApp();
		}

		private function setFullSizeScreenApp(): void
		{
			const scaleFactorWidth: Number = App.SCR_W / aWidth;
			const scaleFactorHeight: Number = App.SCR_H / aHeight;
			scaleFactorMax = Math.max(scaleFactorWidth, scaleFactorHeight);

			widthFull = aWidth * scaleFactorMax;
			heightFull = aHeight * scaleFactorMax;

			const xPos: Number = (App.SCR_W - widthFull) / 2;
			const yPos: Number = (App.SCR_H - heightFull) / 2;

			_viewPortFull = new Rectangle(xPos, yPos, widthFull, heightFull);
		}

		public function setLanguage():void
		{
			// определяем язык системы
			var lang: String = Capabilities.language;
			Console.log("Main", "Language = " + lang);
			// переключаем язык
			switch(lang)
			{
//				case "ru": Language.setRussian(); break;
				default:   Language.setEnglish(); break;
			}
		}

		private function onResize(e:ResizeEvent = null):void
		{
			var stageSize: Point = new Point(App.SCR_W, App.SCR_H);
			var screenSize: Point = new Point(aWidth, aHeight);

			var scX:Number = screenSize.x / stageSize.x;
			var scY:Number = screenSize.y / stageSize.y;

			var scaleMin:Number = Math.min(scX, scY);
			var scaleMax:Number = Math.max(scX, scY);

			if (_logoAiva)
			{
				_logoAiva.x = screenSize.x / 2;
				_logoAiva.y = screenSize.y / 2;
			}

			App.onResize(screenSize, scaleMin, scaleMax);
		}
		
		private function fl_Activate(event:Event):void
		{
			// Здесь запустите таймеры и добавьте прослушиватели событий.
			if (starling != null)
			{
				Starling.current.nativeOverlay.stage.frameRate = App.FPS;
				onResize(null);
			}
		}

		private function fl_Deactivate(event:Event):void
		{
			if (!DEV) {
				// Здесь остановите таймеры и удалите прослушиватели событий.
				if (starling != null)
				{
					Starling.current.nativeOverlay.stage.frameRate = 0;
				}
			}
		}

		public static function deleteLogo(): void
		{
			_stage.removeChild(_logoAiva);
			_logoAiva = null;
		}

		public static function getCorrectPosition(point: Point): void
		{
			const percentX: Number = point.x / App.SCR_W;
			const percentY: Number = point.y / App.SCR_H;

			point.x = (percentX < .5) ?
					point.x = point.x + _viewPortFull.x :
					point.x = _viewPortFull.width - (App.SCR_W - point.x) + _viewPortFull.x;

			point.y = (percentY < .5) ?
					point.y = point.y + _viewPortFull.y :
					point.y = _viewPortFull.height - (App.SCR_H - point.y) + _viewPortFull.y;
		}

		public static function get deltaScaleFactor(): Number { return _deltaScaleFactor; }
		public static function get deltaScaleX(): Number { return _deltaScaleX; }
		public static function get deltaScaleY(): Number { return _deltaScaleY; }
	}
}