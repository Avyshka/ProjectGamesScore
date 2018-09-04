package by.src.menu.actions
{
	import by.src.events.Events;

	public class ChangeGameToMaxMinAction extends Action
	{
		override public function run():void
		{
			_dispatcher.dispatchEventWith(Events.GAME_TO_MIN_OR_MAX_CHANGED);
		}
	}
}
