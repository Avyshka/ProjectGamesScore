package by.src.messageBox.messageBoxes
{
	import by.framework.Language;
	import by.framework.textFields.Text3D;
	import by.src.data.PointsAddedData;
	import by.src.gui.EllipseButton;
	import by.src.menu.commands.AddPointsCommand;
	import by.src.menu.interfaces.ICommand;
	import by.src.messageBox.MessageBoxWithCancel;
	import by.src.messageBox.views.Counter;
	import by.src.utils.GetPlayerNameWithoutIDUtils;

	import starling.events.Event;

	public class MessageBoxAddPoints extends MessageBoxWithCancel
	{
		private var _title: Text3D;
		private var _counter: Counter;
		private var _btnAddPoints: EllipseButton;

		private var _pointsAddedData: PointsAddedData;
		private var _command: ICommand;

		public function MessageBoxAddPoints()
		{
			super();

			_pointsAddedData = new PointsAddedData();

			_counter = new Counter();
			_content.addChild(_counter);

			_title = new Text3D(220, 30, 30, 0, _counter.height / -2 - 30, 0xFFFF00, 0xFF6600);
			_content.addChild(_title);

			_btnAddPoints = new EllipseButton(EllipseButton.COLOR_GREEN, Language.getText(Language.ADD_POINTS_BUTTON));
			_btnAddPoints.alignPivot();
			_btnAddPoints.y = _counter.height / 2 + 50;
			_content.addChild(_btnAddPoints);

			_command = new AddPointsCommand(_pointsAddedData);

			arrange();
		}

		override public function init():void
		{
			super.init();

			_pointsAddedData.playerName = _playerData.playerName;

			_title.text = GetPlayerNameWithoutIDUtils.cutPlayerName(_pointsAddedData.playerName);
			_counter.init();
			_btnAddPoints.addEventListener(Event.TRIGGERED, onTriggerButton);
		}

		override public function free():void
		{
			_counter.free();
			_btnAddPoints.removeEventListener(Event.TRIGGERED, onTriggerButton);
			super.free();
		}

		private function onTriggerButton(event: Event):void
		{
			const points: int = _counter.getValue();
//			if (pointsCurrent > 0)
//			{
				_pointsAddedData.points = points;
				_command.execute();
				free();
//			}
		}
	}
}
