package by.src.menu.commands
{
	import by.src.data.PointsAddedData;
	import by.src.events.Events;
	import by.src.events.EventsDispatcher;
	import by.src.menu.interfaces.ICommand;

	public class AddPointsCommand implements ICommand
	{
		private var _dispatcher: EventsDispatcher = EventsDispatcher.getInstance();
		private var _receiver: PointsAddedData;

		public function AddPointsCommand(receiver: PointsAddedData)
		{
			_receiver = receiver;
		}

		public function execute():void
		{
			_dispatcher.dispatchEventWith(Events.ADD_POINTS_COMPLETE, false, _receiver);
		}
	}
}
