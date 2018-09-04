package by.src.balloons.views
{
	import by.framework.Builder;

	import starling.animation.Transitions;

	import starling.display.Sprite;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class Crown extends Sprite
	{
		private static var _instance: Crown;

		public function Crown()
		{
			if(_instance != null)
			{
				throw("Error: Crown уже существует. Используйте Crown.getInstance();");
			}
			_instance = this;

			Builder.createImage("crown", this)
					.alignPivot(HAlign.CENTER, VAlign.BOTTOM);
		}

		public static function getInstance(): Crown
		{
			return (_instance == null) ? new Crown() : _instance;
		}

		public static function init(obj: Sprite): void
		{
			if (_instance.parent && _instance.parent == obj)
			{
				return;
			}
			_instance.scaleX = 0;
			_instance.scaleY = 0;
			Builder.addTweenScale(_instance, 1, 1.5, Transitions.EASE_OUT_ELASTIC);
		}

		public static function free(): void
		{
			if (_instance && _instance.parent)
			{
				_instance.parent.removeChild(_instance);
			}
		}
	}
}
