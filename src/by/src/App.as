package by.src
{
	import by.framework.Builder;
	import by.framework.Progress;
	import by.framework.artist.Artist;
	import by.framework.textFields.TextShadow;

	import flash.geom.Point;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class App extends Sprite
	{
		//---------------------------------------
		// PUBLIC VARIABLES
		//---------------------------------------

		[Embed(source="../../../data/fonts/FontAivaMono.fnt", mimeType="application/octet-stream")]
		public static const FontXmlAiva: Class;
		 
		[Embed(source="../../../data/fonts/FontAivaMono.png")]
		public static const FontTextureAiva: Class;

		//размер документа по ширине/высоте
		public static const SCR_W: int = 960;
		public static const SCR_H: int = 540;
		
		//середина документа по ширине/высоте
		public static const SCR_W_HALF:int = SCR_W / 2;
		public static const SCR_H_HALF:int = SCR_H / 2;
		
		public static const LOAD_ASSETS:int = 0;

		// количество кадров в секунду
		public static const FPS: int = 40;

		public static const artist: Artist = new Artist();

		//---------------------------------------
		// PRIVATE VARIABLES
		//---------------------------------------
		private static var _instance:App;

		private static var _wrapper:Sprite = new Sprite();
		private static var _background: Image;

		private var _universe: Universe;

		private static var _tf: TextShadow;

		private static var _state: int;
		private static var _percent: int = 0;
		private static var _progress: Progress;

		private static var _screenSize: Point;
		private static var _scaleMin: Number;
		private static var _scaleMax: Number;

		private static var _initialize: Boolean;

		// Initialization:
		public function App()
		{
			super();
			
			if(_instance != null){
				throw("Error: Мир уже существует. Используйте App.getInstance();");
			}
			_instance = this;
			
			(stage == null) ? addEventListener(Event.ADDED_TO_STAGE, init) : init(null);
		}

		private function init(evt:Event = null):void
		{
			if (evt != null)
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}

			var texture: Texture = Texture.fromEmbeddedAsset(FontTextureAiva);
			var xml: XML = XML(new FontXmlAiva());
			TextField.registerBitmapFont(new BitmapFont(texture, xml));

			_state = LOAD_ASSETS;
			_progress = new Progress(1);

			Artist.setCallbackPreloader(createPreloader);
			Artist.setCallbackComplete(onComplete);

			artist.startInitLoading();
		}

		private function createPreloader(): void
		{
			Main.deleteLogo();

			_background = Builder.createImage("background", this);

			_wrapper.pivotX = App.SCR_W / 2;
			_wrapper.pivotY = App.SCR_H / 2;
			addChild(_wrapper);

			_tf = new TextShadow(SCR_W, 150, 90, App.SCR_W_HALF, App.SCR_H_HALF, 0xFFFFFF);
			_wrapper.addChild(_tf);

			onResize(_screenSize, _scaleMin, _scaleMax);

			Artist.setCallbackProgress(onProgress);
		}
		
		/**
		 * отображение процесса кэширования клипов
		 */
		public static function onProgress(percent:Number):void
		{
			_percent = percent;
			if (_percent > 100)
			{
				_percent = 100;
			}
			_tf.text = int(_progress.getTotalProgress(_state, _percent)) + "%";
		}

		private function onComplete():void
		{
			free();

			_universe = Universe.getInstance();
			_wrapper.addChild(_universe);

			artist.clearAssetsPreloader();
		}

		private function free():void
		{
			_progress = null;

			_tf.removeFromParent(true);
			_tf = null;
		}

		public static function onResize(screenSize:Point, scaleMin:Number, scaleMax:Number):void
		{
			_screenSize = screenSize;
			_scaleMin = scaleMin;
			_scaleMax = scaleMax;

			if (!_instance)
			{
				return;
			}

			if (_initialize)
			{
				return;
			}

			var centerX:Number = _screenSize.x * .5;
			var centerY:Number = _screenSize.y * .5;

			_wrapper.scaleX = _wrapper.scaleY = scaleMin;

			_wrapper.x = centerX;
			_wrapper.y = centerY;

			_background.scaleX = _background.scaleY = scaleMax;
			_background.x = centerX;
			_background.y = centerY;

			_initialize = true;
		}

		// ссылка на мир
		public static function getInstance():App
		{
			return (_instance == null) ? new App() : _instance;
		}

		public static function get background(): Image { return _background; }
		public static function get wrapper(): Sprite { return _wrapper; }
	}
}