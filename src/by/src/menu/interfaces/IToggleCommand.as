package by.src.menu.interfaces
{
	import by.src.gui.Toggle;

	public interface IToggleCommand extends ICommand
	{
		function setReceiver(receiver: Toggle): void;
	}
}
