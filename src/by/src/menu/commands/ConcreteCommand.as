package by.src.menu.commands
{
	import by.src.menu.actions.Action;
	import by.src.menu.interfaces.ICommand;

	public class ConcreteCommand implements ICommand
	{
		private var _action: Action;

		public function ConcreteCommand(action: Action)
		{
			_action = action;
		}

		public function execute():void
		{
			_action.run();
		}
	}
}
