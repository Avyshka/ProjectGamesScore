package by.src.menu.actions
{
	import by.src.events.EventsDispatcher;

	public class Action
	{
		protected var _dispatcher: EventsDispatcher = EventsDispatcher.getInstance();

		public function run(): void
		{
			throw("This is abstract method. Please overrade it.")
		}
	}
}
