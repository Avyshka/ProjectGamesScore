package by.src.menu.actions
{
	import by.src.events.Events;

	public class ShowMessageBoxEndGameAction extends Action
	{
		override public function run(): void
		{
			_dispatcher.dispatchEventWith(Events.SHOW_MESSAGE_BOX_END_GAME);
		}
	}
}
