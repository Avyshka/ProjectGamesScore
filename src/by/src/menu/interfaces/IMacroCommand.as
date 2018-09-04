package by.src.menu.interfaces
{
	public interface IMacroCommand extends ICommand
	{
		function add(command: ICommand): void;
		function remove(command: ICommand): void;
	}
}
