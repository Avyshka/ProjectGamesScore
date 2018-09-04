package by.src.messageBox
{
	import by.framework.Builder;
	import by.framework.Language;
	import by.src.gui.EllipseButton;
	import by.src.menu.interfaces.ICommand;

	import starling.events.Event;
	import starling.text.TextField;

	public class MessageBoxApproval extends MessageBoxBase
	{
		private static const GAP: int = 60;

		private var _btnApprove: EllipseButton;
		private var _btnCancel: EllipseButton;

		protected var _title: TextField;
		protected var _command: ICommand;

		public function MessageBoxApproval()
		{
			super();

			_title = Builder.createTextField(300, 50, "", 20, 0xFFFFFF, 0, -50, _content);

			_btnApprove = new EllipseButton(EllipseButton.COLOR_GREEN, Language.getText(Language.BTN_YES));
			_btnApprove.alignPivot();
			_btnApprove.x = GAP;
			_btnApprove.y = 50;
			_content.addChild(_btnApprove);

			_btnCancel = new EllipseButton(EllipseButton.COLOR_RED, Language.getText(Language.BTN_NO));
			_btnCancel.alignPivot();
			_btnCancel.x = -GAP;
			_btnCancel.y = 50;
			_content.addChild(_btnCancel);
		}

		override public function init(): void
		{
			super.init();
			_btnApprove.addEventListener(Event.TRIGGERED, onApproveClick);
			_btnCancel.addEventListener(Event.TRIGGERED, onCancelClick);
		}

		override public function free(): void
		{
			super.free();
			_btnApprove.removeEventListener(Event.TRIGGERED, onApproveClick);
			_btnCancel.removeEventListener(Event.TRIGGERED, onCancelClick);
		}

		private function onApproveClick(event: Event): void
		{
			_command.execute();
			free();
		}

		private function onCancelClick(event: Event): void
		{
			free();
		}
	}
}
