package by.src.menu.actions
{
	import by.src.events.Events;

	public class EndGameAction extends Action
	{
		override public function run():void
		{
			_dispatcher.dispatchEventWith(Events.START_END_GAME);
		}
	}
}
