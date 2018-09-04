package by.src.messageBox.messageBoxes
{
	import by.framework.Language;
	import by.framework.textFields.Text3D;
	import by.src.data.DelBalloonData;
	import by.src.menu.commands.DelBalloonCommand;
	import by.src.messageBox.MessageBoxApproval;
	import by.src.utils.GetPlayerNameWithoutIDUtils;

	public class MessageBoxDelBalloonApproval extends MessageBoxApproval
	{
		private var _tfPlayerName: Text3D;
		private var _delBalloonData: DelBalloonData;

		public function MessageBoxDelBalloonApproval()
		{
			super();

			_title.y = -50;

			_tfPlayerName = new Text3D(300, 30, 30, 0, -10, 0xFFFF00, 0xFF6600);
			_content.addChild(_tfPlayerName);

			_delBalloonData = new DelBalloonData();

			arrange();
		}

		override public function init():void
		{
			super.init();

			_delBalloonData.playerName = _playerData.playerName;

			_title.text = Language.getText(Language.DEL_APPROVAL);
			_tfPlayerName.text = GetPlayerNameWithoutIDUtils.cutPlayerName(_delBalloonData.playerName);

			if (!_command)
			{
				_command = new DelBalloonCommand(_delBalloonData);
			}
		}
	}
}
