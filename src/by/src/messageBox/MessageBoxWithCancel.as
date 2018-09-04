package by.src.messageBox
{
	import by.framework.artist.Artist;

	import starling.display.Button;
	import starling.events.Event;

	public class MessageBoxWithCancel extends MessageBoxBase
	{
		private var _btnCancel: Button;

		public function MessageBoxWithCancel()
		{
			super();

			_gap = 20;

			_btnCancel = new Button(Artist.getTexture("btnDel"));
			_btnCancel.alignPivot();
			addChild(_btnCancel);

			_content.y = _gap / 2;
		}

		override protected function arrange():void
		{
			super.arrange();

			_btnCancel.x = _background.width / 2 - _btnCancel.width / 2 - 5;
			_btnCancel.y = -_background.height / 2 + _btnCancel.height / 2 + 5;
		}

		override public function init():void
		{
			super.init();
			_btnCancel.addEventListener(Event.TRIGGERED, onCancelClick);
		}

		override public function free():void
		{
			super.free();
			_btnCancel.removeEventListener(Event.TRIGGERED, onCancelClick);
		}

		private function onCancelClick(event: Event): void
		{
			free();
		}
	}
}
