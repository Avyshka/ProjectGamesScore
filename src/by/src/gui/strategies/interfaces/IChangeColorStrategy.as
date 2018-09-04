package by.src.gui.strategies.interfaces
{
	import by.src.gui.Toggle;

	public interface IChangeColorStrategy
	{
		function changeColor(toggle: Toggle, isSwitched: Boolean): void;
	}
}
