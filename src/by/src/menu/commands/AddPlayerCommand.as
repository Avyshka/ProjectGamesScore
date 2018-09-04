package by.src.menu.commands
{
	import by.src.data.PlayerData;
	import by.src.events.Events;
	import by.src.events.EventsDispatcher;
	import by.src.menu.interfaces.ICommand;

	import flash.text.StageText;

	public class AddPlayerCommand implements ICommand
	{
		private var _dispatcher: EventsDispatcher = EventsDispatcher.getInstance();
		private var _receiver: StageText;

		public function AddPlayerCommand(receiver: StageText)
		{
			_receiver = receiver;
		}

		public function execute():void
		{
			var data: PlayerData = new PlayerData();
			data.playerName = _receiver.text.toLocaleUpperCase();

			_dispatcher.dispatchEventWith(Events.ADD_NEW_PLAYER, false, data);
		}
	}
}
