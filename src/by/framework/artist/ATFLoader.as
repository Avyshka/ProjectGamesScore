package by.framework.artist
{
	import by.framework.AMath;
	import by.framework.Progress;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.ImageDecodingPolicy;
	import flash.system.LoaderContext;
	import flash.system.System;
	import flash.utils.ByteArray;

	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class ATFLoader extends EventDispatcher
	{
		private static const LOADING_ATF: uint = 0;
		private static const LOADING_XML: uint = 1;

		private var _loader: URLLoader;
		private var _loaderContext: LoaderContext = new LoaderContext();
		private var _address: String;
		private var _assetName: String;

		private var _texture: Texture;
		private var _xml: XML;
		private var _atlas: TextureAtlas;

		private var _loadEvent: LoadEvent;
		private var _bytes: ByteArray;

		private var _progress: Progress;
		private var _state: int;
		private var _percent: Number;
		private var _percentTotal: Number;

		public function ATFLoader(address: String)
		{
			_address = address + "/";

			_progress = new Progress(2);

			_loader = new URLLoader();
			_loader.dataFormat = URLLoaderDataFormat.BINARY;

			_loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			_loaderContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;

			_loadEvent = new LoadEvent(LoadEvent.LOADING_COMPLETE);
		}

		public function load(assetName: String): void
		{
			_assetName = assetName;

			_state = LOADING_ATF;
			_progress.getTotalProgress(_state, 0);

			_loader.addEventListener(Event.COMPLETE, onLoadTextureComplete, false, 0, true);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError, false, 0, true);
			_loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			trace(_address + _assetName + ".atf");
			_loader.load(new URLRequest(_address + _assetName + ".atf"));
		}
	
		private function onLoadTextureComplete(evt: Event): void
		{
			try
			{
				_bytes = _loader.data as ByteArray;
				_texture = Texture.fromAtfData(_bytes);

				_state = LOADING_XML;

				_loader.removeEventListener(Event.COMPLETE, onLoadTextureComplete);
				_loader.addEventListener(Event.COMPLETE, onLoadXMLComplete);

				_loader.load(new URLRequest(_address + _assetName + ".xml"));
			}
			catch(err:Error)
			{
				trace("ERROR: Failed to parse the downloaded data as Texture: " + _assetName + "\n"+err.message);
			}
		}

		private function onLoadXMLComplete(evt: Event): void
		{
			try
			{
				_loader.removeEventListener(Event.COMPLETE, onLoadXMLComplete);
				_loader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
				_loader.removeEventListener(ProgressEvent.PROGRESS, onProgress);

				_xml = new XML(evt.target.data);
				_atlas = new TextureAtlas(_texture, _xml);
				_loadEvent.atlas = _atlas;
				dispatchEvent(_loadEvent);

				_texture = null;
				System.disposeXML(_xml);
			}
			catch(err:Error)
			{
				trace("ERROR: Failed to parse the downloaded data as XML: " + _assetName + "\n"+err.message);
			}
		}
		
		public function onProgress(evt:ProgressEvent): void
        {
			_percent = AMath.toPercent(evt.bytesLoaded, evt.bytesTotal) * 100;
			_percentTotal = _progress.getTotalProgress(_state, _percent);
        } 
		
		private function onIOError(evt:IOErrorEvent): void
		{
			trace("Ошибка при попытке загрузки XML-документа.\n"+evt.text);
			dispatchEvent(new Event("folderIsEmpty"));
		}

		public function get loader(): URLLoader { return _loader; }
		public function get percent(): Number { return _percentTotal; }
	}
}