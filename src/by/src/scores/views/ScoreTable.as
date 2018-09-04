package by.src.scores.views
{
	import by.src.data.PlayerData;

	import starling.display.Sprite;

	public class ScoreTable extends Sprite
	{
		private var _vScoreTableRows: Vector.<ScoreTableRow>;

		public function ScoreTable()
		{
			_vScoreTableRows = new Vector.<ScoreTableRow>();
		}

		public function init(vPlayerData: Vector.<PlayerData>): void
		{
			clearRows();

			const countPlayers: int = vPlayerData.length;
			for (var indexPlayer: int = 0; indexPlayer < countPlayers; indexPlayer++)
			{
				createTableRow(vPlayerData[indexPlayer], indexPlayer);
			}
		}

		private function clearRows(): void
		{
			const countRows: int = _vScoreTableRows.length;
			for (var indexRow: int = 0; indexRow < countRows; indexRow++)
			{
				_vScoreTableRows[indexRow].free();
			}
			_vScoreTableRows = new Vector.<ScoreTableRow>();
		}

		private function createTableRow(playerData: PlayerData, indexPlayer: int): void
		{
			var tableRow: ScoreTableRow = new ScoreTableRow();
			tableRow.init(playerData);
			tableRow.y = indexPlayer * 50;
			addChild(tableRow);

			_vScoreTableRows.push(tableRow);
		}
	}
}
