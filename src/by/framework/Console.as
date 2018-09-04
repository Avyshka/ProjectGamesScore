package by.framework
{
	import flash.text.TextField;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import flash.text.TextFieldAutoSize;

	public class Console extends Sprite
	{
		private static var _txtStatus: TextField;
		private static var _labels: Dictionary = new Dictionary();
		private static var _lastIndex:int = 0;
		
		public function Console(w: Number)
		{
			_txtStatus = new TextField();
			_txtStatus.defaultTextFormat = new TextFormat("Arial", 14, 0xFFFFFF);
			_txtStatus.width = w;
			_txtStatus.height = 480;
			_txtStatus.y = 0;
			_txtStatus.multiline = true;
			_txtStatus.wordWrap = true;
			_txtStatus.text = "\n\n\n";
			_txtStatus.background = true;
			_txtStatus.backgroundColor = 0x000000;
			_txtStatus.autoSize = TextFieldAutoSize.LEFT;
			_txtStatus.alpha = .66;
			addChild(_txtStatus);
			
			_labels["log"] = new TextFormat("Arial", 14, 0xFFFF99);
			_labels["console"] = new TextFormat("Arial", 14, 0xFFFF00);
			
			_lastIndex = _txtStatus.length;
			
			Console.log("console", "INIT\n");
		}
		
		public static function log(keyword:String, mess: String, color: uint = 0): void
		{
			if (!_txtStatus)
			{
				return;
			}

			if (keyword == "" || keyword == null)
			{
				keyword = "log";
				color = 0xFFFFCC;
			}
			keyword = keyword.toLocaleLowerCase();
			
			if (_labels[keyword] == null)
			{
				if (color == 0)
				{
					color = Math.random() * 0xFFFFFF;
				}
				_labels[keyword] = new TextFormat("Arial", 14, color);
			}
			
			_txtStatus.appendText("\n" + keyword + ": " + mess);
			
			var i: int = _txtStatus.text.indexOf(keyword, _lastIndex);
			var j: int = _txtStatus.text.indexOf(":", _lastIndex);
			_txtStatus.setTextFormat(_labels[keyword], i, j);
			_lastIndex = _txtStatus.length;
		}
	}

}