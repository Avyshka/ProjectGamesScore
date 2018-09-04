package by.framework.textFields
{
	import by.framework.Builder;

	import starling.display.Sprite;
	import starling.text.TextField;

	public class TextShadow extends Sprite
	{
		private var _tfMain: TextField;
		private var _tfTL: TextField;
		private var _tfTR: TextField;
		private var _tfBL: TextField;
		private var _tfBR: TextField;
		
		public function TextShadow(w: int, h: int, size: int, posX:Number, posY: Number, colorTop: uint, colorShadow: uint = 0x000000, range: int = 1)
		{
			x = posX;
			y = posY;
			
			_tfTL = Builder.createTextField(w, h, "", size, colorShadow, -range, -range, this);
			_tfTR = Builder.createTextField(w, h, "", size, colorShadow,  range, -range, this);
			_tfBL = Builder.createTextField(w, h, "", size, colorShadow, -range,  range, this);
			_tfBR = Builder.createTextField(w, h, "", size, colorShadow,  range,  range, this);
			_tfMain = Builder.createTextField(w, h, "", size, colorTop, 0, 0, this);

			this.alignPivot();
		}
		
		public function set text(value: String): void
		{
			_tfTL.text = value;
			_tfTR.text = value;
			_tfBL.text = value;
			_tfBR.text = value;
			_tfMain.text = value;
		}
		
		public function get text(): String
		{
			return _tfMain.text;
		}
		
		public function set fontSize(size: int): void
		{
			_tfTL.fontSize = size;
			_tfTR.fontSize = size;
			_tfBL.fontSize = size;
			_tfBR.fontSize = size;
			_tfMain.fontSize = size;
		}
		
		public function alignText(hAlign: String, vAlign: String): void
		{
			_tfTL.hAlign = hAlign;
			_tfTL.vAlign = vAlign;
			
			_tfTR.hAlign = hAlign;
			_tfTR.vAlign = vAlign;
			
			_tfBL.hAlign = hAlign;
			_tfBL.vAlign = vAlign;
			
			_tfBR.hAlign = hAlign;
			_tfBR.vAlign = vAlign;
			
			_tfMain.hAlign = hAlign;
			_tfMain.vAlign = vAlign;
		}

		public function sliceDown(posY: int): void
		{
			_tfBL.y += posY;
			_tfBR.y += posY;
		}

		public function set color(color: uint): void
		{
			_tfMain.color = color;
		}
	}

}