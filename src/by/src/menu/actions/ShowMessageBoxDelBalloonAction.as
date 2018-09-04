package by.src.menu.actions
{
	import by.src.data.PlayerData;
	import by.src.events.Events;

	public class ShowMessageBoxDelBalloonAction extends Action
	{
		private var _data: PlayerData;

		public function ShowMessageBoxDelBalloonAction(data: PlayerData)
		{
			_data = data;
		}

		override public function run(): void
		{
			_dispatcher.dispatchEventWith(Events.SHOW_MESSAGE_BOX_DEL_BALLOON, false, _data);
		}
	}
}
