package by.src.messageBox.managers
{
	import by.framework.ComponentPool;
	import by.src.data.PlayerData;
	import by.src.events.Events;
	import by.src.events.EventsDispatcher;
	import by.src.messageBox.MessageBoxBase;
	import by.src.messageBox.messageBoxes.MessageBoxAddPlayer;
	import by.src.messageBox.messageBoxes.MessageBoxAddPoints;
	import by.src.messageBox.messageBoxes.MessageBoxDelBalloonApproval;

	import starling.events.Event;

	public class MessageBoxManager
	{
		private var _dispatcher: EventsDispatcher = EventsDispatcher.getInstance();
		private var _messageBox: MessageBoxBase;

		public function MessageBoxManager()
		{
			_dispatcher.addEventListener(Events.SHOW_MESSAGE_BOX_ADD_PLAYER, onShowAddPlayerMessageBox);
			_dispatcher.addEventListener(Events.SHOW_MESSAGE_BOX_ADD_POINTS, onShowAddPointsMessageBox);
			_dispatcher.addEventListener(Events.SHOW_MESSAGE_BOX_DEL_BALLOON, onShowDelBalloonMessageBox);
		}

		private function onShowAddPlayerMessageBox(event: Event): void
		{
			if (_messageBox)
			{
				_messageBox.free();
			}
			_messageBox = ComponentPool.get(MessageBoxAddPlayer);
			_messageBox.init();
		}

		private function onShowAddPointsMessageBox(event: Event): void
		{
			if (_messageBox)
			{
				_messageBox.free();
			}
			var playerData: PlayerData = event.data as PlayerData;

			_messageBox = ComponentPool.get(MessageBoxAddPoints);
			_messageBox.addData(playerData);
			_messageBox.init();
		}

		private function onShowDelBalloonMessageBox(event: Event): void
		{
			if (_messageBox)
			{
				_messageBox.free();
			}
			var playerData: PlayerData = event.data as PlayerData;

			_messageBox = ComponentPool.get(MessageBoxDelBalloonApproval);
			_messageBox.addData(playerData);
			_messageBox.init();
		}
	}
}
