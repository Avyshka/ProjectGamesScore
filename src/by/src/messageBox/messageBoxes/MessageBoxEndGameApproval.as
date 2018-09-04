package by.src.messageBox.messageBoxes
{
	import by.framework.Language;
	import by.src.menu.actions.EndGameAction;
	import by.src.menu.commands.ConcreteCommand;
	import by.src.messageBox.MessageBoxApproval;

	public class MessageBoxEndGameApproval extends MessageBoxApproval
	{
		public function MessageBoxEndGameApproval()
		{
			super();
			_title.height *= 2;
			_title.border = true;
			arrange();
		}
		override public function init():void
		{
			super.init();

			setTitleTextID(Language.END_GAME_APPROVAL);

			if (!_command)
			{
				_command = new ConcreteCommand(new EndGameAction());
			}
		}
	}
}
