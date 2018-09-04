package by.src.gui.strategies
{
	import by.src.gui.Toggle;
	import by.src.gui.strategies.interfaces.IChangeColorStrategy;

	public class ChangeColorStrategy implements IChangeColorStrategy
	{
		private var _colorON: uint;
		private var _colorOFF: uint;

		public function ChangeColorStrategy(colorON: uint, colorOFF: uint)
		{
			_colorON = colorON;
			_colorOFF = colorOFF;
		}

		public function changeColor(toggle: Toggle, isSwitched: Boolean): void
		{
			var color: uint = isSwitched ? _colorON : _colorOFF;
			toggle.color = color;
		}
	}
}
