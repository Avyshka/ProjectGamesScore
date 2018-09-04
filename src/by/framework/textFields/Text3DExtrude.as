package by.framework.textFields
{
	import by.framework.Builder;

	import starling.display.Sprite;
	import starling.text.TextField;

	public class Text3DExtrude extends Sprite
	{
		private var _tfTop: TextField;
		private var _tfMid: TextField;
		private var _tfBot: TextField;
		
		public function Text3DExtrude(w: int, h: int, size: int, posX:Number, posY: Number, colorTop: uint, colorBot: uint = 0xFFFFFF, colorMid: uint = 0x000000)
		{
			x = posX;
			y = posY;
			
			_tfBot = Builder.createTextField(w, h, "", size, colorBot, 0, 2, this);
			_tfMid = Builder.createTextField(w, h, "", size, colorMid, 0, -2, this);
			_tfTop = Builder.createTextField(w, h, "", size, colorTop, 0, 0, this);
			
			_tfBot.alpha = _tfMid.alpha = .5;
			
			this.alignPivot();
		}
		
		public function set text(value: String): void
		{
			_tfBot.text = value;
			_tfMid.text = value;
			_tfTop.text = value;
		}

	}

}