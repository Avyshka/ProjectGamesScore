package by.framework.textFields
{
	import by.framework.Builder;

	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;

	public class Text3D extends Sprite
	{
		private var _tfTop: TextField;
		private var _tfMid: TextField;
		private var _tfBot: TextField;
		private var _tfShadow: TextShadow;

		private var _fontWidth: int;
		private var _fontHeight: int;
		private var _fontHeightFull: int;
		private var _fontSize: int;
		private var _extrude: int;

		public function Text3D(w: int, h: int, size: int, posX:Number, posY: Number, colorTop: uint, colorBot: uint, colorMid: uint = 0x000000, extrude: int = 3, extrude2: int = 1)
		{
			x = posX;
			y = posY;

			_fontWidth = w;
			_fontHeight = h;
			_fontHeightFull = _fontHeight + 3;
			_fontSize = size;
			_extrude = extrude;

			_tfBot = Builder.createTextField(_fontWidth, _fontHeight, "", _fontSize, colorBot, 0, _extrude, this);
			_tfMid = Builder.createTextField(_fontWidth, _fontHeight, "", _fontSize, colorMid, 0, extrude2, this);
			_tfTop = Builder.createTextField(_fontWidth, _fontHeight, "", _fontSize, colorTop, 0, 0, this);
			
			this.alignPivot();
		}
		
		public function set text(value: String): void
		{
			_tfBot.text = value;
			_tfMid.text = value;
			_tfTop.text = value;

			if (_tfShadow)
			{
				_tfShadow.text = value;
			}
		}

		public function addContur(color: uint, weight: int = 1): void
		{
			_tfShadow = new TextShadow(_fontWidth, _fontHeight, _fontSize, 0, 0, color, color, weight);
			_tfShadow.sliceDown(_extrude);
			addChildAt(_tfShadow, 0);
		}

		public function alignText(hAlign: String, vAlign: String): void
		{
			_tfBot.hAlign = hAlign;
			_tfBot.vAlign = vAlign;

			_tfMid.hAlign = hAlign;
			_tfMid.vAlign = vAlign;

			_tfTop.hAlign = hAlign;
			_tfTop.vAlign = vAlign;

			if (_tfShadow)
			{
				_tfShadow.alignText(hAlign, vAlign);
			}
		}

		public function autoSize(value: Boolean): void
		{
			if (value)
			{
				_tfBot.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
				_tfMid.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
				_tfTop.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			}
			else
			{
				_tfBot.autoSize = TextFieldAutoSize.NONE;
				_tfMid.autoSize = TextFieldAutoSize.NONE;
				_tfTop.autoSize = TextFieldAutoSize.NONE;
			}
		}

		public function set border(value: Boolean): void { _tfTop.border = value; }

		public function get text(): String { return _tfTop.text; }
		public function set color(color: uint): void { _tfTop.color = color; }
	}

}