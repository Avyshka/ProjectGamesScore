package by.src.gui
{
	import by.framework.Builder;
	import by.framework.artist.Artist;
	import by.src.constants.Colors;
	import by.src.gui.strategies.interfaces.IChangeColorStrategy;

	import starling.display.Button;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class Toggle extends Button
	{
		private var _imgON: Texture;
		private var _imgOFF: Texture;

		private var _isSwitched: Boolean = false;

		private var _tf: TextField;
		private var _textOn: String;
		private var _textOff: String;

		private var _strategy: IChangeColorStrategy;

		public function Toggle(imgOn: String, imgOff: String)
		{
			_imgON = Artist.getTexture(imgOn);
			_imgOFF = Artist.getTexture(imgOff);

			super(_imgON);

			alignPivot();
		}

		public function setTextValues(textOn: String, textOff: String): void
		{
			_textOn = textOn;
			_textOff = textOff;

			const posX: Number = width / 2;
			const posY: Number = height / 2;

			_tf = Builder.createTextField(width, height, "", 20, Colors.COLOR_VERY_LIGHT, 0, 0, overlay);
			_tf.alignPivot();
			_tf.x = posX;
			_tf.y = posY;
			_tf.touchable = _tf.touchGroup = false;
		}

		public function addStrategy(strategy: IChangeColorStrategy): void
		{
			_strategy = strategy;
		}

		public function init(isSwitch: Boolean): void
		{
			_isSwitched = isSwitch;
			commitData();
		}

		public function onSwitch(): void
		{
			_isSwitched = !_isSwitched;
			commitData();
		}

		protected function commitData(): void
		{
			upState = _isSwitched ? _imgON : _imgOFF;
			if (_tf)
			{
				_tf.text = _isSwitched ? _textOn : _textOff;
			}
			if (_strategy)
			{
				_strategy.changeColor(this, _isSwitched);
			}
		}

		public function get isSwitched():Boolean { return _isSwitched; }
	}
}
