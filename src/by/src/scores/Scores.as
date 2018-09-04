package by.src.scores
{
	import by.src.data.PlayerData;
	import by.src.scores.views.ScoreTable;

	import starling.display.Sprite;

	public class Scores extends Sprite
	{
		private var _scoreTable: ScoreTable;

		public function Scores()
		{
			_scoreTable = new ScoreTable();
			_scoreTable.x = 40;
			_scoreTable.y = 150;
			addChild(_scoreTable);
		}

		public function init(vPlayerData: Vector.<PlayerData>): void
		{
			_scoreTable.init(vPlayerData);
		}
	}
}
