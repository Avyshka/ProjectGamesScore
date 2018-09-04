package by.src.messageBox
{
	import by.framework.ComponentPool;
	import by.src.App;
	import by.src.Universe;
	import by.src.constants.Colors;
	import by.src.data.PlayerData;

	import starling.display.Quad;
	import starling.display.Sprite;

	public class MessageBoxBase extends Sprite
	{
		protected static const DOUBLE_MARGIN: int = 40;
		protected static const DOUBLE_BORDER_THICK: int = 4;

		protected var _gap: int = 0;

		protected static var _universe: Universe = Universe.getInstance();

		protected var _border: Quad;
		protected var _background: Quad;

		protected var _content: Sprite;
		protected var _playerData: PlayerData;

		public function MessageBoxBase()
		{
			_border = new Quad(100, 100, Colors.COLOR_LIGHT);
			_border.alignPivot();
			addChild(_border);

			_background = new Quad(100, 100, Colors.COLOR_NORMAL);
			_background.alignPivot();
			addChild(_background);

			_content = new Sprite();
			addChild(_content);
		}

		protected function arrange(): void
		{
			var width: Number = _content.width;
			var height: Number = _content.height;

			_border.width = width + DOUBLE_MARGIN + DOUBLE_BORDER_THICK;
			_border.height = height + DOUBLE_MARGIN + DOUBLE_BORDER_THICK + _gap;

			_background.width = width + DOUBLE_MARGIN;
			_background.height = height + DOUBLE_MARGIN + _gap;
		}

		public function addData(playerData: PlayerData): void
		{
			_playerData = playerData;
		}

		public function init(): void
		{
			x = App.SCR_W_HALF;
			y = App.SCR_H_HALF;
			_universe.layerUI.addChild(this);
		}

		public function free(): void
		{
			_playerData = null;
			removeFromParent();
			ComponentPool.dispose(this);
		}
	}
}
