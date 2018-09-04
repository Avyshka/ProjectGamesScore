package by.src.scores.views
{
	import by.framework.Builder;
	import by.framework.ComponentPool;
	import by.framework.textFields.Text3D;
	import by.src.data.PlayerData;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class ScoreTableRow extends Sprite
	{
		private static const FONT_SIZE: int = 30;

		private static var counter: int = 0;

		private var _tfCount: TextField;
		private var _tfPoints: TextField;
		private var _colorBox: Image;
		private var _tfPlayerName: Text3D;

		public function ScoreTableRow()
		{
			_tfCount = Builder.createTextField(50, ScoreTableRow.FONT_SIZE + 10, "", ScoreTableRow.FONT_SIZE, 0xFFFFFF, 0, 0, this);
			_tfCount.alignPivot(HAlign.RIGHT);
			_tfCount.hAlign = HAlign.RIGHT;

			_colorBox = Builder.createImage("particle0", this);
			_colorBox.color = 0xFF66FF;
			_colorBox.x = 20;

			_tfPlayerName = new Text3D(200, ScoreTableRow.FONT_SIZE + 10, ScoreTableRow.FONT_SIZE, 40, 0, 0xFFFF99, 0xFF6600);
			_tfPlayerName.alignPivot(HAlign.LEFT);
			_tfPlayerName.alignText(HAlign.LEFT, VAlign.CENTER);
			addChild(_tfPlayerName);

			_tfPoints = Builder.createTextField(100, ScoreTableRow.FONT_SIZE + 10, "", ScoreTableRow.FONT_SIZE, 0xFFFFFF, 0, 0, this);
			_tfPoints.alignPivot(HAlign.LEFT);
			_tfPoints.hAlign = HAlign.RIGHT;
			_tfPoints.x = _tfPlayerName.x + _tfPlayerName.width + 10;
		}

		public function init(playerData: PlayerData): void
		{
			ScoreTableRow.counter++;

			_tfCount.text = ScoreTableRow.counter.toString();
			_tfPlayerName.text = playerData.playerName.substr(playerData.playerName.indexOf("_") + 1);
			_colorBox.color = playerData.colorMain;
			_tfPoints.text = playerData.pointsCurrent.toString();
		}

		public function free(): void
		{
			removeFromParent(true);
			ScoreTableRow.counter = 0;
		}
	}
}
