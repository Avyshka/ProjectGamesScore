package by.src.menu.commands
{
	import by.src.events.Events;
	import by.src.events.EventsDispatcher;
	import by.src.gui.Toggle;
	import by.src.menu.interfaces.IToggleCommand;

	public class ChangeVisibilityDelButtonBalloonsCommand implements IToggleCommand
	{
		private var _dispatcher: EventsDispatcher = EventsDispatcher.getInstance();
		private var _receiver: Toggle;

		public function setReceiver(receiver: Toggle): void
		{
			_receiver = receiver;
		}

		public function execute(): void
		{
			_receiver.onSwitch();
			_dispatcher.dispatchEventWith(Events.CHANGE_VISIBILITY_DEL_BUTTON_BALLONS, false, _receiver.isSwitched);
		}
	}
}
