package by.src.menu.commands
{
	import by.src.menu.interfaces.ICommand;
	import by.src.menu.interfaces.IMacroCommand;

	public class ConcreteMacroCommand implements IMacroCommand
	{
		private var _commandsList: Vector.<ICommand>;
		private var _countCommands: int;

		public function ConcreteMacroCommand()
		{
			_commandsList = new Vector.<ICommand>();
			_countCommands = 0;
		}

		public function add(command:ICommand):void
		{
			_commandsList.push(command);
			_countCommands = _commandsList.length;
		}

		public function remove(command:ICommand):void
		{
			var indexCommand: int = _commandsList.indexOf(command);
			if (indexCommand >= 0)
			{
				_commandsList.splice(indexCommand, 1);
				_countCommands = _commandsList.length;
			}
		}

		public function execute():void
		{
			for (var indexCommand: int = 0; indexCommand < _commandsList; indexCommand++)
			{
				_commandsList[indexCommand].execute();
			}
		}
	}
}
