package by.framework.artist
{
	import by.framework.Console;
	import by.framework.Progress;

	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;

	import starling.events.EventDispatcher;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Artist extends EventDispatcher
	{
		// интервал между загрузками атласов
		private static const INTERVAL_FOR_INIT_LOADING: uint = 200;
		private static const INTERVAL_FOR_LAZY_LOADING: uint = 7000;

		// метод отображения предзагручика
		private static var _callbackPreloader: Function;
		
		// метод запуска игры после загрузки всех ресурсов приложения
		private static var _callbackComplete: Function;
		
		// метод отображения загрузки всех ресурсов приложения
		private static var _callbackProgress: Function;
		
		// вектор всех атласов
		private static var _atlases: Vector.<TextureAtlas>;
		
		private static var _currentIntervalForLoading: uint;

		private static var _totalAtlasesForLoading: int;
		private static var _percent: int;
		
		private static var _index: int;
		private static var _indexPreloader: int;
		private static var _countAtlases: int;

		private static var _isLazyLoaded: Boolean = false;

		private static var _atfLoader: ATFLoader = new ATFLoader("img");

		private static var _arrCurrentAssets: Array;
		private static var _arrInitialAssets: Array = [
			"backgrounds",
			"ui",
			"gameobjects"
		];

		private static var _arrLazyAssets: Array = [
			"*"
		];

		private static var _progress: Progress = new Progress(_arrInitialAssets.length);

		public static function setCallbackPreloader(callbackPreloader: Function): void
		{
			_callbackPreloader = callbackPreloader;
		}
		
		public static function setCallbackComplete(callbackComplete: Function): void
		{
			_callbackComplete = callbackComplete;
		}
		
		public static function setCallbackProgress(callbackProgress: Function): void
		{
			_callbackProgress = callbackProgress;
		}
		
		public function startInitLoading(): void
		{
			_atlases = new Vector.<TextureAtlas>();

			_currentIntervalForLoading = INTERVAL_FOR_INIT_LOADING;

			_arrCurrentAssets = _arrInitialAssets;
			_totalAtlasesForLoading = _arrCurrentAssets.length;

			_percent = 0;
			_index = 0;
			_progress.getTotalProgress(_index, _percent);

			_indexPreloader = _arrInitialAssets.indexOf("preloader");

			_atfLoader.addEventListener(LoadEvent.LOADING_COMPLETE, onLoadComplete);
			_atfLoader.loader.addEventListener(ProgressEvent.PROGRESS, onUpdateProgress);

			_atfLoader.load(_arrCurrentAssets[_index]);
		}

		public function startLazyLoading(): void
		{
			_currentIntervalForLoading = INTERVAL_FOR_LAZY_LOADING;

			_arrCurrentAssets = _arrLazyAssets;
			_totalAtlasesForLoading = _arrCurrentAssets.length;

			_index = 0;

			_atfLoader.addEventListener(LoadEvent.LOADING_COMPLETE, onLoadComplete);

			_atfLoader.load(_arrCurrentAssets[_index]);
		}

		private function onLoadComplete(event: LoadEvent): void
		{
			_atlases.push(event.atlas);
			_countAtlases = _atlases.length;
			trace(_countAtlases)

			// showing progress
			onUpdateProgress();

			// creating preloader
			if (_index == _indexPreloader || _indexPreloader == -1)
			{
				createPreloader();
			}

			_index++;

			if (_index < _totalAtlasesForLoading)
			{
				setTimeout(loadNextAsset, _currentIntervalForLoading);
			}
			else
			{
				loadingComplete();
			}
		}

		private function loadingComplete():void
		{
			_atfLoader.removeEventListener(LoadEvent.LOADING_COMPLETE, onLoadComplete);

			if (_callbackComplete != null)
			{
				_countAtlases = _atlases.length;
				_callbackComplete();

				_atfLoader.loader.removeEventListener(ProgressEvent.PROGRESS, onUpdateProgress);

				if (!_isLazyLoaded)
				{
//					_callbackProgress = null;
					_callbackComplete = null;
//					startLazyLoading();
				}
			}
			else
			{
				if (!_isLazyLoaded)
				{
					_countAtlases = _atlases.length;
					_isLazyLoaded = true;

					_index = 0;
					_arrCurrentAssets = [];
					_arrInitialAssets = null;
					_arrLazyAssets = null;
				}
				trace("WARNING: method onComplete not settled");
				Console.log("WARNING", "method onComplete not settled");
			}
		}

		private function loadNextAsset():void
		{
			_atfLoader.load(_arrCurrentAssets[_index]);
		}

		private function createPreloader():void
		{
			if (_callbackPreloader != null)
			{
				_countAtlases = _atlases.length;
				_callbackPreloader();
				_callbackPreloader = null;
			}
		}

		private function onUpdateProgress(evt: Event = null):void
		{
			if (_callbackProgress != null)
			{
				_percent = _progress.getTotalProgress(_index, _atfLoader.percent);
				_callbackProgress(_percent);
			}
		}

		public static function getTexture(nameTexture: String): Texture
		{
			var t1: Number = getTimer();
			for (var i: int = 0; i < _countAtlases; i++)
			{
				if (_atlases[i].getTexture(nameTexture) != null)
				{
//					if((getTimer() - t1) > 20) trace("getTexture: " + (getTimer() - t1) + " ms");
					return _atlases[i].getTexture(nameTexture);
				}
			}
			trace("ERROR: Текстура "+nameTexture+" не найдена");
			Console.log("ERROR", "Текстура " + nameTexture + " не найдена");
			return null;
		}
		
		public static function getTextures(nameTextures: String): Vector.<Texture>
		{
			var t1: Number = getTimer();
			for (var i: int = 0; i < _countAtlases; i++)
			{
				if (_atlases[i].getTextures(nameTextures).length > 0)
				{
//					if((getTimer() - t1) > 20) trace("getTexture: " + (getTimer() - t1) + " ms");
//					Console.log("GET", "Текстуры " + nameTextures + " получены");
					return _atlases[i].getTextures(nameTextures);
				}
			}
			trace("ERROR: Textures "+nameTextures+" not found");
			Console.log("ERROR", "Текстуры " + nameTextures + " не найдены");
			return null;
		}
		
		public function clearAssetsPreloader(): void
		{
			if (_indexPreloader >= 0)
			{
				var atlas:TextureAtlas = _atlases[_indexPreloader];
				atlas.dispose();

				_atlases.splice(_indexPreloader, 1);
				_countAtlases = _atlases.length;
			}
		}

		public static function get isLazyLoaded(): Boolean { return _isLazyLoaded; }
	}
}

