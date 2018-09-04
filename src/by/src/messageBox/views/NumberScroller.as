package by.src.messageBox.views
{
	import by.framework.Builder;
	import by.framework.artist.Artist;

	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import starling.utils.deg2rad;

	public class NumberScroller extends Sprite
	{
		private var _tfNumber: TextField;
		private var _btnUp: Button;
		private var _btnDown: Button;

		private var _count: int;

		public function NumberScroller()
		{
			_tfNumber = Builder.createTextField(50, 50, "0", 50, 0xFFFFCC, 0, 0, this);
			_tfNumber.alignPivot();

			_btnUp = new Button(Artist.getTexture("btnArrow"));
			_btnUp.alignPivot(HAlign.CENTER, VAlign.TOP);
			_btnUp.rotation = deg2rad(180);
			_btnUp.y = _tfNumber.height / -2;
			addChild(_btnUp);

			_btnDown = new Button(Artist.getTexture("btnArrow"));
			_btnDown.alignPivot(HAlign.CENTER, VAlign.TOP);
			_btnDown.y = _tfNumber.height / 2;
			addChild(_btnDown);
		}

		public function init(): void
		{
			_count = 0;
			changeTextFieldValue();

			_btnUp.addEventListener(Event.TRIGGERED, onBtnClick);
			_btnDown.addEventListener(Event.TRIGGERED, onBtnClick);
		}

		public function free(): void
		{
			_btnUp.removeEventListener(Event.TRIGGERED, onBtnClick);
			_btnDown.removeEventListener(Event.TRIGGERED, onBtnClick);
		}

		private function onBtnClick(event: Event):void
		{
			const btn: Button = event.currentTarget as Button;

			if (btn == _btnUp)
			{
				_count++;
			}
			else
			{
				_count--;
			}
			_count += 10;
			_count %= 10;

			changeTextFieldValue();
		}

		private function changeTextFieldValue(): void
		{
			_tfNumber.text = _count.toString();
		}

		public function get count(): int {return _count;}
	}
}
