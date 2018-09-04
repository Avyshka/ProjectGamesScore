package by.src.menu.commands
{
	import by.src.balloons.Balloon;
	import by.src.events.Events;
	import by.src.events.EventsDispatcher;
	import by.src.menu.interfaces.ICommand;

	public class AddPointsRequestCommand implements ICommand
	{
		private var _dispatcher: EventsDispatcher = EventsDispatcher.getInstance();
		private var _receiver: Balloon;

		public function AddPointsRequestCommand(receiver: Balloon)
		{
			_receiver = receiver;
		}

		public function execute():void
		{
			_dispatcher.dispatchEventWith(Events.ADD_POINTS_REQUEST, false, _receiver);
		}
	}
}
