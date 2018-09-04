package by.src.menu.actions
{
	import by.src.data.PlayerData;
	import by.src.events.Events;

	public class ShowMessageBoxAddPointsAction extends Action
	{
		private var _data: PlayerData;

		public function ShowMessageBoxAddPointsAction(data: PlayerData)
		{
			_data = data;
		}

		override public function run(): void
		{
			_dispatcher.dispatchEventWith(Events.SHOW_MESSAGE_BOX_ADD_POINTS, false, _data);
		}
	}
}
