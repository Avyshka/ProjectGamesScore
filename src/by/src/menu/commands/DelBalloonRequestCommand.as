package by.src.menu.commands
{
	import by.src.balloons.Balloon;
	import by.src.events.Events;
	import by.src.events.EventsDispatcher;
	import by.src.menu.interfaces.ICommand;

	public class DelBalloonRequestCommand implements ICommand
	{
		private var _dispatcher: EventsDispatcher = EventsDispatcher.getInstance();
		private var _receiver: Balloon;

		public function DelBalloonRequestCommand(receiver: Balloon)
		{
			_receiver = receiver;
		}

		public function execute():void
		{
			_dispatcher.dispatchEventWith(Events.DEL_BALLOON_REQUEST, false, _receiver);
		}
	}
}