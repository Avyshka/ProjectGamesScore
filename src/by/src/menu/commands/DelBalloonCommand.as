package by.src.menu.commands
{
	import by.src.data.DelBalloonData;
	import by.src.events.Events;
	import by.src.events.EventsDispatcher;
	import by.src.menu.interfaces.ICommand;

	public class DelBalloonCommand implements ICommand
	{
		private var _dispatcher: EventsDispatcher = EventsDispatcher.getInstance();
		private var _receiver: DelBalloonData;

		public function DelBalloonCommand(receiver: DelBalloonData)
		{
			_receiver = receiver;
		}

		public function execute():void
		{
			_dispatcher.dispatchEventWith(Events.DEL_BALLOON_COMPLETE, false, _receiver);
		}
	}
}
