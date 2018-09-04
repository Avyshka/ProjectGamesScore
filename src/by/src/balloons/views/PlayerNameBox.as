package by.src.balloons.views
{
	import by.framework.textFields.Text3D;
	import by.src.constants.Colors;
	import by.src.utils.GetPlayerNameWithoutIDUtils;

	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;

	public class PlayerNameBox extends Sprite
	{
		private var _border: Quad;
		private var _background: Quad;
		private var _tfPlayerName: Text3D;
		private var _btnChangeName: Button;

		public function PlayerNameBox()
		{
			_border = new Quad(1, 1, Colors.COLOR_LIGHT);
			_background = new Quad(1, 1, Colors.COLOR_DARK);

			_border.alignPivot();
			_background.alignPivot();

			_tfPlayerName = new Text3D(10, 10, 24, 0, -2, 0xFFFFCC, 0xFF6600);
			_tfPlayerName.autoSize(true);
			_tfPlayerName.alignPivot();

			addChild(_border);
			addChild(_background);
			addChild(_tfPlayerName);
		}

		public function init(playerName: String): void
		{
			_tfPlayerName.text = GetPlayerNameWithoutIDUtils.cutPlayerName(playerName);

			_tfPlayerName.alignPivot();
			var width: Number = _tfPlayerName.width + 36;
			var height: Number = _tfPlayerName.height + 6;

			_border.width = width + 4;
			_border.height = height + 4;
			_background.width = width;
			_background.height = height;
		}
	}
}
